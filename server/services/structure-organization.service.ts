import {
  createStructureChart,
  createStructureEdge,
  createStructureNode,
  findStructureChartByIdOrSlug,
  findStructureEdgeById,
  findStructureNodeById,
  listStructureCharts,
  listStructureEdges,
  listStructureNodes,
  softDeleteStructureChart,
  softDeleteStructureEdge,
  softDeleteStructureNode,
  updateStructureChart,
  updateStructureEdge,
  updateStructureNode,
  type ChartWriteInput,
  type EdgeWriteInput,
  type NodeWriteInput,
  type StructureChartRow,
  type StructureEdgeRow,
  type StructureNodeRow
} from '../repositories/structure-organization.repository'
import { findTenantSiteBySlug } from '../repositories/tenant-site.repository'

function parseJson<T = any>(value: unknown, fallback: T): T {
  if (!value) return fallback
  if (typeof value === 'object') return value as T

  if (typeof value === 'string') {
    try {
      return JSON.parse(value) as T
    } catch {
      return fallback
    }
  }

  return fallback
}

function cleanString(value: unknown, fallback = '') {
  const text = String(value || '').trim()
  return text || fallback
}

function nullable(value: unknown) {
  const text = String(value || '').trim()
  return text || null
}

function cleanSlug(value: unknown) {
  return String(value || '')
    .trim()
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '')
}

function numberValue(value: unknown, fallback = 0) {
  const number = Number(value)
  return Number.isFinite(number) ? number : fallback
}

function intValue(value: unknown, fallback = 0) {
  const number = Number(value)
  return Number.isFinite(number) ? Math.max(0, Math.floor(number)) : fallback
}

function boolValue(value: unknown, fallback = false) {
  if (value === undefined || value === null || value === '') return fallback
  return value === true || value === 1 || value === '1' || value === 'true'
}

function mergeObject(...items: unknown[]) {
  return items.reduce<Record<string, any>>((result, item) => {
    if (!item || typeof item !== 'object' || Array.isArray(item)) return result
    return {
      ...result,
      ...(item as Record<string, any>)
    }
  }, {})
}

function dateOrNull(value: unknown) {
  if (!value) return null
  const date = new Date(value as any)
  return Number.isNaN(date.getTime()) ? null : date
}

function getPageLimit(event: any) {
  const query = getQuery(event)

  const page = Math.max(1, Number(query.page || 1))
  const limit = Math.min(200, Math.max(1, Number(query.limit || 20)))

  return {
    page,
    limit
  }
}

function paginationMeta(page: number, limit: number, total: number) {
  const totalPages = Math.max(1, Math.ceil(total / limit))

  return {
    page,
    limit,
    total,
    totalPages,
    hasMore: page < totalPages
  }
}

function mapChart(row: StructureChartRow) {
  return {
    id: row.id,
    tenantId: row.tenant_id,
    title: row.title,
    slug: row.slug,
    description: row.description,
    chartType: row.chart_type,
    layoutEngine: row.layout_engine,
    layoutDirection: row.layout_direction,
    canvasWidth: Number(row.canvas_width || 1200),
    canvasHeight: Number(row.canvas_height || 800),
    backgroundColor: row.background_color,
    backgroundImageUrl: row.background_image_url,
    gridEnabled: Boolean(row.grid_enabled),
    gridSize: Number(row.grid_size || 20),
    snapToGrid: Boolean(row.snap_to_grid),
    zoomMin: Number(row.zoom_min || 0.25),
    zoomMax: Number(row.zoom_max || 2.5),
    initialScale: Number(row.initial_scale || 1),
    nodeDefaultConfig: parseJson(row.node_default_config, {}),
    edgeDefaultConfig: parseJson(row.edge_default_config, {}),
    konvaConfig: parseJson(row.konva_config, {}),
    metadata: parseJson(row.metadata, {}),
    status: row.status,
    isFeatured: Boolean(row.is_featured),
    sortOrder: Number(row.sort_order || 0),
    createdAt: row.created_at,
    updatedAt: row.updated_at
  }
}

function mapNode(row: StructureNodeRow) {
  return {
    id: row.id,
    tenantId: row.tenant_id,
    chartId: row.chart_id,
    parentId: row.parent_id,
    name: row.name,
    slug: row.slug,
    positionTitle: row.position_title,
    positionCode: row.position_code,
    organizationUnit: row.organization_unit,
    photoUrl: row.photo_url,
    icon: row.icon,
    shortDescription: row.short_description,
    contentHtml: row.content_html,
    contentJson: parseJson(row.content_json, {}),
    phone: row.phone,
    whatsapp: row.whatsapp,
    email: row.email,
    termStart: row.term_start,
    termEnd: row.term_end,
    nodeType: row.node_type,
    shapeType: row.shape_type,
    x: Number(row.x || 0),
    y: Number(row.y || 0),
    width: Number(row.width || 220),
    height: Number(row.height || 110),
    rotation: Number(row.rotation || 0),
    scaleX: Number(row.scale_x || 1),
    scaleY: Number(row.scale_y || 1),
    fillColor: row.fill_color,
    borderColor: row.border_color,
    borderWidth: Number(row.border_width || 1),
    textColor: row.text_color,
    accentColor: row.accent_color,
    fontFamily: row.font_family,
    nameFontSize: Number(row.name_font_size || 16),
    positionFontSize: Number(row.position_font_size || 13),
    photoShape: row.photo_shape,
    photoWidth: Number(row.photo_width || 56),
    photoHeight: Number(row.photo_height || 56),
    draggable: Boolean(row.draggable),
    locked: Boolean(row.locked),
    visible: Boolean(row.visible),
    konvaConfig: parseJson(row.konva_config, {}),
    styleConfig: parseJson(row.style_config, {}),
    socialConfig: parseJson(row.social_config, {}),
    metadata: parseJson(row.metadata, {}),
    status: row.status,
    isFeatured: Boolean(row.is_featured),
    sortOrder: Number(row.sort_order || 0)
  }
}

function mapEdge(row: StructureEdgeRow) {
  return {
    id: row.id,
    tenantId: row.tenant_id,
    chartId: row.chart_id,
    sourceNodeId: row.source_node_id,
    targetNodeId: row.target_node_id,
    edgeType: row.edge_type,
    label: row.label,
    lineType: row.line_type,
    strokeColor: row.stroke_color,
    strokeWidth: Number(row.stroke_width || 2),
    strokeDash: parseJson(row.stroke_dash, []),
    arrowStart: Boolean(row.arrow_start),
    arrowEnd: Boolean(row.arrow_end),
    pointsConfig: parseJson(row.points_config, {}),
    konvaConfig: parseJson(row.konva_config, {}),
    metadata: parseJson(row.metadata, {}),
    status: row.status,
    sortOrder: Number(row.sort_order || 0)
  }
}

async function resolveTenant(event: any) {
  const tenantSlug = cleanSlug(getRouterParam(event, 'tenantSlug'))

  if (!tenantSlug) {
    throw createError({
      statusCode: 400,
      statusMessage: 'Tenant slug tidak valid.'
    })
  }

  const tenant = await findTenantSiteBySlug(tenantSlug)

  if (!tenant) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Tenant tidak ditemukan atau tidak aktif.'
    })
  }

  return tenant
}

async function resolveChart(event: any, tenantId: string) {
  const chartId = cleanString(getRouterParam(event, 'chartId'))

  if (!chartId) {
    throw createError({
      statusCode: 400,
      statusMessage: 'Chart ID tidak valid.'
    })
  }

  const chart = await findStructureChartByIdOrSlug(tenantId, chartId)

  if (!chart) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Bagan struktur organisasi tidak ditemukan.'
    })
  }

  return chart
}

function buildChartInput(body: any, tenantId: string, current?: any): ChartWriteInput {
  return {
    tenantId,
    title: cleanString(body?.title ?? current?.title, 'Struktur Organisasi'),
    slug: cleanSlug(body?.slug ?? current?.slug ?? body?.title ?? current?.title ?? 'struktur-organisasi'),
    description: nullable(body?.description ?? current?.description),
    chartType: body?.chartType ?? current?.chartType ?? 'organization',
    layoutEngine: body?.layoutEngine ?? current?.layoutEngine ?? 'manual',
    layoutDirection: body?.layoutDirection ?? current?.layoutDirection ?? 'top-bottom',
    canvasWidth: intValue(body?.canvasWidth ?? current?.canvasWidth, 1200),
    canvasHeight: intValue(body?.canvasHeight ?? current?.canvasHeight, 800),
    backgroundColor: nullable(body?.backgroundColor ?? current?.backgroundColor),
    backgroundImageUrl: nullable(body?.backgroundImageUrl ?? current?.backgroundImageUrl),
    gridEnabled: boolValue(body?.gridEnabled ?? current?.gridEnabled, false),
    gridSize: intValue(body?.gridSize ?? current?.gridSize, 20),
    snapToGrid: boolValue(body?.snapToGrid ?? current?.snapToGrid, false),
    zoomMin: numberValue(body?.zoomMin ?? current?.zoomMin, 0.25),
    zoomMax: numberValue(body?.zoomMax ?? current?.zoomMax, 2.5),
    initialScale: numberValue(body?.initialScale ?? current?.initialScale, 1),
    nodeDefaultConfig: mergeObject(current?.nodeDefaultConfig, body?.nodeDefaultConfig),
    edgeDefaultConfig: mergeObject(current?.edgeDefaultConfig, body?.edgeDefaultConfig),
    konvaConfig: mergeObject(current?.konvaConfig, body?.konvaConfig),
    metadata: mergeObject(current?.metadata, body?.metadata),
    status: body?.status ?? current?.status ?? 'published',
    isFeatured: boolValue(body?.isFeatured ?? current?.isFeatured, false),
    sortOrder: intValue(body?.sortOrder ?? current?.sortOrder, 0)
  }
}

function buildNodeInput(body: any, tenantId: string, chartId: string, current?: any): NodeWriteInput {
  return {
    tenantId,
    chartId,
    parentId: nullable(body?.parentId ?? current?.parentId),
    name: cleanString(body?.name ?? current?.name, 'Nama'),
    slug: cleanSlug(body?.slug ?? current?.slug ?? body?.name ?? current?.name ?? 'node'),
    positionTitle: cleanString(body?.positionTitle ?? current?.positionTitle, 'Jabatan'),
    positionCode: nullable(body?.positionCode ?? current?.positionCode),
    organizationUnit: nullable(body?.organizationUnit ?? current?.organizationUnit),
    photoUrl: nullable(body?.photoUrl ?? current?.photoUrl),
    icon: nullable(body?.icon ?? current?.icon),
    shortDescription: nullable(body?.shortDescription ?? current?.shortDescription),
    contentHtml: body?.contentHtml ?? current?.contentHtml ?? null,
    contentJson: mergeObject(current?.contentJson, body?.contentJson),
    phone: nullable(body?.phone ?? current?.phone),
    whatsapp: nullable(body?.whatsapp ?? current?.whatsapp),
    email: nullable(body?.email ?? current?.email),
    termStart: dateOrNull(body?.termStart ?? current?.termStart),
    termEnd: dateOrNull(body?.termEnd ?? current?.termEnd),
    nodeType: body?.nodeType ?? current?.nodeType ?? 'person',
    shapeType: body?.shapeType ?? current?.shapeType ?? 'card',
    x: numberValue(body?.x ?? current?.x, 0),
    y: numberValue(body?.y ?? current?.y, 0),
    width: numberValue(body?.width ?? current?.width, 220),
    height: numberValue(body?.height ?? current?.height, 110),
    rotation: numberValue(body?.rotation ?? current?.rotation, 0),
    scaleX: numberValue(body?.scaleX ?? current?.scaleX, 1),
    scaleY: numberValue(body?.scaleY ?? current?.scaleY, 1),
    fillColor: nullable(body?.fillColor ?? current?.fillColor),
    borderColor: nullable(body?.borderColor ?? current?.borderColor),
    borderWidth: numberValue(body?.borderWidth ?? current?.borderWidth, 1),
    textColor: nullable(body?.textColor ?? current?.textColor),
    accentColor: nullable(body?.accentColor ?? current?.accentColor),
    fontFamily: nullable(body?.fontFamily ?? current?.fontFamily),
    nameFontSize: intValue(body?.nameFontSize ?? current?.nameFontSize, 16),
    positionFontSize: intValue(body?.positionFontSize ?? current?.positionFontSize, 13),
    photoShape: body?.photoShape ?? current?.photoShape ?? 'circle',
    photoWidth: numberValue(body?.photoWidth ?? current?.photoWidth, 56),
    photoHeight: numberValue(body?.photoHeight ?? current?.photoHeight, 56),
    draggable: boolValue(body?.draggable ?? current?.draggable, true),
    locked: boolValue(body?.locked ?? current?.locked, false),
    visible: boolValue(body?.visible ?? current?.visible, true),
    konvaConfig: mergeObject(current?.konvaConfig, body?.konvaConfig),
    styleConfig: mergeObject(current?.styleConfig, body?.styleConfig),
    socialConfig: mergeObject(current?.socialConfig, body?.socialConfig),
    metadata: mergeObject(current?.metadata, body?.metadata),
    status: body?.status ?? current?.status ?? 'active',
    isFeatured: boolValue(body?.isFeatured ?? current?.isFeatured, false),
    sortOrder: intValue(body?.sortOrder ?? current?.sortOrder, 0)
  }
}

function buildEdgeInput(body: any, tenantId: string, chartId: string, current?: any): EdgeWriteInput {
  return {
    tenantId,
    chartId,
    sourceNodeId: cleanString(body?.sourceNodeId ?? current?.sourceNodeId),
    targetNodeId: cleanString(body?.targetNodeId ?? current?.targetNodeId),
    edgeType: body?.edgeType ?? current?.edgeType ?? 'hierarchy',
    label: nullable(body?.label ?? current?.label),
    lineType: body?.lineType ?? current?.lineType ?? 'orthogonal',
    strokeColor: nullable(body?.strokeColor ?? current?.strokeColor),
    strokeWidth: numberValue(body?.strokeWidth ?? current?.strokeWidth, 2),
    strokeDash: Array.isArray(body?.strokeDash) ? body.strokeDash : current?.strokeDash || [],
    arrowStart: boolValue(body?.arrowStart ?? current?.arrowStart, false),
    arrowEnd: boolValue(body?.arrowEnd ?? current?.arrowEnd, false),
    pointsConfig: mergeObject(current?.pointsConfig, body?.pointsConfig),
    konvaConfig: mergeObject(current?.konvaConfig, body?.konvaConfig),
    metadata: mergeObject(current?.metadata, body?.metadata),
    status: body?.status ?? current?.status ?? 'active',
    sortOrder: intValue(body?.sortOrder ?? current?.sortOrder, 0)
  }
}

export async function listChartsFromEvent(event: any) {
  const tenant = await resolveTenant(event)
  const query = getQuery(event)
  const { page, limit } = getPageLimit(event)

  const result = await listStructureCharts({
    tenantId: tenant.id,
    q: cleanString(query.q),
    status: cleanString(query.status || 'published'),
    chartType: cleanString(query.chartType || query.type || 'all'),
    layoutEngine: cleanString(query.layoutEngine || 'all'),
    featured: boolValue(query.featured, false),
    page,
    limit,
    sort: cleanString(query.sort || 'sort_order')
  })

  return {
    data: result.rows.map(mapChart),
    meta: paginationMeta(page, limit, result.total)
  }
}

export async function createChartFromEvent(event: any) {
  const tenant = await resolveTenant(event)
  const body = await readBody(event)
  const payload = buildChartInput(body, tenant.id)
  const created = await createStructureChart(payload)

  if (!created) {
    throw createError({
      statusCode: 500,
      statusMessage: 'Bagan gagal dibuat.'
    })
  }

  setResponseStatus(event, 201)

  return {
    data: mapChart(created)
  }
}

export async function getChartFromEvent(event: any) {
  const tenant = await resolveTenant(event)
  const chart = await resolveChart(event, tenant.id)

  const query = getQuery(event)
  const includeGraph = cleanString(query.include || 'graph') === 'graph'

  if (!includeGraph) {
    return {
      data: mapChart(chart)
    }
  }

  const nodes = await listStructureNodes({
    tenantId: tenant.id,
    chartId: chart.id,
    status: 'active',
    page: 1,
    limit: 200,
    sort: 'sort_order'
  })

  const edges = await listStructureEdges({
    tenantId: tenant.id,
    chartId: chart.id,
    status: 'active',
    page: 1,
    limit: 200,
    sort: 'sort_order'
  })

  return {
    data: {
      chart: mapChart(chart),
      nodes: nodes.rows.map(mapNode),
      edges: edges.rows.map(mapEdge)
    }
  }
}

export async function updateChartFromEvent(event: any) {
  const tenant = await resolveTenant(event)
  const chart = await resolveChart(event, tenant.id)
  const body = await readBody(event)

  const current = mapChart(chart)
  const payload = buildChartInput(body, tenant.id, current)
  const updated = await updateStructureChart(chart.id, payload)

  if (!updated) {
    throw createError({
      statusCode: 500,
      statusMessage: 'Bagan gagal diperbarui.'
    })
  }

  return {
    data: mapChart(updated)
  }
}

export async function deleteChartFromEvent(event: any) {
  const tenant = await resolveTenant(event)
  const chart = await resolveChart(event, tenant.id)

  await softDeleteStructureChart(tenant.id, chart.id)

  return {
    message: 'Bagan berhasil dihapus.'
  }
}

export async function listNodesFromEvent(event: any) {
  const tenant = await resolveTenant(event)
  const chart = await resolveChart(event, tenant.id)
  const query = getQuery(event)
  const { page, limit } = getPageLimit(event)

  const hasViewport =
    query.viewportX !== undefined &&
    query.viewportY !== undefined &&
    query.viewportWidth !== undefined &&
    query.viewportHeight !== undefined

  const result = await listStructureNodes({
    tenantId: tenant.id,
    chartId: chart.id,
    q: cleanString(query.q),
    status: cleanString(query.status || 'active'),
    nodeType: cleanString(query.nodeType || query.type || 'all'),
    parentId: query.parentId === undefined ? undefined : cleanString(query.parentId),
    visible: query.visible === undefined ? undefined : boolValue(query.visible),
    viewport: hasViewport
      ? {
          x: numberValue(query.viewportX, 0),
          y: numberValue(query.viewportY, 0),
          width: numberValue(query.viewportWidth, 1200),
          height: numberValue(query.viewportHeight, 800)
        }
      : null,
    page,
    limit,
    sort: cleanString(query.sort || 'sort_order')
  })

  return {
    data: result.rows.map(mapNode),
    meta: paginationMeta(page, limit, result.total)
  }
}

export async function createNodeFromEvent(event: any) {
  const tenant = await resolveTenant(event)
  const chart = await resolveChart(event, tenant.id)
  const body = await readBody(event)

  const payload = buildNodeInput(body, tenant.id, chart.id)
  const created = await createStructureNode(payload)

  if (!created) {
    throw createError({
      statusCode: 500,
      statusMessage: 'Node struktur gagal dibuat.'
    })
  }

  setResponseStatus(event, 201)

  return {
    data: mapNode(created)
  }
}

export async function getNodeFromEvent(event: any) {
  const tenant = await resolveTenant(event)
  const chart = await resolveChart(event, tenant.id)
  const nodeId = cleanString(getRouterParam(event, 'nodeId'))

  const node = await findStructureNodeById(tenant.id, chart.id, nodeId)

  if (!node) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Node struktur tidak ditemukan.'
    })
  }

  return {
    data: mapNode(node)
  }
}

export async function updateNodeFromEvent(event: any) {
  const tenant = await resolveTenant(event)
  const chart = await resolveChart(event, tenant.id)
  const nodeId = cleanString(getRouterParam(event, 'nodeId'))

  const node = await findStructureNodeById(tenant.id, chart.id, nodeId)

  if (!node) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Node struktur tidak ditemukan.'
    })
  }

  const body = await readBody(event)
  const current = mapNode(node)
  const payload = buildNodeInput(body, tenant.id, chart.id, current)
  const updated = await updateStructureNode(node.id, payload)

  if (!updated) {
    throw createError({
      statusCode: 500,
      statusMessage: 'Node struktur gagal diperbarui.'
    })
  }

  return {
    data: mapNode(updated)
  }
}

export async function deleteNodeFromEvent(event: any) {
  const tenant = await resolveTenant(event)
  const chart = await resolveChart(event, tenant.id)
  const nodeId = cleanString(getRouterParam(event, 'nodeId'))

  const node = await findStructureNodeById(tenant.id, chart.id, nodeId)

  if (!node) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Node struktur tidak ditemukan.'
    })
  }

  await softDeleteStructureNode(tenant.id, chart.id, node.id)

  return {
    message: 'Node struktur berhasil dihapus.'
  }
}

export async function listEdgesFromEvent(event: any) {
  const tenant = await resolveTenant(event)
  const chart = await resolveChart(event, tenant.id)
  const query = getQuery(event)
  const { page, limit } = getPageLimit(event)

  const visibleNodeIds = cleanString(query.visibleNodeIds)
    .split(',')
    .map((item) => item.trim())
    .filter(Boolean)

  const result = await listStructureEdges({
    tenantId: tenant.id,
    chartId: chart.id,
    status: cleanString(query.status || 'active'),
    edgeType: cleanString(query.edgeType || query.type || 'all'),
    sourceNodeId: cleanString(query.sourceNodeId),
    targetNodeId: cleanString(query.targetNodeId),
    visibleNodeIds,
    page,
    limit,
    sort: cleanString(query.sort || 'sort_order')
  })

  return {
    data: result.rows.map(mapEdge),
    meta: paginationMeta(page, limit, result.total)
  }
}

export async function createEdgeFromEvent(event: any) {
  const tenant = await resolveTenant(event)
  const chart = await resolveChart(event, tenant.id)
  const body = await readBody(event)

  const payload = buildEdgeInput(body, tenant.id, chart.id)

  if (!payload.sourceNodeId || !payload.targetNodeId) {
    throw createError({
      statusCode: 400,
      statusMessage: 'sourceNodeId dan targetNodeId wajib diisi.'
    })
  }

  const created = await createStructureEdge(payload)

  if (!created) {
    throw createError({
      statusCode: 500,
      statusMessage: 'Garis struktur gagal dibuat.'
    })
  }

  setResponseStatus(event, 201)

  return {
    data: mapEdge(created)
  }
}

export async function getEdgeFromEvent(event: any) {
  const tenant = await resolveTenant(event)
  const chart = await resolveChart(event, tenant.id)
  const edgeId = cleanString(getRouterParam(event, 'edgeId'))

  const edge = await findStructureEdgeById(tenant.id, chart.id, edgeId)

  if (!edge) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Garis struktur tidak ditemukan.'
    })
  }

  return {
    data: mapEdge(edge)
  }
}

export async function updateEdgeFromEvent(event: any) {
  const tenant = await resolveTenant(event)
  const chart = await resolveChart(event, tenant.id)
  const edgeId = cleanString(getRouterParam(event, 'edgeId'))

  const edge = await findStructureEdgeById(tenant.id, chart.id, edgeId)

  if (!edge) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Garis struktur tidak ditemukan.'
    })
  }

  const body = await readBody(event)
  const current = mapEdge(edge)
  const payload = buildEdgeInput(body, tenant.id, chart.id, current)

  if (!payload.sourceNodeId || !payload.targetNodeId) {
    throw createError({
      statusCode: 400,
      statusMessage: 'sourceNodeId dan targetNodeId wajib diisi.'
    })
  }

  const updated = await updateStructureEdge(edge.id, payload)

  if (!updated) {
    throw createError({
      statusCode: 500,
      statusMessage: 'Garis struktur gagal diperbarui.'
    })
  }

  return {
    data: mapEdge(updated)
  }
}

export async function deleteEdgeFromEvent(event: any) {
  const tenant = await resolveTenant(event)
  const chart = await resolveChart(event, tenant.id)
  const edgeId = cleanString(getRouterParam(event, 'edgeId'))

  const edge = await findStructureEdgeById(tenant.id, chart.id, edgeId)

  if (!edge) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Garis struktur tidak ditemukan.'
    })
  }

  await softDeleteStructureEdge(tenant.id, chart.id, edge.id)

  return {
    message: 'Garis struktur berhasil dihapus.'
  }
}