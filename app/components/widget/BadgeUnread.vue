<template>
    <span v-if="unread > 0"
        class="absolute -top-1 -right-1 min-w-4 h-4 px-1 inline-flex items-center justify-center rounded-full text-[10px] bg-red-600 text-white">
        {{ unread > 99 ? '99+' : unread }}
    </span>
</template>

<script setup lang="ts">
import { useNotifications } from '~/composables/useNotifications'
const { unread } = useNotifications()
</script>
