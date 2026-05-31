export type StructureChartStatus = 'draft' | 'published' | 'archived' | 'inactive'
export type StructureNodeStatus = 'active' | 'inactive'
export type StructureEdgeStatus = 'active' | 'inactive'

export type StructureChartType =
  | 'organization'
  | 'department'
  | 'school'
  | 'pesantren'
  | 'company'
  | 'committee'
  | 'custom'

export type StructureLayoutEngine =
  | 'manual'
  | 'tree'
  | 'dagre'
  | 'grid'
  | 'radial'
  | 'custom'

export type StructureLayoutDirection =
  | 'top-bottom'
  | 'bottom-top'
  | 'left-right'
  | 'right-left'
  | 'free'

export type StructureNodeType =
  | 'person'
  | 'position'
  | 'department'
  | 'division'
  | 'unit'
  | 'group'
  | 'placeholder'
  | 'custom'

export type StructureShapeType =
  | 'card'
  | 'rounded_rect'
  | 'rect'
  | 'circle'
  | 'avatar_card'
  | 'custom'

export type StructurePhotoShape = 'circle' | 'rounded_rect' | 'rect'

export type StructureEdgeType =
  | 'hierarchy'
  | 'assistant'
  | 'coordination'
  | 'dotted'
  | 'custom'

export type StructureLineType =
  | 'straight'
  | 'orthogonal'
  | 'bezier'
  | 'step'
  | 'custom'

export type StructureOrganizationChart = {
  id: string
  tenantId: string
  title: string
  slug: string
  description: string | null
  chartType: StructureChartType
  layoutEngine: StructureLayoutEngine
  layoutDirection: StructureLayoutDirection
  canvasWidth: number
  canvasHeight: number
  backgroundColor: string | null
  backgroundImageUrl: string | null
  gridEnabled: boolean
  gridSize: number
  snapToGrid: boolean
  zoomMin: number
  zoomMax: number
  initialScale: number
  nodeDefaultConfig: Record<string, any>
  edgeDefaultConfig: Record<string, any>
  konvaConfig: Record<string, any>
  metadata: Record<string, any>
  status: StructureChartStatus
  isFeatured: boolean
  sortOrder: number
  createdAt?: string | Date
  updatedAt?: string | Date
}

export type StructureOrganizationNode = {
  id: string
  tenantId: string
  chartId: string
  parentId: string | null
  name: string
  slug: string
  positionTitle: string
  positionCode: string | null
  organizationUnit: string | null
  photoUrl: string | null
  icon: string | null
  shortDescription: string | null
  contentHtml: string | null
  contentJson: Record<string, any>
  phone: string | null
  whatsapp: string | null
  email: string | null
  termStart: string | Date | null
  termEnd: string | Date | null
  nodeType: StructureNodeType
  shapeType: StructureShapeType
  x: number
  y: number
  width: number
  height: number
  rotation: number
  scaleX: number
  scaleY: number
  fillColor: string | null
  borderColor: string | null
  borderWidth: number
  textColor: string | null
  accentColor: string | null
  fontFamily: string | null
  nameFontSize: number
  positionFontSize: number
  photoShape: StructurePhotoShape
  photoWidth: number
  photoHeight: number
  draggable: boolean
  locked: boolean
  visible: boolean
  konvaConfig: Record<string, any>
  styleConfig: Record<string, any>
  socialConfig: Record<string, any>
  metadata: Record<string, any>
  status: StructureNodeStatus
  isFeatured: boolean
  sortOrder: number
}

export type StructureOrganizationEdge = {
  id: string
  tenantId: string
  chartId: string
  sourceNodeId: string
  targetNodeId: string
  edgeType: StructureEdgeType
  label: string | null
  lineType: StructureLineType
  strokeColor: string | null
  strokeWidth: number
  strokeDash: any[]
  arrowStart: boolean
  arrowEnd: boolean
  pointsConfig: Record<string, any>
  konvaConfig: Record<string, any>
  metadata: Record<string, any>
  status: StructureEdgeStatus
  sortOrder: number
}

export type StructureChartListResponse = {
  data: StructureOrganizationChart[]
  meta: {
    page: number
    limit: number
    total: number
    totalPages: number
    hasMore: boolean
  }
}

export type StructureNodeListResponse = {
  data: StructureOrganizationNode[]
  meta: {
    page: number
    limit: number
    total: number
    totalPages: number
    hasMore: boolean
  }
}

export type StructureEdgeListResponse = {
  data: StructureOrganizationEdge[]
  meta: {
    page: number
    limit: number
    total: number
    totalPages: number
    hasMore: boolean
  }
}

export type StructureChartDetailResponse = {
  data: {
    chart: StructureOrganizationChart
    nodes: StructureOrganizationNode[]
    edges: StructureOrganizationEdge[]
  }
}