const routes = [
  {
    path: '/',
    component: () => import('layouts/MainLayout.vue'),
    children: [
      { name: 'root', path: '', component: () => import('pages/IndexPage.vue') },
      { name: 'category-detail', path: 'category/:parentId', component: () => import('pages/CategoryDetailPage.vue') }
    ]
  },

  // Always leave this as last one,
  // but you can also remove it
  {
    path: '/:catchAll(.*)*',
    component: () => import('pages/ErrorNotFound.vue')
  }
]

export default routes
