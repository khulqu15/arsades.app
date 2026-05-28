<template>
    <div class="p-4 rounded-xl border border-gray-200 bg-white shadow-xs dark:bg-neutral-800 dark:border-neutral-700">
        <div class="flex items-center justify-between mb-3">
            <h3 class="font-semibold text-gray-800 dark:text-neutral-100">{{ title }}</h3>
            <slot name="actions" />
        </div>
        <Line :data="data" :options="options" />
    </div>
</template>

<script setup lang="ts">
import { Line } from 'vue-chartjs'
import { Chart, LineElement, PointElement, LinearScale, CategoryScale, Tooltip, Legend, Filler } from 'chart.js'
Chart.register(LineElement, PointElement, LinearScale, CategoryScale, Tooltip, Legend, Filler)

defineProps<{
    title: string
    data: any
    options?: any
}>()
</script>
