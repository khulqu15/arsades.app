<template>
  <div class="h-screen overflow-hidden bg-neutral-100 text-neutral-900 dark:bg-neutral-950 dark:text-neutral-100">
    <!-- Top Bar -->
    <header class="fixed inset-x-0 top-0 z-50 flex h-14 items-center border-b border-neutral-200 bg-white/95 px-3 backdrop-blur dark:border-neutral-800 dark:bg-neutral-950/95">
      <!-- Left: Brand + File -->
      <div class="flex min-w-0 flex-1 items-center gap-2">
        <button
          type="button"
          class="inline-flex size-9 items-center justify-center rounded-xl border border-neutral-200 bg-white text-neutral-700 hover:bg-neutral-50 dark:border-neutral-800 dark:bg-neutral-900 dark:text-neutral-200 dark:hover:bg-neutral-800"
          aria-label="Back"
        >
          <span class="text-lg leading-none">←</span>
        </button>

        <div class="flex min-w-0 items-center gap-2">
          <div class="flex size-8 items-center justify-center rounded-xl bg-neutral-900 text-xs font-bold text-white dark:bg-white dark:text-neutral-900">
            E
          </div>

          <div class="hidden min-w-0 sm:block">
            <p class="truncate text-sm font-semibold leading-4">
              Website Editor
            </p>
            <p class="truncate text-xs text-neutral-500 dark:text-neutral-400">
              Draft saved · Landing Page
            </p>
          </div>
        </div>
      </div>

      <!-- Center: Tools -->
      <nav class="hidden items-center rounded-2xl border border-neutral-200 bg-neutral-50 p-1 dark:border-neutral-800 dark:bg-neutral-900 lg:flex">
        <button
          v-for="tool in tools"
          :key="tool.key"
          type="button"
          :class="[
            'hs-tooltip relative inline-flex size-9 items-center justify-center rounded-xl text-sm transition',
            activeTool === tool.key
              ? 'bg-white text-neutral-950 shadow-sm dark:bg-neutral-800 dark:text-white'
              : 'text-neutral-500 hover:bg-white hover:text-neutral-950 dark:text-neutral-400 dark:hover:bg-neutral-800 dark:hover:text-white'
          ]"
          :aria-label="tool.label"
          @click="activeTool = tool.key"
        >
          <span>{{ tool.icon }}</span>
          <span class="sr-only">{{ tool.label }}</span>
        </button>
      </nav>

      <!-- Right: Actions -->
      <div class="flex flex-1 items-center justify-end gap-2">
        <button
          type="button"
          class="hidden rounded-xl border border-neutral-200 bg-white px-3 py-2 text-sm font-medium text-neutral-700 hover:bg-neutral-50 dark:border-neutral-800 dark:bg-neutral-900 dark:text-neutral-200 dark:hover:bg-neutral-800 sm:inline-flex"
        >
          Preview
        </button>

        <button
          type="button"
          class="inline-flex items-center gap-2 rounded-xl bg-neutral-900 px-3 py-2 text-sm font-semibold text-white hover:bg-neutral-800 dark:bg-white dark:text-neutral-900 dark:hover:bg-neutral-200"
        >
          Publish
        </button>

        <button
          type="button"
          class="inline-flex size-9 items-center justify-center rounded-full border border-neutral-200 bg-white text-sm font-semibold text-neutral-700 dark:border-neutral-800 dark:bg-neutral-900 dark:text-neutral-200"
          aria-label="User menu"
        >
          A
        </button>
      </div>
    </header>

    <!-- Main Editor Shell -->
    <div class="flex h-screen pt-14">
      <!-- Left Rail -->
      <aside class="hidden w-[68px] shrink-0 border-r border-neutral-200 bg-white dark:border-neutral-800 dark:bg-neutral-950 lg:flex lg:flex-col">
        <div class="flex flex-1 flex-col items-center gap-2 py-3">
          <button
            v-for="panel in panels"
            :key="panel.key"
            type="button"
            :class="[
              'inline-flex size-11 items-center justify-center rounded-2xl text-lg transition',
              activePanel === panel.key
                ? 'bg-neutral-900 text-white dark:bg-white dark:text-neutral-900'
                : 'text-neutral-500 hover:bg-neutral-100 hover:text-neutral-900 dark:text-neutral-400 dark:hover:bg-neutral-900 dark:hover:text-white'
            ]"
            :aria-label="panel.label"
            @click="activePanel = panel.key"
          >
            {{ panel.icon }}
          </button>
        </div>

        <div class="border-t border-neutral-200 p-3 dark:border-neutral-800">
          <button
            type="button"
            class="inline-flex size-11 items-center justify-center rounded-2xl text-neutral-500 hover:bg-neutral-100 hover:text-neutral-900 dark:text-neutral-400 dark:hover:bg-neutral-900 dark:hover:text-white"
            aria-label="Settings"
          >
            ⚙
          </button>
        </div>
      </aside>

      <!-- Left Panel -->
      <aside class="hidden w-72 shrink-0 border-r border-neutral-200 bg-white dark:border-neutral-800 dark:bg-neutral-950 xl:block">
        <div class="flex h-full flex-col">
          <div class="border-b border-neutral-200 p-4 dark:border-neutral-800">
            <div class="flex items-center justify-between">
              <h2 class="text-sm font-semibold">
                {{ activePanelTitle }}
              </h2>

              <button
                type="button"
                class="inline-flex size-8 items-center justify-center rounded-lg text-neutral-500 hover:bg-neutral-100 hover:text-neutral-900 dark:text-neutral-400 dark:hover:bg-neutral-900 dark:hover:text-white"
                aria-label="Add"
              >
                +
              </button>
            </div>

            <div class="mt-3">
              <label class="sr-only" for="editor-search">Search</label>
              <input
                id="editor-search"
                v-model="search"
                type="search"
                placeholder="Search layers, pages..."
                class="block w-full rounded-xl border border-neutral-200 bg-neutral-50 px-3 py-2 text-sm outline-none transition placeholder:text-neutral-400 focus:border-neutral-400 focus:bg-white dark:border-neutral-800 dark:bg-neutral-900 dark:text-neutral-100 dark:focus:border-neutral-600"
              >
            </div>
          </div>

          <div class="min-h-0 flex-1 overflow-y-auto p-3">
            <!-- Pages Panel -->
            <div v-if="activePanel === 'pages'" class="space-y-2">
              <button
                v-for="page in filteredPages"
                :key="page.path"
                type="button"
                class="flex w-full items-center justify-between rounded-xl px-3 py-2 text-left text-sm hover:bg-neutral-100 dark:hover:bg-neutral-900"
              >
                <span class="min-w-0 truncate">{{ page.name }}</span>
                <span class="text-xs text-neutral-400">{{ page.path }}</span>
              </button>
            </div>

            <!-- Layers Panel -->
            <div v-else-if="activePanel === 'layers'" class="space-y-1">
              <button
                v-for="layer in filteredLayers"
                :key="layer.id"
                type="button"
                :class="[
                  'flex w-full items-center gap-2 rounded-xl px-3 py-2 text-left text-sm hover:bg-neutral-100 dark:hover:bg-neutral-900',
                  layer.selected ? 'bg-neutral-100 dark:bg-neutral-900' : ''
                ]"
              >
                <span class="text-neutral-400">{{ layer.icon }}</span>
                <span class="min-w-0 flex-1 truncate">{{ layer.name }}</span>
                <span v-if="layer.locked" class="text-xs text-neutral-400">🔒</span>
              </button>
            </div>

            <!-- Assets Panel -->
            <div v-else class="grid grid-cols-2 gap-3">
              <button
                v-for="asset in filteredAssets"
                :key="asset.id"
                type="button"
                class="group overflow-hidden rounded-2xl border border-neutral-200 bg-neutral-50 text-left hover:bg-white dark:border-neutral-800 dark:bg-neutral-900 dark:hover:bg-neutral-800"
              >
                <div class="flex aspect-square items-center justify-center text-3xl">
                  {{ asset.icon }}
                </div>
                <div class="border-t border-neutral-200 px-3 py-2 dark:border-neutral-800">
                  <p class="truncate text-xs font-medium">{{ asset.name }}</p>
                </div>
              </button>
            </div>
          </div>
        </div>
      </aside>

      <!-- Center Canvas Area -->
      <main class="relative min-w-0 flex-1 bg-neutral-100 dark:bg-neutral-950">
        <!-- Canvas Top Toolbar -->
        <div class="absolute left-0 right-0 top-0 z-20 flex h-12 items-center justify-between border-b border-neutral-200 bg-white/90 px-3 backdrop-blur dark:border-neutral-800 dark:bg-neutral-950/90">
          <div class="flex items-center gap-2">
            <select
              v-model="activeBreakpoint"
              class="rounded-xl border border-neutral-200 bg-white px-3 py-1.5 text-sm outline-none dark:border-neutral-800 dark:bg-neutral-900"
            >
              <option value="desktop">Desktop · 1440</option>
              <option value="tablet">Tablet · 834</option>
              <option value="mobile">Mobile · 390</option>
            </select>

            <div class="hidden items-center gap-1 rounded-xl border border-neutral-200 bg-white p-1 dark:border-neutral-800 dark:bg-neutral-900 md:flex">
              <button
                type="button"
                class="rounded-lg px-2 py-1 text-xs hover:bg-neutral-100 dark:hover:bg-neutral-800"
                @click="zoomOut"
              >
                −
              </button>
              <span class="min-w-12 text-center text-xs text-neutral-500">
                {{ zoom }}%
              </span>
              <button
                type="button"
                class="rounded-lg px-2 py-1 text-xs hover:bg-neutral-100 dark:hover:bg-neutral-800"
                @click="zoomIn"
              >
                +
              </button>
            </div>
          </div>

          <div class="hidden items-center gap-2 text-xs text-neutral-500 md:flex">
            <span>Auto layout</span>
            <span class="size-1 rounded-full bg-neutral-300 dark:bg-neutral-700" />
            <span>{{ activeBreakpointLabel }}</span>
          </div>
        </div>

        <!-- Canvas Workspace -->
        <div class="h-full overflow-auto px-6 pb-16 pt-20">
          <div class="mx-auto flex min-h-full w-max items-start justify-center">
            <div
              :style="canvasScaleStyle"
              class="origin-top rounded-[28px] border border-neutral-300 bg-white shadow-2xl shadow-neutral-300/60 dark:border-neutral-700 dark:bg-neutral-900 dark:shadow-black/40"
            >
              <div
                :style="artboardStyle"
                class="relative overflow-hidden rounded-[27px] bg-white dark:bg-neutral-950"
              >
                <!-- Optional grid -->
                <div
                  class="pointer-events-none absolute inset-0 opacity-[0.35] dark:opacity-[0.2]"
                  style="background-image: linear-gradient(to right, rgba(115,115,115,.18) 1px, transparent 1px), linear-gradient(to bottom, rgba(115,115,115,.18) 1px, transparent 1px); background-size: 24px 24px;"
                />

                <!-- Page content rendered here -->
                <slot />

                <!-- Empty placeholder if page has no visible content -->
                <div class="pointer-events-none absolute inset-0 flex items-center justify-center">
                  <div class="rounded-3xl border border-dashed border-neutral-300 bg-white/80 px-6 py-5 text-center shadow-sm backdrop-blur dark:border-neutral-700 dark:bg-neutral-900/80">
                    <p class="text-sm font-semibold">Canvas Slot</p>
                    <p class="mt-1 max-w-xs text-xs text-neutral-500 dark:text-neutral-400">
                      Render Vue Konva/editor page content inside this layout.
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Bottom Status Bar -->
        <div class="absolute bottom-0 left-0 right-0 z-20 flex h-9 items-center justify-between border-t border-neutral-200 bg-white/90 px-4 text-xs text-neutral-500 backdrop-blur dark:border-neutral-800 dark:bg-neutral-950/90">
          <div class="flex items-center gap-3">
            <span>Ready</span>
            <span class="hidden sm:inline">X: 0 · Y: 0</span>
          </div>

          <div class="flex items-center gap-3">
            <span>{{ artboard.width }} × {{ artboard.height }}</span>
            <span>{{ zoom }}%</span>
          </div>
        </div>
      </main>

      <!-- Right Properties Panel -->
      <aside class="hidden w-80 shrink-0 border-l border-neutral-200 bg-white dark:border-neutral-800 dark:bg-neutral-950 2xl:block">
        <div class="flex h-full flex-col">
          <div class="border-b border-neutral-200 p-4 dark:border-neutral-800">
            <div class="flex items-center justify-between">
              <h2 class="text-sm font-semibold">Properties</h2>
              <span class="rounded-lg bg-neutral-100 px-2 py-1 text-xs text-neutral-500 dark:bg-neutral-900">
                Frame
              </span>
            </div>
          </div>

          <div class="min-h-0 flex-1 overflow-y-auto">
            <!-- Design -->
            <section class="border-b border-neutral-200 p-4 dark:border-neutral-800">
              <h3 class="mb-3 text-xs font-semibold uppercase tracking-wide text-neutral-500">
                Layout
              </h3>

              <div class="grid grid-cols-2 gap-3">
                <label class="space-y-1">
                  <span class="text-xs text-neutral-500">Width</span>
                  <input
                    v-model.number="artboard.width"
                    type="number"
                    class="w-full rounded-xl border border-neutral-200 bg-neutral-50 px-3 py-2 text-sm outline-none focus:border-neutral-400 dark:border-neutral-800 dark:bg-neutral-900"
                  >
                </label>

                <label class="space-y-1">
                  <span class="text-xs text-neutral-500">Height</span>
                  <input
                    v-model.number="artboard.height"
                    type="number"
                    class="w-full rounded-xl border border-neutral-200 bg-neutral-50 px-3 py-2 text-sm outline-none focus:border-neutral-400 dark:border-neutral-800 dark:bg-neutral-900"
                  >
                </label>

                <label class="space-y-1">
                  <span class="text-xs text-neutral-500">X</span>
                  <input
                    value="0"
                    type="number"
                    class="w-full rounded-xl border border-neutral-200 bg-neutral-50 px-3 py-2 text-sm outline-none focus:border-neutral-400 dark:border-neutral-800 dark:bg-neutral-900"
                  >
                </label>

                <label class="space-y-1">
                  <span class="text-xs text-neutral-500">Y</span>
                  <input
                    value="0"
                    type="number"
                    class="w-full rounded-xl border border-neutral-200 bg-neutral-50 px-3 py-2 text-sm outline-none focus:border-neutral-400 dark:border-neutral-800 dark:bg-neutral-900"
                  >
                </label>
              </div>
            </section>

            <!-- Responsive -->
            <section class="border-b border-neutral-200 p-4 dark:border-neutral-800">
              <h3 class="mb-3 text-xs font-semibold uppercase tracking-wide text-neutral-500">
                Responsive
              </h3>

              <div class="space-y-2">
                <button
                  v-for="breakpoint in breakpoints"
                  :key="breakpoint.key"
                  type="button"
                  :class="[
                    'flex w-full items-center justify-between rounded-xl border px-3 py-2 text-sm',
                    activeBreakpoint === breakpoint.key
                      ? 'border-neutral-900 bg-neutral-900 text-white dark:border-white dark:bg-white dark:text-neutral-900'
                      : 'border-neutral-200 bg-white hover:bg-neutral-50 dark:border-neutral-800 dark:bg-neutral-900 dark:hover:bg-neutral-800'
                  ]"
                  @click="selectBreakpoint(breakpoint.key)"
                >
                  <span>{{ breakpoint.label }}</span>
                  <span class="text-xs opacity-70">{{ breakpoint.width }}px</span>
                </button>
              </div>
            </section>

            <!-- Appearance -->
            <section class="border-b border-neutral-200 p-4 dark:border-neutral-800">
              <h3 class="mb-3 text-xs font-semibold uppercase tracking-wide text-neutral-500">
                Appearance
              </h3>

              <div class="space-y-3">
                <label class="flex items-center justify-between gap-3">
                  <span class="text-sm">Background</span>
                  <input
                    type="color"
                    value="#ffffff"
                    class="h-9 w-14 rounded-lg border border-neutral-200 bg-transparent dark:border-neutral-800"
                  >
                </label>

                <label class="flex items-center justify-between gap-3">
                  <span class="text-sm">Radius</span>
                  <input
                    type="number"
                    value="24"
                    class="w-24 rounded-xl border border-neutral-200 bg-neutral-50 px-3 py-2 text-sm outline-none dark:border-neutral-800 dark:bg-neutral-900"
                  >
                </label>

                <label class="flex items-center justify-between gap-3">
                  <span class="text-sm">Shadow</span>
                  <select class="w-32 rounded-xl border border-neutral-200 bg-neutral-50 px-3 py-2 text-sm outline-none dark:border-neutral-800 dark:bg-neutral-900">
                    <option>None</option>
                    <option selected>Soft</option>
                    <option>Large</option>
                  </select>
                </label>
              </div>
            </section>

            <!-- Export -->
            <section class="p-4">
              <button
                type="button"
                class="w-full rounded-xl border border-neutral-200 bg-white px-3 py-2 text-sm font-medium hover:bg-neutral-50 dark:border-neutral-800 dark:bg-neutral-900 dark:hover:bg-neutral-800"
              >
                Export Design JSON
              </button>
            </section>
          </div>
        </div>
      </aside>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, reactive, ref, watch } from "vue"

type PanelKey = 'pages' | 'layers' | 'assets'
type ToolKey = 'select' | 'frame' | 'text' | 'shape' | 'hand' | 'comment'
type BreakpointKey = 'desktop' | 'tablet' | 'mobile'

const activePanel = ref<PanelKey>('layers')
const activeTool = ref<ToolKey>('select')
const activeBreakpoint = ref<BreakpointKey>('desktop')
const search = ref('')
const zoom = ref(80)

const tools: Array<{ key: ToolKey; label: string; icon: string }> = [
    { key: 'select', label: 'Select', icon: '↖' },
    { key: 'frame', label: 'Frame', icon: '▣' },
    { key: 'text', label: 'Text', icon: 'T' },
    { key: 'shape', label: 'Shape', icon: '□' },
    { key: 'hand', label: 'Hand', icon: '✋' },
    { key: 'comment', label: 'Comment', icon: '💬' }
]

const panels: Array<{ key: PanelKey; label: string; icon: string }> = [
    { key: 'pages', label: 'Pages', icon: '📄' },
    { key: 'layers', label: 'Layers', icon: '☰' },
    { key: 'assets', label: 'Assets', icon: '◈' }
]

const pages = [
    { name: 'Home', path: '/' },
    { name: 'About', path: '/about' },
    { name: 'Pricing', path: '/pricing' },
    { name: 'Blog', path: '/blog' },
    { name: 'Contact', path: '/contact' }
]

const layers = [
    { id: 'root', name: 'Page', icon: '▣', selected: false, locked: false },
    { id: 'navbar', name: 'Navbar', icon: '☰', selected: false, locked: true },
    { id: 'hero', name: 'Hero Section', icon: '▢', selected: true, locked: false },
    { id: 'headline', name: 'Headline', icon: 'T', selected: false, locked: false },
    { id: 'cta', name: 'Primary Button', icon: '●', selected: false, locked: false },
    { id: 'footer', name: 'Footer', icon: '▤', selected: false, locked: true }
]

const assets = [
    { id: 'logo', name: 'Logo', icon: '◆' },
    { id: 'image', name: 'Hero Image', icon: '🖼️' },
    { id: 'icon', name: 'Icons', icon: '⭐' },
    { id: 'video', name: 'Video', icon: '🎬' }
]

const breakpoints: Array<{ key: BreakpointKey; label: string; width: number; height: number }> = [
    { key: 'desktop', label: 'Desktop', width: 1440, height: 900 },
    { key: 'tablet', label: 'Tablet', width: 834, height: 1112 },
    { key: 'mobile', label: 'Mobile', width: 390, height: 844 }
]

const activePanelTitle = computed(() => {
    const currentPanel = panels.find((panel) => panel.key === activePanel.value)
    return currentPanel?.label ?? 'Panel'
})

const activeBreakpointData = computed(() => {
  return breakpoints.find((breakpoint) => breakpoint.key === activeBreakpoint.value) ?? breakpoints[0]
})

const activeBreakpointLabel = computed(() => {
    return `${activeBreakpointData.value!.label} ${activeBreakpointData.value!.width}px`
})

const artboard = reactive({
    width: activeBreakpointData.value!.width,
    height: activeBreakpointData.value!.height
})

const artboardStyle = computed(() => ({
    width: `${artboard.width}px`,
    height: `${artboard.height}px`
}))

const canvasScaleStyle = computed(() => ({
    transform: `scale(${zoom.value / 100})`
}))

const filteredPages = computed(() => {
    return filterBySearch(pages, ['name', 'path'])
})

const filteredLayers = computed(() => {
    return filterBySearch(layers, ['name'])
})

const filteredAssets = computed(() => {
    return filterBySearch(assets, ['name'])
})

function filterBySearch<T extends Record<string, unknown>>(items: T[], keys: Array<keyof T>) {
    const keyword = search.value.trim().toLowerCase()

    if (!keyword) return items

    return items.filter((item) => {
        return keys.some((key) => String(item[key]).toLowerCase().includes(keyword))
    })
}

function selectBreakpoint(key: BreakpointKey) {
    activeBreakpoint.value = key

    const selectedBreakpoint = breakpoints.find((breakpoint) => breakpoint.key === key)

    if (!selectedBreakpoint) return

    artboard.width = selectedBreakpoint.width
    artboard.height = selectedBreakpoint.height
}

function zoomIn() {
    zoom.value = Math.min(200, zoom.value + 10)
}

function zoomOut() {
    zoom.value = Math.max(30, zoom.value - 10)
}

watch(activeBreakpoint.value!, (key) => {
    const selectedBreakpoint = breakpoints.find((breakpoint: any) => breakpoint.key === key)

    if (!selectedBreakpoint) return

    artboard.width = selectedBreakpoint.width
    artboard.height = selectedBreakpoint.height
})
</script>