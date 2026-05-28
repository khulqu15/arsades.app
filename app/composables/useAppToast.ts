import { useState } from '#imports'

export type ToastType = 'success' | 'error' | 'warning' | 'info'

export type ToastItem = {
  id: number
  type: ToastType
  title: string
  message?: string
  duration: number
}

export function useAppToast() {
  const toasts = useState<ToastItem[]>('global-toasts', () => [])

  function showToast(payload: {
    type?: ToastType
    title: string
    message?: string
    duration?: number
  }) {
    const toast: ToastItem = {
      id: Date.now() + Math.floor(Math.random() * 1000),
      type: payload.type || 'info',
      title: payload.title,
      message: payload.message,
      duration: payload.duration || 4500
    }

    toasts.value = [toast, ...toasts.value].slice(0, 5)

    window.setTimeout(() => {
      toasts.value = toasts.value.filter((item) => item.id !== toast.id)
    }, toast.duration)
  }

  return {
    toasts,
    success: (title: string, message?: string) =>
      showToast({ type: 'success', title, message }),
    error: (title: string, message?: string) =>
      showToast({ type: 'error', title, message }),
    warning: (title: string, message?: string) =>
      showToast({ type: 'warning', title, message }),
    info: (title: string, message?: string) =>
      showToast({ type: 'info', title, message }),
    showToast
  }
}