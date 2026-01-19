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

    <!-- Empty State -->
    <div
      v-if="!loading && (!cart || !cart.items || cart.items.length === 0)"
      class="flex flex-center"
      style="min-height: 60vh"
    >
      <div class="text-h6 text-grey-7">
        Your cart is empty
      </div>
    </div>

    <!-- Cart with Items -->
    <div v-else-if="cart && cart.items && cart.items.length > 0">
      <!-- Product Table -->
      <q-table
        :rows="cart.items"
        :columns="columns"
        row-key="id"
        flat
        class="q-mb-lg"
        :hide-pagination="true"
        :rows-per-page-options="[0]"
      >
        <template v-slot:body-cell-name="props">
          <q-td :props="props">
            {{ props.value }}
          </q-td>
        </template>

        <template v-slot:body-cell-price="props">
          <q-td :props="props">
            ${{ formatPrice(props.value) }}
          </q-td>
        </template>

        <template v-slot:body-cell-quantity="props">
          <q-td :props="props">
            <q-input
              v-model.number="props.row.quantity"
              type="number"
              min="1"
              dense
              outlined
              style="width: 80px"
              @update:model-value="onQuantityChange(props.row)"
            />
          </q-td>
        </template>

        <template v-slot:body-cell-total="props">
          <q-td :props="props">
            ${{ formatPrice(props.value) }}
          </q-td>
        </template>

        <template v-slot:body-cell-actions="props">
          <q-td :props="props">
            <q-btn
              flat
              round
              dense
              icon="delete"
              color="negative"
              @click="removeProduct(props.row.productId)"
            />
          </q-td>
        </template>
      </q-table>

      <!-- Total Section -->
      <div class="row justify-between items-center q-mt-md">
        <div>
          <q-btn
            color="negative"
            label="Cancel Cart"
            @click="handleCancelCart"
          />
        </div>
        <div class="text-h6">
          Total: ${{ formatPrice(cart.totalPrice) }}
        </div>
      </div>
    </div>
  </q-page>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue'
import { useCartStore } from 'stores/cart'
import { useQuasar } from 'quasar'

const cartStore = useCartStore()
const $q = useQuasar()

const loading = ref(false)
const error = ref(null)

const cart = computed(() => cartStore.cart)

const columns = [
  {
    name: 'name',
    required: true,
    label: 'Product Name',
    align: 'left',
    field: row => row.productName || 'Unknown Product',
    format: val => val
  },
  {
    name: 'price',
    label: 'Price',
    align: 'left',
    field: row => row.productPrice || 0,
    format: val => val
  },
  {
    name: 'quantity',
    label: 'Quantity',
    align: 'center',
    field: row => row.quantity
  },
  {
    name: 'total',
    label: 'Total',
    align: 'right',
    field: row => row.itemTotal || (row.productPrice ? row.productPrice * row.quantity : 0),
    format: val => val
  },
  {
    name: 'actions',
    label: '',
    align: 'center',
    field: row => row.id
  }
]

let quantityChangeTimeout = null

function formatPrice(price) {
  if (!price) return '0.00'
  const numPrice = typeof price === 'string' ? parseFloat(price) : price
  return numPrice.toFixed(2)
}

async function onQuantityChange(item) {
  if (!item.quantity || item.quantity < 1) {
    return
  }

  // Debounce quantity changes
  if (quantityChangeTimeout) {
    clearTimeout(quantityChangeTimeout)
  }

  quantityChangeTimeout = setTimeout(async () => {
    try {
      loading.value = true
      error.value = null
      await cartStore.updateQuantity(item.productId, item.quantity)
      $q.notify({
        type: 'positive',
        message: 'Quantity updated',
        position: 'top',
        timeout: 1000
      })
    } catch (err) {
      error.value = 'Failed to update quantity. Please try again.'
      console.error('Failed to update quantity', err)
      // Reload cart to get correct values
      await cartStore.refreshCart()
    } finally {
      loading.value = false
    }
  }, 500)
}

async function removeProduct(productId) {
  try {
    loading.value = true
    error.value = null
    await cartStore.removeProduct(productId)
    $q.notify({
      type: 'positive',
      message: 'Product removed from cart',
      position: 'top',
      timeout: 1000
    })
  } catch (err) {
    error.value = 'Failed to remove product. Please try again.'
    console.error('Failed to remove product', err)
  } finally {
    loading.value = false
  }
}

async function loadCart() {
  loading.value = true
  error.value = null
  try {
    await cartStore.refreshCart()
  } catch (err) {
    error.value = 'Failed to load cart. Please try again later.'
    console.error('Failed to load cart', err)
  } finally {
    loading.value = false
  }
}

async function handleCancelCart() {
  // Check if Dialog plugin is available
  if (!$q.dialog) {
    console.error('Dialog plugin is not available')
    return
  }

  $q.dialog({
    title: 'Cancel Cart',
    message: 'Are you sure you want to cancel this cart? This action cannot be undone.',
    cancel: true,
    persistent: true
  }).onOk(async () => {
    try {
      loading.value = true
      error.value = null
      await cartStore.cancelCart()
      // Refresh the page after successful cancellation
      window.location.reload()
    } catch (err) {
      error.value = 'Failed to cancel cart. Please try again.'
      console.error('Failed to cancel cart', err)
      $q.notify({
        type: 'negative',
        message: 'Failed to cancel cart. Please try again.',
        position: 'top',
        timeout: 3000
      })
    } finally {
      loading.value = false
    }
  })
}

onMounted(loadCart)

watch(() => cartStore.loading, (newVal) => {
  if (newVal) {
    loading.value = true
  }
})
</script>

<style scoped>
</style>
