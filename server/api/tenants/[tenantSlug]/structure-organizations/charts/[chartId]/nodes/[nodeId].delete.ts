import { deleteNodeFromEvent } from '~~/server/services/structure-organization.service'

export default defineEventHandler(async (event) => {
    return await deleteNodeFromEvent(event)
})