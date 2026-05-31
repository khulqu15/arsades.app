<template>
  <section
    v-if="shouldShow"
    ref="rootRef"
    class="flex h-full min-h-[520px] w-full flex-col overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-sm"
    :style="rootStyle"
  >
    <!-- Header -->
    <header
      v-if="showHeader"
      class="relative shrink-0 overflow-hidden border-b border-neutral-100 bg-gradient-to-br from-blue-50 via-white to-white p-5 sm:p-6"
    >
      <div class="pointer-events-none absolute -right-16 -top-16 h-44 w-44 rounded-full bg-blue-100 blur-3xl"></div>

      <div class="relative flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
        <div>
          <p class="inline-flex items-center gap-2 rounded-full bg-blue-50 px-3 py-1.5 text-xs font-black uppercase tracking-[0.16em] text-blue-600 ring-1 ring-blue-100">
            <Icon icon="solar:hierarchy-bold-duotone" class="h-4 w-4" />
            Struktur Organisasi
          </p>

          <h2 class="mt-3 text-2xl font-black tracking-tight text-neutral-950 sm:text-3xl">
            {{ displayTitle }}
          </h2>

          <p class="mt-2 max-w-2xl text-sm font-semibold leading-7 text-neutral-600">
            {{ displayDescription }}
          </p>
        </div>

        <button
          v-if="showRefresh"
          type="button"
          class="inline-flex h-10 shrink-0 items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-black text-neutral-700 shadow-sm transition hover:-translate-y-0.5 hover:border-blue-200 hover:bg-blue-50 hover:text-blue-600"
          @click="refresh"
        >
          <Icon icon="solar:refresh-bold-duotone" class="h-4 w-4" :class="pending ? 'animate-spin' : ''" />
          Refresh
        </button>
      </div>
    </header>

    <!-- Body -->
    <div class="min-h-0 flex-1 p-3 sm:p-4">
      <div
        ref="viewportRef"
        class="relative h-full min-h-[420px] overflow-auto rounded-[1.6rem] border border-neutral-200 bg-[#f7f8fb]"
        @wheel="handleWheelZoom"
      >
        <div class="pointer-events-none absolute inset-0 z-0 opacity-80">
          <div class="absolute -left-40 top-10 h-96 w-96 rounded-full bg-blue-100 blur-3xl"></div>
          <div class="absolute right-0 top-1/4 h-96 w-96 rounded-full bg-cyan-100 blur-3xl"></div>
          <div class="absolute bottom-0 left-1/2 h-80 w-80 -translate-x-1/2 rounded-full bg-indigo-100 blur-3xl"></div>
        </div>

        <!-- Zoom Toolbar -->
        <div
          v-if="flatNodes.length"
          class="absolute right-3 top-3 z-40 flex items-center gap-1 rounded-2xl border border-neutral-200 bg-white/95 p-1 shadow-[0_16px_50px_rgba(15,23,42,0.12)] backdrop-blur-xl"
        >
          <button
            type="button"
            class="zoom-button"
            aria-label="Zoom out"
            @click="zoomOut"
          >
            <Icon icon="solar:magnifer-zoom-out-bold-duotone" class="h-5 w-5" />
          </button>

          <button
            type="button"
            class="inline-flex h-9 min-w-16 items-center justify-center rounded-xl px-2 text-xs font-black text-neutral-700 transition hover:bg-blue-50 hover:text-blue-700"
            @click="fitToParent"
          >
            {{ Math.round(zoom * 100) }}%
          </button>

          <button
            type="button"
            class="zoom-button"
            aria-label="Zoom in"
            @click="zoomIn"
          >
            <Icon icon="solar:magnifer-zoom-in-bold-duotone" class="h-5 w-5" />
          </button>

          <div class="mx-1 h-5 w-px bg-neutral-200"></div>

          <button
            type="button"
            class="zoom-button"
            aria-label="Fit to parent"
            @click="fitToParent"
          >
            <Icon icon="solar:full-screen-square-bold-duotone" class="h-5 w-5" />
          </button>
        </div>

        <!-- Helper -->
        <div
          v-if="flatNodes.length"
          class="absolute left-3 top-3 z-30 hidden rounded-2xl border border-neutral-200 bg-white/95 px-3 py-2 text-xs font-black text-neutral-500 shadow-sm backdrop-blur-xl md:block"
        >
          Ctrl/Cmd + Scroll untuk zoom
        </div>

        <!-- Loading -->
        <div v-if="pending" class="relative z-10 grid h-full min-h-[420px] place-items-center p-6">
          <div class="w-full max-w-4xl space-y-5">
            <div class="mx-auto h-24 w-64 animate-pulse rounded-[1.6rem] bg-white"></div>

            <div class="grid gap-4 sm:grid-cols-3">
              <div
                v-for="item in 6"
                :key="item"
                class="h-24 animate-pulse rounded-[1.6rem] bg-white"
              ></div>
            </div>
          </div>
        </div>

        <!-- Canvas -->
        <div
          v-else-if="flatNodes.length"
          class="relative z-10"
          :style="scaledExtentStyle"
        >
          <div
            class="absolute left-0 top-0"
            :style="scaledContentStyle"
          >
            <div
              class="pointer-events-none absolute inset-0 canvas-grid"
              :style="canvasGridStyle"
            ></div>

            <!-- Lines -->
            <svg
              class="pointer-events-none absolute left-0 top-0 z-10 overflow-visible"
              :width="sceneWidth"
              :height="sceneHeight"
              :viewBox="`0 0 ${sceneWidth} ${sceneHeight}`"
            >
              <path
                v-for="edge in visibleEdges"
                :key="edge.id"
                :d="edgePathD(edge)"
                fill="none"
                :stroke="edge.strokeColor || '#94a3b8'"
                :stroke-width="edge.strokeWidth || 2"
                :stroke-dasharray="edgeDashArray(edge)"
                stroke-linecap="round"
                stroke-linejoin="round"
              />
            </svg>

            <!-- Nodes -->
            <article
              v-for="node in flatNodes"
              :key="node.id"
              class="absolute z-20 overflow-hidden"
              :style="nodeCardStyle(node)"
            >
              <div
                class="absolute grid place-items-center overflow-hidden"
                :style="nodePhotoStyle(node)"
              >
                <img
                  v-if="hasPhoto(node)"
                  :src="node.photoUrl"
                  :alt="node.name"
                  class="h-full w-full object-cover"
                  loading="lazy"
                  @error="markPhotoFailed(node.id)"
                >

                <Icon
                  v-else
                  :icon="node.icon || 'solar:user-rounded-bold-duotone'"
                  class="h-6 w-6"
                  :style="{ color: node.accentColor || props.accentColor }"
                />
              </div>

              <h3
                class="absolute truncate font-black"
                :style="nodeNameStyle(node)"
              >
                {{ node.name }}
              </h3>

              <p
                class="absolute line-clamp-2 font-bold leading-5"
                :style="nodePositionStyle(node)"
              >
                {{ node.positionTitle }}
              </p>
            </article>
          </div>
        </div>

        <!-- Empty -->
        <div v-else-if="showEmpty" class="relative z-10 grid h-full min-h-[420px] place-items-center p-6 text-center">
          <div>
            <div class="mx-auto grid h-14 w-14 place-items-center rounded-3xl bg-blue-50 text-blue-600">
              <Icon icon="solar:hierarchy-bold-duotone" class="h-7 w-7" />
            </div>

            <h3 class="mt-4 text-lg font-black text-neutral-950">
              Struktur organisasi belum tersedia
            </h3>

            <p class="mx-auto mt-2 max-w-md text-sm font-semibold leading-7 text-neutral-500">
              Data bagan belum dipublikasikan atau masih kosong.
            </p>
          </div>
        </div>
      </div>

      <div
        v-if="flatNodes.length && showFooter"
        class="mt-3 flex flex-wrap items-center justify-between gap-3 rounded-2xl border border-blue-100 bg-blue-50 px-4 py-3"
      >
        <p class="text-xs font-black uppercase tracking-[0.14em] text-blue-700">
          {{ flatNodes.length }} Anggota · {{ visibleEdges.length }} Relasi
        </p>

        <p v-if="chart?.title" class="text-xs font-bold text-blue-700">
          {{ chart.title }}
        </p>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import { Icon } from '@iconify/vue'
import { computed, nextTick, onBeforeUnmount, onMounted, reactive, ref, watch } from 'vue'
import { useAppApi } from '~/composables/useAppApi'

type AnchorKey =
  | 'top'
  | 'bottom'
  | 'left'
  | 'right'
  | 'topLeft'
  | 'topRight'
  | 'bottomLeft'
  | 'bottomRight'

type LineType = 'orthogonal' | 'straight' | 'bezier' | 'manual' | string

type CanvasPoint = {
  x: number
  y: number
}

type StructureNode = {
  id: string
  parentId: string | null
  name: string
  slug: string
  positionTitle: string
  organizationUnit: string
  photoUrl: string
  icon: string
  x: number
  y: number
  width: number
  height: number
  rotation: number
  scaleX: number
  scaleY: number
  fillColor: string
  borderColor: string
  borderWidth: number
  textColor: string
  accentColor: string
  cornerRadius: number
  padding: number
  nameFontSize: number
  positionFontSize: number
  photoShape: 'circle' | 'rounded_rect' | 'rect'
  photoWidth: number
  photoHeight: number
  visible: boolean
  sortOrder: number
  metadata: Record<string, any>
  styleConfig: Record<string, any>
  konvaConfig: Record<string, any>
}

type StructureEdge = {
  id: string
  sourceNodeId: string
  targetNodeId: string
  sourceAnchor: AnchorKey
  targetAnchor: AnchorKey
  lineType: LineType
  strokeColor: string
  strokeWidth: number
  strokeDash: number[]
  label: string
  sortOrder: number
  metadata: Record<string, any>
  konvaConfig: Record<string, any>
}

type StructureChart = {
  id: string
  slug: string
  title: string
  description?: string | null
  canvasWidth?: number
  canvasHeight?: number
}

const props = withDefaults(defineProps<{
  tenantSlug: string
  chartSlug?: string
  title?: string
  description?: string
  accentColor?: string
  showEmpty?: boolean
  showRefresh?: boolean
  showHeader?: boolean
  showFooter?: boolean
  height?: string
  minZoom?: number
  maxZoom?: number
}>(), {
  chartSlug: '',
  title: 'Struktur Organisasi',
  description: 'Susunan kelembagaan dan jabatan yang aktif dalam pengelolaan layanan.',
  accentColor: '#2563eb',
  showEmpty: false,
  showRefresh: false,
  showHeader: true,
  showFooter: true,
  height: '100%',
  minZoom: 0.25,
  maxZoom: 2.5
})

const { tenantApiUrl } = useAppApi()

const rootRef = ref<HTMLElement | null>(null)
const viewportRef = ref<HTMLElement | null>(null)

const viewportSize = reactive({
  width: 0,
  height: 0
})

const zoom = ref(1)
const autoFit = ref(true)
const failedPhotos = ref<Record<string, boolean>>({})

let resizeObserver: ResizeObserver | null = null

const chartBaseUrl = computed(() => {
  return tenantApiUrl(props.tenantSlug, '/structure-organizations/charts')
})

const {
  data: structureData,
  pending,
  refresh
} = await useAsyncData(
  `profile-structure-organization-canvas-${props.tenantSlug}-${props.chartSlug || 'default'}`,
  async () => {
    const targetChart = await resolveChart()

    if (!targetChart?.id && !targetChart?.slug) {
      return {
        chart: null,
        nodes: [],
        edges: []
      }
    }

    const chartKey = targetChart.id || targetChart.slug

    const detail = await $fetch<any>(`${chartBaseUrl.value}/${chartKey}`, {
      query: {
        include: 'graph'
      }
    })

    const payload = detail?.data || {}

    return {
      chart: normalizeChart(payload.chart || targetChart),
      nodes: normalizeNodes(payload.nodes),
      edges: normalizeEdges(payload.edges)
    }
  },
  {
    watch: [chartBaseUrl, () => props.chartSlug],
    default: () => ({
      chart: null,
      nodes: [],
      edges: []
    })
  }
)

const chart = computed<StructureChart | null>(() => {
  return structureData.value?.chart || null
})

const flatNodes = computed<StructureNode[]>(() => {
  return (structureData.value?.nodes || [])
    .filter((node) => node.visible !== false)
    .sort((a, b) => {
      if (a.sortOrder !== b.sortOrder) return a.sortOrder - b.sortOrder
      if (a.y !== b.y) return a.y - b.y
      return a.x - b.x
    })
})

const nodeMap = computed(() => {
  return new Map(flatNodes.value.map((node) => [node.id, node]))
})

const visibleEdges = computed<StructureEdge[]>(() => {
  return (structureData.value?.edges || [])
    .filter((edge) => {
      return nodeMap.value.has(edge.sourceNodeId) && nodeMap.value.has(edge.targetNodeId)
    })
    .sort((a, b) => a.sortOrder - b.sortOrder)
})

const shouldShow = computed(() => {
  return pending.value || flatNodes.value.length > 0 || props.showEmpty
})

const displayTitle = computed(() => {
  return props.title || chart.value?.title || 'Struktur Organisasi'
})

const displayDescription = computed(() => {
  return props.description || chart.value?.description || 'Susunan kelembagaan dan jabatan yang aktif dalam pengelolaan layanan.'
})

const rootStyle = computed(() => ({
  '--org-primary': props.accentColor || '#2563eb',
  height: props.height || '100%'
}))

const sceneBounds = computed(() => {
  return computeSceneBounds(flatNodes.value, visibleEdges.value)
})

const scenePadding = computed(() => 56)

const sceneWidth = computed(() => {
  return Math.max(360, sceneBounds.value.maxX - sceneBounds.value.minX + scenePadding.value * 2)
})

const sceneHeight = computed(() => {
  return Math.max(260, sceneBounds.value.maxY - sceneBounds.value.minY + scenePadding.value * 2)
})

const fitScale = computed(() => {
  if (!viewportSize.width || !viewportSize.height || !sceneWidth.value || !sceneHeight.value) return 1

  const availableWidth = Math.max(200, viewportSize.width - 32)
  const availableHeight = Math.max(200, viewportSize.height - 32)

  const scale = Math.min(
    availableWidth / sceneWidth.value,
    availableHeight / sceneHeight.value
  )

  return clamp(scale, props.minZoom, props.maxZoom)
})

const scaledWidth = computed(() => sceneWidth.value * zoom.value)
const scaledHeight = computed(() => sceneHeight.value * zoom.value)

const extentWidth = computed(() => {
  return Math.max(viewportSize.width, scaledWidth.value + 32)
})

const extentHeight = computed(() => {
  return Math.max(viewportSize.height, scaledHeight.value + 32)
})

const contentOffsetX = computed(() => {
  return Math.max(16, (extentWidth.value - scaledWidth.value) / 2)
})

const contentOffsetY = computed(() => {
  return Math.max(16, (extentHeight.value - scaledHeight.value) / 2)
})

const scaledExtentStyle = computed(() => ({
  width: `${extentWidth.value}px`,
  height: `${extentHeight.value}px`,
  minWidth: '100%',
  minHeight: '100%'
}))

const scaledContentStyle = computed(() => ({
  width: `${sceneWidth.value}px`,
  height: `${sceneHeight.value}px`,
  left: `${contentOffsetX.value}px`,
  top: `${contentOffsetY.value}px`,
  transform: `scale(${zoom.value})`,
  transformOrigin: 'top left'
}))

const canvasGridStyle = computed(() => ({
  width: `${sceneWidth.value}px`,
  height: `${sceneHeight.value}px`
}))

watch(
  [
    () => viewportSize.width,
    () => viewportSize.height,
    sceneWidth,
    sceneHeight,
    flatNodes
  ],
  () => {
    if (!autoFit.value) return

    nextTick(() => {
      fitToParent()
    })
  },
  { flush: 'post' }
)

onMounted(() => {
  setupResizeObserver()

  nextTick(() => {
    updateViewportSize()
    fitToParent()
  })
})

onBeforeUnmount(() => {
  if (resizeObserver) {
    resizeObserver.disconnect()
    resizeObserver = null
  }
})

async function resolveChart() {
  if (props.chartSlug) {
    try {
      const detail = await $fetch<any>(`${chartBaseUrl.value}/${props.chartSlug}`, {
        query: {
          include: 'chart'
        }
      })

      return normalizeChart(detail?.data?.chart || detail?.data || detail)
    } catch {
      return null
    }
  }

  const response = await $fetch<any>(chartBaseUrl.value, {
    query: {
      status: 'published',
      limit: 1,
      sort: 'sort_order'
    }
  })

  return normalizeChart(response?.data?.[0])
}

function setupResizeObserver() {
  if (!viewportRef.value || typeof ResizeObserver === 'undefined') return

  resizeObserver = new ResizeObserver(() => {
    updateViewportSize()
  })

  resizeObserver.observe(viewportRef.value)
}

function updateViewportSize() {
  const rect = viewportRef.value?.getBoundingClientRect()

  viewportSize.width = Math.max(0, Math.floor(rect?.width || 0))
  viewportSize.height = Math.max(0, Math.floor(rect?.height || 0))
}

function fitToParent() {
  autoFit.value = true
  zoom.value = roundScale(fitScale.value)

  nextTick(() => {
    const viewport = viewportRef.value
    if (!viewport) return

    viewport.scrollLeft = Math.max(0, (extentWidth.value - viewport.clientWidth) / 2)
    viewport.scrollTop = Math.max(0, (extentHeight.value - viewport.clientHeight) / 2)
  })
}

function zoomIn() {
  zoomWithPivot(zoom.value + 0.12)
}

function zoomOut() {
  zoomWithPivot(zoom.value - 0.12)
}

function handleWheelZoom(event: WheelEvent) {
  if (!event.ctrlKey && !event.metaKey) return

  event.preventDefault()

  const direction = event.deltaY > 0 ? -1 : 1
  const nextZoom = zoom.value + direction * 0.1

  zoomWithPivot(nextZoom, event)
}

function zoomWithPivot(nextZoom: number, event?: WheelEvent) {
  const viewport = viewportRef.value
  if (!viewport) return

  autoFit.value = false

  const oldZoom = zoom.value
  const rect = viewport.getBoundingClientRect()

  const pivotX = event ? event.clientX - rect.left : viewport.clientWidth / 2
  const pivotY = event ? event.clientY - rect.top : viewport.clientHeight / 2

  const sceneX = (viewport.scrollLeft + pivotX - contentOffsetX.value) / oldZoom
  const sceneY = (viewport.scrollTop + pivotY - contentOffsetY.value) / oldZoom

  zoom.value = roundScale(clamp(nextZoom, props.minZoom, props.maxZoom))

  nextTick(() => {
    viewport.scrollLeft = sceneX * zoom.value + contentOffsetX.value - pivotX
    viewport.scrollTop = sceneY * zoom.value + contentOffsetY.value - pivotY
  })
}

function normalizeChart(value: any): StructureChart | null {
  if (!value || typeof value !== 'object') return null

  return {
    id: cleanString(value.id),
    slug: cleanString(value.slug),
    title: cleanString(value.title, 'Struktur Organisasi'),
    description: cleanString(value.description),
    canvasWidth: numberValue(value.canvasWidth, 1600),
    canvasHeight: numberValue(value.canvasHeight, 1000)
  }
}

function normalizeNodes(value: any): StructureNode[] {
  if (!Array.isArray(value)) return []

  return value
    .map((item) => {
      const metadata = normalizeObject(item.metadata)
      const style = normalizeObject(item.styleConfig)
      const konva = normalizeObject(item.konvaConfig)

      return {
        id: cleanString(item.id),
        parentId: item.parentId || null,
        name: cleanString(item.name, 'Nama'),
        slug: cleanString(item.slug),
        positionTitle: cleanString(item.positionTitle, 'Jabatan'),
        organizationUnit: cleanString(item.organizationUnit),
        photoUrl: cleanString(item.photoUrl),
        icon: cleanString(item.icon, 'solar:user-rounded-bold-duotone'),
        x: numberValue(item.x, 0),
        y: numberValue(item.y, 0),
        width: numberValue(item.width || style.width, 240),
        height: numberValue(item.height || style.height, 124),
        rotation: numberValue(item.rotation, 0),
        scaleX: numberValue(item.scaleX, 1),
        scaleY: numberValue(item.scaleY, 1),
        fillColor: cleanString(item.fillColor || style.fillColor, '#ffffff'),
        borderColor: cleanString(item.borderColor || style.borderColor, '#dbeafe'),
        borderWidth: numberValue(item.borderWidth, 1),
        textColor: cleanString(item.textColor || style.textColor, '#111827'),
        accentColor: cleanString(item.accentColor || style.accentColor, props.accentColor),
        cornerRadius: numberValue(style.cornerRadius || metadata.cornerRadius || item.cornerRadius, 22),
        padding: numberValue(style.padding || metadata.padding || item.padding, 16),
        nameFontSize: numberValue(item.nameFontSize, 16),
        positionFontSize: numberValue(item.positionFontSize, 13),
        photoShape: item.photoShape || 'circle',
        photoWidth: numberValue(item.photoWidth, 56),
        photoHeight: numberValue(item.photoHeight, 56),
        visible: item.visible !== false,
        sortOrder: numberValue(item.sortOrder, 0),
        metadata,
        styleConfig: style,
        konvaConfig: konva
      }
    })
    .filter((item) => item.id)
}

function normalizeEdges(value: any): StructureEdge[] {
  if (!Array.isArray(value)) return []

  return value
    .map((item) => {
      const metadata = normalizeObject(item.metadata)
      const konva = normalizeObject(item.konvaConfig)

      return {
        id: cleanString(item.id),
        sourceNodeId: cleanString(item.sourceNodeId),
        targetNodeId: cleanString(item.targetNodeId),
        sourceAnchor: normalizeAnchor(metadata.sourceAnchor || item.sourceAnchor || 'bottom'),
        targetAnchor: normalizeAnchor(metadata.targetAnchor || item.targetAnchor || 'top'),
        lineType: cleanString(item.lineType, 'orthogonal'),
        strokeColor: cleanString(item.strokeColor, '#94a3b8'),
        strokeWidth: numberValue(item.strokeWidth, 2),
        strokeDash: Array.isArray(item.strokeDash) ? item.strokeDash.map((dash: any) => numberValue(dash, 0)) : [],
        label: cleanString(item.label),
        sortOrder: numberValue(item.sortOrder, 0),
        metadata,
        konvaConfig: konva
      }
    })
    .filter((item) => item.id && item.sourceNodeId && item.targetNodeId)
}

function computeSceneBounds(nodes: StructureNode[], edges: StructureEdge[]) {
  const points: CanvasPoint[] = []

  for (const node of nodes) {
    const width = Math.max(1, node.width * node.scaleX)
    const height = Math.max(1, node.height * node.scaleY)

    points.push({ x: node.x, y: node.y })
    points.push({ x: node.x + width, y: node.y + height })
  }

  for (const edge of edges) {
    points.push(...edgePoints(edge))
  }

  if (!points.length) {
    return {
      minX: 0,
      minY: 0,
      maxX: 960,
      maxY: 420
    }
  }

  const xs = points.map((point) => point.x)
  const ys = points.map((point) => point.y)

  return {
    minX: Math.min(...xs),
    minY: Math.min(...ys),
    maxX: Math.max(...xs),
    maxY: Math.max(...ys)
  }
}

function edgePathD(edge: StructureEdge) {
  const points = edgePoints(edge).map(toScenePoint)

  if (points.length < 2) return ''

  const [start, ...rest] = points

  if (edge.lineType === 'bezier' && points.length >= 3) {
    const control = points[1]
    const end = points[points.length - 1]
    return `M ${start.x} ${start.y} Q ${control.x} ${control.y} ${end.x} ${end.y}`
  }

  return [
    `M ${start.x} ${start.y}`,
    ...rest.map((point) => `L ${point.x} ${point.y}`)
  ].join(' ')
}

function edgePoints(edge: StructureEdge): CanvasPoint[] {
  const endpoints = edgeEndpointPoints(edge)
  if (!endpoints) return []

  const { from, to } = endpoints

  if (edge.lineType === 'straight') {
    return [from, to]
  }

  if (edge.lineType === 'bezier') {
    const controlPoint = normalizePoint(edge.metadata?.controlPoint) || {
      x: (from.x + to.x) / 2,
      y: (from.y + to.y) / 2 - Math.max(70, Math.abs(to.x - from.x) * 0.16)
    }

    return [from, controlPoint, to]
  }

  if (edge.lineType === 'manual') {
    const manualPoints = normalizePointArray(edge.metadata?.manualPoints)

    if (manualPoints.length >= 2) {
      return [
        from,
        ...manualPoints.slice(1, -1),
        to
      ]
    }

    return [from, midpoint(from, to), to]
  }

  return pointArrayToObjects(orthogonalPoints(from, to))
}

function edgeEndpointPoints(edge: StructureEdge) {
  const source = nodeMap.value.get(edge.sourceNodeId)
  const target = nodeMap.value.get(edge.targetNodeId)

  if (!source || !target) return null

  return {
    from: anchorPoint(source, edge.sourceAnchor),
    to: anchorPoint(target, edge.targetAnchor)
  }
}

function anchorPoint(node: StructureNode, anchor: AnchorKey): CanvasPoint {
  const width = node.width
  const height = node.height

  const points: Record<AnchorKey, CanvasPoint> = {
    top: { x: node.x + width / 2, y: node.y },
    bottom: { x: node.x + width / 2, y: node.y + height },
    left: { x: node.x, y: node.y + height / 2 },
    right: { x: node.x + width, y: node.y + height / 2 },
    topLeft: { x: node.x, y: node.y },
    topRight: { x: node.x + width, y: node.y },
    bottomLeft: { x: node.x, y: node.y + height },
    bottomRight: { x: node.x + width, y: node.y + height }
  }

  return points[anchor] || points.bottom
}

function orthogonalPoints(from: CanvasPoint, to: CanvasPoint) {
  const dx = Math.abs(to.x - from.x)
  const dy = Math.abs(to.y - from.y)

  if (dy >= dx) {
    const midY = from.y + (to.y - from.y) / 2
    return [from.x, from.y, from.x, midY, to.x, midY, to.x, to.y]
  }

  const midX = from.x + (to.x - from.x) / 2
  return [from.x, from.y, midX, from.y, midX, to.y, to.x, to.y]
}

function toScenePoint(point: CanvasPoint): CanvasPoint {
  return {
    x: point.x - sceneBounds.value.minX + scenePadding.value,
    y: point.y - sceneBounds.value.minY + scenePadding.value
  }
}

function nodeCardStyle(node: StructureNode) {
  const point = toScenePoint({ x: node.x, y: node.y })

  return {
    left: `${point.x}px`,
    top: `${point.y}px`,
    width: `${node.width}px`,
    height: `${node.height}px`,
    borderRadius: `${node.cornerRadius}px`,
    background: node.fillColor || '#ffffff',
    border: `${node.borderWidth || 1}px solid ${node.borderColor || '#dbeafe'}`,
    color: node.textColor || '#111827',
    transform: `rotate(${node.rotation || 0}deg) scale(${node.scaleX || 1}, ${node.scaleY || 1})`,
    transformOrigin: 'top left',
    boxShadow: '0 20px 55px -38px rgba(37, 99, 235, 0.85), 0 8px 16px rgba(15, 23, 42, 0.06)'
  }
}

function nodePhotoStyle(node: StructureNode) {
  return {
    left: `${node.padding}px`,
    top: `${node.padding + 6}px`,
    width: `${node.photoWidth}px`,
    height: `${node.photoHeight}px`,
    borderRadius: node.photoShape === 'circle'
      ? '9999px'
      : node.photoShape === 'rect'
        ? '0.75rem'
        : '1rem',
    background: '#eff6ff',
    border: `1px solid ${node.accentColor || props.accentColor}`
  }
}

function nodeNameStyle(node: StructureNode) {
  return {
    left: `${node.padding + node.photoWidth + 12}px`,
    top: `${node.padding + 14}px`,
    width: `${node.width - node.padding * 2 - node.photoWidth - 12}px`,
    fontSize: `${node.nameFontSize}px`,
    color: node.textColor || '#111827'
  }
}

function nodePositionStyle(node: StructureNode) {
  return {
    left: `${node.padding + node.photoWidth + 12}px`,
    top: `${node.padding + 42}px`,
    width: `${node.width - node.padding * 2 - node.photoWidth - 12}px`,
    fontSize: `${node.positionFontSize}px`,
    color: node.accentColor || props.accentColor
  }
}

function hasPhoto(node: StructureNode) {
  return Boolean(node.photoUrl && !failedPhotos.value[node.id])
}

function markPhotoFailed(id: string) {
  failedPhotos.value = {
    ...failedPhotos.value,
    [id]: true
  }
}

function edgeDashArray(edge: StructureEdge) {
  if (!edge.strokeDash?.length) return undefined
  return edge.strokeDash.join(' ')
}

function normalizeAnchor(value: unknown): AnchorKey {
  const anchor = String(value || '').trim() as AnchorKey

  const allowed: AnchorKey[] = [
    'top',
    'bottom',
    'left',
    'right',
    'topLeft',
    'topRight',
    'bottomLeft',
    'bottomRight'
  ]

  return allowed.includes(anchor) ? anchor : 'bottom'
}

function pointArrayToObjects(points: number[]) {
  const result: CanvasPoint[] = []

  for (let index = 0; index < points.length; index += 2) {
    result.push({
      x: numberValue(points[index], 0),
      y: numberValue(points[index + 1], 0)
    })
  }

  return result
}

function normalizePoint(value: unknown): CanvasPoint | null {
  if (!value || typeof value !== 'object') return null

  const item = value as Record<string, unknown>
  const x = Number(item.x)
  const y = Number(item.y)

  if (!Number.isFinite(x) || !Number.isFinite(y)) return null

  return { x, y }
}

function normalizePointArray(value: unknown): CanvasPoint[] {
  if (!Array.isArray(value)) return []

  return value
    .map((item) => normalizePoint(item))
    .filter(Boolean) as CanvasPoint[]
}

function midpoint(from: CanvasPoint, to: CanvasPoint): CanvasPoint {
  return {
    x: (from.x + to.x) / 2,
    y: (from.y + to.y) / 2
  }
}

function cleanString(value: unknown, fallback = '') {
  const text = String(value || '').trim()
  return text || fallback
}

function numberValue(value: unknown, fallback = 0) {
  const number = Number(value)
  return Number.isFinite(number) ? number : fallback
}

function normalizeObject(value: unknown) {
  if (!value || typeof value !== 'object' || Array.isArray(value)) return {}
  return value as Record<string, any>
}

function clamp(value: number, min: number, max: number) {
  return Math.max(min, Math.min(max, value))
}

function roundScale(value: number) {
  return Math.round(value * 100) / 100
}
</script>

<style scoped>
.canvas-grid {
  background-size: 32px 32px;
  background-image:
    linear-gradient(to right, rgba(148, 163, 184, 0.14) 1px, transparent 1px),
    linear-gradient(to bottom, rgba(148, 163, 184, 0.14) 1px, transparent 1px);
}

.zoom-button {
  display: inline-flex;
  height: 2.25rem;
  width: 2.25rem;
  align-items: center;
  justify-content: center;
  border-radius: 0.75rem;
  color: rgb(82 82 82);
  transition: 160ms ease;
}

.zoom-button:hover {
  background: rgb(239 246 255);
  color: rgb(37 99 235);
}

.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>