<template>
  <main class="relative min-h-screen overflow-hidden bg-[#f7f8fb] text-neutral-950">
    <div class="pointer-events-none fixed inset-0 opacity-80">
      <div class="absolute -left-40 top-10 h-96 w-96 rounded-full bg-blue-100 blur-3xl"></div>
      <div class="absolute right-0 top-1/4 h-96 w-96 rounded-full bg-cyan-100 blur-3xl"></div>
      <div class="absolute bottom-0 left-1/2 h-80 w-80 -translate-x-1/2 rounded-full bg-indigo-100 blur-3xl"></div>
    </div>

    <!-- Left Floating Tools -->
    <aside class="fixed left-4 top-1/2 z-40 -translate-y-1/2 rounded-[1.6rem] border border-white/70 bg-white/90 p-2 shadow-[0_24px_80px_rgba(15,23,42,0.14)] backdrop-blur-xl">
      <div class="space-y-2">
        <button
          v-for="tool in tools"
          :key="tool.value"
          type="button"
          class="group relative flex h-12 w-12 items-center justify-center rounded-2xl transition"
          :class="activeTool === tool.value ? 'bg-blue-600 text-white shadow-lg shadow-blue-600/25' : 'text-neutral-500 hover:bg-blue-50 hover:text-blue-700'"
          :draggable="tool.value === 'block'"
          @click="handleToolClick(tool.value)"
          @dragstart="onToolDragStart($event, tool.value)"
          @dragend="onToolDragEnd"
        >
          <Icon :icon="tool.icon" class="h-5 w-5" />
          <span class="pointer-events-none absolute left-[calc(100%+0.75rem)] top-1/2 z-50 -translate-y-1/2 whitespace-nowrap rounded-xl bg-neutral-950 px-3 py-2 text-xs font-black text-white opacity-0 shadow-xl transition group-hover:opacity-100">
            {{ tool.label }}
          </span>
        </button>
      </div>
    </aside>

    <!-- Header -->
    <section class="relative z-10 px-4 py-4 pl-24 sm:px-6 sm:py-5">
      <div class="mx-auto flex max-w-[1600px] flex-col gap-3 rounded-[2rem] border border-white/70 bg-white/90 p-3 shadow-sm backdrop-blur-xl lg:flex-row lg:items-center lg:justify-between">
        <div class="flex min-w-0 items-center gap-3">
          <div class="grid h-12 w-12 shrink-0 place-items-center rounded-2xl bg-blue-600 text-white shadow-lg shadow-blue-600/25">
            <Icon icon="solar:hierarchy-bold-duotone" class="h-6 w-6" />
          </div>
          <div class="min-w-0">
            <div class="flex flex-wrap items-center gap-2">
              <p class="truncate text-lg font-black tracking-tight text-neutral-950 sm:text-xl">Struktur Organisasi</p>
              <span class="rounded-full bg-blue-50 px-2.5 py-1 text-[11px] font-black uppercase tracking-[0.14em] text-blue-700">
                {{ tenantSlug }}
              </span>
              <span v-if="hasUnsavedChanges" class="rounded-full bg-amber-50 px-2.5 py-1 text-[11px] font-black text-amber-700 ring-1 ring-amber-100">
                Belum disimpan
              </span>
            </div>
            <p class="mt-1 line-clamp-1 text-xs font-semibold text-neutral-500">
              Canvas bagan ala Figma/Framer untuk pemerintahan desa, sekolah, pondok, yayasan, dan tenant lain.
            </p>
          </div>
        </div>

        <div class="flex flex-wrap items-center gap-2">
          <button type="button" class="topbar-button" @click="loadInitialChart">
            <Icon icon="solar:refresh-bold-duotone" class="h-4 w-4" :class="isLoading ? 'animate-spin' : ''" />
            Refresh
          </button>
          <button type="button" class="topbar-button" @click="resetView">
            <Icon icon="solar:round-graph-bold-duotone" class="h-4 w-4" />
            Reset View
          </button>
          <div class="relative">
            <button type="button" class="topbar-button" @click="exportMenuOpen = !exportMenuOpen">
              <Icon icon="solar:export-bold-duotone" class="h-4 w-4" />
              Export
            </button>
            <div v-if="exportMenuOpen" class="absolute right-0 top-[calc(100%+0.5rem)] z-50 w-44 overflow-hidden rounded-2xl border border-neutral-200 bg-white p-1 shadow-2xl">
              <button type="button" class="menu-button" @click="exportAsPdf">
                <Icon icon="solar:file-text-bold-duotone" class="h-4 w-4" />
                PDF
              </button>
              <button type="button" class="menu-button" @click="exportAsCsv">
                <Icon icon="solar:document-bold-duotone" class="h-4 w-4" />
                CSV
              </button>
              <button type="button" class="menu-button" @click="exportAsExcel">
                <Icon icon="solar:table-bold-duotone" class="h-4 w-4" />
                Excel
              </button>
            </div>
          </div>
          <button type="button" class="inline-flex h-10 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 text-sm font-black text-white shadow-lg shadow-blue-600/25 transition hover:-translate-y-0.5 hover:bg-blue-700 disabled:cursor-not-allowed disabled:opacity-60" :disabled="isSaving" @click="saveDiagram">
            <Icon :icon="isSaving ? 'svg-spinners:180-ring' : 'solar:diskette-bold-duotone'" class="h-4 w-4" />
            {{ isSaving ? 'Menyimpan...' : 'Save' }}
          </button>
        </div>
      </div>
    </section>

    <!-- Canvas Workspace -->
    <section class="relative z-10 px-4 pb-4 pl-24 sm:px-6 sm:pb-6">
      <div class="mx-auto grid max-w-[1600px] gap-4 lg:grid-cols-[1fr_300px]">
        <div
          ref="stageShell"
          class="relative min-h-[calc(100vh-7.5rem)] overflow-hidden rounded-[2rem] border border-white/70 bg-white/85 shadow-[0_24px_90px_rgba(15,23,42,0.08)] backdrop-blur-xl"
          @dragover.prevent
          @drop="onCanvasDrop"
          @click="closeFloatingMenus"
        >
          <div class="pointer-events-none absolute inset-0 canvas-grid"></div>
          <div class="absolute left-4 top-4 z-20 flex flex-wrap items-center gap-2">
            <div class="rounded-2xl border border-neutral-200 bg-white/90 px-3 py-2 text-xs font-black text-neutral-600 shadow-sm backdrop-blur">
              Tool: <span class="text-blue-700">{{ activeToolLabel }}</span>
            </div>
            <div class="rounded-2xl border border-neutral-200 bg-white/90 px-3 py-2 text-xs font-black text-neutral-600 shadow-sm backdrop-blur">
              Zoom: {{ Math.round(stageScale * 100) }}%
            </div>
            <div v-if="lineSource" class="rounded-2xl border border-blue-100 bg-blue-50 px-3 py-2 text-xs font-black text-blue-700 shadow-sm">
              Pilih node tujuan
            </div>
          </div>

          <ClientOnly>
            <v-stage
              ref="stageRef"
              :config="stageConfig"
              @wheel="onWheel"
              @mousedown="onStageMouseDown"
              @mousemove="onStageMouseMove"
              @mouseup="onStageMouseUp"
              @click="onStageClick"
            >
              <v-layer ref="gridLayerRef">
                <v-line
                  v-for="line in gridLines"
                  :key="line.id"
                  :config="line.config"
                />
              </v-layer>

              <v-layer ref="edgeLayerRef">
                <v-line
                  v-for="edge in edges"
                  :key="edge.id"
                  :config="edgeKonvaConfig(edge)"
                  @click="selectEdge(edge.id)"
                  @contextmenu="openEdgeContextMenu($event, edge)"
                />
                <v-line
                  v-if="tempLine"
                  :config="tempLineConfig"
                />
              </v-layer>

              <v-layer ref="nodeLayerRef">
                <v-group
                  v-for="node in nodes"
                  :key="node.id"
                  :config="nodeGroupConfig(node)"
                  @dragstart="onNodeDragStart(node)"
                  @dragmove="onNodeDragMove($event, node)"
                  @dragend="onNodeDragEnd($event, node)"
                  @mouseenter="onNodeMouseEnter(node)"
                  @mouseleave="onNodeMouseLeave(node)"
                  @click="onNodeClick($event, node)"
                  @dblclick="openNodeSettings(node)"
                  @contextmenu="openNodeContextMenu($event, node)"
                >
                  <v-rect :config="nodeShadowConfig(node)" />
                  <v-rect :config="nodeCardConfig(node)" />

                  <v-group :config="photoGroupConfig(node)">
                    <v-circle :config="photoBackgroundConfig(node)" />
                    <v-image
                      v-if="imageCache[node.id]"
                      :config="nodePhotoImageConfig(node)"
                      @dblclick="openPhotoPicker(node)"
                    />
                    <v-text
                      v-else
                      :config="nodePhotoFallbackConfig(node)"
                      @dblclick="openPhotoPicker(node)"
                    />
                  </v-group>

                  <v-text
                    :config="nodeNameTextConfig(node)"
                    @dblclick="openTextEditor(node, 'name')"
                  />
                  <v-text
                    :config="nodePositionTextConfig(node)"
                    @dblclick="openTextEditor(node, 'positionTitle')"
                  />

                  <v-group
                    v-if="isNodeActive(node.id)"
                    :config="ellipsisGroupConfig(node)"
                    @click="openNodeMenuFromCanvas($event, node)"
                  >
                    <v-circle :config="ellipsisCircleConfig" />
                    <v-text :config="ellipsisTextConfig" />
                  </v-group>

                  <v-circle
                    v-for="handle in visibleHandles(node)"
                    :key="`${node.id}-${handle}`"
                    :config="handleConfig(node, handle)"
                    @mousedown="startLineFromHandle($event, node, handle)"
                    @mouseup="finishLineToHandle($event, node, handle)"
                    @mouseenter="setStageCursor('crosshair')"
                    @mouseleave="setStageCursor(activeTool === 'line' ? 'crosshair' : 'default')"
                  />
                </v-group>
              </v-layer>
            </v-stage>
          </ClientOnly>

          <input ref="photoInput" type="file" accept="image/jpeg,image/jpg,image/png,image/webp" class="hidden" @change="onPickPhoto">

          <!-- Context Menu -->
          <div
            v-if="contextMenu.show"
            class="fixed z-[80] w-52 overflow-hidden rounded-2xl border border-neutral-200 bg-white p-1 shadow-2xl shadow-neutral-950/15"
            :style="{ left: `${contextMenu.x}px`, top: `${contextMenu.y}px` }"
            @click.stop
          >
            <button type="button" class="menu-button" @click="contextMenu.kind === 'node' ? openNodeSettingsById(contextMenu.targetId) : openEdgeSettingsById(contextMenu.targetId)">
              <Icon icon="solar:settings-bold-duotone" class="h-4 w-4" />
              Edit Param
            </button>
            <button v-if="contextMenu.kind === 'node'" type="button" class="menu-button" @click="duplicateNodeById(contextMenu.targetId)">
              <Icon icon="solar:copy-bold-duotone" class="h-4 w-4" />
              Duplikat
            </button>
            <button type="button" class="menu-button text-red-600 hover:bg-red-50" @click="requestDelete(contextMenu.kind, contextMenu.targetId)">
              <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-4 w-4" />
              Hapus
            </button>
          </div>
        </div>

        <!-- Compact Inspector -->
        <aside class="hidden min-h-[calc(100vh-7.5rem)] rounded-[2rem] border border-white/70 bg-white/90 p-4 shadow-sm backdrop-blur-xl lg:block">
          <div class="flex items-center justify-between gap-3">
            <div>
              <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">Inspector</p>
              <h2 class="mt-1 text-lg font-black text-neutral-950">Canvas</h2>
            </div>
            <div class="grid h-10 w-10 place-items-center rounded-2xl bg-blue-50 text-blue-600">
              <Icon icon="solar:slider-vertical-bold-duotone" class="h-5 w-5" />
            </div>
          </div>

          <div class="mt-5 space-y-3">
            <div class="rounded-3xl border border-neutral-200 bg-neutral-50 p-4">
              <p class="text-xs font-black uppercase tracking-[0.14em] text-neutral-400">Bagan</p>
              <input v-model.trim="chart.title" type="text" class="mt-3 input-field" placeholder="Judul bagan">
              <input v-model.trim="chart.slug" type="text" class="mt-2 input-field" placeholder="slug-bagan">
            </div>

            <div class="grid grid-cols-2 gap-2">
              <div class="rounded-2xl border border-neutral-200 bg-neutral-50 p-3">
                <p class="text-[11px] font-black text-neutral-400">Nodes</p>
                <p class="mt-1 text-2xl font-black text-neutral-950">{{ nodes.length }}</p>
              </div>
              <div class="rounded-2xl border border-neutral-200 bg-neutral-50 p-3">
                <p class="text-[11px] font-black text-neutral-400">Lines</p>
                <p class="mt-1 text-2xl font-black text-neutral-950">{{ edges.length }}</p>
              </div>
            </div>

            <div class="rounded-3xl border border-neutral-200 bg-neutral-50 p-4">
              <p class="text-sm font-black text-neutral-950">Selected</p>
              <div v-if="selectedNode" class="mt-3 flex items-center gap-3">
                <div class="grid h-12 w-12 place-items-center overflow-hidden rounded-2xl border border-neutral-200 bg-white">
                  <img v-if="selectedNode.photoUrl" :src="selectedNode.photoUrl" class="h-full w-full object-cover" alt="">
                  <Icon v-else icon="solar:user-rounded-bold-duotone" class="h-6 w-6 text-blue-600" />
                </div>
                <div class="min-w-0">
                  <p class="truncate text-sm font-black text-neutral-950">{{ selectedNode.name }}</p>
                  <p class="truncate text-xs font-semibold text-neutral-500">{{ selectedNode.positionTitle }}</p>
                </div>
              </div>
              <p v-else-if="selectedEdge" class="mt-3 text-sm font-bold text-neutral-600">Line dipilih</p>
              <p v-else class="mt-3 text-sm font-bold text-neutral-400">Klik node atau line.</p>
            </div>

            <div class="rounded-3xl border border-blue-100 bg-blue-50 p-4 text-xs font-semibold leading-5 text-blue-700">
              Double click text untuk edit, double click photo untuk upload, klik kanan untuk dropdown param.
            </div>
          </div>
        </aside>
      </div>
    </section>

    <!-- Node Settings Modal -->
    <Teleport to="body">
      <Transition name="modal-fade">
        <div v-if="nodeSettingsOpen" class="fixed inset-0 z-[90] flex items-center justify-center bg-neutral-950/50 p-4 backdrop-blur-sm" @mousedown.self="closeNodeSettings">
          <section class="w-full max-w-2xl overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-2xl">
            <header class="flex items-start justify-between gap-4 border-b border-neutral-100 bg-gradient-to-br from-blue-50 via-white to-white p-5">
              <div>
                <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">Edit Param</p>
                <h3 class="mt-1 text-xl font-black text-neutral-950">Block Organisasi</h3>
              </div>
              <button type="button" class="modal-close" @click="closeNodeSettings">
                <Icon icon="solar:close-circle-bold-duotone" class="h-5 w-5" />
              </button>
            </header>

            <div class="grid max-h-[72vh] gap-4 overflow-y-auto p-5 sm:grid-cols-2">
              <label class="field-label sm:col-span-2">
                <span>Photo URL</span>
                <div class="mt-2 flex gap-2">
                  <input v-model.trim="nodeForm.photoUrl" type="url" class="input-field" placeholder="https://res.cloudinary.com/...">
                  <button type="button" class="secondary-button shrink-0" @click="triggerNodeFormPhoto">
                    <Icon icon="solar:upload-bold-duotone" class="h-4 w-4" />
                  </button>
                </div>
              </label>
              <label class="field-label">
                <span>Nama</span>
                <input v-model.trim="nodeForm.name" type="text" class="input-field" placeholder="Nama pejabat">
              </label>
              <label class="field-label">
                <span>Jabatan</span>
                <input v-model.trim="nodeForm.positionTitle" type="text" class="input-field" placeholder="Kepala Desa">
              </label>
              <label class="field-label">
                <span>Rounded</span>
                <input v-model.number="nodeForm.cornerRadius" type="range" min="0" max="36" class="range-field">
                <p class="mt-1 text-xs font-black text-neutral-400">{{ nodeForm.cornerRadius }}px</p>
              </label>
              <label class="field-label">
                <span>Background</span>
                <div class="mt-2 flex gap-2">
                  <input v-model="nodeForm.fillColor" type="color" class="h-11 w-14 rounded-2xl border border-neutral-200 bg-white p-1">
                  <input v-model.trim="nodeForm.fillColor" type="text" class="input-field" placeholder="#ffffff">
                </div>
              </label>
              <label class="field-label">
                <span>Padding</span>
                <input v-model.number="nodeForm.padding" type="number" min="8" max="40" class="input-field">
              </label>
              <label class="field-label">
                <span>Accent Color</span>
                <div class="mt-2 flex gap-2">
                  <input v-model="nodeForm.accentColor" type="color" class="h-11 w-14 rounded-2xl border border-neutral-200 bg-white p-1">
                  <input v-model.trim="nodeForm.accentColor" type="text" class="input-field">
                </div>
              </label>
              <label class="field-label">
                <span>Width</span>
                <input v-model.number="nodeForm.width" type="number" min="150" class="input-field">
              </label>
              <label class="field-label">
                <span>Height</span>
                <input v-model.number="nodeForm.height" type="number" min="90" class="input-field">
              </label>
              <label class="field-label">
                <span>Text Color</span>
                <div class="mt-2 flex gap-2">
                  <input v-model="nodeForm.textColor" type="color" class="h-11 w-14 rounded-2xl border border-neutral-200 bg-white p-1">
                  <input v-model.trim="nodeForm.textColor" type="text" class="input-field">
                </div>
              </label>
              <label class="field-label">
                <span>Border Color</span>
                <div class="mt-2 flex gap-2">
                  <input v-model="nodeForm.borderColor" type="color" class="h-11 w-14 rounded-2xl border border-neutral-200 bg-white p-1">
                  <input v-model.trim="nodeForm.borderColor" type="text" class="input-field">
                </div>
              </label>
            </div>

            <footer class="flex flex-col-reverse gap-2 border-t border-neutral-100 bg-neutral-50 p-5 sm:flex-row sm:justify-end">
              <button type="button" class="secondary-button" @click="closeNodeSettings">Batal</button>
              <button type="button" class="primary-button" @click="applyNodeSettings">Terapkan</button>
            </footer>
          </section>
        </div>
      </Transition>
    </Teleport>

    <!-- Edge Settings Modal -->
    <Teleport to="body">
      <Transition name="modal-fade">
        <div v-if="edgeSettingsOpen" class="fixed inset-0 z-[90] flex items-center justify-center bg-neutral-950/50 p-4 backdrop-blur-sm" @mousedown.self="closeEdgeSettings">
          <section class="w-full max-w-lg overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-2xl">
            <header class="flex items-start justify-between gap-4 border-b border-neutral-100 bg-gradient-to-br from-blue-50 via-white to-white p-5">
              <div>
                <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">Line</p>
                <h3 class="mt-1 text-xl font-black text-neutral-950">Edit Garis</h3>
              </div>
              <button type="button" class="modal-close" @click="closeEdgeSettings">
                <Icon icon="solar:close-circle-bold-duotone" class="h-5 w-5" />
              </button>
            </header>
            <div class="grid gap-4 p-5 sm:grid-cols-2">
              <label class="field-label sm:col-span-2">
                <span>Label</span>
                <input v-model.trim="edgeForm.label" type="text" class="input-field" placeholder="Opsional">
              </label>
              <label class="field-label">
                <span>Line Type</span>
                <select v-model="edgeForm.lineType" class="input-field">
                  <option value="orthogonal">Orthogonal 90°</option>
                  <option value="straight">Straight</option>
                  <option value="bezier">Bezier</option>
                </select>
              </label>
              <label class="field-label">
                <span>Width</span>
                <input v-model.number="edgeForm.strokeWidth" type="number" min="1" max="10" class="input-field">
              </label>
              <label class="field-label">
                <span>Color</span>
                <div class="mt-2 flex gap-2">
                  <input v-model="edgeForm.strokeColor" type="color" class="h-11 w-14 rounded-2xl border border-neutral-200 bg-white p-1">
                  <input v-model.trim="edgeForm.strokeColor" type="text" class="input-field">
                </div>
              </label>
              <label class="field-label">
                <span>Style</span>
                <select v-model="edgeForm.dashMode" class="input-field">
                  <option value="solid">Solid</option>
                  <option value="dashed">Dashed</option>
                  <option value="dotted">Dotted</option>
                </select>
              </label>
            </div>
            <footer class="flex flex-col-reverse gap-2 border-t border-neutral-100 bg-neutral-50 p-5 sm:flex-row sm:justify-end">
              <button type="button" class="secondary-button" @click="closeEdgeSettings">Batal</button>
              <button type="button" class="primary-button" @click="applyEdgeSettings">Terapkan</button>
            </footer>
          </section>
        </div>
      </Transition>
    </Teleport>

    <!-- Text Modal -->
    <Teleport to="body">
      <Transition name="modal-fade">
        <div v-if="textEditorOpen" class="fixed inset-0 z-[92] flex items-center justify-center bg-neutral-950/50 p-4 backdrop-blur-sm" @mousedown.self="closeTextEditor">
          <section class="w-full max-w-md rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-2xl">
            <div class="flex items-start justify-between gap-4">
              <div>
                <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">Text</p>
                <h3 class="mt-1 text-xl font-black text-neutral-950">Edit {{ textFieldLabel }}</h3>
              </div>
              <button type="button" class="modal-close" @click="closeTextEditor">
                <Icon icon="solar:close-circle-bold-duotone" class="h-5 w-5" />
              </button>
            </div>
            <input v-model.trim="textForm.value" type="text" class="mt-5 input-field" autofocus>
            <div class="mt-5 flex justify-end gap-2">
              <button type="button" class="secondary-button" @click="closeTextEditor">Batal</button>
              <button type="button" class="primary-button" @click="applyTextEdit">Simpan</button>
            </div>
          </section>
        </div>
      </Transition>
    </Teleport>

    <!-- Delete Confirm Modal -->
    <Teleport to="body">
      <Transition name="modal-fade">
        <div v-if="deleteModal.open" class="fixed inset-0 z-[95] flex items-center justify-center bg-neutral-950/50 p-4 backdrop-blur-sm" @mousedown.self="deleteModal.open = false">
          <section class="w-full max-w-md rounded-[2rem] border border-neutral-200 bg-white p-5 text-center shadow-2xl">
            <div class="mx-auto grid h-14 w-14 place-items-center rounded-3xl bg-red-50 text-red-600">
              <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-7 w-7" />
            </div>
            <h3 class="mt-4 text-xl font-black text-neutral-950">Hapus item?</h3>
            <p class="mt-2 text-sm font-semibold leading-6 text-neutral-500">
              Data akan dihapus dari canvas dan akan tersinkron ke database saat tombol Save ditekan.
            </p>
            <div class="mt-5 grid gap-2 sm:grid-cols-2">
              <button type="button" class="secondary-button" @click="deleteModal.open = false">Batal</button>
              <button type="button" class="danger-button" @click="confirmDeleteItem">Hapus</button>
            </div>
          </section>
        </div>
      </Transition>
    </Teleport>

    <!-- Toast -->
    <Transition name="toast">
      <div v-if="toast.show" class="fixed bottom-5 right-5 z-[110] w-[min(420px,calc(100vw-2rem))] rounded-[1.5rem] border border-neutral-200 bg-white p-4 shadow-2xl shadow-neutral-950/15">
        <div class="flex items-start gap-3">
          <div class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl" :class="toast.type === 'success' ? 'bg-blue-50 text-blue-600' : 'bg-red-50 text-red-600'">
            <Icon :icon="toast.type === 'success' ? 'solar:check-circle-bold-duotone' : 'solar:danger-circle-bold-duotone'" class="h-6 w-6" />
          </div>
          <div class="min-w-0 flex-1">
            <p class="font-black text-neutral-950">{{ toast.title }}</p>
            <p class="mt-1 text-sm font-semibold leading-6 text-neutral-500">{{ toast.message }}</p>
          </div>
          <button type="button" class="grid h-8 w-8 place-items-center rounded-xl text-neutral-400 hover:bg-neutral-50 hover:text-neutral-700" @click="closeToast">
            <Icon icon="solar:close-circle-bold-duotone" class="h-5 w-5" />
          </button>
        </div>
      </div>
    </Transition>
  </main>
</template>

<script setup lang="ts">
import { Icon } from '@iconify/vue'
import { computed, nextTick, onBeforeUnmount, onMounted, reactive, ref, shallowRef, watch } from 'vue'
import { useRequestURL, useRuntimeConfig } from 'nuxt/app'
import { useAppApi } from '../../composables/useAppApi'
import { useCloudinaryUpload } from '../../composables/useCloudinaryUpload'

definePageMeta({
  layout: 'app',
  layoutProps: {
    title: 'Structure Organization'
  }
})

type ToolType = 'select' | 'block' | 'line' | 'text'
type AnchorKey = 'top' | 'bottom' | 'topLeft' | 'topRight' | 'bottomLeft' | 'bottomRight'
type ToastType = 'success' | 'error'
type DeleteKind = 'node' | 'edge'

type DiagramNode = {
  id: string
  persisted: boolean
  parentId: string | null
  name: string
  slug: string
  positionTitle: string
  positionCode: string | null
  organizationUnit: string | null
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
  draggable: boolean
  locked: boolean
  visible: boolean
  nodeType: string
  shapeType: string
  metadata: Record<string, any>
  konvaConfig: Record<string, any>
  styleConfig: Record<string, any>
  sortOrder: number
}

type DiagramEdge = {
  id: string
  persisted: boolean
  sourceNodeId: string
  targetNodeId: string
  sourceAnchor: AnchorKey
  targetAnchor: AnchorKey
  edgeType: string
  label: string
  lineType: 'orthogonal' | 'straight' | 'bezier'
  strokeColor: string
  strokeWidth: number
  strokeDash: number[]
  arrowStart: boolean
  arrowEnd: boolean
  metadata: Record<string, any>
  konvaConfig: Record<string, any>
  sortOrder: number
}

type ChartState = {
  id: string
  persisted: boolean
  title: string
  slug: string
  description: string
  chartType: string
  layoutEngine: string
  layoutDirection: string
  canvasWidth: number
  canvasHeight: number
  backgroundColor: string
  backgroundImageUrl: string
  status: string
  isFeatured: boolean
  sortOrder: number
}

const runtime = useRuntimeConfig()
const requestUrl = useRequestURL()
const { tenantApiUrl } = useAppApi()
const uploader = useCloudinaryUpload() as any

const stageRef = shallowRef<any>(null)
const stageShell = ref<HTMLElement | null>(null)
const gridLayerRef = shallowRef<any>(null)
const nodeLayerRef = shallowRef<any>(null)
const edgeLayerRef = shallowRef<any>(null)
const photoInput = ref<HTMLInputElement | null>(null)

const activeTool = ref<ToolType>('select')
const isDraggingTool = ref(false)
const isLoading = ref(false)
const isSaving = ref(false)
const exportMenuOpen = ref(false)
const hasUnsavedChanges = ref(false)

const selectedNodeId = ref('')
const selectedEdgeId = ref('')
const hoveredNodeId = ref('')
const stageScale = ref(1)
const stageX = ref(0)
const stageY = ref(0)
const stageWidth = ref(1280)
const stageHeight = ref(760)

const nodes = ref<DiagramNode[]>([])
const edges = ref<DiagramEdge[]>([])
const deletedNodeIds = ref<string[]>([])
const deletedEdgeIds = ref<string[]>([])
const imageCache = ref<Record<string, HTMLImageElement>>({})

const lineSource = ref<null | { nodeId: string; anchor: AnchorKey }>(null)
const tempLine = ref<null | { sourceNodeId: string; sourceAnchor: AnchorKey; x: number; y: number }>(null)

const contextMenu = reactive({
  show: false,
  kind: 'node' as DeleteKind,
  targetId: '',
  x: 0,
  y: 0
})

const deleteModal = reactive({
  open: false,
  kind: 'node' as DeleteKind,
  targetId: ''
})

const nodeSettingsOpen = ref(false)
const edgeSettingsOpen = ref(false)
const textEditorOpen = ref(false)
const nodeFormId = ref('')
const edgeFormId = ref('')
const pendingPhotoNodeId = ref('')
const textFormNodeId = ref('')
const textFormField = ref<'name' | 'positionTitle'>('name')

const chart = reactive<ChartState>({
  id: '',
  persisted: false,
  title: 'Struktur Organisasi',
  slug: 'struktur-organisasi',
  description: 'Bagan struktur organisasi tenant.',
  chartType: 'organization',
  layoutEngine: 'manual',
  layoutDirection: 'top-bottom',
  canvasWidth: 1600,
  canvasHeight: 1000,
  backgroundColor: '#ffffff',
  backgroundImageUrl: '',
  status: 'published',
  isFeatured: true,
  sortOrder: 0
})

const nodeForm = reactive({
  photoUrl: '',
  name: '',
  positionTitle: '',
  cornerRadius: 22,
  fillColor: '#ffffff',
  borderColor: '#dbeafe',
  textColor: '#171717',
  accentColor: '#2563eb',
  padding: 16,
  width: 240,
  height: 124
})

const edgeForm = reactive({
  label: '',
  lineType: 'orthogonal' as 'orthogonal' | 'straight' | 'bezier',
  strokeColor: '#94a3b8',
  strokeWidth: 2,
  dashMode: 'solid' as 'solid' | 'dashed' | 'dotted'
})

const textForm = reactive({
  value: ''
})

const toast = reactive({
  show: false,
  type: 'success' as ToastType,
  title: '',
  message: ''
})

let toastTimer: ReturnType<typeof setTimeout> | null = null

const tools = [
  { value: 'block' as ToolType, label: 'Block Kotak', icon: 'solar:widget-5-bold-duotone' },
  { value: 'line' as ToolType, label: 'Line', icon: 'solar:branching-paths-down-bold-duotone' },
  { value: 'text' as ToolType, label: 'Text', icon: 'solar:text-bold-duotone' }
]

const hostname = computed(() => String(requestUrl.hostname || '').replace(/^www\./, '').toLowerCase())
const envClientName = computed(() => String(runtime.public.clientName || 'martopuro').trim().toLowerCase())
const tenantSlug = computed(() => {
  if (hostname.value.includes('martopuro')) return 'martopuro'
  if (hostname.value.includes('obayan')) return 'obayan'
  return envClientName.value || 'martopuro'
})

const chartBaseUrl = computed(() => tenantApiUrl(tenantSlug.value, '/structure-organizations/charts'))
const chartUrl = computed(() => chart.id ? `${chartBaseUrl.value}/${chart.id}` : '')

const activeToolLabel = computed(() => tools.find((item) => item.value === activeTool.value)?.label || 'Select')
const selectedNode = computed(() => nodes.value.find((item) => item.id === selectedNodeId.value) || null)
const selectedEdge = computed(() => edges.value.find((item) => item.id === selectedEdgeId.value) || null)
const textFieldLabel = computed(() => textFormField.value === 'name' ? 'Nama' : 'Jabatan')

const stageConfig = computed(() => ({
  width: stageWidth.value,
  height: stageHeight.value,
  x: stageX.value,
  y: stageY.value,
  scaleX: stageScale.value,
  scaleY: stageScale.value,
  draggable: activeTool.value === 'select' && !selectedNodeId.value && !lineSource.value
}))

const gridLines = computed(() => {
  const size = 40
  const lines: Array<{ id: string; config: Record<string, any> }> = []
  const width = Math.max(chart.canvasWidth, stageWidth.value * 2)
  const height = Math.max(chart.canvasHeight, stageHeight.value * 2)

  for (let x = -width; x <= width; x += size) {
    lines.push({
      id: `v-${x}`,
      config: {
        points: [x, -height, x, height],
        stroke: '#e5e7eb',
        strokeWidth: 1,
        opacity: x === 0 ? 0.8 : 0.5,
        listening: false
      }
    })
  }

  for (let y = -height; y <= height; y += size) {
    lines.push({
      id: `h-${y}`,
      config: {
        points: [-width, y, width, y],
        stroke: '#e5e7eb',
        strokeWidth: 1,
        opacity: y === 0 ? 0.8 : 0.5,
        listening: false
      }
    })
  }

  return lines
})

const tempLineConfig = computed(() => {
  if (!tempLine.value) return {}
  const source = nodes.value.find((item) => item.id === tempLine.value?.sourceNodeId)
  if (!source) return {}
  const from = anchorPoint(source, tempLine.value.sourceAnchor)
  const to = { x: tempLine.value.x, y: tempLine.value.y }

  return {
    points: orthogonalPoints(from, to),
    stroke: '#2563eb',
    strokeWidth: 2,
    dash: [8, 6],
    lineCap: 'round',
    lineJoin: 'round',
    listening: false
  }
})

watch(nodes, () => {
  hasUnsavedChanges.value = true
  loadNodeImages()
}, { deep: true })

watch(edges, () => {
  hasUnsavedChanges.value = true
}, { deep: true })

watch(activeTool, (value) => {
  if (value === 'line') setStageCursor('crosshair')
  else if (value === 'text') setStageCursor('text')
  else setStageCursor('default')
})

onMounted(() => {
  updateStageSize()
  window.addEventListener('resize', updateStageSize)
  loadInitialChart()
})

onBeforeUnmount(() => {
  window.removeEventListener('resize', updateStageSize)
  if (toastTimer) clearTimeout(toastTimer)
})

function updateStageSize() {
  const rect = stageShell.value?.getBoundingClientRect()
  stageWidth.value = Math.max(600, Math.floor(rect?.width || 1200))
  stageHeight.value = Math.max(520, Math.floor(rect?.height || 760))
}

async function loadInitialChart() {
  isLoading.value = true

  try {
    const response = await $fetch<any>(chartBaseUrl.value, {
      query: {
        status: 'all',
        limit: 1,
        sort: 'sort_order'
      }
    })

    const firstChart = response?.data?.[0]

    if (!firstChart) {
      resetLocalDiagram()
      showToast('success', 'Canvas baru', 'Belum ada bagan, kamu bisa mulai membuat struktur organisasi.')
      return
    }

    const detail = await $fetch<any>(`${chartBaseUrl.value}/${firstChart.id}`, {
      query: { include: 'graph' }
    })

    hydrateFromResponse(detail?.data)
    showToast('success', 'Bagan dimuat', 'Struktur organisasi berhasil dimuat.')
  } catch (error: any) {
    showToast('error', 'Gagal memuat', getErrorMessage(error, 'Data struktur organisasi belum bisa dimuat.'))
  } finally {
    isLoading.value = false
    await nextTick()
    hasUnsavedChanges.value = false
  }
}

function resetLocalDiagram() {
  chart.id = ''
  chart.persisted = false
  chart.title = 'Struktur Organisasi'
  chart.slug = 'struktur-organisasi'
  chart.description = 'Bagan struktur organisasi tenant.'
  chart.status = 'published'
  nodes.value = []
  edges.value = []
  deletedNodeIds.value = []
  deletedEdgeIds.value = []
  selectedNodeId.value = ''
  selectedEdgeId.value = ''
  lineSource.value = null
  tempLine.value = null
}

function hydrateFromResponse(data: any) {
  const incomingChart = data?.chart || data
  const incomingNodes = Array.isArray(data?.nodes) ? data.nodes : []
  const incomingEdges = Array.isArray(data?.edges) ? data.edges : []

  chart.id = cleanString(incomingChart?.id)
  chart.persisted = Boolean(incomingChart?.id)
  chart.title = cleanString(incomingChart?.title, 'Struktur Organisasi')
  chart.slug = cleanSlug(incomingChart?.slug || chart.title)
  chart.description = cleanString(incomingChart?.description)
  chart.chartType = cleanString(incomingChart?.chartType, 'organization')
  chart.layoutEngine = cleanString(incomingChart?.layoutEngine, 'manual')
  chart.layoutDirection = cleanString(incomingChart?.layoutDirection, 'top-bottom')
  chart.canvasWidth = numberValue(incomingChart?.canvasWidth, 1600)
  chart.canvasHeight = numberValue(incomingChart?.canvasHeight, 1000)
  chart.backgroundColor = cleanString(incomingChart?.backgroundColor, '#ffffff')
  chart.backgroundImageUrl = cleanString(incomingChart?.backgroundImageUrl)
  chart.status = cleanString(incomingChart?.status, 'published')
  chart.isFeatured = Boolean(incomingChart?.isFeatured)
  chart.sortOrder = numberValue(incomingChart?.sortOrder, 0)

  nodes.value = incomingNodes.map(mapApiNode)
  edges.value = incomingEdges.map(mapApiEdge)
  deletedNodeIds.value = []
  deletedEdgeIds.value = []
  selectedNodeId.value = ''
  selectedEdgeId.value = ''
  loadNodeImages()
}

function mapApiNode(item: any): DiagramNode {
  const style = normalizeObject(item?.styleConfig)
  const metadata = normalizeObject(item?.metadata)

  return {
    id: cleanString(item?.id) || uid(),
    persisted: true,
    parentId: item?.parentId || null,
    name: cleanString(item?.name, 'Nama'),
    slug: cleanSlug(item?.slug || item?.name),
    positionTitle: cleanString(item?.positionTitle, 'Jabatan'),
    positionCode: item?.positionCode || null,
    organizationUnit: item?.organizationUnit || null,
    photoUrl: cleanString(item?.photoUrl),
    icon: cleanString(item?.icon, 'solar:user-rounded-bold-duotone'),
    x: numberValue(item?.x, 100),
    y: numberValue(item?.y, 100),
    width: numberValue(item?.width, 240),
    height: numberValue(item?.height, 124),
    rotation: numberValue(item?.rotation, 0),
    scaleX: numberValue(item?.scaleX, 1),
    scaleY: numberValue(item?.scaleY, 1),
    fillColor: cleanString(item?.fillColor || style.fillColor, '#ffffff'),
    borderColor: cleanString(item?.borderColor || style.borderColor, '#dbeafe'),
    borderWidth: numberValue(item?.borderWidth, 1),
    textColor: cleanString(item?.textColor || style.textColor, '#171717'),
    accentColor: cleanString(item?.accentColor || style.accentColor, '#2563eb'),
    cornerRadius: numberValue(style.cornerRadius || metadata.cornerRadius, 22),
    padding: numberValue(style.padding || metadata.padding, 16),
    nameFontSize: numberValue(item?.nameFontSize, 16),
    positionFontSize: numberValue(item?.positionFontSize, 13),
    photoShape: item?.photoShape || 'circle',
    photoWidth: numberValue(item?.photoWidth, 56),
    photoHeight: numberValue(item?.photoHeight, 56),
    draggable: item?.draggable !== false,
    locked: Boolean(item?.locked),
    visible: item?.visible !== false,
    nodeType: cleanString(item?.nodeType, 'person'),
    shapeType: cleanString(item?.shapeType, 'card'),
    metadata,
    konvaConfig: normalizeObject(item?.konvaConfig),
    styleConfig: style,
    sortOrder: numberValue(item?.sortOrder, 0)
  }
}

function mapApiEdge(item: any): DiagramEdge {
  const metadata = normalizeObject(item?.metadata)
  const dash = Array.isArray(item?.strokeDash) ? item.strokeDash : []

  return {
    id: cleanString(item?.id) || uid(),
    persisted: true,
    sourceNodeId: cleanString(item?.sourceNodeId),
    targetNodeId: cleanString(item?.targetNodeId),
    sourceAnchor: metadata.sourceAnchor || 'bottom',
    targetAnchor: metadata.targetAnchor || 'top',
    edgeType: cleanString(item?.edgeType, 'hierarchy'),
    label: cleanString(item?.label),
    lineType: item?.lineType || 'orthogonal',
    strokeColor: cleanString(item?.strokeColor, '#94a3b8'),
    strokeWidth: numberValue(item?.strokeWidth, 2),
    strokeDash: dash,
    arrowStart: Boolean(item?.arrowStart),
    arrowEnd: Boolean(item?.arrowEnd),
    metadata,
    konvaConfig: normalizeObject(item?.konvaConfig),
    sortOrder: numberValue(item?.sortOrder, 0)
  }
}

function handleToolClick(tool: ToolType) {
  closeFloatingMenus()
  activeTool.value = tool

  if (tool === 'block') {
    const center = screenToCanvas(stageWidth.value / 2, stageHeight.value / 2)
    createNodeAt(center.x - 120, center.y - 62)
    activeTool.value = 'select'
  }
}

function onToolDragStart(event: DragEvent, tool: ToolType) {
  isDraggingTool.value = true
  event.dataTransfer?.setData('tool', tool)
  event.dataTransfer?.setDragImage(new Image(), 0, 0)
}

function onToolDragEnd() {
  isDraggingTool.value = false
}

function onCanvasDrop(event: DragEvent) {
  const tool = event.dataTransfer?.getData('tool') as ToolType
  if (tool !== 'block') return

  const rect = stageShell.value?.getBoundingClientRect()
  const point = screenToCanvas(
    event.clientX - Number(rect?.left || 0),
    event.clientY - Number(rect?.top || 0)
  )

  createNodeAt(point.x - 120, point.y - 62)
  isDraggingTool.value = false
  activeTool.value = 'select'
}

function createNodeAt(x: number, y: number) {
  const color = randomPalette()
  const id = uid()
  const order = nodes.value.length + 1

  nodes.value.push({
    id,
    persisted: false,
    parentId: null,
    name: `Nama ${order}`,
    slug: `nama-${order}`,
    positionTitle: 'Jabatan',
    positionCode: null,
    organizationUnit: null,
    photoUrl: '',
    icon: 'solar:user-rounded-bold-duotone',
    x,
    y,
    width: 240,
    height: 124,
    rotation: 0,
    scaleX: 1,
    scaleY: 1,
    fillColor: color.bg,
    borderColor: color.border,
    borderWidth: 1,
    textColor: '#111827',
    accentColor: color.accent,
    cornerRadius: 22,
    padding: 16,
    nameFontSize: 16,
    positionFontSize: 13,
    photoShape: 'circle',
    photoWidth: 56,
    photoHeight: 56,
    draggable: true,
    locked: false,
    visible: true,
    nodeType: 'person',
    shapeType: 'card',
    metadata: {},
    konvaConfig: {},
    styleConfig: {},
    sortOrder: order
  })

  selectedNodeId.value = id
  selectedEdgeId.value = ''
  showToast('success', 'Block ditambahkan', 'Block organisasi muncul di canvas.')
}

function nodeGroupConfig(node: DiagramNode) {
  return {
    x: node.x,
    y: node.y,
    rotation: node.rotation,
    scaleX: node.scaleX,
    scaleY: node.scaleY,
    draggable: node.draggable && !node.locked,
    visible: node.visible
  }
}

function nodeShadowConfig(node: DiagramNode) {
  return {
    x: 0,
    y: 8,
    width: node.width,
    height: node.height,
    cornerRadius: node.cornerRadius,
    fill: 'rgba(15,23,42,0.08)',
    blurRadius: 18,
    listening: false
  }
}

function nodeCardConfig(node: DiagramNode) {
  return {
    x: 0,
    y: 0,
    width: node.width,
    height: node.height,
    cornerRadius: node.cornerRadius,
    fill: node.fillColor,
    stroke: isNodeActive(node.id) ? node.accentColor : node.borderColor,
    strokeWidth: isNodeActive(node.id) ? 2 : node.borderWidth,
    shadowColor: 'rgba(15,23,42,0.12)',
    shadowBlur: 18,
    shadowOffsetY: 8,
    shadowOpacity: isNodeActive(node.id) ? 0.22 : 0.08
  }
}

function photoGroupConfig(node: DiagramNode) {
  return {
    x: node.padding,
    y: node.padding + 6
  }
}

function photoBackgroundConfig(node: DiagramNode) {
  return {
    x: node.photoWidth / 2,
    y: node.photoHeight / 2,
    radius: Math.min(node.photoWidth, node.photoHeight) / 2,
    fill: '#eff6ff',
    stroke: node.accentColor,
    strokeWidth: 1
  }
}

function nodePhotoImageConfig(node: DiagramNode) {
  return {
    x: 0,
    y: 0,
    image: imageCache.value[node.id],
    width: node.photoWidth,
    height: node.photoHeight,
    cornerRadius: node.photoShape === 'circle' ? node.photoWidth / 2 : 14
  }
}

function nodePhotoFallbackConfig(node: DiagramNode) {
  return {
    x: 0,
    y: 13,
    width: node.photoWidth,
    height: 28,
    text: '👤',
    fontSize: 24,
    align: 'center',
    verticalAlign: 'middle',
    fill: node.accentColor
  }
}

function nodeNameTextConfig(node: DiagramNode) {
  return {
    x: node.padding + node.photoWidth + 12,
    y: node.padding + 14,
    width: node.width - node.padding * 2 - node.photoWidth - 12,
    height: 22,
    text: node.name,
    fontSize: node.nameFontSize,
    fontStyle: 'bold',
    fill: node.textColor,
    ellipsis: true
  }
}

function nodePositionTextConfig(node: DiagramNode) {
  return {
    x: node.padding + node.photoWidth + 12,
    y: node.padding + 42,
    width: node.width - node.padding * 2 - node.photoWidth - 12,
    height: 20,
    text: node.positionTitle,
    fontSize: node.positionFontSize,
    fill: '#64748b',
    ellipsis: true
  }
}

function ellipsisGroupConfig(node: DiagramNode) {
  return {
    x: node.width - 24,
    y: 22
  }
}

const ellipsisCircleConfig = {
  x: 0,
  y: 0,
  radius: 13,
  fill: '#ffffff',
  stroke: '#e5e7eb',
  strokeWidth: 1,
  shadowColor: 'rgba(15,23,42,0.12)',
  shadowBlur: 8,
  shadowOffsetY: 2
}

const ellipsisTextConfig = {
  x: -7,
  y: -11,
  width: 14,
  height: 16,
  text: '⋯',
  fontSize: 18,
  fontStyle: 'bold',
  fill: '#475569',
  align: 'center'
}

function handleConfig(node: DiagramNode, anchor: AnchorKey) {
  const point = localAnchorPoint(node, anchor)
  return {
    x: point.x,
    y: point.y,
    radius: 5.5,
    fill: '#ffffff',
    stroke: node.accentColor,
    strokeWidth: 2,
    shadowColor: 'rgba(37,99,235,0.25)',
    shadowBlur: 8,
    hitStrokeWidth: 16
  }
}

function visibleHandles(node: DiagramNode) {
  if (!isNodeActive(node.id) && activeTool.value !== 'line') return []
  return ['top', 'bottom', 'topLeft', 'topRight', 'bottomLeft', 'bottomRight'] as AnchorKey[]
}

function isNodeActive(id: string) {
  return selectedNodeId.value === id || hoveredNodeId.value === id || activeTool.value === 'line'
}

function edgeKonvaConfig(edge: DiagramEdge) {
  const source = nodes.value.find((item) => item.id === edge.sourceNodeId)
  const target = nodes.value.find((item) => item.id === edge.targetNodeId)

  if (!source || !target) {
    return {
      points: [],
      visible: false
    }
  }

  const from = anchorPoint(source, edge.sourceAnchor)
  const to = anchorPoint(target, edge.targetAnchor)
  const points = edge.lineType === 'straight'
    ? [from.x, from.y, to.x, to.y]
    : orthogonalPoints(from, to)

  return {
    points,
    stroke: selectedEdgeId.value === edge.id ? '#2563eb' : edge.strokeColor,
    strokeWidth: selectedEdgeId.value === edge.id ? edge.strokeWidth + 1 : edge.strokeWidth,
    dash: edge.strokeDash,
    lineCap: 'round',
    lineJoin: 'round',
    tension: edge.lineType === 'bezier' ? 0.45 : 0,
    hitStrokeWidth: 18,
    shadowColor: 'rgba(37,99,235,0.18)',
    shadowBlur: selectedEdgeId.value === edge.id ? 10 : 0
  }
}

function onNodeDragStart(node: DiagramNode) {
  selectedNodeId.value = node.id
  selectedEdgeId.value = ''
}

function onNodeDragMove(event: any, node: DiagramNode) {
  const target = event.target
  node.x = round(target.x())
  node.y = round(target.y())
}

function onNodeDragEnd(event: any, node: DiagramNode) {
  const target = event.target
  node.x = round(target.x())
  node.y = round(target.y())
}

function onNodeMouseEnter(node: DiagramNode) {
  hoveredNodeId.value = node.id
  setStageCursor(activeTool.value === 'line' ? 'crosshair' : 'move')
}

function onNodeMouseLeave(node: DiagramNode) {
  if (hoveredNodeId.value === node.id) hoveredNodeId.value = ''
  setStageCursor(activeTool.value === 'line' ? 'crosshair' : 'default')
}

function onNodeClick(event: any, node: DiagramNode) {
  event.cancelBubble = true
  closeFloatingMenus()

  if (activeTool.value === 'text') {
    openTextEditor(node, 'name')
    return
  }

  if (activeTool.value === 'line') {
    if (!lineSource.value) {
      lineSource.value = { nodeId: node.id, anchor: 'bottom' }
      selectedNodeId.value = node.id
      return
    }

    if (lineSource.value.nodeId !== node.id) {
      createEdge(lineSource.value.nodeId, node.id, lineSource.value.anchor, 'top')
      lineSource.value = null
      tempLine.value = null
      activeTool.value = 'select'
      return
    }
  }

  selectedNodeId.value = node.id
  selectedEdgeId.value = ''
}

function onStageClick(event: any) {
  const target = event.target
  const stage = stageRef.value?.getStage?.()
  if (target === stage) {
    selectedNodeId.value = ''
    selectedEdgeId.value = ''
    if (activeTool.value !== 'line' && activeTool.value !== 'text') activeTool.value = 'select'
    closeFloatingMenus()
  }
}

function onStageMouseDown(event: any) {
  const stage = stageRef.value?.getStage?.()
  if (event.target === stage && activeTool.value === 'select') {
    selectedNodeId.value = ''
    selectedEdgeId.value = ''
  }
}

function onStageMouseMove() {
  if (!tempLine.value) return
  const pointer = stageRef.value?.getStage?.().getPointerPosition()
  if (!pointer) return
  const point = screenToCanvas(pointer.x, pointer.y)
  tempLine.value.x = point.x
  tempLine.value.y = point.y
}

function onStageMouseUp() {
  if (tempLine.value && !lineSource.value) {
    tempLine.value = null
  }
}

function onWheel(event: any) {
  event.evt.preventDefault()
  const stage = stageRef.value?.getStage?.()
  const oldScale = stageScale.value
  const pointer = stage?.getPointerPosition()
  if (!pointer) return

  const scaleBy = 1.06
  const direction = event.evt.deltaY > 0 ? -1 : 1
  const newScale = direction > 0 ? oldScale * scaleBy : oldScale / scaleBy
  const clampedScale = Math.max(0.25, Math.min(2.5, newScale))
  const mousePointTo = {
    x: (pointer.x - stageX.value) / oldScale,
    y: (pointer.y - stageY.value) / oldScale
  }

  stageScale.value = clampedScale
  stageX.value = pointer.x - mousePointTo.x * clampedScale
  stageY.value = pointer.y - mousePointTo.y * clampedScale
}

function resetView() {
  stageScale.value = 1
  stageX.value = 0
  stageY.value = 0
}

function startLineFromHandle(event: any, node: DiagramNode, anchor: AnchorKey) {
  event.cancelBubble = true
  lineSource.value = { nodeId: node.id, anchor }
  const point = anchorPoint(node, anchor)
  tempLine.value = {
    sourceNodeId: node.id,
    sourceAnchor: anchor,
    x: point.x,
    y: point.y
  }
  activeTool.value = 'line'
}

function finishLineToHandle(event: any, node: DiagramNode, anchor: AnchorKey) {
  event.cancelBubble = true
  if (!lineSource.value || lineSource.value.nodeId === node.id) return
  createEdge(lineSource.value.nodeId, node.id, lineSource.value.anchor, anchor)
  lineSource.value = null
  tempLine.value = null
  activeTool.value = 'select'
}

function createEdge(sourceNodeId: string, targetNodeId: string, sourceAnchor: AnchorKey, targetAnchor: AnchorKey) {
  const exists = edges.value.some((edge) => edge.sourceNodeId === sourceNodeId && edge.targetNodeId === targetNodeId)
  if (exists) {
    showToast('error', 'Line sudah ada', 'Relasi antar block tersebut sudah dibuat.')
    return
  }

  edges.value.push({
    id: uid(),
    persisted: false,
    sourceNodeId,
    targetNodeId,
    sourceAnchor,
    targetAnchor,
    edgeType: 'hierarchy',
    label: '',
    lineType: 'orthogonal',
    strokeColor: '#94a3b8',
    strokeWidth: 2,
    strokeDash: [],
    arrowStart: false,
    arrowEnd: false,
    metadata: { sourceAnchor, targetAnchor },
    konvaConfig: {},
    sortOrder: edges.value.length
  })

  showToast('success', 'Line dibuat', 'Garis relasi otomatis tersambung ke block tujuan.')
}

function selectEdge(id: string) {
  selectedEdgeId.value = id
  selectedNodeId.value = ''
}

function openNodeContextMenu(event: any, node: DiagramNode) {
  event.evt.preventDefault()
  event.cancelBubble = true
  openContextMenu('node', node.id, event.evt.clientX, event.evt.clientY)
}

function openEdgeContextMenu(event: any, edge: DiagramEdge) {
  event.evt.preventDefault()
  event.cancelBubble = true
  openContextMenu('edge', edge.id, event.evt.clientX, event.evt.clientY)
}

function openNodeMenuFromCanvas(event: any, node: DiagramNode) {
  event.cancelBubble = true
  const pointer = stageRef.value?.getStage?.().getPointerPosition()
  const rect = stageShell.value?.getBoundingClientRect()
  openContextMenu(
    'node',
    node.id,
    Number(rect?.left || 0) + Number(pointer?.x || 0) + 12,
    Number(rect?.top || 0) + Number(pointer?.y || 0) + 12
  )
}

function openContextMenu(kind: DeleteKind, targetId: string, x: number, y: number) {
  contextMenu.show = true
  contextMenu.kind = kind
  contextMenu.targetId = targetId
  contextMenu.x = Math.min(window.innerWidth - 230, x)
  contextMenu.y = Math.min(window.innerHeight - 160, y)
}

function closeFloatingMenus() {
  contextMenu.show = false
  exportMenuOpen.value = false
}

function openNodeSettingsById(id: string) {
  const node = nodes.value.find((item) => item.id === id)
  if (node) openNodeSettings(node)
}

function openNodeSettings(node: DiagramNode) {
  closeFloatingMenus()
  nodeFormId.value = node.id
  nodeForm.photoUrl = node.photoUrl
  nodeForm.name = node.name
  nodeForm.positionTitle = node.positionTitle
  nodeForm.cornerRadius = node.cornerRadius
  nodeForm.fillColor = node.fillColor
  nodeForm.borderColor = node.borderColor
  nodeForm.textColor = node.textColor
  nodeForm.accentColor = node.accentColor
  nodeForm.padding = node.padding
  nodeForm.width = node.width
  nodeForm.height = node.height
  nodeSettingsOpen.value = true
}

function closeNodeSettings() {
  nodeSettingsOpen.value = false
}

function applyNodeSettings() {
  const node = nodes.value.find((item) => item.id === nodeFormId.value)
  if (!node) return

  node.photoUrl = nodeForm.photoUrl
  node.name = nodeForm.name || 'Nama'
  node.slug = cleanSlug(nodeForm.name || node.name)
  node.positionTitle = nodeForm.positionTitle || 'Jabatan'
  node.cornerRadius = numberValue(nodeForm.cornerRadius, 22)
  node.fillColor = nodeForm.fillColor || '#ffffff'
  node.borderColor = nodeForm.borderColor || '#dbeafe'
  node.textColor = nodeForm.textColor || '#171717'
  node.accentColor = nodeForm.accentColor || '#2563eb'
  node.padding = numberValue(nodeForm.padding, 16)
  node.width = numberValue(nodeForm.width, 240)
  node.height = numberValue(nodeForm.height, 124)
  node.styleConfig = {
    ...node.styleConfig,
    cornerRadius: node.cornerRadius,
    padding: node.padding,
    fillColor: node.fillColor,
    borderColor: node.borderColor,
    textColor: node.textColor,
    accentColor: node.accentColor
  }

  closeNodeSettings()
  loadNodeImages()
}

function openEdgeSettingsById(id: string) {
  const edge = edges.value.find((item) => item.id === id)
  if (!edge) return

  closeFloatingMenus()
  edgeFormId.value = edge.id
  edgeForm.label = edge.label
  edgeForm.lineType = edge.lineType
  edgeForm.strokeColor = edge.strokeColor
  edgeForm.strokeWidth = edge.strokeWidth
  edgeForm.dashMode = dashModeFromArray(edge.strokeDash)
  edgeSettingsOpen.value = true
}

function closeEdgeSettings() {
  edgeSettingsOpen.value = false
}

function applyEdgeSettings() {
  const edge = edges.value.find((item) => item.id === edgeFormId.value)
  if (!edge) return

  edge.label = edgeForm.label
  edge.lineType = edgeForm.lineType
  edge.strokeColor = edgeForm.strokeColor || '#94a3b8'
  edge.strokeWidth = numberValue(edgeForm.strokeWidth, 2)
  edge.strokeDash = dashArrayFromMode(edgeForm.dashMode)
  closeEdgeSettings()
}

function openTextEditor(node: DiagramNode, field: 'name' | 'positionTitle') {
  textFormNodeId.value = node.id
  textFormField.value = field
  textForm.value = node[field]
  textEditorOpen.value = true
}

function closeTextEditor() {
  textEditorOpen.value = false
}

function applyTextEdit() {
  const node = nodes.value.find((item) => item.id === textFormNodeId.value)
  if (!node) return

  node[textFormField.value] = textForm.value || (textFormField.value === 'name' ? 'Nama' : 'Jabatan')
  if (textFormField.value === 'name') node.slug = cleanSlug(node.name)
  closeTextEditor()
}

function openPhotoPicker(node: DiagramNode) {
  pendingPhotoNodeId.value = node.id
  photoInput.value?.click()
}

function triggerNodeFormPhoto() {
  pendingPhotoNodeId.value = nodeFormId.value
  photoInput.value?.click()
}

async function onPickPhoto(event: Event) {
  const input = event.target as HTMLInputElement
  const file = input.files?.[0]
  if (!file || !pendingPhotoNodeId.value) return

  try {
    validateImage(file)
    const method = uploader.uploadImage || uploader.uploadFile
    if (typeof method !== 'function') throw new Error('Fitur upload belum tersedia.')

    const response = await method(file, {
      folder: `${tenantSlug.value}/structure-organizations/photos`,
      maxWidth: 900,
      maxHeight: 900,
      quality: 0.82,
      maxBytes: 5 * 1024 * 1024
    })

    const url = getUploadedUrl(response)
    if (!url) throw new Error('URL hasil upload tidak ditemukan.')

    const node = nodes.value.find((item) => item.id === pendingPhotoNodeId.value)
    if (node) node.photoUrl = url
    if (nodeFormId.value === pendingPhotoNodeId.value) nodeForm.photoUrl = url

    showToast('success', 'Foto diganti', 'Foto berhasil diunggah dan dipasang ke block.')
  } catch (error: any) {
    showToast('error', 'Gagal upload', getErrorMessage(error, 'Gunakan link foto atau coba gambar lain.'))
  } finally {
    input.value = ''
    pendingPhotoNodeId.value = ''
    loadNodeImages()
  }
}

function duplicateNodeById(id: string) {
  const node = nodes.value.find((item) => item.id === id)
  if (!node) return

  const copied: DiagramNode = {
    ...node,
    id: uid(),
    persisted: false,
    name: `${node.name} Copy`,
    slug: `${node.slug}-copy`,
    x: node.x + 32,
    y: node.y + 32,
    sortOrder: nodes.value.length + 1
  }

  nodes.value.push(copied)
  selectedNodeId.value = copied.id
  closeFloatingMenus()
}

function requestDelete(kind: DeleteKind, targetId: string) {
  closeFloatingMenus()
  deleteModal.kind = kind
  deleteModal.targetId = targetId
  deleteModal.open = true
}

function confirmDeleteItem() {
  if (deleteModal.kind === 'node') {
    const node = nodes.value.find((item) => item.id === deleteModal.targetId)
    if (node?.persisted) deletedNodeIds.value.push(node.id)

    const removedEdges = edges.value.filter((edge) => edge.sourceNodeId === deleteModal.targetId || edge.targetNodeId === deleteModal.targetId)
    for (const edge of removedEdges) {
      if (edge.persisted) deletedEdgeIds.value.push(edge.id)
    }

    nodes.value = nodes.value.filter((item) => item.id !== deleteModal.targetId)
    edges.value = edges.value.filter((edge) => edge.sourceNodeId !== deleteModal.targetId && edge.targetNodeId !== deleteModal.targetId)
    if (selectedNodeId.value === deleteModal.targetId) selectedNodeId.value = ''
  }

  if (deleteModal.kind === 'edge') {
    const edge = edges.value.find((item) => item.id === deleteModal.targetId)
    if (edge?.persisted) deletedEdgeIds.value.push(edge.id)
    edges.value = edges.value.filter((item) => item.id !== deleteModal.targetId)
    if (selectedEdgeId.value === deleteModal.targetId) selectedEdgeId.value = ''
  }

  deleteModal.open = false
  showToast('success', 'Item dihapus', 'Klik Save untuk menyimpan perubahan ke database.')
}

async function saveDiagram() {
  if (isSaving.value) return
  isSaving.value = true

  try {
    let savedChart = null as any

    if (!chart.persisted) {
      savedChart = await $fetch<any>(chartBaseUrl.value, {
        method: 'POST',
        body: chartPayload()
      })
    } else {
      savedChart = await $fetch<any>(chartUrl.value, {
        method: 'PUT',
        body: chartPayload()
      })
    }

    const chartData = savedChart?.data
    if (chartData?.id) {
      chart.id = chartData.id
      chart.slug = chartData.slug || chart.slug
      chart.persisted = true
    }

    const chartKey = chart.id || chart.slug
    const nodeIdMap = new Map<string, string>()

    for (const edgeId of unique(deletedEdgeIds.value)) {
      await safeFetch(`${chartBaseUrl.value}/${chartKey}/edges/${edgeId}`, { method: 'DELETE' })
    }

    for (const nodeId of unique(deletedNodeIds.value)) {
      await safeFetch(`${chartBaseUrl.value}/${chartKey}/nodes/${nodeId}`, { method: 'DELETE' })
    }

    for (const node of nodes.value) {
      const payload = nodePayload(node)
      let result: any

      if (node.persisted) {
        result = await $fetch<any>(`${chartBaseUrl.value}/${chartKey}/nodes/${node.id}`, {
          method: 'PUT',
          body: payload
        })
      } else {
        const oldId = node.id
        result = await $fetch<any>(`${chartBaseUrl.value}/${chartKey}/nodes`, {
          method: 'POST',
          body: payload
        })
        const newId = result?.data?.id
        if (newId) {
          nodeIdMap.set(oldId, newId)
          node.id = newId
          node.persisted = true
        }
      }
    }

    if (nodeIdMap.size) {
      for (const edge of edges.value) {
        edge.sourceNodeId = nodeIdMap.get(edge.sourceNodeId) || edge.sourceNodeId
        edge.targetNodeId = nodeIdMap.get(edge.targetNodeId) || edge.targetNodeId
      }
    }

    for (const edge of edges.value) {
      const payload = edgePayload(edge)

      if (edge.persisted) {
        await $fetch(`${chartBaseUrl.value}/${chartKey}/edges/${edge.id}`, {
          method: 'PUT',
          body: payload
        })
      } else {
        const result = await $fetch<any>(`${chartBaseUrl.value}/${chartKey}/edges`, {
          method: 'POST',
          body: payload
        })
        const newId = result?.data?.id
        if (newId) {
          edge.id = newId
          edge.persisted = true
        }
      }
    }

    deletedNodeIds.value = []
    deletedEdgeIds.value = []
    hasUnsavedChanges.value = false
    showToast('success', 'Tersimpan', 'Struktur organisasi berhasil disimpan ke database.')
  } catch (error: any) {
    showToast('error', 'Gagal menyimpan', getErrorMessage(error, 'Periksa endpoint dan koneksi lalu coba lagi.'))
  } finally {
    isSaving.value = false
  }
}

function chartPayload() {
  return {
    title: chart.title || 'Struktur Organisasi',
    slug: cleanSlug(chart.slug || chart.title || 'struktur-organisasi'),
    description: chart.description || null,
    chartType: chart.chartType,
    layoutEngine: 'manual',
    layoutDirection: chart.layoutDirection,
    canvasWidth: chart.canvasWidth,
    canvasHeight: chart.canvasHeight,
    backgroundColor: chart.backgroundColor || null,
    backgroundImageUrl: chart.backgroundImageUrl || null,
    gridEnabled: true,
    gridSize: 40,
    snapToGrid: false,
    zoomMin: 0.25,
    zoomMax: 2.5,
    initialScale: 1,
    nodeDefaultConfig: {
      cornerRadius: 22,
      padding: 16,
      width: 240,
      height: 124
    },
    edgeDefaultConfig: {
      stroke: '#94a3b8',
      strokeWidth: 2,
      lineCap: 'round',
      lineJoin: 'round'
    },
    konvaConfig: {
      scale: stageScale.value,
      x: stageX.value,
      y: stageY.value
    },
    metadata: {
      source: 'app-structure-organization',
      nodeCount: nodes.value.length,
      edgeCount: edges.value.length
    },
    status: chart.status,
    isFeatured: chart.isFeatured,
    sortOrder: chart.sortOrder
  }
}

function nodePayload(node: DiagramNode) {
  return {
    parentId: node.parentId,
    name: node.name,
    slug: cleanSlug(node.slug || node.name),
    positionTitle: node.positionTitle,
    positionCode: node.positionCode,
    organizationUnit: node.organizationUnit,
    photoUrl: node.photoUrl || null,
    icon: node.icon,
    shortDescription: null,
    contentHtml: null,
    contentJson: {},
    nodeType: node.nodeType,
    shapeType: node.shapeType,
    x: node.x,
    y: node.y,
    width: node.width,
    height: node.height,
    rotation: node.rotation,
    scaleX: node.scaleX,
    scaleY: node.scaleY,
    fillColor: node.fillColor,
    borderColor: node.borderColor,
    borderWidth: node.borderWidth,
    textColor: node.textColor,
    accentColor: node.accentColor,
    nameFontSize: node.nameFontSize,
    positionFontSize: node.positionFontSize,
    photoShape: node.photoShape,
    photoWidth: node.photoWidth,
    photoHeight: node.photoHeight,
    draggable: node.draggable,
    locked: node.locked,
    visible: node.visible,
    konvaConfig: node.konvaConfig,
    styleConfig: {
      ...node.styleConfig,
      cornerRadius: node.cornerRadius,
      padding: node.padding,
      fillColor: node.fillColor,
      borderColor: node.borderColor,
      textColor: node.textColor,
      accentColor: node.accentColor
    },
    socialConfig: {},
    metadata: {
      ...node.metadata,
      cornerRadius: node.cornerRadius,
      padding: node.padding
    },
    status: 'active',
    isFeatured: false,
    sortOrder: node.sortOrder
  }
}

function edgePayload(edge: DiagramEdge) {
  return {
    sourceNodeId: edge.sourceNodeId,
    targetNodeId: edge.targetNodeId,
    edgeType: edge.edgeType,
    label: edge.label || null,
    lineType: edge.lineType,
    strokeColor: edge.strokeColor,
    strokeWidth: edge.strokeWidth,
    strokeDash: edge.strokeDash,
    arrowStart: edge.arrowStart,
    arrowEnd: edge.arrowEnd,
    pointsConfig: {},
    konvaConfig: edge.konvaConfig,
    metadata: {
      ...edge.metadata,
      sourceAnchor: edge.sourceAnchor,
      targetAnchor: edge.targetAnchor
    },
    status: 'active',
    sortOrder: edge.sortOrder
  }
}

async function safeFetch(url: string, options: Record<string, any>) {
  try {
    await $fetch(url, options)
  } catch {
    // Soft delete may already be applied; keep save flow resilient.
  }
}

async function exportAsPdf() {
  exportMenuOpen.value = false

  try {
    const stage = stageRef.value?.getStage?.()
    if (!stage) throw new Error('Canvas belum siap.')

    const dataUrl = stage.toDataURL({ pixelRatio: 2, mimeType: 'image/png' })
    const { jsPDF } = await import('jspdf')
    const pdf = new jsPDF({ orientation: 'landscape', unit: 'px', format: [stageWidth.value, stageHeight.value] })
    pdf.addImage(dataUrl, 'PNG', 0, 0, stageWidth.value, stageHeight.value)
    pdf.save(`${cleanSlug(chart.slug || chart.title)}.pdf`)
  } catch (error: any) {
    showToast('error', 'Export PDF gagal', getErrorMessage(error, 'Pastikan package jspdf sudah terpasang.'))
  }
}

function exportAsCsv() {
  exportMenuOpen.value = false
  const rows = [
    ['type', 'id', 'name', 'position', 'source', 'target', 'x', 'y'],
    ...nodes.value.map((node) => ['node', node.id, node.name, node.positionTitle, '', '', String(node.x), String(node.y)]),
    ...edges.value.map((edge) => ['edge', edge.id, '', '', edge.sourceNodeId, edge.targetNodeId, '', ''])
  ]
  downloadBlob(toCsv(rows), `${cleanSlug(chart.slug || chart.title)}.csv`, 'text/csv;charset=utf-8')
}

function exportAsExcel() {
  exportMenuOpen.value = false
  const rows = [
    ['Type', 'ID', 'Name', 'Position', 'Source', 'Target', 'X', 'Y'],
    ...nodes.value.map((node) => ['Node', node.id, node.name, node.positionTitle, '', '', String(node.x), String(node.y)]),
    ...edges.value.map((edge) => ['Edge', edge.id, '', '', edge.sourceNodeId, edge.targetNodeId, '', ''])
  ]
  downloadBlob(toTsv(rows), `${cleanSlug(chart.slug || chart.title)}.xls`, 'application/vnd.ms-excel;charset=utf-8')
}

function loadNodeImages() {
  for (const node of nodes.value) {
    if (!node.photoUrl || imageCache.value[node.id]) continue
    const image = new Image()
    image.crossOrigin = 'anonymous'
    image.onload = () => {
      imageCache.value = {
        ...imageCache.value,
        [node.id]: image
      }
    }
    image.src = node.photoUrl
  }
}

function anchorPoint(node: DiagramNode, anchor: AnchorKey) {
  const local = localAnchorPoint(node, anchor)
  return {
    x: node.x + local.x,
    y: node.y + local.y
  }
}

function localAnchorPoint(node: DiagramNode, anchor: AnchorKey) {
  const map: Record<AnchorKey, { x: number; y: number }> = {
    top: { x: node.width / 2, y: 0 },
    bottom: { x: node.width / 2, y: node.height },
    topLeft: { x: 0, y: 0 },
    topRight: { x: node.width, y: 0 },
    bottomLeft: { x: 0, y: node.height },
    bottomRight: { x: node.width, y: node.height }
  }
  return map[anchor]
}

function orthogonalPoints(from: { x: number; y: number }, to: { x: number; y: number }) {
  const dx = Math.abs(to.x - from.x)
  const dy = Math.abs(to.y - from.y)

  if (dy >= dx) {
    const midY = from.y + (to.y - from.y) / 2
    return [from.x, from.y, from.x, midY, to.x, midY, to.x, to.y]
  }

  const midX = from.x + (to.x - from.x) / 2
  return [from.x, from.y, midX, from.y, midX, to.y, to.x, to.y]
}

function screenToCanvas(x: number, y: number) {
  return {
    x: (x - stageX.value) / stageScale.value,
    y: (y - stageY.value) / stageScale.value
  }
}

function setStageCursor(cursor: string) {
  const container = stageRef.value?.getStage?.().container?.()
  if (container) container.style.cursor = cursor
}

function validateImage(file: File) {
  const allowed = ['image/jpeg', 'image/jpg', 'image/png', 'image/webp']
  if (!allowed.includes(file.type)) throw new Error('Gunakan gambar JPG, PNG, atau WebP.')
  if (file.size > 5 * 1024 * 1024) throw new Error('Ukuran gambar maksimal 5 MB.')
}

function getUploadedUrl(response: any) {
  return cleanString(
    response?.secure_url ||
    response?.secureUrl ||
    response?.url ||
    response?.data?.secure_url ||
    response?.data?.secureUrl ||
    response?.data?.url
  )
}

function dashArrayFromMode(mode: string) {
  if (mode === 'dashed') return [10, 8]
  if (mode === 'dotted') return [2, 8]
  return []
}

function dashModeFromArray(value: number[]) {
  if (!value?.length) return 'solid'
  if (value[0] <= 3) return 'dotted'
  return 'dashed'
}

function randomPalette() {
  const palettes = [
    { bg: '#ffffff', border: '#dbeafe', accent: '#2563eb' },
    { bg: '#f8fafc', border: '#c7d2fe', accent: '#4f46e5' },
    { bg: '#f0fdf4', border: '#bbf7d0', accent: '#16a34a' },
    { bg: '#fff7ed', border: '#fed7aa', accent: '#ea580c' },
    { bg: '#fdf2f8', border: '#fbcfe8', accent: '#db2777' },
    { bg: '#ecfeff', border: '#a5f3fc', accent: '#0891b2' }
  ]
  return palettes[Math.floor(Math.random() * palettes.length)]
}

function uid() {
  if (typeof crypto !== 'undefined' && crypto.randomUUID) return crypto.randomUUID()
  return `local-${Date.now()}-${Math.random().toString(16).slice(2)}`
}

function cleanString(value: unknown, fallback = '') {
  const text = String(value || '').trim()
  return text || fallback
}

function cleanSlug(value: unknown) {
  return cleanString(value)
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9\s-]/g, '')
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-')
    .replace(/^-|-$/g, '')
}

function numberValue(value: unknown, fallback = 0) {
  const number = Number(value)
  return Number.isFinite(number) ? number : fallback
}

function round(value: number) {
  return Math.round(value * 100) / 100
}

function normalizeObject(value: unknown) {
  if (!value || typeof value !== 'object' || Array.isArray(value)) return {}
  return value as Record<string, any>
}

function unique(values: string[]) {
  return Array.from(new Set(values.filter(Boolean)))
}

function toCsv(rows: string[][]) {
  return rows
    .map((row) => row.map((cell) => `"${String(cell).replaceAll('"', '""')}"`).join(','))
    .join('\n')
}

function toTsv(rows: string[][]) {
  return rows.map((row) => row.map((cell) => String(cell).replaceAll('\t', ' ')).join('\t')).join('\n')
}

function downloadBlob(content: string, filename: string, type: string) {
  const blob = new Blob([content], { type })
  const url = URL.createObjectURL(blob)
  const link = document.createElement('a')
  link.href = url
  link.download = filename
  link.click()
  URL.revokeObjectURL(url)
}

function getErrorMessage(error: any, fallback: string) {
  return (
    error?.data?.statusMessage ||
    error?.data?.message ||
    error?.statusMessage ||
    error?.message ||
    fallback
  )
}

function showToast(type: ToastType, title: string, message: string) {
  if (toastTimer) clearTimeout(toastTimer)
  toast.type = type
  toast.title = title
  toast.message = message
  toast.show = true
  toastTimer = setTimeout(() => {
    toast.show = false
  }, 3400)
}

function closeToast() {
  if (toastTimer) clearTimeout(toastTimer)
  toast.show = false
}
</script>

<style scoped>
.canvas-grid {
  background-size: 32px 32px;
  background-image:
    linear-gradient(to right, rgba(148, 163, 184, 0.14) 1px, transparent 1px),
    linear-gradient(to bottom, rgba(148, 163, 184, 0.14) 1px, transparent 1px);
}

.topbar-button {
  display: inline-flex;
  height: 2.5rem;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  border-radius: 1rem;
  border: 1px solid rgb(229 229 229);
  background: rgba(255, 255, 255, 0.92);
  padding: 0 0.9rem;
  font-size: 0.875rem;
  font-weight: 900;
  color: rgb(64 64 64);
  transition: 160ms ease;
}

.topbar-button:hover {
  transform: translateY(-1px);
  border-color: rgb(191 219 254);
  background: rgb(239 246 255);
  color: rgb(29 78 216);
}

.menu-button {
  display: flex;
  width: 100%;
  align-items: center;
  gap: 0.65rem;
  border-radius: 0.85rem;
  padding: 0.65rem 0.75rem;
  text-align: left;
  font-size: 0.8125rem;
  font-weight: 900;
  color: rgb(64 64 64);
  transition: 140ms ease;
}

.menu-button:hover {
  background: rgb(239 246 255);
  color: rgb(29 78 216);
}

.input-field {
  display: block;
  width: 100%;
  border-radius: 1rem;
  border: 1px solid rgb(229 229 229);
  background: rgb(250 250 250);
  padding: 0.75rem 1rem;
  font-size: 0.875rem;
  font-weight: 700;
  color: rgb(38 38 38);
  outline: none;
  transition: 160ms ease;
}

.input-field:focus {
  border-color: rgb(37 99 235);
  background: white;
  box-shadow: 0 0 0 4px rgb(219 234 254);
}

.field-label span {
  display: block;
  font-size: 0.8125rem;
  font-weight: 900;
  color: rgb(64 64 64);
}

.range-field {
  margin-top: 0.8rem;
  width: 100%;
  accent-color: #2563eb;
}

.primary-button,
.secondary-button,
.danger-button {
  display: inline-flex;
  min-height: 2.75rem;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  border-radius: 1rem;
  padding: 0 1.15rem;
  font-size: 0.875rem;
  font-weight: 900;
  transition: 160ms ease;
}

.primary-button {
  background: #2563eb;
  color: white;
  box-shadow: 0 14px 28px rgba(37, 99, 235, 0.22);
}

.primary-button:hover {
  background: #1d4ed8;
}

.secondary-button {
  border: 1px solid rgb(229 229 229);
  background: white;
  color: rgb(64 64 64);
}

.secondary-button:hover {
  background: rgb(250 250 250);
}

.danger-button {
  background: #dc2626;
  color: white;
  box-shadow: 0 14px 28px rgba(220, 38, 38, 0.18);
}

.danger-button:hover {
  background: #b91c1c;
}

.modal-close {
  display: grid;
  height: 2.5rem;
  width: 2.5rem;
  place-items: center;
  border-radius: 1rem;
  border: 1px solid rgb(229 229 229);
  color: rgb(82 82 82);
  transition: 160ms ease;
}

.modal-close:hover {
  background: rgb(250 250 250);
  color: rgb(23 23 23);
}

.modal-fade-enter-active,
.modal-fade-leave-active,
.toast-enter-active,
.toast-leave-active {
  transition: 180ms ease;
}

.modal-fade-enter-from,
.modal-fade-leave-to {
  opacity: 0;
  transform: scale(0.98);
}

.toast-enter-from,
.toast-leave-to {
  opacity: 0;
  transform: translateY(12px);
}

.line-clamp-1 {
  display: -webkit-box;
  -webkit-line-clamp: 1;
  line-clamp: 1;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>
