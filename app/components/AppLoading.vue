<template>
    <Transition
        enter-active-class="transition duration-300 ease-out"
        enter-from-class="opacity-0 scale-[0.98]"
        enter-to-class="opacity-100 scale-100"
        leave-active-class="transition duration-200 ease-in"
        leave-from-class="opacity-100 scale-100"
        leave-to-class="opacity-0 scale-[0.98]"
    >
        <div
        v-if="visible"
        class="fixed inset-0 z-[9999] flex items-center justify-center bg-white/75 px-4 backdrop-blur-xl dark:bg-neutral-950/75"
        >
            <div class="pointer-events-none absolute inset-0 overflow-hidden">
                <div class="absolute left-1/2 top-1/2 h-72 w-72 -translate-x-1/2 -translate-y-1/2 rounded-full bg-emerald-500/15 blur-3xl"></div>
                <div class="absolute right-10 top-10 h-40 w-40 rounded-full bg-blue-500/10 blur-3xl"></div>
                <div class="absolute bottom-10 left-10 h-40 w-40 rounded-full bg-lime-500/10 blur-3xl"></div>
            </div>

            <div class="relative w-full max-w-sm overflow-hidden rounded-[2rem] border border-white/70 bg-white/90 p-6 text-center shadow-2xl shadow-emerald-950/10 backdrop-blur-2xl dark:border-neutral-800 dark:bg-neutral-900/90 dark:shadow-black/30">
                <div class="mx-auto mb-5 flex h-16 w-16 items-center justify-center rounded-3xl bg-emerald-50 text-emerald-600 ring-1 ring-emerald-100 dark:bg-emerald-500/10 dark:text-emerald-400 dark:ring-emerald-500/20">
                    <svg
                        class="h-8 w-8 animate-spin"
                        xmlns="http://www.w3.org/2000/svg"
                        fill="none"
                        viewBox="0 0 24 24"
                        aria-hidden="true"
                    >
                        <circle
                        class="opacity-20"
                        cx="12"
                        cy="12"
                        r="10"
                        stroke="currentColor"
                        stroke-width="4"
                        />
                        <path
                        class="opacity-90"
                        fill="currentColor"
                        d="M4 12a8 8 0 0 1 8-8v4a4 4 0 0 0-4 4H4Z"
                        />
                    </svg>
                </div>

                <h2 class="text-lg font-semibold text-neutral-900 dark:text-white">
                    {{ title }}
                </h2>

                <p class="mt-2 text-sm leading-6 text-neutral-500 dark:text-neutral-400">
                    {{ description }}
                </p>

                <div class="mt-6 h-2 overflow-hidden rounded-full bg-neutral-100 dark:bg-neutral-800">
                    <div class="h-full w-1/2 animate-[global-loading_1.2s_ease-in-out_infinite] rounded-full bg-emerald-500"></div>
                </div>
            </div>
        </div>
    </Transition>
</template>

<script setup lang="ts">
import { computed, onMounted } from 'vue'
import { useNuxtApp, useState } from '#imports'

const loadingState = useState<boolean>('global-loading', () => false)

const visible = computed(() => loadingState.value)

const title = 'Memuat Halaman'
const description = 'Mohon tunggu sebentar, sistem sedang menyiapkan tampilan terbaik untuk Anda.'

onMounted(() => {
    const nuxtApp = useNuxtApp()

    nuxtApp.hook('page:start', () => {
        loadingState.value = true
    })

    nuxtApp.hook('page:finish', () => {
        loadingState.value = false
    })
})
</script>

<style scoped>
@keyframes global-loading {
    0% {
        transform: translateX(-120%);
    }

    50% {
        transform: translateX(80%);
    }

    100% {
        transform: translateX(220%);
    }
}
</style>