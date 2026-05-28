<template>
  <div class="p-4 rounded-xl border border-gray-200 bg-white shadow-xs dark:bg-neutral-800 dark:border-neutral-700">
    <div class="flex flex-wrap items-center justify-between gap-3 mb-3">
      <h3 class="font-semibold text-gray-800 dark:text-neutral-100">{{ title }}</h3>
      <div class="flex items-center flex-wrap gap-2">
        <label class="text-xs text-gray-500 dark:text-neutral-400">Tampilkan</label>
        <select v-model="pageSize" class="px-2 py-1 text-xs rounded border border-gray-200 dark:bg-neutral-900 dark:border-neutral-700">
          <option :value="5">5</option>
          <option :value="10">10</option>
          <option :value="20">20</option>
          <option :value="50">50</option>
        </select>
        <div class="relative">
          <input v-model="q" type="search" placeholder="Cari..." class="pl-8 pr-8 py-1.5 w-56 text-xs rounded-md border border-gray-200 bg-white shadow-xs focus:outline-none focus:ring-2 focus:ring-blue-500/30 dark:bg-neutral-900 dark:border-neutral-700 dark:text-neutral-200"/>
          <Icon icon="lucide:search" class="absolute left-2.5 top-1/2 -translate-y-1/2 size-4 text-gray-400" />
          <button v-if="q" @click="q=''" class="absolute right-2 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600">
            <Icon icon="lucide:x" class="size-4" />
          </button>
        </div>
      </div>
    </div>

    <div class="overflow-x-auto">
      <table class="min-w-full text-sm">
        <thead>
          <tr class="text-left text-gray-500 dark:text-neutral-400">
            <th class="px-3 py-2 w-10">
              <input type="checkbox" @change="toggleAll" />
            </th>
            <th v-for="c in columns" :key="c.key" class="px-3 py-2 cursor-pointer select-none" @click="sort(c)">
              <div class="inline-flex items-center gap-1">
                {{ c.label }}
                <Icon v-if="sortKey === c.key" :icon="asc ? 'lucide:chevron-up' : 'lucide:chevron-down'" width="14" height="14" />
              </div>
            </th>
            <th class="px-3 py-2">Action</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="row in paged" :key="rowKey(row)" class="border-t border-gray-100 dark:border-neutral-700 hover:bg-gray-50/60 dark:hover:bg-neutral-800/60">
            <td class="px-3 py-2">
              <input type="checkbox" v-model="selectedIds" :value="rowKey(row)" />
            </td>
            <td v-for="c in columns" :key="c.key" class="px-3 py-2">
              <slot :name="`cell-${c.key}`" :row="row">{{ row[c.key] }}</slot>
            </td>
            <td class="px-3 py-2">
              <slot name="cell-action" :row="row">
                <button class="text-xs px-2 py-1 rounded border hover:bg-gray-50 dark:hover:bg-neutral-800">Detail</button>
              </slot>
            </td>
          </tr>
          <tr v-if="!paged.length">
            <td :colspan="columns.length + 2" class="px-3 py-6 text-center text-gray-500 dark:text-neutral-400">Tidak ada data</td>
          </tr>
        </tbody>
      </table>
    </div>

    <div class="flex items-center justify-between mt-4 text-xs text-gray-600 dark:text-neutral-400">
      <span>Menampilkan {{ start+1 }}–{{ Math.min(end, filtered.length) }} dari {{ filtered.length }}</span>
      <div class="flex items-center gap-1">
        <button class="px-2 py-1 rounded border border-gray-200 dark:border-neutral-600 hover:bg-gray-50 dark:hover:bg-neutral-800" :disabled="page===1" @click="page--">Prev</button>
        <span class="px-2">Hal {{ page }}/{{ totalPages || 1 }}</span>
        <button class="px-2 py-1 rounded border border-gray-200 dark:border-neutral-600 hover:bg-gray-50 dark:hover:bg-neutral-800" :disabled="page===totalPages || !totalPages" @click="page++">Next</button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { Icon } from '@iconify/vue'
import { computed, ref, watch } from 'vue'

type Column = { key: string; label: string; sortable?: boolean }
const props = defineProps<{
  title: string
  rows: any[]
  columns: Column[]
  rowKey?: (row: any) => string|number
}>()

const q = ref('')
const page = ref(1)
const pageSize = ref(10)
const sortKey = ref<string | null>(null)
const asc = ref(true)
const selectedIds = ref<Array<string|number>>([])
const allChecked = computed(() => paged.value.length && paged.value.every(r => selectedIds.value.includes(rowKey(r))))

const rowKey = (row: any) => props.rowKey?.(row) ?? row.id ?? JSON.stringify(row)

watch([() => props.rows, q, pageSize], () => { page.value = 1 })

const filtered = computed(() => {
  const s = q.value.trim().toLowerCase()
  if (!s) return props.rows
  return props.rows.filter(r => JSON.stringify(r).toLowerCase().includes(s))
})

const sorted = computed(() => {
  if (!sortKey.value) return filtered.value
  const arr = [...filtered.value]
  arr.sort((a, b) => {
    const A = a[sortKey.value as string]
    const B = b[sortKey.value as string]
    if (A === B) return 0
    return (A > B ? 1 : -1) * (asc.value ? 1 : -1)
  })
  return arr
})

const totalPages = computed(() => Math.ceil(sorted.value.length / pageSize.value))
const start = computed(() => (page.value - 1) * pageSize.value)
const end = computed(() => start.value + pageSize.value)
const paged = computed(() => sorted.value.slice(start.value, end.value))

function sort(c: Column) {
  if (!c.sortable) return
  if (sortKey.value === c.key) asc.value = !asc.value
  else { sortKey.value = c.key; asc.value = true }
  page.value = 1
}

function toggleAll(e: Event) {
  const checked = (e.target as HTMLInputElement).checked
  if (checked) selectedIds.value = [...new Set([...selectedIds.value, ...paged.value.map(rowKey)])]
  else selectedIds.value = selectedIds.value.filter(id => !paged.value.map(rowKey).includes(id))
}
</script>
