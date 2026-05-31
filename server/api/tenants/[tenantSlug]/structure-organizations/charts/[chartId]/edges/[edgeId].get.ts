import { getEdgeFromEvent } from '~~/server/services/structure-organization.service'

export default defineEventHandler(async (event) => {
    return await getEdgeFromEvent(event)
})