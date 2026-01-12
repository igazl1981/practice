import { defineBoot } from '#q-app/wrappers'
import axios from 'axios'

// Axios instance pointing to backend API.
// In dev, /api is proxied by Quasar/Vite to the Spring Boot backend to avoid CORS.
// In prod, you can serve frontend and backend from the same origin.
const api = axios.create({ baseURL: '/api' })

export default defineBoot(({ app }) => {
  app.config.globalProperties.$axios = axios
  app.config.globalProperties.$api = api
})

export { api }
