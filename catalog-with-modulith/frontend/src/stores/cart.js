import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { api } from 'boot/axios'

export const useCartStore = defineStore('cart', () => {
  const cartId = ref(null)
  const cart = ref(null)
  const loading = ref(false)

  const CART_ID_KEY = 'cartId'

  // Load cartId from localStorage on initialization
  function loadCartId() {
    const stored = localStorage.getItem(CART_ID_KEY)
    if (stored) {
      cartId.value = Number(stored)
    }
  }

  // Save cartId to localStorage
  function saveCartId(id) {
    cartId.value = id
    if (id) {
      localStorage.setItem(CART_ID_KEY, id.toString())
    } else {
      localStorage.removeItem(CART_ID_KEY)
    }
  }

  // Add product to cart
  async function addProduct(productId, quantity = 1) {
    loading.value = true
    try {
      const currentCartId = cartId.value
      const response = await api.post('/carts', {
        cartId: currentCartId,
        products: [{ productId, quantity }]
      })

      // If we didn't have a cartId and got one back, save it
      if (!currentCartId && response.data?.id) {
        saveCartId(response.data.id)
      }

      // Refresh cart data
      await refreshCart()
      return response.data
    } catch (error) {
      console.error('Failed to add product to cart', error)
      throw error
    } finally {
      loading.value = false
    }
  }

  // Refresh cart data from backend
  async function refreshCart() {
    if (!cartId.value) {
      cart.value = null
      return
    }

    loading.value = true
    try {
      const response = await api.get(`/carts/${cartId.value}`)
      cart.value = response.data
    } catch (error) {
      if (error.response?.status === 404) {
        // Cart not found, clear cartId
        saveCartId(null)
        cart.value = null
      } else {
        console.error('Failed to load cart', error)
        throw error
      }
    } finally {
      loading.value = false
    }
  }

  // Update product quantity
  async function updateQuantity(productId, quantity) {
    if (!cartId.value) {
      throw new Error('No cart available')
    }

    loading.value = true
    try {
      await api.put(`/carts/${cartId.value}/items`, {
        products: [{ productId, quantity }]
      })
      await refreshCart()
    } catch (error) {
      console.error('Failed to update quantity', error)
      throw error
    } finally {
      loading.value = false
    }
  }

  // Remove product from cart
  async function removeProduct(productId) {
    if (!cartId.value) {
      throw new Error('No cart available')
    }

    loading.value = true
    try {
      await api.delete(`/carts/${cartId.value}/items`, {
        data: { productIds: [productId] }
      })
      await refreshCart()
    } catch (error) {
      console.error('Failed to remove product', error)
      throw error
    } finally {
      loading.value = false
    }
  }

  // Cancel cart
  async function cancelCart() {
    if (!cartId.value) {
      throw new Error('No cart available')
    }

    loading.value = true
    try {
      await api.post(`/carts/${cartId.value}/cancel`)
      // Clear cartId from localStorage and reset cart state
      saveCartId(null)
      cart.value = null
    } catch (error) {
      console.error('Failed to cancel cart', error)
      // Clear state even on error if cart doesn't exist
      if (error.response?.status === 404) {
        saveCartId(null)
        cart.value = null
      }
      throw error
    } finally {
      loading.value = false
    }
  }

  // Get distinct items count (number of different products in cart)
  const getTotalItems = computed(() => {
    if (!cart.value || !cart.value.items || cart.value.items.length === 0) {
      return 0
    }
    return cart.value.items.length
  })

  // Get total price from backend
  const getTotalPrice = computed(() => {
    return cart.value?.totalPrice || 0
  })

  // Initialize cartId from localStorage
  loadCartId()

  return {
    cartId,
    cart,
    loading,
    addProduct,
    refreshCart,
    updateQuantity,
    removeProduct,
    cancelCart,
    getTotalItems,
    getTotalPrice,
    saveCartId
  }
})
