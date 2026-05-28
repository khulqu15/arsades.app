import { getRoleList } from '../../services/user.service'

export default defineEventHandler(async () => {
    return getRoleList()
})