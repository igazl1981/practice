<template>
  <q-page class="q-pa-md">
    <q-inner-loading :showing="loading">
      <q-spinner color="primary" size="3em" />
    </q-inner-loading>

    <div v-if="error" class="q-mb-md">
      <q-banner type="negative" dense>
        {{ error }}
      </q-banner>
    </div>

    <!-- Back button and title on the same line -->
    <div v-if="category" class="flex items-center q-mb-lg">
      <q-btn
        v-if="category.parentId !== null"
        fab
        flat
        color="primary"
        icon="arrow_back"
        @click="navigateToCategory(category.parentId)"
        class="q-mr-md"
      />  
      <div class="text-h4">
        {{ category.name }}
      </div>
    </div>

    <!-- Subcategories Section -->
    <div v-if="subcategories.length > 0" class="q-mb-lg">
      <div class="row q-col-gutter-md">
        <div
          v-for="subcategory in subcategories"
          :key="subcategory.id"
          class="col-auto"
        >
          <q-btn
            flat
            size="sm"
            color="primary"
            class="q-mb-sm q-mr-sm"
            @click="navigateToCategory(subcategory.id)"
          >
            <template v-if="subcategory.image" #prepend>
              <q-avatar size="24px">
                <img :src="getCategoryImagePath(subcategory.image)" :alt="subcategory.name" />
              </q-avatar>
            </template>
            <template v-else #prepend>
              <q-avatar size="24px" color="grey-4">
                <q-icon name="category" size="18px" color="grey-8" />
              </q-avatar>
            </template>
            {{ subcategory.name }}
          </q-btn>
        </div>
      </div>
    </div>

    <!-- Products Section -->
    <div v-if="products.length > 0">
      <div class="flex items-center justify-between q-mb-md">
        <div class="text-h6">
          Products
        </div>
        <div class="flex items-center q-gutter-sm">
          <q-select
            v-model="sortBy"
            :options="sortOptions"
            option-label="label"
            option-value="value"
            label="Sort by"
            dense
            outlined
            emit-value
            map-options
            style="min-width: 150px"
            @update:model-value="onSortChange"
          />
          <q-select
            v-model="sortOrder"
            :options="sortOrderOptions"
            option-label="label"
            option-value="value"
            dense
            outlined
            emit-value
            map-options
            style="min-width: 120px"
            @update:model-value="onSortChange"
          />
        </div>
      </div>
      <div class="row q-col-gutter-md">
        <div
          v-for="product in products"
          :key="product.id"
          class="col-12 col-sm-6 col-md-4 col-lg-3 product-card-wrapper"
        >
          <q-card class="product-card" flat bordered>
            <div class="product-image flex flex-center">
              <img 
                :src="`/static/images/product-placeholder-${product.id % 5}.png`" 
                :alt="product.name"
                class="product-image-img"
              />
            </div>

            <q-card-section>
              <div class="flex items-center justify-between q-mt-sm">
                <div class="text-h6 text-left">
                  {{ product.name }}
                </div>
                <div class="text-body2 text-grey-7">
                  ${{ formatPrice(product.price) }}
                </div>
              </div>
              <div
                v-if="product.shortDescription"
                class="text-body2 text-grey-7 q-mt-sm text-justify"
              >
                {{ product.shortDescription }}
              </div>
              <div class="q-mt-md">
                <q-btn
                  color="primary"
                  label="Add to Cart"
                  icon="shopping_cart"
                  @click="addToCart(product.id)"
                  :loading="addingToCart === product.id"
                />
              </div>
            </q-card-section>
          </q-card>
        </div>
      </div>
      <div v-if="totalPages > 1" class="flex justify-center q-mt-lg">
        <q-pagination
          v-model="currentPage"
          :max="totalPages"
          :max-pages="7"
          direction-links
          boundary-links
          @update:model-value="onPageChange"
        />
      </div>
      <div v-if="totalElements > 0" class="text-center text-caption text-grey-7 q-mt-sm">
        Showing {{ (currentPage - 1) * pageSize + 1 }} to {{ Math.min(currentPage * pageSize, totalElements) }} of {{ totalElements }} products
      </div>
    </div>

    <div
      v-if="!loading && !error && subcategories.length === 0 && products.length === 0"
      class="text-grey-7"
    >
      No subcategories or products found.
    </div>
  </q-page>
</template>

<script setup>
import { ref, onMounted, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { api } from 'boot/axios'
import { useCartStore } from 'stores/cart'
import { useQuasar } from 'quasar'

const route = useRoute()
const router = useRouter()
const cartStore = useCartStore()
const $q = useQuasar()

const category = ref(null)
const subcategories = ref([])
const products = ref([])
const loading = ref(false)
const error = ref(null)
const addingToCart = ref(null)

// Pagination state
const currentPage = ref(1)
const pageSize = ref(12)
const totalPages = ref(0)
const totalElements = ref(0)

// Sorting state
const sortBy = ref('name')
const sortOrder = ref('asc')
const sortOptions = [
  { label: 'Name', value: 'name' },
  { label: 'Price', value: 'price' }
]
const sortOrderOptions = [
  { label: 'Ascending', value: 'asc' },
  { label: 'Descending', value: 'desc' }
]

function getCategoryImagePath (imageFileName) {
  return `/static/images/${imageFileName}`
}

function formatPrice (price) {
  const numPrice = typeof price === 'string' ? parseFloat(price) : price
  return numPrice.toFixed(2)
}

function navigateToCategory (categoryId) {
  router.push({ name: 'category-detail', params: { parentId: categoryId } })
}

async function addToCart (productId) {
  addingToCart.value = productId
  try {
    await cartStore.addProduct(productId, 1)
    $q.notify({
      type: 'positive',
      message: 'Product added to cart',
      position: 'top',
      timeout: 2000
    })
  } catch (err) {
    $q.notify({
      type: 'negative',
      message: 'Failed to add product to cart',
      position: 'top',
      timeout: 2000
    })
    console.error('Failed to add product to cart', err)
  } finally {
    addingToCart.value = null
  }
}

async function loadCategoryData () {
  const categoryIdParam = route.params.parentId
  if (!categoryIdParam) {
    error.value = 'Category ID is required.'
    return
  }

  const categoryId = Number(categoryIdParam)
  if (isNaN(categoryId)) {
    error.value = 'Invalid category ID.'
    return
  }

  loading.value = true
  error.value = null

  try {
    // Fetch current category by ID
    const categoryResponse = await api.get(`/catalog/categories/${categoryId}`)
    category.value = categoryResponse.data

    // Load subcategories using parentId query parameter
    const categoriesResponse = await api.get('/catalog/categories', {
      params: { parentId: categoryId }
    })
    if (Array.isArray(categoriesResponse.data)) {
      subcategories.value = categoriesResponse.data
    }

    // Load products with pagination
    await loadProducts(categoryId)
  } catch (err) {
    // eslint-disable-next-line no-console
    console.error('Failed to load category data', err)
    error.value = 'Failed to load category data. Please try again later.'
  } finally {
    loading.value = false
  }
}

async function loadProducts (categoryId, showLoading = false) {
  if (showLoading) {
    loading.value = true
  }
  try {
    // Build sort parameter (Spring format: property,direction)
    const sortParam = `${sortBy.value},${sortOrder.value}`
    
    // Spring pagination is 0-indexed
    const pageParam = currentPage.value - 1

    const productsResponse = await api.get(`/catalog/categories/${categoryId}/products`, {
      params: {
        page: pageParam,
        size: pageSize.value,
        sort: sortParam
      }
    })

    // Handle paginated response (Page object)
    const pageData = productsResponse.data
    if (pageData && pageData.content) {
      products.value = pageData.content
      totalPages.value = pageData.totalPages || 0
      totalElements.value = pageData.totalElements || 0
    } else if (Array.isArray(productsResponse.data)) {
      // Fallback for non-paginated response
      products.value = productsResponse.data
      totalPages.value = 1
      totalElements.value = productsResponse.data.length
    }
  } catch (err) {
    // eslint-disable-next-line no-console
    console.error('Failed to load products', err)
    error.value = 'Failed to load products. Please try again later.'
    products.value = []
  } finally {
    if (showLoading) {
      loading.value = false
    }
  }
}

function onPageChange () {
  const categoryIdParam = route.params.parentId
  if (categoryIdParam) {
    const categoryId = Number(categoryIdParam)
    if (!isNaN(categoryId)) {
      loadProducts(categoryId, true)
    }
  }
}

function onSortChange () {
  // Reset to first page when sorting changes
  currentPage.value = 1
  const categoryIdParam = route.params.parentId
  if (categoryIdParam) {
    const categoryId = Number(categoryIdParam)
    if (!isNaN(categoryId)) {
      loadProducts(categoryId, true)
    }
  }
}

onMounted(loadCategoryData)

watch(() => route.params.parentId, () => {
  // Reset pagination when category changes
  currentPage.value = 1
  sortBy.value = 'name'
  sortOrder.value = 'asc'
  loadCategoryData()
})
</script>

<style scoped>
.product-card-wrapper {
  display: flex;
  flex-direction: column;
}

.product-card {
  display: flex;
  flex-direction: column;
  height: 100%;
  transition: transform 0.2s, box-shadow 0.2s;
  cursor: pointer;
}

.product-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.product-image {
  height: 200px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  overflow: hidden;
  flex-shrink: 0;
}

.product-image-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.product-card :deep(.q-card__section) {
  flex: 1 1 auto;
  display: flex;
  flex-direction: column;
}
</style>
