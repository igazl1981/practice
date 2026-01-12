<template>
  <q-page class="q-pa-md">
    <div class="text-h5 q-mb-md">
      Main categories
    </div>

    <q-inner-loading :showing="loading">
      <q-spinner color="primary" size="3em" />
    </q-inner-loading>

    <div v-if="error" class="q-mb-md">
      <q-banner type="negative" dense>
        {{ error }}
      </q-banner>
    </div>

    <div class="row q-col-gutter-md">
      <div
        v-for="category in categories"
        :key="category.id"
        class="col-12 col-sm-6 col-md-4 col-lg-3"
      >
        <q-card
          class="category-card"
          flat
          bordered
          @click="navigateToCategory(category.id)"
        >
          <q-img
            v-if="category.image"
            :src="getCategoryImagePath(category.image)"
            :alt="category.name"
            height="200px"
            class="category-image"
            fit="cover"
          >
            <template v-slot:error>
              <div class="absolute-full flex flex-center bg-grey-3 text-grey-8">
                <q-icon name="category" size="64px" />
              </div>
            </template>
          </q-img>
          <div
            v-else
            class="category-image flex flex-center"
          >
            <q-icon name="category" size="64px" color="white" />
          </div>

          <q-card-section class="text-center">
            <div class="text-h6 q-mt-sm">
              {{ category.name }}
            </div>
          </q-card-section>
        </q-card>
      </div>
    </div>

    <div
      v-if="!loading && !error && categories.length === 0"
      class="text-grey-7"
    >
      No categories found.
    </div>
  </q-page>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { api } from 'boot/axios'

const router = useRouter()

const categories = ref([])
const loading = ref(false)
const error = ref(null)

function getCategoryImagePath (imageFileName) {
  return `/static/images/${imageFileName}`
}

function navigateToCategory (categoryId) {
  router.push({ path: '/category/' + categoryId })
}

async function loadCategories () {
  loading.value = true
  error.value = null
  try {
    const response = await api.get('/catalog/categories')
    const data = response.data

    if (Array.isArray(data)) {
      categories.value = data
    } else {
      // eslint-disable-next-line no-console
      console.error('Unexpected categories payload', data)
      error.value = 'Unexpected response from server when loading categories.'
      categories.value = []
    }
  } catch (err) {
    // eslint-disable-next-line no-console
    console.error('Failed to load categories', err)
    error.value = 'Failed to load categories. Please try again later.'
  } finally {
    loading.value = false
  }
}

onMounted(loadCategories)
</script>

<style scoped>
.category-card {
  transition: transform 0.2s, box-shadow 0.2s;
  cursor: pointer;
}

.category-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.category-image {
  height: 200px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.category-image img {
  object-fit: cover;
}
</style>
