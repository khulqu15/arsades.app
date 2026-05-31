import { createChartFromEvent } from '~~/server/services/structure-organization.service'

export default defineEventHandler(async (event) => {
    return await createChartFromEvent(event)
})