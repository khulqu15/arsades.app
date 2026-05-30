import type { CreateUserPayload, UserItem } from '../../../types/rbac'
import { useAppApi } from '../useAppApi'

type AuthResponse = {
  data: UserItem | UserItem[]
  message?: string
  meta?: Record<string, any>
}

type FetchOptions = NonNullable<Parameters<typeof $fetch>[1]>

type FirebaseClients = {
  auth: import('firebase/auth').Auth
  db: import('firebase/database').Database
}

type FirebaseRuntimeConfig = {
  apiKey: string
  authDomain: string
  databaseURL: string
  projectId: string
  storageBucket: string
  messagingSenderId: string
  appId: string
}

let firebaseClientPromise: Promise<FirebaseClients> | null = null

export function useAuth() {
  const runtime = useRuntimeConfig()
  const { apiUrl } = useAppApi()

  const tenantSlug = computed(() => {
    return String(runtime.public.clientName || 'martopuro')
      .trim()
      .toLowerCase()
  })

  const authPath = computed(() => '/api')

  const mysqlLookupEnabled = computed(() => {
    return String(runtime.public.enableMysqlUserLookup || 'true') === 'true'
  })

  const mysqlUserLookupPath = computed(() => {
    return String(runtime.public.mysqlUserLookupPath || '/users')
  })

  const autoRegisterInvalidCredential = computed(() => {
    return String(runtime.public.autoRegisterInvalidCredential || 'true') === 'true'
  })

  const user = useState<UserItem | null>('auth:user', () => null)

  const token = useState<string | null>('auth:token', () => {
    if (import.meta.client) {
      return localStorage.getItem('auth_token')
    }

    return null
  })

  const pending = ref(false)
  const errorMessage = ref('')

  const isLoggedIn = computed(() => Boolean(user.value))
  const roles = computed(() => user.value?.roles || [])
  const permissions = computed(() => user.value?.permissions || [])

  function authEndpoint(path: string) {
    const cleanPath = path.startsWith('/') ? path : `/${path}`
    return apiUrl(`${authPath.value}${cleanPath}`)
  }

  function hasRole(roleCode: string) {
    return roles.value.some((role) => role.roleCode === roleCode)
  }

  function can(permissionCode: string) {
    return permissions.value.includes(permissionCode)
  }

  function ensureClient() {
    if (!import.meta.client) {
      throw createError({
        statusCode: 400,
        statusMessage: 'Firebase Auth hanya bisa dijalankan di client.'
      })
    }
  }

  function getFirebaseRuntimeConfig(): FirebaseRuntimeConfig {
    const publicRuntime = runtime.public as Record<string, any>

    return {
      apiKey: String(publicRuntime.firebaseApiKey || ''),
      authDomain: String(publicRuntime.firebaseAuthDomain || ''),
      databaseURL: String(
        publicRuntime.firebaseDatabaseURL ||
        publicRuntime.firebaseDatabaseUrl ||
        ''
      ),
      projectId: String(publicRuntime.firebaseProjectId || ''),
      storageBucket: String(publicRuntime.firebaseStorageBucket || ''),
      messagingSenderId: String(publicRuntime.firebaseMessagingSenderId || ''),
      appId: String(publicRuntime.firebaseAppId || '')
    }
  }

  async function getFirebaseClients(): Promise<FirebaseClients> {
    ensureClient()

    if (firebaseClientPromise) return firebaseClientPromise

    firebaseClientPromise = Promise.all([
      import('firebase/app'),
      import('firebase/auth'),
      import('firebase/database')
    ]).then(async ([firebaseApp, firebaseAuth, firebaseDatabase]) => {
      const config = getFirebaseRuntimeConfig()

      if (
        !config.apiKey ||
        !config.authDomain ||
        !config.databaseURL ||
        !config.projectId ||
        !config.appId
      ) {
        throw createError({
          statusCode: 500,
          statusMessage:
            'Konfigurasi Firebase belum lengkap. Cek NUXT_PUBLIC_FIREBASE_* di environment.'
        })
      }

      const app = firebaseApp.getApps().length
        ? firebaseApp.getApp()
        : firebaseApp.initializeApp(config)

      const auth = firebaseAuth.getAuth(app)

      try {
        await firebaseAuth.setPersistence(
          auth,
          firebaseAuth.browserLocalPersistence
        )
      } catch {
        // Abaikan error persistence supaya auth tetap jalan.
      }

      const db = firebaseDatabase.getDatabase(app)

      return {
        auth,
        db
      }
    })

    return firebaseClientPromise
  }

  function normalizeEmail(email?: string | null) {
    return String(email || '').trim().toLowerCase()
  }

  function toFirebaseKey(value: string) {
    return String(value || '')
      .trim()
      .toLowerCase()
      .replace(/[.#$/[\]]/g, '_')
  }

  function normalizeArray<T = any>(value: any): T[] {
    if (!value) return []
    if (Array.isArray(value)) return value as T[]

    if (typeof value === 'object') {
      return Object.values(value) as T[]
    }

    return []
  }

  function getDefaultName(email?: string | null) {
    const cleanEmail = String(email || '').trim()
    if (!cleanEmail) return 'User'

    return cleanEmail.split('@')[0] || 'User'
  }

  function getTenantUserPath(firebaseUid: string) {
    return `${tenantSlug.value}/users/${firebaseUid}`
  }

  function getTenantUserEmailIndexPath(email: string) {
    return `${tenantSlug.value}/userEmailIndex/${toFirebaseKey(email)}`
  }

  function getGlobalFirebaseUserPath(firebaseUid: string) {
    return `firebaseUsers/${firebaseUid}`
  }

  function getGlobalFirebaseEmailIndexPath(email: string) {
    return `firebaseUserEmailIndex/${toFirebaseKey(email)}`
  }

  function createDefaultUserFromFirebase(
    firebaseUser: import('firebase/auth').User,
    override: Partial<UserItem> = {}
  ): UserItem {
    const now = Date.now()
    const email = normalizeEmail(firebaseUser.email || override.email)

    return {
      id: override.id || firebaseUser.uid,
      name:
        override.name ||
        firebaseUser.displayName ||
        getDefaultName(email),
      email,
      avatarUrl:
        override.avatarUrl ||
        firebaseUser.photoURL ||
        null,
      phone:
        override.phone ||
        firebaseUser.phoneNumber ||
        null,
      status: override.status || 'active',
      emailVerifiedAt:
        override.emailVerifiedAt ||
        (firebaseUser.emailVerified ? now : null),
      lastLoginAt: now,
      createdAt: override.createdAt || now,
      updatedAt: now,
      roles:
        override.roles ||
        [
          {
            roleCode: 'user',
            roleName: 'User',
            scope: 'tenant',
            tenantId: null,
            tenantSlug: tenantSlug.value,
            tenantName: tenantSlug.value
          }
        ],
      permissions: override.permissions || []
    }
  }

  function normalizeUserItem(
    value: any,
    firebaseUser?: import('firebase/auth').User
  ): UserItem {
    const now = Date.now()

    const email = normalizeEmail(
      value?.email ||
      firebaseUser?.email ||
      ''
    )

    return {
      id: String(value?.id || value?.firebaseUid || firebaseUser?.uid || ''),
      name: String(
        value?.name ||
        firebaseUser?.displayName ||
        getDefaultName(email)
      ),
      email,
      avatarUrl:
        value?.avatarUrl ??
        value?.avatar_url ??
        firebaseUser?.photoURL ??
        null,
      phone:
        value?.phone ??
        firebaseUser?.phoneNumber ??
        null,
      status: value?.status || 'active',
      emailVerifiedAt:
        value?.emailVerifiedAt ??
        value?.email_verified_at ??
        (firebaseUser?.emailVerified ? now : null),
      lastLoginAt:
        value?.lastLoginAt ??
        value?.last_login_at ??
        now,
      createdAt:
        value?.createdAt ??
        value?.created_at ??
        now,
      updatedAt:
        value?.updatedAt ??
        value?.updated_at ??
        now,
      roles: normalizeArray(value?.roles),
      permissions: normalizeArray<string>(value?.permissions)
    }
  }

  function extractMysqlUser(response: any): UserItem | null {
    const data = response?.data

    if (Array.isArray(data)) {
      return data.length ? normalizeUserItem(data[0]) : null
    }

    if (Array.isArray(data?.data)) {
      return data.data.length ? normalizeUserItem(data.data[0]) : null
    }

    if (data && typeof data === 'object') {
      return normalizeUserItem(data)
    }

    return null
  }

  function isInvalidCredentialError(error: any) {
    const code = String(error?.code || '')

    return [
      'auth/invalid-credential',
      'auth/user-not-found'
    ].includes(code)
  }

  async function getFreshFirebaseToken(forceRefresh = false) {
    if (!import.meta.client) return null

    const { auth } = await getFirebaseClients()

    if (!auth.currentUser) return null

    const freshToken = await auth.currentUser.getIdToken(forceRefresh)

    token.value = freshToken
    localStorage.setItem('auth_token', freshToken)

    return freshToken
  }

  function getAuthHeaders(optionsHeaders?: FetchOptions['headers']) {
    const headers: Record<string, string> = {
      Accept: 'application/json',
      'Content-Type': 'application/json'
    }

    if (token.value) {
      headers.Authorization = `Bearer ${token.value}`
    }

    return {
      ...headers,
      ...((optionsHeaders || {}) as Record<string, string>)
    }
  }

  async function authFetch<T>(
    path: string,
    options: FetchOptions = {}
  ) {
    await getFreshFirebaseToken()

    return await $fetch<T>(authEndpoint(path), {
      ...options,
      headers: getAuthHeaders(options.headers)
    })
  }

  async function lookupExistingMysqlUserByEmail(email: string) {
    if (!mysqlLookupEnabled.value) return null

    const cleanEmail = normalizeEmail(email)
    if (!cleanEmail) return null

    const encodedEmail = encodeURIComponent(cleanEmail)
    const encodedTenant = encodeURIComponent(tenantSlug.value)

    const candidates = [
      `${mysqlUserLookupPath.value}?search=${encodedEmail}&tenantSlug=${encodedTenant}`,
      `${mysqlUserLookupPath.value}?email=${encodedEmail}&tenantSlug=${encodedTenant}`,
      `/users?search=${encodedEmail}&tenantSlug=${encodedTenant}`,
      `/users?email=${encodedEmail}&tenantSlug=${encodedTenant}`
    ]

    for (const path of candidates) {
      try {
        const response = await authFetch<AuthResponse>(path, {
          method: 'GET'
        })

        const mysqlUser = extractMysqlUser(response)

        if (mysqlUser?.email && normalizeEmail(mysqlUser.email) === cleanEmail) {
          return mysqlUser
        }
      } catch {
        // Lookup MySQL hanya opsional dan read-only.
      }
    }

    return null
  }

  async function readRealtimeUser(firebaseUid: string) {
    const { db } = await getFirebaseClients()
    const { ref: dbRef, get } = await import('firebase/database')

    const snapshot = await get(dbRef(db, getTenantUserPath(firebaseUid)))

    if (!snapshot.exists()) return null

    return normalizeUserItem(snapshot.val())
  }

  async function readRealtimeUserByEmail(email: string) {
    const cleanEmail = normalizeEmail(email)
    if (!cleanEmail) return null

    const { db } = await getFirebaseClients()
    const { ref: dbRef, get } = await import('firebase/database')

    const indexSnapshot = await get(
      dbRef(db, getTenantUserEmailIndexPath(cleanEmail))
    )

    if (!indexSnapshot.exists()) return null

    const uid = String(indexSnapshot.val()?.uid || '')
    if (!uid) return null

    return await readRealtimeUser(uid)
  }

  async function saveRealtimeUser(
    firebaseUser: import('firebase/auth').User,
    profile: UserItem,
    options?: {
      source?: 'firebase' | 'mysql' | 'realtime_database' | 'auto_register'
    }
  ) {
    const { db } = await getFirebaseClients()
    const { ref: dbRef, update } = await import('firebase/database')

    const now = Date.now()
    const email = normalizeEmail(profile.email || firebaseUser.email)

    const payload = {
      ...profile,
      id: profile.id || firebaseUser.uid,
      firebaseUid: firebaseUser.uid,
      firebaseEmail: email,
      tenantSlug: tenantSlug.value,
      source: options?.source || 'firebase',
      provider: 'firebase',
      lastLoginAt: now,
      updatedAt: now
    }

    const updates: Record<string, any> = {
      [getTenantUserPath(firebaseUser.uid)]: payload,
      [getGlobalFirebaseUserPath(firebaseUser.uid)]: payload
    }

    if (email) {
      updates[getTenantUserEmailIndexPath(email)] = {
        uid: firebaseUser.uid,
        email,
        tenantSlug: tenantSlug.value,
        updatedAt: now
      }

      updates[getGlobalFirebaseEmailIndexPath(email)] = {
        uid: firebaseUser.uid,
        email,
        tenantSlug: tenantSlug.value,
        updatedAt: now
      }
    }

    await update(dbRef(db), updates)

    return normalizeUserItem(payload, firebaseUser)
  }

  async function resolveUserProfile(
    firebaseUser: import('firebase/auth').User,
    source: 'firebase' | 'auto_register' = 'firebase'
  ) {
    const email = normalizeEmail(firebaseUser.email)

    const mysqlUser = await lookupExistingMysqlUserByEmail(email)

    if (mysqlUser) {
      return await saveRealtimeUser(firebaseUser, mysqlUser, {
        source: 'mysql'
      })
    }

    const realtimeUser = await readRealtimeUser(firebaseUser.uid)

    if (realtimeUser) {
      return await saveRealtimeUser(firebaseUser, realtimeUser, {
        source: 'realtime_database'
      })
    }

    const defaultUser = createDefaultUserFromFirebase(firebaseUser)

    return await saveRealtimeUser(firebaseUser, defaultUser, {
      source
    })
  }

  function setLocalSession(profile: UserItem, authToken?: string | null) {
    user.value = profile

    if (import.meta.client) {
      if (authToken) {
        token.value = authToken
        localStorage.setItem('auth_token', authToken)
      }

      localStorage.setItem('auth_user', JSON.stringify(profile))
    }
  }

  function clearLocalSession() {
    user.value = null
    token.value = null

    if (import.meta.client) {
      localStorage.removeItem('auth_token')
      localStorage.removeItem('auth_user')
    }
  }

  async function restoreCurrentFirebaseSession() {
    if (!import.meta.client) return null

    const { auth } = await getFirebaseClients()
    const firebaseAuth = await import('firebase/auth')

    const firebaseUser = await new Promise<import('firebase/auth').User | null>((resolve) => {
      const unsubscribe = firebaseAuth.onAuthStateChanged(auth, (currentUser) => {
        unsubscribe()
        resolve(currentUser)
      })
    })

    if (!firebaseUser) return null

    const freshToken = await firebaseUser.getIdToken(true)
    const profile = await resolveUserProfile(firebaseUser)

    setLocalSession(profile, freshToken)

    return profile
  }

  async function fetchMe() {
    try {
      const profile = await restoreCurrentFirebaseSession()

      if (!profile) {
        clearLocalSession()
        return null
      }

      return profile
    } catch {
      clearLocalSession()
      return null
    }
  }

  async function autoRegisterFirebaseAuth(payload: {
    email: string
    password: string
  }) {
    const { auth } = await getFirebaseClients()
    const firebaseAuth = await import('firebase/auth')

    const email = normalizeEmail(payload.email)

    const existingMysqlUser = await lookupExistingMysqlUserByEmail(email)
    const existingRealtimeUser = await readRealtimeUserByEmail(email)

    const displayName =
      existingMysqlUser?.name ||
      existingRealtimeUser?.name ||
      getDefaultName(email)

    const credential = await firebaseAuth.createUserWithEmailAndPassword(
      auth,
      email,
      payload.password
    )

    await firebaseAuth.updateProfile(credential.user, {
      displayName,
      photoURL:
        existingMysqlUser?.avatarUrl ||
        existingRealtimeUser?.avatarUrl ||
        null
    })

    const profile =
      existingMysqlUser ||
      existingRealtimeUser ||
      createDefaultUserFromFirebase(credential.user, {
        name: displayName,
        email,
        avatarUrl:
          existingMysqlUser?.avatarUrl ||
          existingRealtimeUser?.avatarUrl ||
          null,
        phone:
          existingMysqlUser?.phone ||
          existingRealtimeUser?.phone ||
          null,
        roles:
          existingMysqlUser?.roles?.length
            ? existingMysqlUser.roles
            : existingRealtimeUser?.roles?.length
              ? existingRealtimeUser.roles
              : undefined,
        permissions:
          existingMysqlUser?.permissions?.length
            ? existingMysqlUser.permissions
            : existingRealtimeUser?.permissions?.length
              ? existingRealtimeUser.permissions
              : undefined
      })

    const savedProfile = await saveRealtimeUser(credential.user, profile, {
      source: existingMysqlUser
        ? 'mysql'
        : existingRealtimeUser
          ? 'realtime_database'
          : 'auto_register'
    })

    const freshToken = await credential.user.getIdToken(true)

    setLocalSession(savedProfile, freshToken)

    return savedProfile
  }

  async function login(payload: {
    email: string
    password: string
  }) {
    pending.value = true
    errorMessage.value = ''

    try {
      const { auth } = await getFirebaseClients()
      const firebaseAuth = await import('firebase/auth')

      try {
        const credential = await firebaseAuth.signInWithEmailAndPassword(
          auth,
          normalizeEmail(payload.email),
          payload.password
        )

        const freshToken = await credential.user.getIdToken(true)
        const profile = await resolveUserProfile(credential.user)

        setLocalSession(profile, freshToken)

        return profile
      } catch (loginError: any) {
        if (
          autoRegisterInvalidCredential.value &&
          isInvalidCredentialError(loginError)
        ) {
          return await autoRegisterFirebaseAuth(payload)
        }

        const restoredProfile = await restoreCurrentFirebaseSession()

        if (restoredProfile) {
          return restoredProfile
        }

        throw loginError
      }
    } catch (error: any) {
      errorMessage.value = mapFirebaseAuthError(error)
      throw error
    } finally {
      pending.value = false
    }
  }

  async function register(payload: CreateUserPayload) {
    pending.value = true
    errorMessage.value = ''

    try {
      const { auth } = await getFirebaseClients()
      const firebaseAuth = await import('firebase/auth')

      const anyPayload = payload as any
      const email = normalizeEmail(anyPayload.email)
      const password = String(anyPayload.password || 'Password123')

      const existingMysqlUser = await lookupExistingMysqlUserByEmail(email)
      const existingRealtimeUser = await readRealtimeUserByEmail(email)

      const displayName =
        String(anyPayload.name || '').trim() ||
        existingMysqlUser?.name ||
        existingRealtimeUser?.name ||
        getDefaultName(email)

      const credential = await firebaseAuth.createUserWithEmailAndPassword(
        auth,
        email,
        password
      )

      await firebaseAuth.updateProfile(credential.user, {
        displayName,
        photoURL:
          anyPayload.avatarUrl ||
          existingMysqlUser?.avatarUrl ||
          existingRealtimeUser?.avatarUrl ||
          null
      })

      const profile = existingMysqlUser
        ? existingMysqlUser
        : existingRealtimeUser
          ? existingRealtimeUser
          : createDefaultUserFromFirebase(credential.user, {
              name: displayName,
              email,
              avatarUrl: anyPayload.avatarUrl || null,
              phone: anyPayload.phone || null,
              status: anyPayload.status || 'active',
              roles: [
                {
                  roleCode: anyPayload.roleCode || 'user',
                  roleName: anyPayload.roleCode || 'User',
                  scope: anyPayload.roleCode === 'super_admin' ? 'global' : 'tenant',
                  tenantId: anyPayload.tenantId || null,
                  tenantSlug:
                    anyPayload.roleCode === 'super_admin'
                      ? null
                      : tenantSlug.value,
                  tenantName:
                    anyPayload.roleCode === 'super_admin'
                      ? null
                      : tenantSlug.value
                }
              ],
              permissions: []
            })

      const savedProfile = await saveRealtimeUser(credential.user, profile, {
        source: existingMysqlUser
          ? 'mysql'
          : existingRealtimeUser
            ? 'realtime_database'
            : 'firebase'
      })

      const freshToken = await credential.user.getIdToken(true)

      setLocalSession(savedProfile, freshToken)

      return savedProfile
    } catch (error: any) {
      if (String(error?.code || '') === 'auth/email-already-in-use') {
        errorMessage.value =
          'Email sudah terdaftar di Firebase Auth. Silakan login menggunakan password Firebase.'
      } else {
        errorMessage.value = mapFirebaseAuthError(error, 'Registrasi gagal.')
      }

      throw error
    } finally {
      pending.value = false
    }
  }

  async function logout() {
    try {
      if (import.meta.client) {
        const { auth } = await getFirebaseClients()
        const firebaseAuth = await import('firebase/auth')

        await firebaseAuth.signOut(auth)
      }
    } finally {
      clearLocalSession()
      await navigateTo('/login')
    }
  }

  function mapFirebaseAuthError(
    error: any,
    fallback = 'Login gagal. Periksa email dan password.'
  ) {
    const code = String(error?.code || '')

    const messages: Record<string, string> = {
      'auth/invalid-email': 'Format email belum valid.',
      'auth/user-disabled': 'Akun ini sedang dinonaktifkan.',
      'auth/user-not-found': 'Email belum terdaftar di Firebase Auth.',
      'auth/wrong-password': 'Password salah.',
      'auth/invalid-credential':
        'Email atau password belum cocok. Sistem sudah mencoba membuat akun Firebase otomatis.',
      'auth/email-already-in-use':
        'Email sudah terdaftar di Firebase Auth. Silakan login dengan password Firebase yang benar.',
      'auth/weak-password': 'Password minimal 6 karakter untuk Firebase Auth.',
      'auth/network-request-failed':
        'Koneksi ke Firebase bermasalah. Sistem sudah mencoba memulihkan session yang masih aktif.',
      'auth/too-many-requests':
        'Terlalu banyak percobaan login. Coba lagi beberapa saat.',
      'auth/configuration-not-found':
        'Firebase Auth belum aktif. Aktifkan Email/Password provider di Firebase Console.'
    }

    return (
      error?.data?.statusMessage ||
      error?.data?.message ||
      error?.statusMessage ||
      messages[code] ||
      fallback
    )
  }

  return {
    tenantSlug,
    authPath,

    user,
    token,
    pending,
    errorMessage,

    isLoggedIn,
    roles,
    permissions,

    hasRole,
    can,

    fetchMe,
    login,
    register,
    logout
  }
}