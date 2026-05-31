import type { RowDataPacket } from 'mysql2/promise'
import { dbQuery } from '../utils/mysql'

export type StructureChartRow = RowDataPacket & {
  id: string
  tenant_id: string
  title: string
  slug: string
  description: string | null
  chart_type: string
  layout_engine: string
  layout_direction: string
  canvas_width: number
  canvas_height: number
  background_color: string | null
  background_image_url: string | null
  grid_enabled: 0 | 1
  grid_size: number
  snap_to_grid: 0 | 1
  zoom_min: number | string
  zoom_max: number | string
  initial_scale: number | string
  node_default_config: unknown
  edge_default_config: unknown
  konva_config: unknown
  metadata: unknown
  status: string
  is_featured: 0 | 1
  sort_order: number
  created_at: Date | string
  updated_at: Date | string
}

export type StructureNodeRow = RowDataPacket & {
  id: string
  tenant_id: string
  chart_id: string
  parent_id: string | null
  name: string
  slug: string
  position_title: string
  position_code: string | null
  organization_unit: string | null
  photo_url: string | null
  icon: string | null
  short_description: string | null
  content_html: string | null
  content_json: unknown
  phone: string | null
  whatsapp: string | null
  email: string | null
  term_start: Date | string | null
  term_end: Date | string | null
  node_type: string
  shape_type: string
  x: number | string
  y: number | string
  width: number | string
  height: number | string
  rotation: number | string
  scale_x: number | string
  scale_y: number | string
  fill_color: string | null
  border_color: string | null
  border_width: number | string
  text_color: string | null
  accent_color: string | null
  font_family: string | null
  name_font_size: number
  position_font_size: number
  photo_shape: string
  photo_width: number | string
  photo_height: number | string
  draggable: 0 | 1
  locked: 0 | 1
  visible: 0 | 1
  konva_config: unknown
  style_config: unknown
  social_config: unknown
  metadata: unknown
  status: string
  is_featured: 0 | 1
  sort_order: number
  created_at: Date | string
  updated_at: Date | string
}

export type StructureEdgeRow = RowDataPacket & {
  id: string
  tenant_id: string
  chart_id: string
  source_node_id: string
  target_node_id: string
  edge_type: string
  label: string | null
  line_type: string
  stroke_color: string | null
  stroke_width: number | string
  stroke_dash: unknown
  arrow_start: 0 | 1
  arrow_end: 0 | 1
  points_config: unknown
  konva_config: unknown
  metadata: unknown
  status: string
  sort_order: number
  created_at: Date | string
  updated_at: Date | string
}

type CountRow = RowDataPacket & {
  total: number
}

export type PaginatedResult<T> = {
  rows: T[]
  total: number
}

export type ChartListParams = {
  tenantId: string
  q?: string
  status?: string
  chartType?: string
  layoutEngine?: string
  featured?: boolean
  page: number
  limit: number
  sort?: string
}

export type NodeListParams = {
  tenantId: string
  chartId: string
  q?: string
  status?: string
  nodeType?: string
  parentId?: string | null
  visible?: boolean
  page: number
  limit: number
  sort?: string
  viewport?: {
    x: number
    y: number
    width: number
    height: number
  } | null
}

export type EdgeListParams = {
  tenantId: string
  chartId: string
  status?: string
  edgeType?: string
  sourceNodeId?: string
  targetNodeId?: string
  visibleNodeIds?: string[]
  page: number
  limit: number
  sort?: string
}

export type ChartWriteInput = {
  id?: string
  tenantId: string
  title: string
  slug: string
  description?: string | null
  chartType?: string
  layoutEngine?: string
  layoutDirection?: string
  canvasWidth?: number
  canvasHeight?: number
  backgroundColor?: string | null
  backgroundImageUrl?: string | null
  gridEnabled?: boolean
  gridSize?: number
  snapToGrid?: boolean
  zoomMin?: number
  zoomMax?: number
  initialScale?: number
  nodeDefaultConfig?: Record<string, any>
  edgeDefaultConfig?: Record<string, any>
  konvaConfig?: Record<string, any>
  metadata?: Record<string, any>
  status?: string
  isFeatured?: boolean
  sortOrder?: number
}

export type NodeWriteInput = {
  id?: string
  tenantId: string
  chartId: string
  parentId?: string | null
  name: string
  slug: string
  positionTitle: string
  positionCode?: string | null
  organizationUnit?: string | null
  photoUrl?: string | null
  icon?: string | null
  shortDescription?: string | null
  contentHtml?: string | null
  contentJson?: Record<string, any>
  phone?: string | null
  whatsapp?: string | null
  email?: string | null
  termStart?: string | Date | null
  termEnd?: string | Date | null
  nodeType?: string
  shapeType?: string
  x?: number
  y?: number
  width?: number
  height?: number
  rotation?: number
  scaleX?: number
  scaleY?: number
  fillColor?: string | null
  borderColor?: string | null
  borderWidth?: number
  textColor?: string | null
  accentColor?: string | null
  fontFamily?: string | null
  nameFontSize?: number
  positionFontSize?: number
  photoShape?: string
  photoWidth?: number
  photoHeight?: number
  draggable?: boolean
  locked?: boolean
  visible?: boolean
  konvaConfig?: Record<string, any>
  styleConfig?: Record<string, any>
  socialConfig?: Record<string, any>
  metadata?: Record<string, any>
  status?: string
  isFeatured?: boolean
  sortOrder?: number
}

export type EdgeWriteInput = {
  id?: string
  tenantId: string
  chartId: string
  sourceNodeId: string
  targetNodeId: string
  edgeType?: string
  label?: string | null
  lineType?: string
  strokeColor?: string | null
  strokeWidth?: number
  strokeDash?: any[]
  arrowStart?: boolean
  arrowEnd?: boolean
  pointsConfig?: Record<string, any>
  konvaConfig?: Record<string, any>
  metadata?: Record<string, any>
  status?: string
  sortOrder?: number
}

const chartColumns = `
  id,
  tenant_id,
  title,
  slug,
  description,
  chart_type,
  layout_engine,
  layout_direction,
  canvas_width,
  canvas_height,
  background_color,
  background_image_url,
  grid_enabled,
  grid_size,
  snap_to_grid,
  zoom_min,
  zoom_max,
  initial_scale,
  node_default_config,
  edge_default_config,
  konva_config,
  metadata,
  status,
  is_featured,
  sort_order,
  created_at,
  updated_at
`

const nodeColumns = `
  id,
  tenant_id,
  chart_id,
  parent_id,
  name,
  slug,
  position_title,
  position_code,
  organization_unit,
  photo_url,
  icon,
  short_description,
  content_html,
  content_json,
  phone,
  whatsapp,
  email,
  term_start,
  term_end,
  node_type,
  shape_type,
  x,
  y,
  width,
  height,
  rotation,
  scale_x,
  scale_y,
  fill_color,
  border_color,
  border_width,
  text_color,
  accent_color,
  font_family,
  name_font_size,
  position_font_size,
  photo_shape,
  photo_width,
  photo_height,
  draggable,
  locked,
  visible,
  konva_config,
  style_config,
  social_config,
  metadata,
  status,
  is_featured,
  sort_order,
  created_at,
  updated_at
`

const edgeColumns = `
  id,
  tenant_id,
  chart_id,
  source_node_id,
  target_node_id,
  edge_type,
  label,
  line_type,
  stroke_color,
  stroke_width,
  stroke_dash,
  arrow_start,
  arrow_end,
  points_config,
  konva_config,
  metadata,
  status,
  sort_order,
  created_at,
  updated_at
`

function uuid() {
  return crypto.randomUUID()
}

function jsonValue(value: unknown, fallback: any) {
  if (value === undefined || value === null) return JSON.stringify(fallback)
  return JSON.stringify(value)
}

function nullable(value: unknown) {
  const text = String(value || '').trim()
  return text || null
}

function numberValue(value: unknown, fallback = 0) {
  const number = Number(value)
  return Number.isFinite(number) ? number : fallback
}

function intValue(value: unknown, fallback = 0) {
  const number = Number(value)
  return Number.isFinite(number) ? Math.max(0, Math.floor(number)) : fallback
}

function boolValue(value: unknown) {
  return value === true || value === 1 || value === '1' || value === 'true'
}

function dateValue(value: unknown) {
  if (!value) return null
  const date = new Date(value as any)
  return Number.isNaN(date.getTime()) ? null : date
}

function cleanSlug(value: unknown) {
  return String(value || '')
    .trim()
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '')
}

function normalizePage(page: number) {
  return Math.max(1, Number(page || 1))
}

function normalizeLimit(limit: number) {
  return Math.min(200, Math.max(1, Number(limit || 20)))
}

function offsetFrom(page: number, limit: number) {
  return (normalizePage(page) - 1) * normalizeLimit(limit)
}

function chartOrderBy(sort?: string) {
  if (sort === 'newest') return 'created_at DESC'
  if (sort === 'oldest') return 'created_at ASC'
  if (sort === 'title') return 'title ASC'
  if (sort === 'updated') return 'updated_at DESC'
  return 'sort_order ASC, created_at DESC'
}

function nodeOrderBy(sort?: string) {
  if (sort === 'newest') return 'created_at DESC'
  if (sort === 'oldest') return 'created_at ASC'
  if (sort === 'name') return 'name ASC'
  if (sort === 'position') return 'position_title ASC'
  if (sort === 'y') return 'y ASC, x ASC'
  return 'sort_order ASC, y ASC, x ASC'
}

function edgeOrderBy(sort?: string) {
  if (sort === 'newest') return 'created_at DESC'
  if (sort === 'oldest') return 'created_at ASC'
  return 'sort_order ASC, created_at ASC'
}

export async function listStructureCharts(params: ChartListParams): Promise<PaginatedResult<StructureChartRow>> {
  const where = ['tenant_id = ?', 'deleted_at IS NULL']
  const values: any[] = [params.tenantId]

  if (params.q) {
    where.push('(title LIKE ? OR slug LIKE ? OR description LIKE ?)')
    const keyword = `%${params.q}%`
    values.push(keyword, keyword, keyword)
  }

  if (params.status && params.status !== 'all') {
    where.push('status = ?')
    values.push(params.status)
  }

  if (params.chartType && params.chartType !== 'all') {
    where.push('chart_type = ?')
    values.push(params.chartType)
  }

  if (params.layoutEngine && params.layoutEngine !== 'all') {
    where.push('layout_engine = ?')
    values.push(params.layoutEngine)
  }

  if (params.featured) {
    where.push('is_featured = 1')
  }

  const whereSql = where.join(' AND ')
  const page = normalizePage(params.page)
  const limit = normalizeLimit(params.limit)
  const offset = offsetFrom(page, limit)

  const countRows = await dbQuery<CountRow[]>(
    `SELECT COUNT(*) AS total FROM structure_organization_charts WHERE ${whereSql}`,
    values
  )

  const rows = await dbQuery<StructureChartRow[]>(
    `
      SELECT ${chartColumns}
      FROM structure_organization_charts
      WHERE ${whereSql}
      ORDER BY ${chartOrderBy(params.sort)}
      LIMIT ? OFFSET ?
    `,
    [...values, limit, offset]
  )

  return {
    rows,
    total: Number(countRows[0]?.total || 0)
  }
}

export async function findStructureChartByIdOrSlug(tenantId: string, idOrSlug: string) {
  const rows = await dbQuery<StructureChartRow[]>(
    `
      SELECT ${chartColumns}
      FROM structure_organization_charts
      WHERE tenant_id = ?
      AND deleted_at IS NULL
      AND (id = ? OR slug = ?)
      LIMIT 1
    `,
    [tenantId, idOrSlug, cleanSlug(idOrSlug)]
  )

  return rows[0] || null
}

export async function createStructureChart(input: ChartWriteInput) {
  const id = input.id || uuid()

  await dbQuery(
    `
      INSERT INTO structure_organization_charts (
        id,
        tenant_id,
        title,
        slug,
        description,
        chart_type,
        layout_engine,
        layout_direction,
        canvas_width,
        canvas_height,
        background_color,
        background_image_url,
        grid_enabled,
        grid_size,
        snap_to_grid,
        zoom_min,
        zoom_max,
        initial_scale,
        node_default_config,
        edge_default_config,
        konva_config,
        metadata,
        status,
        is_featured,
        sort_order,
        created_at,
        updated_at
      )
      VALUES (
        ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,
        NOW(), NOW()
      )
    `,
    [
      id,
      input.tenantId,
      input.title,
      cleanSlug(input.slug || input.title),
      nullable(input.description),
      input.chartType || 'organization',
      input.layoutEngine || 'manual',
      input.layoutDirection || 'top-bottom',
      intValue(input.canvasWidth, 1200),
      intValue(input.canvasHeight, 800),
      nullable(input.backgroundColor),
      nullable(input.backgroundImageUrl),
      boolValue(input.gridEnabled) ? 1 : 0,
      intValue(input.gridSize, 20),
      boolValue(input.snapToGrid) ? 1 : 0,
      numberValue(input.zoomMin, 0.25),
      numberValue(input.zoomMax, 2.5),
      numberValue(input.initialScale, 1),
      jsonValue(input.nodeDefaultConfig, {}),
      jsonValue(input.edgeDefaultConfig, {}),
      jsonValue(input.konvaConfig, {}),
      jsonValue(input.metadata, {}),
      input.status || 'published',
      boolValue(input.isFeatured) ? 1 : 0,
      intValue(input.sortOrder, 0)
    ]
  )

  return findStructureChartByIdOrSlug(input.tenantId, id)
}

export async function updateStructureChart(id: string, input: ChartWriteInput) {
  await dbQuery(
    `
      UPDATE structure_organization_charts
      SET
        title = ?,
        slug = ?,
        description = ?,
        chart_type = ?,
        layout_engine = ?,
        layout_direction = ?,
        canvas_width = ?,
        canvas_height = ?,
        background_color = ?,
        background_image_url = ?,
        grid_enabled = ?,
        grid_size = ?,
        snap_to_grid = ?,
        zoom_min = ?,
        zoom_max = ?,
        initial_scale = ?,
        node_default_config = ?,
        edge_default_config = ?,
        konva_config = ?,
        metadata = ?,
        status = ?,
        is_featured = ?,
        sort_order = ?,
        updated_at = NOW()
      WHERE id = ?
      AND tenant_id = ?
      AND deleted_at IS NULL
    `,
    [
      input.title,
      cleanSlug(input.slug || input.title),
      nullable(input.description),
      input.chartType || 'organization',
      input.layoutEngine || 'manual',
      input.layoutDirection || 'top-bottom',
      intValue(input.canvasWidth, 1200),
      intValue(input.canvasHeight, 800),
      nullable(input.backgroundColor),
      nullable(input.backgroundImageUrl),
      boolValue(input.gridEnabled) ? 1 : 0,
      intValue(input.gridSize, 20),
      boolValue(input.snapToGrid) ? 1 : 0,
      numberValue(input.zoomMin, 0.25),
      numberValue(input.zoomMax, 2.5),
      numberValue(input.initialScale, 1),
      jsonValue(input.nodeDefaultConfig, {}),
      jsonValue(input.edgeDefaultConfig, {}),
      jsonValue(input.konvaConfig, {}),
      jsonValue(input.metadata, {}),
      input.status || 'published',
      boolValue(input.isFeatured) ? 1 : 0,
      intValue(input.sortOrder, 0),
      id,
      input.tenantId
    ]
  )

  return findStructureChartByIdOrSlug(input.tenantId, id)
}

export async function softDeleteStructureChart(tenantId: string, id: string) {
  await dbQuery(
    `
      UPDATE structure_organization_charts
      SET
        status = 'inactive',
        deleted_at = NOW(),
        updated_at = NOW()
      WHERE id = ?
      AND tenant_id = ?
      AND deleted_at IS NULL
    `,
    [id, tenantId]
  )

  return true
}

export async function listStructureNodes(params: NodeListParams): Promise<PaginatedResult<StructureNodeRow>> {
  const where = ['tenant_id = ?', 'chart_id = ?', 'deleted_at IS NULL']
  const values: any[] = [params.tenantId, params.chartId]

  if (params.q) {
    where.push('(name LIKE ? OR slug LIKE ? OR position_title LIKE ? OR organization_unit LIKE ?)')
    const keyword = `%${params.q}%`
    values.push(keyword, keyword, keyword, keyword)
  }

  if (params.status && params.status !== 'all') {
    where.push('status = ?')
    values.push(params.status)
  }

  if (params.nodeType && params.nodeType !== 'all') {
    where.push('node_type = ?')
    values.push(params.nodeType)
  }

  if (params.parentId !== undefined) {
    if (params.parentId === null || params.parentId === '') {
      where.push('parent_id IS NULL')
    } else {
      where.push('parent_id = ?')
      values.push(params.parentId)
    }
  }

  if (typeof params.visible === 'boolean') {
    where.push('visible = ?')
    values.push(params.visible ? 1 : 0)
  }

  if (params.viewport) {
    where.push('(x + width >= ? AND x <= ? AND y + height >= ? AND y <= ?)')
    values.push(
      params.viewport.x,
      params.viewport.x + params.viewport.width,
      params.viewport.y,
      params.viewport.y + params.viewport.height
    )
  }

  const whereSql = where.join(' AND ')
  const page = normalizePage(params.page)
  const limit = normalizeLimit(params.limit)
  const offset = offsetFrom(page, limit)

  const countRows = await dbQuery<CountRow[]>(
    `SELECT COUNT(*) AS total FROM structure_organizations WHERE ${whereSql}`,
    values
  )

  const rows = await dbQuery<StructureNodeRow[]>(
    `
      SELECT ${nodeColumns}
      FROM structure_organizations
      WHERE ${whereSql}
      ORDER BY ${nodeOrderBy(params.sort)}
      LIMIT ? OFFSET ?
    `,
    [...values, limit, offset]
  )

  return {
    rows,
    total: Number(countRows[0]?.total || 0)
  }
}

export async function findStructureNodeById(tenantId: string, chartId: string, id: string) {
  const rows = await dbQuery<StructureNodeRow[]>(
    `
      SELECT ${nodeColumns}
      FROM structure_organizations
      WHERE tenant_id = ?
      AND chart_id = ?
      AND id = ?
      AND deleted_at IS NULL
      LIMIT 1
    `,
    [tenantId, chartId, id]
  )

  return rows[0] || null
}

export async function createStructureNode(input: NodeWriteInput) {
  const id = input.id || uuid()

  await dbQuery(
    `
      INSERT INTO structure_organizations (
        id,
        tenant_id,
        chart_id,
        parent_id,
        name,
        slug,
        position_title,
        position_code,
        organization_unit,
        photo_url,
        icon,
        short_description,
        content_html,
        content_json,
        phone,
        whatsapp,
        email,
        term_start,
        term_end,
        node_type,
        shape_type,
        x,
        y,
        width,
        height,
        rotation,
        scale_x,
        scale_y,
        fill_color,
        border_color,
        border_width,
        text_color,
        accent_color,
        font_family,
        name_font_size,
        position_font_size,
        photo_shape,
        photo_width,
        photo_height,
        draggable,
        locked,
        visible,
        konva_config,
        style_config,
        social_config,
        metadata,
        status,
        is_featured,
        sort_order,
        created_at,
        updated_at
      )
      VALUES (
        ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,
        ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,
        NOW(), NOW()
      )
    `,
    [
      id,
      input.tenantId,
      input.chartId,
      nullable(input.parentId),
      input.name,
      cleanSlug(input.slug || input.name),
      input.positionTitle,
      nullable(input.positionCode),
      nullable(input.organizationUnit),
      nullable(input.photoUrl),
      nullable(input.icon),
      nullable(input.shortDescription),
      input.contentHtml || null,
      jsonValue(input.contentJson, {}),
      nullable(input.phone),
      nullable(input.whatsapp),
      nullable(input.email),
      dateValue(input.termStart),
      dateValue(input.termEnd),
      input.nodeType || 'person',
      input.shapeType || 'card',
      numberValue(input.x, 0),
      numberValue(input.y, 0),
      numberValue(input.width, 220),
      numberValue(input.height, 110),
      numberValue(input.rotation, 0),
      numberValue(input.scaleX, 1),
      numberValue(input.scaleY, 1),
      nullable(input.fillColor),
      nullable(input.borderColor),
      numberValue(input.borderWidth, 1),
      nullable(input.textColor),
      nullable(input.accentColor),
      nullable(input.fontFamily),
      intValue(input.nameFontSize, 16),
      intValue(input.positionFontSize, 13),
      input.photoShape || 'circle',
      numberValue(input.photoWidth, 56),
      numberValue(input.photoHeight, 56),
      input.draggable === false ? 0 : 1,
      boolValue(input.locked) ? 1 : 0,
      input.visible === false ? 0 : 1,
      jsonValue(input.konvaConfig, {}),
      jsonValue(input.styleConfig, {}),
      jsonValue(input.socialConfig, {}),
      jsonValue(input.metadata, {}),
      input.status || 'active',
      boolValue(input.isFeatured) ? 1 : 0,
      intValue(input.sortOrder, 0)
    ]
  )

  return findStructureNodeById(input.tenantId, input.chartId, id)
}

export async function updateStructureNode(id: string, input: NodeWriteInput) {
  await dbQuery(
    `
      UPDATE structure_organizations
      SET
        parent_id = ?,
        name = ?,
        slug = ?,
        position_title = ?,
        position_code = ?,
        organization_unit = ?,
        photo_url = ?,
        icon = ?,
        short_description = ?,
        content_html = ?,
        content_json = ?,
        phone = ?,
        whatsapp = ?,
        email = ?,
        term_start = ?,
        term_end = ?,
        node_type = ?,
        shape_type = ?,
        x = ?,
        y = ?,
        width = ?,
        height = ?,
        rotation = ?,
        scale_x = ?,
        scale_y = ?,
        fill_color = ?,
        border_color = ?,
        border_width = ?,
        text_color = ?,
        accent_color = ?,
        font_family = ?,
        name_font_size = ?,
        position_font_size = ?,
        photo_shape = ?,
        photo_width = ?,
        photo_height = ?,
        draggable = ?,
        locked = ?,
        visible = ?,
        konva_config = ?,
        style_config = ?,
        social_config = ?,
        metadata = ?,
        status = ?,
        is_featured = ?,
        sort_order = ?,
        updated_at = NOW()
      WHERE id = ?
      AND tenant_id = ?
      AND chart_id = ?
      AND deleted_at IS NULL
    `,
    [
      nullable(input.parentId),
      input.name,
      cleanSlug(input.slug || input.name),
      input.positionTitle,
      nullable(input.positionCode),
      nullable(input.organizationUnit),
      nullable(input.photoUrl),
      nullable(input.icon),
      nullable(input.shortDescription),
      input.contentHtml || null,
      jsonValue(input.contentJson, {}),
      nullable(input.phone),
      nullable(input.whatsapp),
      nullable(input.email),
      dateValue(input.termStart),
      dateValue(input.termEnd),
      input.nodeType || 'person',
      input.shapeType || 'card',
      numberValue(input.x, 0),
      numberValue(input.y, 0),
      numberValue(input.width, 220),
      numberValue(input.height, 110),
      numberValue(input.rotation, 0),
      numberValue(input.scaleX, 1),
      numberValue(input.scaleY, 1),
      nullable(input.fillColor),
      nullable(input.borderColor),
      numberValue(input.borderWidth, 1),
      nullable(input.textColor),
      nullable(input.accentColor),
      nullable(input.fontFamily),
      intValue(input.nameFontSize, 16),
      intValue(input.positionFontSize, 13),
      input.photoShape || 'circle',
      numberValue(input.photoWidth, 56),
      numberValue(input.photoHeight, 56),
      input.draggable === false ? 0 : 1,
      boolValue(input.locked) ? 1 : 0,
      input.visible === false ? 0 : 1,
      jsonValue(input.konvaConfig, {}),
      jsonValue(input.styleConfig, {}),
      jsonValue(input.socialConfig, {}),
      jsonValue(input.metadata, {}),
      input.status || 'active',
      boolValue(input.isFeatured) ? 1 : 0,
      intValue(input.sortOrder, 0),
      id,
      input.tenantId,
      input.chartId
    ]
  )

  return findStructureNodeById(input.tenantId, input.chartId, id)
}

export async function softDeleteStructureNode(tenantId: string, chartId: string, id: string) {
  await dbQuery(
    `
      UPDATE structure_organizations
      SET
        status = 'inactive',
        deleted_at = NOW(),
        updated_at = NOW()
      WHERE id = ?
      AND tenant_id = ?
      AND chart_id = ?
      AND deleted_at IS NULL
    `,
    [id, tenantId, chartId]
  )

  await dbQuery(
    `
      UPDATE structure_organization_edges
      SET
        status = 'inactive',
        deleted_at = NOW(),
        updated_at = NOW()
      WHERE tenant_id = ?
      AND chart_id = ?
      AND deleted_at IS NULL
      AND (source_node_id = ? OR target_node_id = ?)
    `,
    [tenantId, chartId, id, id]
  )

  return true
}

export async function listStructureEdges(params: EdgeListParams): Promise<PaginatedResult<StructureEdgeRow>> {
  const where = ['tenant_id = ?', 'chart_id = ?', 'deleted_at IS NULL']
  const values: any[] = [params.tenantId, params.chartId]

  if (params.status && params.status !== 'all') {
    where.push('status = ?')
    values.push(params.status)
  }

  if (params.edgeType && params.edgeType !== 'all') {
    where.push('edge_type = ?')
    values.push(params.edgeType)
  }

  if (params.sourceNodeId) {
    where.push('source_node_id = ?')
    values.push(params.sourceNodeId)
  }

  if (params.targetNodeId) {
    where.push('target_node_id = ?')
    values.push(params.targetNodeId)
  }

  if (params.visibleNodeIds?.length) {
    const placeholders = params.visibleNodeIds.map(() => '?').join(',')
    where.push(`(source_node_id IN (${placeholders}) OR target_node_id IN (${placeholders}))`)
    values.push(...params.visibleNodeIds, ...params.visibleNodeIds)
  }

  const whereSql = where.join(' AND ')
  const page = normalizePage(params.page)
  const limit = normalizeLimit(params.limit)
  const offset = offsetFrom(page, limit)

  const countRows = await dbQuery<CountRow[]>(
    `SELECT COUNT(*) AS total FROM structure_organization_edges WHERE ${whereSql}`,
    values
  )

  const rows = await dbQuery<StructureEdgeRow[]>(
    `
      SELECT ${edgeColumns}
      FROM structure_organization_edges
      WHERE ${whereSql}
      ORDER BY ${edgeOrderBy(params.sort)}
      LIMIT ? OFFSET ?
    `,
    [...values, limit, offset]
  )

  return {
    rows,
    total: Number(countRows[0]?.total || 0)
  }
}

export async function findStructureEdgeById(tenantId: string, chartId: string, id: string) {
  const rows = await dbQuery<StructureEdgeRow[]>(
    `
      SELECT ${edgeColumns}
      FROM structure_organization_edges
      WHERE tenant_id = ?
      AND chart_id = ?
      AND id = ?
      AND deleted_at IS NULL
      LIMIT 1
    `,
    [tenantId, chartId, id]
  )

  return rows[0] || null
}

export async function createStructureEdge(input: EdgeWriteInput) {
  const id = input.id || uuid()

  await dbQuery(
    `
      INSERT INTO structure_organization_edges (
        id,
        tenant_id,
        chart_id,
        source_node_id,
        target_node_id,
        edge_type,
        label,
        line_type,
        stroke_color,
        stroke_width,
        stroke_dash,
        arrow_start,
        arrow_end,
        points_config,
        konva_config,
        metadata,
        status,
        sort_order,
        created_at,
        updated_at
      )
      VALUES (
        ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,
        NOW(), NOW()
      )
    `,
    [
      id,
      input.tenantId,
      input.chartId,
      input.sourceNodeId,
      input.targetNodeId,
      input.edgeType || 'hierarchy',
      nullable(input.label),
      input.lineType || 'orthogonal',
      nullable(input.strokeColor),
      numberValue(input.strokeWidth, 2),
      jsonValue(input.strokeDash, []),
      boolValue(input.arrowStart) ? 1 : 0,
      boolValue(input.arrowEnd) ? 1 : 0,
      jsonValue(input.pointsConfig, {}),
      jsonValue(input.konvaConfig, {}),
      jsonValue(input.metadata, {}),
      input.status || 'active',
      intValue(input.sortOrder, 0)
    ]
  )

  return findStructureEdgeById(input.tenantId, input.chartId, id)
}

export async function updateStructureEdge(id: string, input: EdgeWriteInput) {
  await dbQuery(
    `
      UPDATE structure_organization_edges
      SET
        source_node_id = ?,
        target_node_id = ?,
        edge_type = ?,
        label = ?,
        line_type = ?,
        stroke_color = ?,
        stroke_width = ?,
        stroke_dash = ?,
        arrow_start = ?,
        arrow_end = ?,
        points_config = ?,
        konva_config = ?,
        metadata = ?,
        status = ?,
        sort_order = ?,
        updated_at = NOW()
      WHERE id = ?
      AND tenant_id = ?
      AND chart_id = ?
      AND deleted_at IS NULL
    `,
    [
      input.sourceNodeId,
      input.targetNodeId,
      input.edgeType || 'hierarchy',
      nullable(input.label),
      input.lineType || 'orthogonal',
      nullable(input.strokeColor),
      numberValue(input.strokeWidth, 2),
      jsonValue(input.strokeDash, []),
      boolValue(input.arrowStart) ? 1 : 0,
      boolValue(input.arrowEnd) ? 1 : 0,
      jsonValue(input.pointsConfig, {}),
      jsonValue(input.konvaConfig, {}),
      jsonValue(input.metadata, {}),
      input.status || 'active',
      intValue(input.sortOrder, 0),
      id,
      input.tenantId,
      input.chartId
    ]
  )

  return findStructureEdgeById(input.tenantId, input.chartId, id)
}

export async function softDeleteStructureEdge(tenantId: string, chartId: string, id: string) {
  await dbQuery(
    `
      UPDATE structure_organization_edges
      SET
        status = 'inactive',
        deleted_at = NOW(),
        updated_at = NOW()
      WHERE id = ?
      AND tenant_id = ?
      AND chart_id = ?
      AND deleted_at IS NULL
    `,
    [id, tenantId, chartId]
  )

  return true
}