import { clearAuthCookie } from '../../utils/auth-token'

export default defineEventHandler(async (event) => {
  clearAuthCookie(event)

  return {
    message: 'Logout berhasil.'
  }
})