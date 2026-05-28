<template>
  <Teleport to="body">
    <transition name="fade">
      <div v-if="modelValue" class="fixed inset-0 z-[100] dark:text-neutral-200">
        <div class="absolute inset-0 bg-black/40" @click="close"></div>

        <div class="absolute inset-0 p-4 flex items-center justify-center">
          <div :class="panelClass" :style="panelStyle" role="dialog" aria-modal="true">
            <div class="px-4 py-3 border-b border-gray-200 dark:border-neutral-700 flex items-center justify-between bg-white dark:bg-neutral-900" :class="isFullscreen ? 'sticky top-0 z-10' : ''">
              <h3 class="font-semibold text-gray-800 dark:text-neutral-100">{{ title }}</h3>
              <button class="p-1 rounded hover:bg-gray-100 dark:hover:bg-neutral-800" @click="close" aria-label="Tutup dialog">
                ✕
              </button>
            </div>

            <div class="px-4 py-3" :class="isFullscreen ? 'flex-1 overflow-y-auto' : 'overflow-y-auto'" :style="bodyStyle">
              <slot />
            </div>

            <div v-if="$slots.footer" class="px-4 py-3 border-t border-gray-200 dark:border-neutral-700 flex justify-end gap-2 bg-white dark:bg-neutral-900" :class="isFullscreen ? 'sticky bottom-0 z-10' : ''">
              <slot name="footer" />
            </div>
          </div>
        </div>
      </div>
    </transition>
  </Teleport>
</template>

<script setup lang="ts">
import { computed, onMounted, onBeforeUnmount } from 'vue'

const props = withDefaults(defineProps<{
  modelValue: boolean
  title?: string
  size?: 'sm'|'md'|'lg'|'xl'|'2xl'|'3xl'|'4xl'|'5xl'|'7xl'|'fullscreen' | string | number
  height?: number | string
}>(), {
  size: 'lg'
})

const emit = defineEmits<{
  (e: 'update:modelValue', v: boolean): void
}>()

const isFullscreen = computed(() => props.size === 'fullscreen')

const presetMaxW: Record<string, string> = {
  sm: 'max-w-sm', md: 'max-w-md', lg: 'max-w-lg', xl: 'max-w-xl',
  '2xl': 'max-w-2xl', '3xl': 'max-w-3xl', '4xl': 'max-w-4xl',
  '5xl': 'max-w-5xl', '7xl': 'max-w-7xl'
}

const widthClassOrStyle = computed(() => {
  if (typeof props.size === 'number') {
    return { style: { maxWidth: `${props.size}px` } }
  }
  if (typeof props.size === 'string') {
    if (props.size === 'fullscreen') return { class: '' }
    if (/^(w|max-w|min-w|size)-/.test(props.size) || props.size.includes('[')) return { class: props.size }
    if (/\d(px|rem|em|vw|vh|%)$/.test(props.size)) return { style: { maxWidth: props.size } }
    if (props.size in presetMaxW) return { class: presetMaxW[props.size] }
  }
  return { class: presetMaxW.lg }
})

const panelClass = computed(() => [
  'bg-white dark:bg-neutral-900',
  'border border-gray-200 dark:border-neutral-700',
  isFullscreen.value
    ? 'w-screen h-screen rounded-none shadow-none flex flex-col'
    : 'w-full rounded-xl shadow-xl',
  widthClassOrStyle.value.class ?? ''
].filter(Boolean).join(' '))

const panelStyle = computed(() => {
  const base: Record<string, string> = {}
  if (!isFullscreen.value) base.maxHeight = 'calc(100vh - 2rem)'
  return { ...(widthClassOrStyle.value.style ?? {}), ...base }
})

const bodyStyle = computed(() => {
  if (isFullscreen.value) return {}
  if (props.height === undefined || props.height === null) return {}
  const h = typeof props.height === 'number' ? `${props.height}px` : String(props.height)
  return { maxHeight: h }
})

function close() { emit('update:modelValue', false) }

function onKey(e: KeyboardEvent) {
  if (e.key === 'Escape') close()
}
onMounted(() => window.addEventListener('keydown', onKey))
onBeforeUnmount(() => window.removeEventListener('keydown', onKey))
</script>

<style scoped>
.fade-enter-active, .fade-leave-active { transition: opacity 0.15s ease; }
.fade-enter-from, .fade-leave-to { opacity: 0; }
</style>
