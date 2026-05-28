export type TenantKey = 'martopuro' | 'obayan' | 'sencra' | string

export function useTenantContext() {
    const tenantHost = useState<string>('tenant:host', () => '')
    const tenantKey = useState<TenantKey>('tenant:key', () => 'obayan')

    const isMartopuro = useState<boolean>('tenant:isMartopuro', () => false)
    const isObayan = useState<boolean>('tenant:isObayan', () => false)
    const isSencra = useState<boolean>('tenant:isSencra', () => false)
    const isRailway = useState<boolean>('tenant:isRailway', () => false)

    return {
        tenantHost,
        tenantKey,

        isMartopuro,
        isObayan,
        isSencra,
        isRailway
    }
}