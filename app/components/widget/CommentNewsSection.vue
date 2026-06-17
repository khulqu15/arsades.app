<template>
  <section class="rounded-[2rem] border border-neutral-200 bg-white p-4 shadow-sm shadow-neutral-950/5 sm:p-5">
    <!-- Form -->
    <div class="overflow-hidden rounded-[1.75rem] border border-neutral-200 bg-neutral-50">
      <div class="grid gap-3 border-b border-neutral-200 bg-white p-3 sm:grid-cols-2 sm:p-4">
        <label class="block">
          <span class="mb-1.5 block text-xs font-black uppercase tracking-[0.12em] text-neutral-400">
            Nama
          </span>
          <input
            v-model.trim="form.name"
            type="text"
            class="block h-11 w-full rounded-2xl border border-neutral-200 bg-neutral-50 px-4 text-sm font-bold text-neutral-800 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:bg-white focus:ring-4 focus:ring-blue-100"
            placeholder="Nama kamu"
          >
        </label>

        <label class="block">
          <span class="mb-1.5 block text-xs font-black uppercase tracking-[0.12em] text-neutral-400">
            Email
          </span>
          <input
            v-model.trim="form.email"
            type="email"
            class="block h-11 w-full rounded-2xl border border-neutral-200 bg-neutral-50 px-4 text-sm font-bold text-neutral-800 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:bg-white focus:ring-4 focus:ring-blue-100"
            placeholder="email@domain.com"
          >
        </label>
      </div>

      <div class="p-3 sm:p-4">
        <textarea
          v-model.trim="form.comment"
          rows="4"
          class="block w-full resize-none rounded-2xl border border-transparent bg-transparent px-1 py-1 text-sm font-semibold leading-7 text-neutral-800 outline-none transition placeholder:text-neutral-400 focus:border-blue-100 focus:bg-white focus:px-4 focus:py-3 focus:ring-4 focus:ring-blue-100"
          placeholder="Add comment..."
          :maxlength="maxLength"
        ></textarea>

        <div
          v-if="formError"
          class="mt-3 flex items-start gap-2 rounded-2xl border border-red-200 bg-red-50 px-4 py-3 text-sm font-bold leading-6 text-red-700"
        >
          <Icon icon="solar:danger-circle-bold-duotone" class="mt-0.5 h-5 w-5 shrink-0" />
          <span>{{ formError }}</span>
        </div>

        <div
          v-if="submitSuccess"
          class="mt-3 flex items-start gap-2 rounded-2xl border border-blue-200 bg-blue-50 px-4 py-3 text-sm font-bold leading-6 text-blue-700"
        >
          <Icon icon="solar:check-circle-bold-duotone" class="mt-0.5 h-5 w-5 shrink-0" />
          <span>Komentar berhasil ditambahkan.</span>
        </div>

        <div class="mt-4 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
          <div class="flex flex-wrap items-center gap-1.5 text-neutral-500">
            <button
              type="button"
              class="comment-tool-button"
              title="Bold"
            >
              <Icon icon="solar:text-bold-bold" class="h-4 w-4" />
            </button>

            <button
              type="button"
              class="comment-tool-button"
              title="Italic"
            >
              <Icon icon="solar:text-italic-bold" class="h-4 w-4" />
            </button>

            <button
              type="button"
              class="comment-tool-button"
              title="Attachment"
            >
              <Icon icon="solar:link-bold-duotone" class="h-4 w-4" />
            </button>

            <button
              type="button"
              class="comment-tool-button"
              title="Mention"
            >
              <Icon icon="solar:mention-circle-bold-duotone" class="h-4 w-4" />
            </button>

            <span class="ml-2 text-xs font-bold text-neutral-400">
              {{ form.comment.length }}/{{ maxLength }}
            </span>
          </div>

          <button
            type="button"
            class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-5 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:-translate-y-0.5 hover:bg-blue-700 disabled:cursor-not-allowed disabled:opacity-50"
            :disabled="submitting"
            @click="submitComment"
          >
            <Icon
              :icon="submitting ? 'svg-spinners:180-ring' : 'solar:plain-bold-duotone'"
              class="h-5 w-5"
            />
            {{ submitting ? 'Mengirim...' : 'Submit' }}
          </button>
        </div>
      </div>
    </div>

    <!-- Header -->
    <div class="mt-8 flex flex-col gap-3 border-t border-neutral-200 pt-6 sm:flex-row sm:items-center sm:justify-between">
      <div class="flex items-center gap-3">
        <h3 class="text-xl font-black tracking-tight text-neutral-950">
          Comments
        </h3>

        <span class="grid h-7 min-w-7 place-items-center rounded-full bg-blue-600 px-2 text-xs font-black text-white shadow-lg shadow-blue-600/20">
          {{ commentCount }}
        </span>
      </div>

      <div class="flex items-center gap-2">
        <Icon icon="solar:sort-from-bottom-to-top-bold-duotone" class="h-5 w-5 text-neutral-500" />
        <select
          v-model="sortBy"
          class="h-10 rounded-2xl border border-neutral-200 bg-white px-3 text-sm font-black text-neutral-700 outline-none transition focus:border-blue-500 focus:ring-4 focus:ring-blue-100"
        >
          <option value="newest">Most recent</option>
          <option value="oldest">Oldest</option>
          <option value="popular">Popular</option>
        </select>
      </div>
    </div>

    <!-- Empty -->
    <div
      v-if="!rootComments.length"
      class="mt-5 rounded-[1.75rem] border border-dashed border-neutral-300 bg-neutral-50 p-8 text-center"
    >
      <div class="mx-auto grid h-14 w-14 place-items-center rounded-2xl bg-blue-50 text-blue-600">
        <Icon icon="solar:chat-round-dots-bold-duotone" class="h-7 w-7" />
      </div>
      <h4 class="mt-4 text-base font-black text-neutral-950">
        Belum ada komentar
      </h4>
      <p class="mx-auto mt-2 max-w-md text-sm font-semibold leading-6 text-neutral-500">
        Jadilah yang pertama memberi tanggapan untuk berita ini.
      </p>
    </div>

    <!-- List -->
    <div v-else class="mt-5 space-y-6">
      <article
        v-for="comment in rootComments"
        :key="comment.id"
        class="relative"
      >
        <div class="flex gap-3">
          <div
            class="grid h-11 w-11 shrink-0 place-items-center rounded-full border border-neutral-200 bg-gradient-to-br from-blue-50 to-sky-50 text-sm font-black text-blue-700 shadow-sm"
          >
            {{ getInitials(comment.name) }}
          </div>

          <div class="min-w-0 flex-1">
            <div class="flex flex-wrap items-center gap-2">
              <h4 class="text-sm font-black text-neutral-950">
                {{ comment.name }}
              </h4>
              <span class="text-xs font-semibold text-neutral-400">
                {{ formatRelativeTime(comment.createdAt) }}
              </span>
            </div>

            <p class="mt-2 whitespace-pre-line text-sm font-medium leading-7 text-neutral-700">
              {{ comment.comment }}
            </p>

            <div class="mt-3 flex flex-wrap items-center gap-3 text-xs font-black">
              <button
                type="button"
                class="inline-flex items-center gap-1.5 text-blue-600 transition hover:text-blue-700"
                @click="reactComment(comment.id, 'like')"
              >
                <Icon icon="solar:like-bold-duotone" class="h-4 w-4" />
                {{ comment.likes }}
              </button>

              <button
                type="button"
                class="inline-flex items-center gap-1.5 text-neutral-500 transition hover:text-neutral-800"
                @click="reactComment(comment.id, 'dislike')"
              >
                <Icon icon="solar:dislike-bold-duotone" class="h-4 w-4" />
                {{ comment.dislikes }}
              </button>

              <button
                type="button"
                class="inline-flex items-center gap-1.5 text-neutral-500 transition hover:text-blue-600"
                @click="startReply(comment)"
              >
                <Icon icon="solar:chat-round-line-bold-duotone" class="h-4 w-4" />
                Reply
              </button>
            </div>

            <!-- Reply form -->
            <div
              v-if="activeReplyId === comment.id"
              class="mt-4 rounded-[1.5rem] border border-blue-100 bg-blue-50/60 p-3"
            >
              <div class="grid gap-2 sm:grid-cols-2">
                <input
                  v-model.trim="replyForm.name"
                  type="text"
                  class="h-10 rounded-2xl border border-blue-100 bg-white px-3 text-sm font-bold text-neutral-800 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-100"
                  placeholder="Nama"
                >

                <input
                  v-model.trim="replyForm.email"
                  type="email"
                  class="h-10 rounded-2xl border border-blue-100 bg-white px-3 text-sm font-bold text-neutral-800 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-100"
                  placeholder="Email"
                >
              </div>

              <textarea
                v-model.trim="replyForm.comment"
                rows="3"
                class="mt-2 block w-full resize-none rounded-2xl border border-blue-100 bg-white px-3 py-2 text-sm font-semibold leading-6 text-neutral-800 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-100"
                placeholder="Tulis balasan..."
                :maxlength="maxLength"
              ></textarea>

              <p
                v-if="replyError"
                class="mt-2 text-xs font-bold text-red-600"
              >
                {{ replyError }}
              </p>

              <div class="mt-3 flex flex-wrap justify-end gap-2">
                <button
                  type="button"
                  class="inline-flex h-10 items-center justify-center rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-black text-neutral-600 transition hover:bg-neutral-50"
                  @click="cancelReply"
                >
                  Batal
                </button>

                <button
                  type="button"
                  class="inline-flex h-10 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700"
                  @click="submitReply(comment.id)"
                >
                  <Icon icon="solar:plain-bold-duotone" class="h-4 w-4" />
                  Kirim Balasan
                </button>
              </div>
            </div>

            <!-- Replies -->
            <div
              v-if="childrenOf(comment.id).length"
              class="mt-5 space-y-5 border-l-2 border-blue-100 pl-4"
            >
              <article
                v-for="reply in childrenOf(comment.id)"
                :key="reply.id"
                class="flex gap-3"
              >
                <div class="grid h-10 w-10 shrink-0 place-items-center rounded-full border border-neutral-200 bg-white text-xs font-black text-blue-700 shadow-sm">
                  {{ getInitials(reply.name) }}
                </div>

                <div class="min-w-0 flex-1">
                  <div class="flex flex-wrap items-center gap-2">
                    <h5 class="text-sm font-black text-neutral-950">
                      {{ reply.name }}
                    </h5>
                    <span class="text-xs font-semibold text-neutral-400">
                      {{ formatRelativeTime(reply.createdAt) }}
                    </span>
                  </div>

                  <p class="mt-2 whitespace-pre-line text-sm font-medium leading-7 text-neutral-700">
                    {{ reply.comment }}
                  </p>

                  <div class="mt-3 flex flex-wrap items-center gap-3 text-xs font-black">
                    <button
                      type="button"
                      class="inline-flex items-center gap-1.5 text-blue-600 transition hover:text-blue-700"
                      @click="reactComment(reply.id, 'like')"
                    >
                      <Icon icon="solar:like-bold-duotone" class="h-4 w-4" />
                      {{ reply.likes }}
                    </button>

                    <button
                      type="button"
                      class="inline-flex items-center gap-1.5 text-neutral-500 transition hover:text-neutral-800"
                      @click="reactComment(reply.id, 'dislike')"
                    >
                      <Icon icon="solar:dislike-bold-duotone" class="h-4 w-4" />
                      {{ reply.dislikes }}
                    </button>
                  </div>
                </div>
              </article>
            </div>
          </div>
        </div>
      </article>
    </div>
  </section>
</template>

<script setup lang="ts">
import { Icon } from '@iconify/vue'
import { computed, onMounted, reactive, ref, watch } from 'vue'

type CommentSort = 'newest' | 'oldest' | 'popular'
type ReactionType = 'like' | 'dislike'

type CommentRecord = {
  id: string
  targetId: string
  parentId: string | null
  name: string
  email: string
  comment: string
  createdAt: string
  likes: number
  dislikes: number
}

type CommentPayload = {
  targetId: string
  parentId: string | null
  name: string
  email: string
  comment: string
  createdAt: string
  record: CommentRecord
}

const props = withDefaults(defineProps<{
  targetId: string
  targetTitle?: string
  initialComments?: CommentRecord[]
  storageKeyPrefix?: string
  persistLocal?: boolean
  maxLength?: number
}>(), {
  targetTitle: '',
  initialComments: () => [],
  storageKeyPrefix: 'comments',
  persistLocal: true,
  maxLength: 1000
})

const emit = defineEmits<{
  (event: 'submit', payload: CommentPayload): void
  (event: 'reply', payload: CommentPayload): void
  (event: 'reaction', payload: { id: string; type: ReactionType; targetId: string }): void
}>()

const sortBy = ref<CommentSort>('newest')
const localComments = ref<CommentRecord[]>([])
const activeReplyId = ref('')
const formError = ref('')
const replyError = ref('')
const submitSuccess = ref(false)
const submitting = ref(false)

const form = reactive({
  name: '',
  email: '',
  comment: ''
})

const replyForm = reactive({
  name: '',
  email: '',
  comment: ''
})

const storageKey = computed(() => {
  return `${props.storageKeyPrefix}:${props.targetId}`
})

const allComments = computed(() => {
  const merged = [...props.initialComments, ...localComments.value]
  const map = new Map<string, CommentRecord>()

  for (const item of merged) {
    if (!item.id) continue
    map.set(item.id, normalizeComment(item))
  }

  return Array.from(map.values())
})

const sortedComments = computed(() => {
  const rows = [...allComments.value]

  if (sortBy.value === 'oldest') {
    return rows.sort((a, b) => getTime(a.createdAt) - getTime(b.createdAt))
  }

  if (sortBy.value === 'popular') {
    return rows.sort((a, b) => {
      const scoreA = a.likes - a.dislikes
      const scoreB = b.likes - b.dislikes

      if (scoreB !== scoreA) return scoreB - scoreA

      return getTime(b.createdAt) - getTime(a.createdAt)
    })
  }

  return rows.sort((a, b) => getTime(b.createdAt) - getTime(a.createdAt))
})

const rootComments = computed(() => {
  return sortedComments.value.filter((item) => !item.parentId)
})

const commentCount = computed(() => {
  return allComments.value.length
})

watch(
  () => props.targetId,
  () => {
    loadLocalComments()
    resetForm()
    cancelReply()
  }
)

onMounted(() => {
  loadLocalComments()
})

function submitComment() {
  formError.value = ''
  submitSuccess.value = false

  const validation = validateInput(form.name, form.email, form.comment)

  if (validation) {
    formError.value = validation
    return
  }

  submitting.value = true

  const record = createCommentRecord({
    parentId: null,
    name: form.name,
    email: form.email,
    comment: form.comment
  })

  addComment(record)

  emit('submit', {
    targetId: props.targetId,
    parentId: null,
    name: form.name,
    email: form.email,
    comment: form.comment,
    createdAt: record.createdAt,
    record
  })

  resetForm()
  submitSuccess.value = true
  submitting.value = false

  window.setTimeout(() => {
    submitSuccess.value = false
  }, 1500)
}

function submitReply(parentId: string) {
  replyError.value = ''

  const validation = validateInput(replyForm.name, replyForm.email, replyForm.comment)

  if (validation) {
    replyError.value = validation
    return
  }

  const record = createCommentRecord({
    parentId,
    name: replyForm.name,
    email: replyForm.email,
    comment: replyForm.comment
  })

  addComment(record)

  emit('reply', {
    targetId: props.targetId,
    parentId,
    name: replyForm.name,
    email: replyForm.email,
    comment: replyForm.comment,
    createdAt: record.createdAt,
    record
  })

  cancelReply()
}

function addComment(record: CommentRecord) {
  localComments.value = [record, ...localComments.value]
  saveLocalComments()
}

function reactComment(id: string, type: ReactionType) {
  localComments.value = localComments.value.map((item) => {
    if (item.id !== id) return item

    return {
      ...item,
      likes: type === 'like' ? item.likes + 1 : item.likes,
      dislikes: type === 'dislike' ? item.dislikes + 1 : item.dislikes
    }
  })

  saveLocalComments()

  emit('reaction', {
    id,
    type,
    targetId: props.targetId
  })
}

function startReply(comment: CommentRecord) {
  activeReplyId.value = comment.id
  replyError.value = ''

  if (!replyForm.name && form.name) replyForm.name = form.name
  if (!replyForm.email && form.email) replyForm.email = form.email
}

function cancelReply() {
  activeReplyId.value = ''
  replyError.value = ''
  replyForm.name = ''
  replyForm.email = ''
  replyForm.comment = ''
}

function childrenOf(parentId: string) {
  return sortedComments.value.filter((item) => item.parentId === parentId)
}

function createCommentRecord(payload: {
  parentId: string | null
  name: string
  email: string
  comment: string
}): CommentRecord {
  return {
    id: createId(),
    targetId: props.targetId,
    parentId: payload.parentId,
    name: payload.name.trim(),
    email: payload.email.trim(),
    comment: payload.comment.trim(),
    createdAt: new Date().toISOString(),
    likes: 0,
    dislikes: 0
  }
}

function normalizeComment(comment: CommentRecord): CommentRecord {
  return {
    id: String(comment.id || createId()),
    targetId: String(comment.targetId || props.targetId),
    parentId: comment.parentId || null,
    name: String(comment.name || 'Anonim'),
    email: String(comment.email || ''),
    comment: String(comment.comment || ''),
    createdAt: String(comment.createdAt || new Date().toISOString()),
    likes: Number(comment.likes || 0),
    dislikes: Number(comment.dislikes || 0)
  }
}

function validateInput(name: string, email: string, comment: string) {
  if (!name.trim()) return 'Nama wajib diisi.'
  if (!email.trim()) return 'Email wajib diisi.'
  if (!isValidEmail(email)) return 'Format email belum valid.'
  if (!comment.trim()) return 'Komentar wajib diisi.'
  if (comment.trim().length < 4) return 'Komentar terlalu singkat.'
  if (comment.trim().length > props.maxLength) return `Komentar maksimal ${props.maxLength} karakter.`

  return ''
}

function isValidEmail(value: string) {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value.trim())
}

function resetForm() {
  form.name = ''
  form.email = ''
  form.comment = ''
  formError.value = ''
}

function loadLocalComments() {
  if (!props.persistLocal) {
    localComments.value = []
    return
  }

  if (typeof window === 'undefined') return

  try {
    const raw = localStorage.getItem(storageKey.value)
    const parsed = raw ? JSON.parse(raw) : []

    localComments.value = Array.isArray(parsed)
      ? parsed.map(normalizeComment).filter((item) => item.targetId === props.targetId)
      : []
  } catch {
    localComments.value = []
  }
}

function saveLocalComments() {
  if (!props.persistLocal) return
  if (typeof window === 'undefined') return

  localStorage.setItem(storageKey.value, JSON.stringify(localComments.value))
}

function getInitials(value: string) {
  const words = String(value || 'A')
    .trim()
    .split(/\s+/)
    .filter(Boolean)
    .slice(0, 2)

  return words
    .map((word) => word.charAt(0).toUpperCase())
    .join('') || 'A'
}

function formatRelativeTime(value: string) {
  const date = new Date(value)
  const time = date.getTime()

  if (Number.isNaN(time)) return 'baru saja'

  const diff = Date.now() - time
  const minute = 60 * 1000
  const hour = 60 * minute
  const day = 24 * hour

  if (diff < minute) return 'baru saja'
  if (diff < hour) return `${Math.floor(diff / minute)} menit yang lalu`
  if (diff < day) return `${Math.floor(diff / hour)} jam yang lalu`

  return new Intl.DateTimeFormat('id-ID', {
    day: '2-digit',
    month: 'short',
    year: 'numeric'
  }).format(date)
}

function getTime(value: string) {
  const time = new Date(value).getTime()
  return Number.isNaN(time) ? 0 : time
}

function createId() {
  if (typeof crypto !== 'undefined' && typeof crypto.randomUUID === 'function') {
    return crypto.randomUUID()
  }

  return `${Date.now()}-${Math.random().toString(36).slice(2, 10)}`
}
</script>

<style scoped>
.comment-tool-button {
  display: inline-flex;
  height: 2.25rem;
  width: 2.25rem;
  align-items: center;
  justify-content: center;
  border-radius: 0.875rem;
  color: rgb(82 82 82);
  transition: 160ms ease;
}

.comment-tool-button:hover {
  background: rgb(239 246 255);
  color: rgb(37 99 235);
}
</style>