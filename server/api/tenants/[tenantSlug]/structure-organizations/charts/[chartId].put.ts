import { updateChartFromEvent } from '~~/server/services/structure-organization.service'

export default defineEventHandler(async (event) => {
    return await updateChartFromEvent(event)
})