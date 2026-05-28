<template>
    <Teleport to="body">
        <div class="fixed right-4 top-4 z-10000 flex w-[calc(100%-2rem)] max-w-sm flex-col gap-3 sm:right-6 sm:top-6 sm:w-full">
        <TransitionGroup
            tag="div"
            enter-active-class="transition duration-300 ease-out"
            enter-from-class="translate-y-2 opacity-0 scale-95"
            enter-to-class="translate-y-0 opacity-100 scale-100"
            leave-active-class="transition duration-200 ease-in"
            leave-from-class="translate-y-0 opacity-100 scale-100"
            leave-to-class="translate-y-2 opacity-0 scale-95"
            move-class="transition duration-300 ease-out"
        >
            <div
            v-for="toast in toasts"
            :key="toast.id"
            class="group pointer-events-auto relative overflow-hidden rounded-2xl border border-white/70 bg-white/95 p-4 shadow-2xl shadow-neutral-900/10 backdrop-blur-xl dark:border-neutral-800 dark:bg-neutral-900/95 dark:shadow-black/30"
            >
            <div
                class="absolute inset-y-0 left-0 w-1"
                :class="toneBarClass(toast.type)"
            ></div>

            <div class="flex gap-3">
                <div
                class="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl"
                :class="toneIconClass(toast.type)"
                >
                <svg
                    v-if="toast.type === 'success'"
                    class="h-5 w-5"
                    viewBox="0 0 24 24"
                    fill="none"
                    aria-hidden="true"
                >
                    <path d="M20 6 9 17l-5-5" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" />
                </svg>

                <svg
                    v-else-if="toast.type === 'error'"
                    class="h-5 w-5"
                    viewBox="0 0 24 24"
                    fill="none"
                    aria-hidden="true"
                >
                    <path d="M12 9v4m0 4h.01M10.3 4.3 2.5 18a2 2 0 0 0 1.7 3h15.6a2 2 0 0 0 1.7-3L13.7 4.3a2 2 0 0 0-3.4 0Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                </svg>

                <svg
                    v-else-if="toast.type === 'warning'"
                    class="h-5 w-5"
                    viewBox="0 0 24 24"
                    fill="none"
                    aria-hidden="true"
                >
                    <path d="M12 8v5m0 4h.01M10.3 4.3 2.5 18a2 2 0 0 0 1.7 3h15.6a2 2 0 0 0 1.7-3L13.7 4.3a2 2 0 0 0-3.4 0Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                </svg>

                <svg
                    v-else
                    class="h-5 w-5"
                    viewBox="0 0 24 24"
                    fill="none"
                    aria-hidden="true"
                >
                    <path d="M12 16v-4m0-4h.01M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                </svg>
                </div>

                <div class="min-w-0 flex-1">
                <p class="text-sm font-semibold text-neutral-900 dark:text-white">
                    {{ toast.title }}
                </p>

                <p
                    v-if="toast.message"
                    class="mt-1 text-sm leading-5 text-neutral-500 dark:text-neutral-400"
                >
                    {{ toast.message }}
                </p>
                </div>

                <button
                type="button"
                class="inline-flex h-8 w-8 shrink-0 items-center justify-center rounded-xl text-neutral-400 transition hover:bg-neutral-100 hover:text-neutral-700 focus:outline-none focus:ring-2 focus:ring-emerald-500/30 dark:hover:bg-neutral-800 dark:hover:text-neutral-200"
                aria-label="Tutup notifikasi"
                @click="removeToast(toast.id)"
                >
                <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" aria-hidden="true">
                    <path d="m18 6-12 12M6 6l12 12" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                </svg>
                </button>
            </div>

            <div class="mt-4 h-1 overflow-hidden rounded-full bg-neutral-100 dark:bg-neutral-800">
                <div
                class="h-full rounded-full"
                :class="toneBarClass(toast.type)"
                :style="{ animationDuration: `${toast.duration}ms` }"
                style="animation-name: toast-progress; animation-timing-function: linear; animation-fill-mode: forwards;"
                ></div>
            </div>
            </div>
        </TransitionGroup>
        </div>
    </Teleport>
</template>

<script setup lang="ts">
import { useState } from '#imports'

type ToastType = 'success' | 'error' | 'warning' | 'info'

type ToastItem = {
    id: number
    type: ToastType
    title: string
    message?: string
    duration: number
}

const toasts = useState<ToastItem[]>('global-toasts', () => [])

function removeToast(id: number) {
    toasts.value = toasts.value.filter((toast) => toast.id !== id)
}

function toneBarClass(type: ToastType) {
    const classes: Record<ToastType, string> = {
        success: 'bg-emerald-500',
        error: 'bg-red-500',
        warning: 'bg-amber-500',
        info: 'bg-blue-500'
    }

    return classes[type]
}

function toneIconClass(type: ToastType) {
    const classes: Record<ToastType, string> = {
        success: 'bg-emerald-50 text-emerald-600 ring-1 ring-emerald-100 dark:bg-emerald-500/10 dark:text-emerald-400 dark:ring-emerald-500/20',
        error: 'bg-red-50 text-red-600 ring-1 ring-red-100 dark:bg-red-500/10 dark:text-red-400 dark:ring-red-500/20',
        warning: 'bg-amber-50 text-amber-600 ring-1 ring-amber-100 dark:bg-amber-500/10 dark:text-amber-400 dark:ring-amber-500/20',
        info: 'bg-blue-50 text-blue-600 ring-1 ring-blue-100 dark:bg-blue-500/10 dark:text-blue-400 dark:ring-blue-500/20'
    }

    return classes[type]
}
</script>

<style scoped>
@keyframes toast-progress {
    from {
        width: 100%;
    }

    to {
        width: 0%;
    }
}
</style>