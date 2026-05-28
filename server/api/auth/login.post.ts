import { loginWithEmailPassword } from '../../services/auth.service'
import { setAuthCookie } from '../../utils/auth-token'

export default defineEventHandler(async (event) => {
    const body = await readBody<{
        email: string
        password: string
        tenantSlug?: string
    }>(event)

    const runtime = useRuntimeConfig()

    const tenantSlug =
        body.tenantSlug ||
        String(runtime.public?.clientName || 'martopuro')

    const result = await loginWithEmailPassword({
        email: body.email,
        password: body.password,
        tenantSlug
    })

    setAuthCookie(event, result.token)

    return {
        data: result.user,
        message: 'Login berhasil.'
    }
})