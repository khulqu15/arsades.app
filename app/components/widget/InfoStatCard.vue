<template>
  <div class="p-4 rounded-xl border border-gray-200 bg-white shadow-xs dark:bg-neutral-800 dark:border-neutral-700">
    <div class="flex items-center justify-between gap-3">
      <div class="space-y-1">
        <p class="text-xs text-gray-500 dark:text-neutral-400">{{ label }}</p>
        <div class="flex items-end gap-2">
          <h3 class="text-2xl font-semibold text-gray-800 dark:text-neutral-100">{{ value }}</h3>
          <span :class="badgeClass" class="text-xs px-2 py-0.5 rounded-md">{{ trendPrefix }}{{ percent }}%</span>
        </div>
      </div>
      <div class="w-10 h-10 rounded-lg bg-gray-100 flex items-center justify-center dark:bg-neutral-700">
        <Icon v-if="icon" :icon="icon" width="18" height="18" class="text-gray-700 dark:text-neutral-200" />
      </div>
    </div>
    <p v-if="sub" class="mt-2 text-[11px] text-gray-500 dark:text-neutral-400">{{ sub }}</p>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { Icon } from '@iconify/vue'

const props = defineProps<{
    label: string
    value: string | number
    percent?: number
    icon?: string
    sub?: string
}>()

const isUp = computed(() => (props.percent ?? 0) >= 0)
const trendPrefix = computed(() => (isUp.value ? '▲ ' : '▼ '))
const badgeClass = computed(() =>
    isUp.value
        ? 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-300'
        : 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-300'
)
</script>
