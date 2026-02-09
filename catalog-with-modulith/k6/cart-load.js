import http from 'k6/http';
import { check, sleep } from 'k6';

const BASE_URL = __ENV.BASE_URL || 'http://localhost:8080';

const DEFAULT_PRODUCT_IDS = [1, 2, 3, 4, 5];

export const options = {
  vus: 3,
  duration: '2m',
};

export function setup() {
  const productIds = fetchProductIds();
  return { productIds: productIds.length > 0 ? productIds : DEFAULT_PRODUCT_IDS };
}

function fetchProductIds() {
  const categoriesRes = http.get(`${BASE_URL}/api/catalog/categories`);
  if (!check(categoriesRes, { 'categories status 200': (r) => r.status === 200 })) {
    return [];
  }
  const categories = categoriesRes.json();
  if (!Array.isArray(categories) || categories.length === 0) return [];

  const ids = [];
  const maxCategories = Math.min(categories.length, 10);
  for (let i = 0; i < maxCategories; i++) {
    const cat = categories[i];
    const catId = typeof cat === 'object' && cat !== null && 'id' in cat ? cat.id : cat;
    const productsRes = http.get(
      `${BASE_URL}/api/catalog/categories/${catId}/products?page=0&size=100`
    );
    if (productsRes.status !== 200) continue;
    const page = productsRes.json();
    const content = page && page.content;
    if (Array.isArray(content)) {
      content.forEach((p) => {
        if (p && typeof p.id === 'number') ids.push(p.id);
      });
    }
  }
  return [...new Set(ids)];
}

function pickRandomProducts(productIds, count) {
  const shuffled = [...productIds].sort(() => Math.random() - 0.5);
  return shuffled.slice(0, count).map((productId) => ({
    productId,
    quantity: Math.floor(Math.random() * 3) + 1,
  }));
}

export default function (data) {
  const productIds = data.productIds;
  if (productIds.length < 2) return;

  const n = Math.floor(Math.random() * 4) + 2; // 2-5 products per cart
  const products = pickRandomProducts(productIds, n);

  // Create cart with first product
  const createPayload = JSON.stringify({
    cartId: null,
    products: [products[0]],
  });
  const createRes = http.post(`${BASE_URL}/api/carts`, createPayload, {
    headers: { 'Content-Type': 'application/json' },
  });

  const createOk = check(createRes, {
    'create cart status 201': (r) => r.status === 201,
  });
  if (!createOk) return;

  const cartId = createRes.json('id');
  if (cartId == null) return;

  // Add remaining products to same cart
  if (products.length > 1) {
    const addPayload = JSON.stringify({
      cartId,
      products: products.slice(1),
    });
    const addRes = http.post(`${BASE_URL}/api/carts`, addPayload, {
      headers: { 'Content-Type': 'application/json' },
    });
    check(addRes, { 'add products status 201': (r) => r.status === 201 });
  }

  sleep(Math.random() * 2 + 1);

  // Submit cart and forget
  const submitRes = http.post(
    `${BASE_URL}/api/carts/${cartId}/submit`,
    null,
    { headers: { 'Content-Type': 'application/json' } }
  );
  check(submitRes, { 'submit cart status 200': (r) => r.status === 200 });
}
