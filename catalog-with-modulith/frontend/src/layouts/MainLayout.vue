<template>
  <q-layout view="lHh Lpr lFf">
    <q-header elevated>
      <q-toolbar>
        <q-btn
          flat
          dense
          round
          icon="menu"
          aria-label="Menu"
          @click="toggleLeftDrawer"
        />

        <q-toolbar-title>
          Learn Modulith
        </q-toolbar-title>

        <q-space />

        <q-btn
          flat
          dense
          round
          icon="shopping_cart"
          aria-label="Cart"
          :to="{ name: 'cart' }"
        >
          <q-badge
            v-if="cartStore.getTotalItems > 0"
            color="red"
            floating
            :label="cartStore.getTotalItems"
          />
        </q-btn>
      </q-toolbar>
    </q-header>

    <q-drawer
      v-model="leftDrawerOpen"
      show-if-above
      bordered
    >
      <q-list>
        <q-item
          clickable
          v-ripple
          tag="router-link"
          to="/"
        >
          <q-item-section avatar>
            <q-icon name="category" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Categories</q-item-label>
            <q-item-label caption>Main categories</q-item-label>
          </q-item-section>
        </q-item>

        <q-item
          clickable
          v-ripple
          tag="router-link"
          :to="{ name: 'cart' }"
        >
          <q-item-section avatar>
            <q-icon name="shopping_cart" />
          </q-item-section>
          <q-item-section>
            <q-item-label>Cart</q-item-label>
            <q-item-label caption>View cart</q-item-label>
          </q-item-section>
        </q-item>
      </q-list>
    </q-drawer>

    <q-page-container>
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useCartStore } from 'stores/cart'

const leftDrawerOpen = ref(false)
const cartStore = useCartStore()

function toggleLeftDrawer () {
  leftDrawerOpen.value = !leftDrawerOpen.value
}

// Load cart on mount if cartId exists
onMounted(() => {
  if (cartStore.cartId) {
    cartStore.refreshCart()
  }
})
</script>
