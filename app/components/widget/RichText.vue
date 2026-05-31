<template>
  <section
    ref="containerRef"
    class="relative overflow-visible rounded-2xl border border-gray-200 bg-white shadow-sm"
  >
    <div class="flex items-center justify-between gap-3 border-b border-gray-200 px-3 py-2.5">
      <div class="min-w-0">
        <p class="text-[11px] font-semibold uppercase tracking-[0.16em] text-blue-600">
          Text Editor
        </p>
        <p class="mt-0.5 text-xs text-gray-500">
          Klik kanan / tahan area editor untuk membuka tools.
        </p>
      </div>

      <button
        type="button"
        class="inline-flex shrink-0 items-center gap-1.5 rounded-xl bg-blue-600 px-3 py-2 text-xs font-semibold text-white shadow-sm transition hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-600/30"
        @click="openTooltipCenter"
      >
        <Icon
          icon="solar:magic-stick-3-bold-duotone"
          class="h-4 w-4"
        />
        Tools
      </button>
    </div>

    <div
      class="relative min-h-[240px] overflow-visible bg-white"
      @contextmenu.prevent="openTooltipFromMouse"
      @touchstart="handleTouchStart"
      @touchend="clearLongPress"
      @touchmove="clearLongPress"
      @touchcancel="clearLongPress"
    >
      <ClientOnly>
        <EditorContent
          v-if="editor"
          :editor="editor"
          class="rich-text-body text-slate-800 [&_.ProseMirror]:!min-h-[240px] [&_.ProseMirror]:!px-4 [&_.ProseMirror]:!py-3 [&_.ProseMirror]:!text-sm [&_.ProseMirror]:!leading-7 [&_.ProseMirror]:!text-slate-800 [&_.ProseMirror]:outline-none [&_.ProseMirror_p]:!my-2 [&_.ProseMirror_h1]:!mb-2 [&_.ProseMirror_h1]:!mt-3 [&_.ProseMirror_h1]:!text-2xl [&_.ProseMirror_h1]:!font-bold [&_.ProseMirror_h1]:!tracking-tight [&_.ProseMirror_h1]:!text-slate-950 [&_.ProseMirror_h2]:!mb-2 [&_.ProseMirror_h2]:!mt-3 [&_.ProseMirror_h2]:!text-xl [&_.ProseMirror_h2]:!font-bold [&_.ProseMirror_h2]:!tracking-tight [&_.ProseMirror_h2]:!text-slate-950 [&_.ProseMirror_h3]:!mb-1.5 [&_.ProseMirror_h3]:!mt-3 [&_.ProseMirror_h3]:!text-base [&_.ProseMirror_h3]:!font-bold [&_.ProseMirror_h3]:!text-slate-950 [&_.ProseMirror_ul]:!list-disc [&_.ProseMirror_ul]:!pl-5 [&_.ProseMirror_ol]:!list-decimal [&_.ProseMirror_ol]:!pl-5 [&_.ProseMirror_table]:!my-3 [&_.ProseMirror_table]:!w-full [&_.ProseMirror_table]:!overflow-hidden [&_.ProseMirror_table]:!rounded-xl [&_.ProseMirror_table]:!border-collapse [&_.ProseMirror_th]:!border [&_.ProseMirror_th]:!border-gray-200 [&_.ProseMirror_th]:!bg-blue-50 [&_.ProseMirror_th]:!p-2.5 [&_.ProseMirror_th]:!text-left [&_.ProseMirror_th]:!font-semibold [&_.ProseMirror_th]:!text-slate-900 [&_.ProseMirror_td]:!border [&_.ProseMirror_td]:!border-gray-200 [&_.ProseMirror_td]:!p-2.5 [&_.ProseMirror_img]:!my-3 [&_.ProseMirror_img]:!max-w-full [&_.ProseMirror_img]:!rounded-xl [&_.ProseMirror_img]:!border [&_.ProseMirror_img]:!border-gray-200 [&_.ProseMirror_iframe]:!my-3 [&_.ProseMirror_iframe]:!min-h-[240px] [&_.ProseMirror_iframe]:!w-full [&_.ProseMirror_iframe]:!rounded-xl [&_.ProseMirror_iframe]:!border [&_.ProseMirror_iframe]:!border-gray-200 [&_.taskflow-choice-input]:!my-3 [&_.taskflow-choice-input]:!rounded-xl [&_.taskflow-choice-input]:!border [&_.taskflow-choice-input]:!border-gray-200 [&_.taskflow-choice-input]:!bg-gray-50 [&_.taskflow-choice-input]:!p-3 [&_.taskflow-choice-copy_strong]:!text-slate-900 [&_.taskflow-choice-copy_small]:!text-gray-500"
        />

        <div
          v-else
          class="min-h-[240px] px-4 py-3 text-sm leading-7 text-gray-400"
        >
          Menyiapkan editor...
        </div>
      </ClientOnly>

      <Teleport to="body">
        <div
          v-if="showTooltip"
          ref="tooltipRef"
          role="dialog"
          aria-label="Editor tools"
          tabindex="-1"
          class="fixed z-[9999] max-h-96 w-[min(360px,calc(100vw-1rem))] overflow-y-auto rounded-2xl border border-gray-200 bg-white p-2 shadow-2xl shadow-gray-900/15 ring-1 ring-gray-900/5"
          :style="{
            left: `${tooltipPosition.x + (containerRef?.getBoundingClientRect().left || 0)}px`,
            top: `${tooltipPosition.y + (containerRef?.getBoundingClientRect().top || 0)}px`
          }"
          @click.stop
          @keydown.esc="closeTooltip"
        >
          <div class="mb-2 flex items-start justify-between gap-3 px-1">
            <div>
              <p class="text-[11px] font-semibold uppercase tracking-[0.16em] text-blue-600">
                Editor Tools
              </p>
              <p class="mt-0.5 text-xs leading-5 text-gray-500">
                Format, table, input, dan embed.
              </p>
            </div>

            <button
              type="button"
              class="grid h-8 w-8 place-items-center rounded-xl text-gray-400 transition hover:bg-gray-100 hover:text-gray-700 focus:outline-none focus:ring-2 focus:ring-blue-600/20"
              @click="closeTooltip"
            >
              <Icon
                icon="solar:close-circle-bold-duotone"
                class="h-5 w-5"
              />
            </button>
          </div>

          <div class="grid grid-cols-5 gap-1.5">
            <button
              v-for="group in toolGroups"
              :key="group.value"
              type="button"
              class="rounded-xl px-1.5 py-2 text-[11px] font-semibold transition focus:outline-none focus:ring-2 focus:ring-blue-600/20"
              :class="activePanel === group.value
                ? 'bg-blue-600 text-white shadow-sm'
                : 'bg-gray-50 text-gray-500 hover:bg-blue-50 hover:text-blue-700'"
              @click="activePanel = group.value"
            >
              <Icon
                :icon="group.icon"
                class="mx-auto mb-1 h-4 w-4"
              />
              {{ group.label }}
            </button>
          </div>

          <div class="mt-2 rounded-2xl border border-gray-200 bg-gray-50 p-2">
            <div v-if="activePanel === 'format'">
              <p class="mb-2 px-1 text-[11px] font-semibold uppercase tracking-[0.14em] text-gray-400">
                Format teks
              </p>

              <div class="grid grid-cols-2 gap-1.5">
                <button
                  v-for="item in blockMenus"
                  :key="item.value"
                  type="button"
                  class="inline-flex items-center gap-2 rounded-xl px-2.5 py-2 text-left text-xs font-semibold transition focus:outline-none focus:ring-2 focus:ring-blue-600/20"
                  :class="isBlockActive(item.value)
                    ? 'bg-blue-600 text-white'
                    : 'bg-white text-gray-600 ring-1 ring-gray-200 hover:bg-blue-50 hover:text-blue-700'"
                  @click="setBlock(item.value)"
                >
                  <Icon
                    :icon="item.icon"
                    class="h-4 w-4"
                  />
                  {{ item.label }}
                </button>
              </div>
            </div>

            <div v-else-if="activePanel === 'style'">
              <p class="mb-2 px-1 text-[11px] font-semibold uppercase tracking-[0.14em] text-gray-400">
                Gaya teks
              </p>

              <div class="grid grid-cols-2 gap-1.5">
                <button
                  type="button"
                  class="inline-flex items-center gap-2 rounded-xl px-2.5 py-2 text-xs font-semibold transition focus:outline-none focus:ring-2 focus:ring-blue-600/20"
                  :class="isActive('bold')
                    ? 'bg-blue-600 text-white'
                    : 'bg-white text-gray-600 ring-1 ring-gray-200 hover:bg-blue-50 hover:text-blue-700'"
                  @click="editor?.chain().focus().toggleBold().run()"
                >
                  <Icon
                    icon="solar:text-bold-bold"
                    class="h-4 w-4"
                  />
                  Bold
                </button>

                <button
                  type="button"
                  class="inline-flex items-center gap-2 rounded-xl px-2.5 py-2 text-xs font-semibold transition focus:outline-none focus:ring-2 focus:ring-blue-600/20"
                  :class="isActive('italic')
                    ? 'bg-blue-600 text-white'
                    : 'bg-white text-gray-600 ring-1 ring-gray-200 hover:bg-blue-50 hover:text-blue-700'"
                  @click="editor?.chain().focus().toggleItalic().run()"
                >
                  <Icon
                    icon="solar:text-italic-bold"
                    class="h-4 w-4"
                  />
                  Italic
                </button>

                <button
                  type="button"
                  class="inline-flex items-center gap-2 rounded-xl px-2.5 py-2 text-xs font-semibold transition focus:outline-none focus:ring-2 focus:ring-blue-600/20"
                  :class="isActive('bulletList')
                    ? 'bg-blue-600 text-white'
                    : 'bg-white text-gray-600 ring-1 ring-gray-200 hover:bg-blue-50 hover:text-blue-700'"
                  @click="editor?.chain().focus().toggleBulletList().run()"
                >
                  <Icon
                    icon="solar:list-down-bold-duotone"
                    class="h-4 w-4"
                  />
                  Bullet
                </button>

                <button
                  type="button"
                  class="inline-flex items-center gap-2 rounded-xl px-2.5 py-2 text-xs font-semibold transition focus:outline-none focus:ring-2 focus:ring-blue-600/20"
                  :class="isActive('orderedList')
                    ? 'bg-blue-600 text-white'
                    : 'bg-white text-gray-600 ring-1 ring-gray-200 hover:bg-blue-50 hover:text-blue-700'"
                  @click="editor?.chain().focus().toggleOrderedList().run()"
                >
                  <Icon
                    icon="solar:list-check-bold-duotone"
                    class="h-4 w-4"
                  />
                  Number
                </button>
              </div>
            </div>

            <div v-else-if="activePanel === 'table'">
              <p class="mb-2 px-1 text-[11px] font-semibold uppercase tracking-[0.14em] text-gray-400">
                Table
              </p>

              <div class="grid grid-cols-2 gap-1.5">
                <button
                  type="button"
                  class="inline-flex items-center gap-2 rounded-xl bg-white px-2.5 py-2 text-xs font-semibold text-gray-600 ring-1 ring-gray-200 transition hover:bg-blue-50 hover:text-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-600/20"
                  @click="insertTable"
                >
                  <Icon
                    icon="solar:widget-2-bold-duotone"
                    class="h-4 w-4"
                  />
                  Insert
                </button>

                <button
                  type="button"
                  class="inline-flex items-center gap-2 rounded-xl bg-white px-2.5 py-2 text-xs font-semibold text-gray-600 ring-1 ring-gray-200 transition hover:bg-blue-50 hover:text-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-600/20"
                  @click="editor?.chain().focus().addColumnAfter().run()"
                >
                  <Icon
                    icon="solar:add-square-bold-duotone"
                    class="h-4 w-4"
                  />
                  Column
                </button>

                <button
                  type="button"
                  class="inline-flex items-center gap-2 rounded-xl bg-white px-2.5 py-2 text-xs font-semibold text-gray-600 ring-1 ring-gray-200 transition hover:bg-blue-50 hover:text-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-600/20"
                  @click="editor?.chain().focus().addRowAfter().run()"
                >
                  <Icon
                    icon="solar:add-square-bold-duotone"
                    class="h-4 w-4"
                  />
                  Row
                </button>

                <button
                  type="button"
                  class="inline-flex items-center gap-2 rounded-xl bg-white px-2.5 py-2 text-xs font-semibold text-red-600 ring-1 ring-gray-200 transition hover:bg-red-50 focus:outline-none focus:ring-2 focus:ring-red-500/20"
                  @click="editor?.chain().focus().deleteTable().run()"
                >
                  <Icon
                    icon="solar:trash-bin-trash-bold-duotone"
                    class="h-4 w-4"
                  />
                  Delete
                </button>
              </div>
            </div>

            <div v-else-if="activePanel === 'input'">
              <p class="mb-2 px-1 text-[11px] font-semibold uppercase tracking-[0.14em] text-gray-400">
                Checkbox / Radio
              </p>

              <div class="grid grid-cols-2 gap-1.5">
                <button
                  type="button"
                  class="rounded-xl px-2.5 py-2 text-xs font-semibold transition focus:outline-none focus:ring-2 focus:ring-blue-600/20"
                  :class="choiceType === 'checkbox'
                    ? 'bg-blue-600 text-white'
                    : 'bg-white text-gray-600 ring-1 ring-gray-200 hover:bg-blue-50 hover:text-blue-700'"
                  @click="choiceType = 'checkbox'"
                >
                  <Icon
                    icon="solar:check-square-bold-duotone"
                    class="mx-auto mb-1 h-4 w-4"
                  />
                  Checkbox
                </button>

                <button
                  type="button"
                  class="rounded-xl px-2.5 py-2 text-xs font-semibold transition focus:outline-none focus:ring-2 focus:ring-blue-600/20"
                  :class="choiceType === 'radio'
                    ? 'bg-blue-600 text-white'
                    : 'bg-white text-gray-600 ring-1 ring-gray-200 hover:bg-blue-50 hover:text-blue-700'"
                  @click="choiceType = 'radio'"
                >
                  <Icon
                    icon="solar:record-circle-bold-duotone"
                    class="mx-auto mb-1 h-4 w-4"
                  />
                  Radio
                </button>
              </div>

              <div class="mt-2 space-y-1.5">
                <input
                  v-model="choiceLabel"
                  type="text"
                  class="editor-input"
                  placeholder="Label, contoh: Saya setuju dengan keputusan ini"
                >

                <textarea
                  v-model="choiceDescription"
                  rows="2"
                  class="editor-textarea"
                  placeholder="Description / note, contoh: Centang jika task sudah divalidasi admin."
                ></textarea>

                <label class="flex items-center gap-2 rounded-xl border border-gray-200 bg-white px-3 py-2 text-xs font-semibold text-gray-600">
                  <input
                    v-model="choiceChecked"
                    type="checkbox"
                    class="h-4 w-4 rounded border-gray-300 text-blue-600 focus:ring-blue-600"
                  >
                  Set checked/default
                </label>
              </div>

              <div class="mt-2 rounded-xl border border-gray-200 bg-white p-3">
                <p class="mb-2 text-[11px] font-semibold uppercase tracking-[0.14em] text-gray-400">
                  Preview
                </p>

                <div class="taskflow-choice-preview">
                  <input
                    :type="choiceType"
                    :checked="choiceChecked"
                    disabled
                  >

                  <div>
                    <p>{{ choiceLabel || 'Label pilihan' }}</p>
                    <span>{{ choiceDescription || 'Description / note akan tampil di sini.' }}</span>
                  </div>
                </div>
              </div>

              <button
                type="button"
                class="mt-2 inline-flex w-full items-center justify-center gap-2 rounded-xl bg-blue-600 px-3 py-2.5 text-xs font-semibold text-white shadow-sm transition hover:bg-blue-700 disabled:cursor-not-allowed disabled:opacity-50 focus:outline-none focus:ring-2 focus:ring-blue-600/30"
                :disabled="!choiceLabel.trim()"
                @click="insertChoiceInput"
              >
                <Icon
                  icon="solar:add-circle-bold-duotone"
                  class="h-4 w-4"
                />
                Sisipkan {{ choiceType === 'checkbox' ? 'checkbox' : 'radio' }}
              </button>
            </div>

            <div v-else>
              <p class="mb-2 px-1 text-[11px] font-semibold uppercase tracking-[0.14em] text-gray-400">
                Embed link
              </p>

              <div class="mb-2 grid grid-cols-3 gap-1.5">
                <button
                  v-for="item in embedMenus"
                  :key="item.value"
                  type="button"
                  class="rounded-xl px-2 py-2 text-xs font-semibold transition focus:outline-none focus:ring-2 focus:ring-blue-600/20"
                  :class="embedType === item.value
                    ? 'bg-blue-600 text-white'
                    : 'bg-white text-gray-600 ring-1 ring-gray-200 hover:bg-blue-50 hover:text-blue-700'"
                  @click="embedType = item.value"
                >
                  <Icon
                    :icon="item.icon"
                    class="mx-auto mb-1 h-4 w-4"
                  />
                  {{ item.label }}
                </button>
              </div>

              <input
                v-model="embedUrl"
                type="url"
                class="min-h-10 w-full rounded-xl border border-gray-200 bg-white px-3 py-2 text-xs text-gray-800 outline-none transition placeholder:text-gray-400 focus:border-blue-600 focus:ring-2 focus:ring-blue-600/10"
                :placeholder="embedPlaceholder"
              >

              <input
                v-if="embedType === 'pdf'"
                v-model="embedTitle"
                type="text"
                class="mt-1.5 min-h-10 w-full rounded-xl border border-gray-200 bg-white px-3 py-2 text-xs text-gray-800 outline-none transition placeholder:text-gray-400 focus:border-blue-600 focus:ring-2 focus:ring-blue-600/10"
                placeholder="Judul PDF, contoh: Brief Project"
              >

              <button
                type="button"
                class="mt-2 inline-flex w-full items-center justify-center gap-2 rounded-xl bg-blue-600 px-3 py-2.5 text-xs font-semibold text-white shadow-sm transition hover:bg-blue-700 disabled:cursor-not-allowed disabled:opacity-50 focus:outline-none focus:ring-2 focus:ring-blue-600/30"
                :disabled="!embedUrl.trim()"
                @click="insertEmbed"
              >
                <Icon
                  icon="solar:add-circle-bold-duotone"
                  class="h-4 w-4"
                />
                Sisipkan embed
              </button>
            </div>
          </div>
        </div>
      </Teleport>
    </div>
  </section>
</template>

<script setup lang="ts">
import { Icon } from '@iconify/vue'
import { Node as TiptapNode, mergeAttributes } from '@tiptap/core'
import { Editor, EditorContent } from '@tiptap/vue-3'
import StarterKit from '@tiptap/starter-kit'
import Placeholder from '@tiptap/extension-placeholder'
import Image from '@tiptap/extension-image'
import Youtube from '@tiptap/extension-youtube'
import { Table } from '@tiptap/extension-table'
import TableRow from '@tiptap/extension-table-row'
import TableCell from '@tiptap/extension-table-cell'
import TableHeader from '@tiptap/extension-table-header'
import {
  computed,
  nextTick,
  onBeforeUnmount,
  onMounted,
  ref,
  watch
} from 'vue'

type ToolPanel = 'format' | 'style' | 'table' | 'input' | 'embed'
type EmbedType = 'image' | 'pdf' | 'youtube'
type BlockType = 'paragraph' | 'h1' | 'h2' | 'h3'
type ChoiceType = 'checkbox' | 'radio'

const model = defineModel<string>({
  default: ''
})

const props = withDefaults(
  defineProps<{
    placeholder?: string
  }>(),
  {
    placeholder: 'Tulis detail tugas di sini...'
  }
)

const PdfEmbed = TiptapNode.create({
  name: 'pdfEmbed',
  group: 'block',
  atom: true,

  addAttributes() {
    return {
      src: {
        default: null
      },
      title: {
        default: 'Dokumen PDF'
      }
    }
  },

  parseHTML() {
    return [
      {
        tag: 'iframe[data-type="pdf-embed"]'
      }
    ]
  },

  renderHTML({ HTMLAttributes }) {
    return [
      'iframe',
      mergeAttributes(HTMLAttributes, {
        'data-type': 'pdf-embed',
        class: 'taskflow-pdf-embed',
        loading: 'lazy',
        title: HTMLAttributes.title || 'Dokumen PDF'
      })
    ]
  }
})

const ChoiceInput = TiptapNode.create({
  name: 'choiceInput',
  group: 'block',
  atom: true,

  addAttributes() {
    return {
      inputType: {
        default: 'checkbox'
      },
      inputName: {
        default: ''
      },
      label: {
        default: 'Label pilihan'
      },
      description: {
        default: ''
      },
      checked: {
        default: false
      }
    }
  },

  parseHTML() {
    return [
      {
        tag: 'div[data-type="taskflow-choice-input"]'
      }
    ]
  },

  renderHTML({ HTMLAttributes }) {
    const inputType = HTMLAttributes.inputType === 'radio' ? 'radio' : 'checkbox'
    const checkedAttrs = HTMLAttributes.checked
      ? {
          checked: 'checked'
        }
      : {}

    return [
      'div',
      mergeAttributes(HTMLAttributes, {
        'data-type': 'taskflow-choice-input',
        class: 'taskflow-choice-input'
      }),
      [
        'label',
        {
          class: 'taskflow-choice-label'
        },
        [
          'input',
          {
            type: inputType,
            name: HTMLAttributes.inputName || undefined,
            value: HTMLAttributes.inputName || undefined,
            ...checkedAttrs
          }
        ],
        [
          'span',
          {
            class: 'taskflow-choice-copy'
          },
          [
            'strong',
            {},
            HTMLAttributes.label || 'Label pilihan'
          ],
          [
            'small',
            {},
            HTMLAttributes.description || ''
          ]
        ]
      ]
    ]
  }
})

const containerRef = ref<HTMLElement | null>(null)
const tooltipRef = ref<HTMLElement | null>(null)
const editor = ref<Editor | null>(null)

const showTooltip = ref(false)
const activePanel = ref<ToolPanel>('format')
const tooltipPosition = ref({
  x: 16,
  y: 16
})

const embedType = ref<EmbedType>('image')
const embedUrl = ref('')
const embedTitle = ref('')

const choiceType = ref<ChoiceType>('checkbox')
const choiceName = ref('')
const choiceLabel = ref('')
const choiceDescription = ref('')
const choiceChecked = ref(false)

let longPressTimer: number | null = null

const toolGroups = [
  {
    value: 'format' as ToolPanel,
    label: 'Format',
    icon: 'solar:text-bold-duotone'
  },
  {
    value: 'style' as ToolPanel,
    label: 'Style',
    icon: 'solar:magic-stick-3-bold-duotone'
  },
  {
    value: 'table' as ToolPanel,
    label: 'Table',
    icon: 'solar:widget-2-bold-duotone'
  },
  {
    value: 'input' as ToolPanel,
    label: 'Input',
    icon: 'solar:check-square-bold-duotone'
  },
  {
    value: 'embed' as ToolPanel,
    label: 'Embed',
    icon: 'solar:paperclip-rounded-bold-duotone'
  }
]

const blockMenus = [
  {
    value: 'paragraph' as BlockType,
    label: 'Paragraph',
    icon: 'solar:text-field-bold-duotone'
  },
  {
    value: 'h1' as BlockType,
    label: 'Heading 1',
    icon: 'solar:text-bold'
  },
  {
    value: 'h2' as BlockType,
    label: 'Heading 2',
    icon: 'solar:text-bold'
  },
  {
    value: 'h3' as BlockType,
    label: 'Heading 3',
    icon: 'solar:text-bold'
  }
]

const embedMenus = [
  {
    value: 'image' as EmbedType,
    label: 'Image',
    icon: 'solar:gallery-bold-duotone'
  },
  {
    value: 'pdf' as EmbedType,
    label: 'PDF',
    icon: 'solar:file-text-bold-duotone'
  },
  {
    value: 'youtube' as EmbedType,
    label: 'YouTube',
    icon: 'solar:video-frame-bold-duotone'
  }
]

const embedPlaceholder = computed(() => {
  if (embedType.value === 'image') return 'https://domain.com/gambar.png'
  if (embedType.value === 'pdf') return 'https://domain.com/file.pdf'
  return 'https://www.youtube.com/watch?v=...'
})

const createEditor = () => {
  editor.value = new Editor({
    content: model.value || '<p></p>',
    extensions: [
      StarterKit,
      Placeholder.configure({
        placeholder: props.placeholder
      }),
      Image.configure({
        inline: false,
        allowBase64: false
      }),
      Youtube.configure({
        controls: true,
        nocookie: true,
        modestBranding: true
      }),
      Table.configure({
        resizable: true
      }),
      TableRow,
      TableHeader,
      TableCell,
      PdfEmbed,
      ChoiceInput
    ],
    editorProps: {
      attributes: {
        class: 'min-h-[260px] px-5 py-4 text-sm leading-7 text-white/80 outline-none'
      }
    },
    onUpdate({ editor }) {
      model.value = editor.getHTML()
    }
  })
}

const clampTooltipPosition = async (x: number, y: number) => {
  await nextTick()

  const container = containerRef.value
  if (!container) {
    tooltipPosition.value = { x, y }
    return
  }

  const tooltipWidth = 430
  const tooltipHeight = 560

  const maxX = Math.max(12, container.clientWidth - tooltipWidth - 12)
  const maxY = Math.max(12, container.clientHeight - tooltipHeight - 12)

  tooltipPosition.value = {
    x: Math.min(Math.max(12, x), maxX),
    y: Math.min(Math.max(12, y), maxY)
  }
}

const openTooltipAtClientPoint = async (clientX: number, clientY: number) => {
  const container = containerRef.value
  if (!container) return

  const rect = container.getBoundingClientRect()

  showTooltip.value = true

  await clampTooltipPosition(
    clientX - rect.left,
    clientY - rect.top
  )
}

const openTooltipFromMouse = async (event: MouseEvent) => {
  event.preventDefault()
  await openTooltipAtClientPoint(event.clientX, event.clientY)
}

const openTooltipCenter = async () => {
  const container = containerRef.value
  if (!container) return

  showTooltip.value = true

  await clampTooltipPosition(
    Math.max(12, container.clientWidth - 450),
    70
  )
}

const handleTouchStart = (event: TouchEvent) => {
  clearLongPress()

  const touch = event.touches[0]
  if (!touch) return

  longPressTimer = window.setTimeout(() => {
    openTooltipAtClientPoint(touch.clientX, touch.clientY)
  }, 520)
}

const clearLongPress = () => {
  if (longPressTimer) {
    window.clearTimeout(longPressTimer)
    longPressTimer = null
  }
}

const closeTooltip = () => {
  showTooltip.value = false
}

const isActive = (name: string) => {
  return Boolean(editor.value?.isActive(name))
}

const isBlockActive = (type: BlockType) => {
  if (type === 'paragraph') return Boolean(editor.value?.isActive('paragraph'))
  if (type === 'h1') return Boolean(editor.value?.isActive('heading', { level: 1 }))
  if (type === 'h2') return Boolean(editor.value?.isActive('heading', { level: 2 }))
  return Boolean(editor.value?.isActive('heading', { level: 3 }))
}

const setBlock = (type: BlockType) => {
  if (type === 'paragraph') {
    editor.value?.chain().focus().setParagraph().run()
  }

  if (type === 'h1') {
    editor.value?.chain().focus().toggleHeading({ level: 1 }).run()
  }

  if (type === 'h2') {
    editor.value?.chain().focus().toggleHeading({ level: 2 }).run()
  }

  if (type === 'h3') {
    editor.value?.chain().focus().toggleHeading({ level: 3 }).run()
  }
}

const insertTable = () => {
  editor.value?.chain().focus().insertTable({
    rows: 3,
    cols: 3,
    withHeaderRow: true
  }).run()
}

const normalizeUrl = (value: string) => {
  const url = value.trim()

  if (!url) return ''
  if (url.startsWith('http://') || url.startsWith('https://')) return url

  return `https://${url}`
}

const normalizeInputName = (value: string) => {
  return value
    .trim()
    .toLowerCase()
    .replace(/[^a-z0-9_-]/g, '-')
    .replace(/-+/g, '-')
    .replace(/^-|-$/g, '')
}

const insertChoiceInput = () => {
  const label = choiceLabel.value.trim()
  if (!label) return

  const fallbackName = normalizeInputName(label)
  const inputName = normalizeInputName(choiceName.value) || fallbackName || `choice-${Date.now()}`

  editor.value?.chain().focus().insertContent({
    type: 'choiceInput',
    attrs: {
      inputType: choiceType.value,
      inputName,
      label,
      description: choiceDescription.value.trim(),
      checked: choiceChecked.value
    }
  }).run()

  choiceName.value = ''
  choiceLabel.value = ''
  choiceDescription.value = ''
  choiceChecked.value = false

  closeTooltip()
}

const insertEmbed = () => {
  const url = normalizeUrl(embedUrl.value)

  if (!url) return

  if (embedType.value === 'image') {
    editor.value?.chain().focus().setImage({
      src: url,
      alt: 'Task image'
    }).run()
  }

  if (embedType.value === 'pdf') {
    editor.value?.chain().focus().insertContent({
      type: 'pdfEmbed',
      attrs: {
        src: url,
        title: embedTitle.value.trim() || 'Dokumen PDF'
      }
    }).run()
  }

  if (embedType.value === 'youtube') {
    editor.value?.chain().focus().setYoutubeVideo({
      src: url,
      width: 640,
      height: 360
    }).run()
  }

  embedUrl.value = ''
  embedTitle.value = ''
  closeTooltip()
}

const handleOutsideClick = (event: MouseEvent) => {
  const target = event.target as HTMLElement
  const container = containerRef.value

  if (!container || !showTooltip.value) return
  if (container.contains(target)) return

  closeTooltip()
}

watch(
  () => model.value,
  (value) => {
    const currentHtml = editor.value?.getHTML()

    if (editor.value && value !== currentHtml) {
      editor.value.commands.setContent(value || '<p></p>', {
        emitUpdate: false
      })
    }
  }
)

onMounted(() => {
  createEditor()
  document.addEventListener('click', handleOutsideClick)
})

onBeforeUnmount(() => {
  clearLongPress()
  document.removeEventListener('click', handleOutsideClick)
  editor.value?.destroy()
})
</script>

<style scoped>
.dropdown-btn {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  border-radius: 0.75rem;
  border: 1px solid rgb(229 231 235);
  background: white;
  padding: 0.625rem 0.75rem;
  text-align: left;
  font-size: 0.75rem;
  font-weight: 700;
  color: rgb(75 85 99);
  transition: 160ms ease;
}

.dropdown-btn:hover {
  border-color: rgb(191 219 254);
  background: rgb(239 246 255);
  color: rgb(29 78 216);
}

.dropdown-btn-active {
  border-color: rgb(37 99 235 / 0.35);
  background: rgb(37 99 235);
  color: white;
  box-shadow: 0 8px 18px rgb(37 99 235 / 0.18);
}

.editor-input,
.editor-textarea {
  display: block;
  width: 100%;
  border-radius: 0.75rem;
  border: 1px solid rgb(229 231 235);
  background: white;
  color: rgb(31 41 55);
  font-size: 0.75rem;
  outline: none;
  transition: 160ms ease;
}

.editor-input {
  min-height: 2.5rem;
  padding: 0.625rem 0.75rem;
}

.editor-textarea {
  resize: none;
  padding: 0.625rem 0.75rem;
}

.editor-input::placeholder,
.editor-textarea::placeholder {
  color: rgb(156 163 175);
}

.editor-input:focus,
.editor-textarea:focus {
  border-color: rgb(37 99 235);
  box-shadow: 0 0 0 3px rgb(37 99 235 / 0.1);
}

.rich-text-body :deep(.ProseMirror) {
  min-height: 240px;
  color: rgb(30 41 59);
}

.rich-text-body :deep(.ProseMirror p) {
  margin: 0.5rem 0;
}

.rich-text-body :deep(.ProseMirror p.is-editor-empty:first-child::before) {
  float: left;
  height: 0;
  pointer-events: none;
  color: rgb(148 163 184);
  content: attr(data-placeholder);
}

.rich-text-body :deep(.ProseMirror h1) {
  margin: 0.875rem 0 0.375rem;
  font-size: 1.5rem;
  line-height: 1.15;
  font-weight: 800;
  letter-spacing: -0.04em;
  color: rgb(15 23 42);
}

.rich-text-body :deep(.ProseMirror h2) {
  margin: 0.875rem 0 0.375rem;
  font-size: 1.25rem;
  line-height: 1.2;
  font-weight: 800;
  letter-spacing: -0.035em;
  color: rgb(15 23 42);
}

.rich-text-body :deep(.ProseMirror h3) {
  margin: 0.75rem 0 0.25rem;
  font-size: 1rem;
  line-height: 1.25;
  font-weight: 800;
  color: rgb(15 23 42);
}

.rich-text-body :deep(.ProseMirror ul) {
  list-style: disc;
  padding-left: 1.25rem;
}

.rich-text-body :deep(.ProseMirror ol) {
  list-style: decimal;
  padding-left: 1.25rem;
}

.rich-text-body :deep(.ProseMirror li) {
  margin: 0.25rem 0;
}

.rich-text-body :deep(.ProseMirror table) {
  width: 100%;
  overflow: hidden;
  border-collapse: collapse;
  border-radius: 0.875rem;
  margin: 0.875rem 0;
  background: white;
}

.rich-text-body :deep(.ProseMirror th),
.rich-text-body :deep(.ProseMirror td) {
  border: 1px solid rgb(229 231 235);
  padding: 0.625rem;
  vertical-align: top;
}

.rich-text-body :deep(.ProseMirror th) {
  background: rgb(239 246 255);
  color: rgb(15 23 42);
  font-weight: 800;
}

.rich-text-body :deep(.ProseMirror img) {
  max-width: 100%;
  border-radius: 0.875rem;
  border: 1px solid rgb(229 231 235);
  margin: 0.875rem 0;
}

.rich-text-body :deep(.ProseMirror iframe) {
  width: 100%;
  min-height: 240px;
  border: 1px solid rgb(229 231 235);
  border-radius: 0.875rem;
  margin: 0.875rem 0;
  background: rgb(249 250 251);
}

.rich-text-body :deep(.taskflow-choice-input),
.taskflow-choice-preview {
  margin: 0.875rem 0;
  border-radius: 0.875rem;
  border: 1px solid rgb(229 231 235);
  background: rgb(249 250 251);
  padding: 0.75rem;
}

.rich-text-body :deep(.taskflow-choice-label),
.taskflow-choice-preview {
  display: flex;
  gap: 0.625rem;
  align-items: flex-start;
}

.rich-text-body :deep(.taskflow-choice-label input),
.taskflow-choice-preview input {
  margin-top: 0.2rem;
  min-width: 1rem;
  width: 1rem;
  height: 1rem;
  accent-color: #2563eb;
}

.rich-text-body :deep(.taskflow-choice-copy),
.taskflow-choice-preview div {
  display: grid;
  gap: 0.125rem;
}

.rich-text-body :deep(.taskflow-choice-copy strong),
.taskflow-choice-preview p {
  margin: 0;
  color: rgb(15 23 42);
  font-size: 0.875rem;
  font-weight: 800;
  line-height: 1.35;
}

.rich-text-body :deep(.taskflow-choice-copy small),
.taskflow-choice-preview span {
  color: rgb(100 116 139);
  font-size: 0.75rem;
  line-height: 1.55;
}
</style>