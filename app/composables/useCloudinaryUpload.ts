// composables/useCloudinaryUpload.ts
export type CloudinaryUploadResult = {
  secure_url: string
  public_id: string
  width?: number
  height?: number
  bytes?: number
  format?: string
}

type ResizeOptions = {
  folder?: string
  maxWidth?: number
  maxHeight?: number
  quality?: number
  maxBytes?: number
}

const ALLOWED_IMAGE_TYPES = new Set([
  'image/jpeg',
  'image/jpg',
  'image/png',
  'image/webp'
])

const DEFAULT_MAX_BYTES = 5 * 1024 * 1024

function validateImageFile(file: File, maxBytes = DEFAULT_MAX_BYTES) {
  if (!ALLOWED_IMAGE_TYPES.has(file.type)) {
    throw new Error('Format gambar harus JPG, PNG, atau WebP. SVG/GIF tidak diperbolehkan.')
  }

  if (file.size > maxBytes) {
    throw new Error(`Ukuran gambar maksimal ${Math.round(maxBytes / 1024 / 1024)} MB.`)
  }
}

function getFetchErrorMessage(err: any, fallback: string) {
  return (
    err?.data?.statusMessage ||
    err?.data?.message ||
    err?.statusMessage ||
    err?.message ||
    fallback
  )
}

export const useCloudinaryUpload = () => {
  const uploading = ref(false)
  const deleting = ref(false)
  const uploadError = ref<string | null>(null)
  const deleteError = ref<string | null>(null)

  async function fileToImage(file: File): Promise<HTMLImageElement> {
    const url = URL.createObjectURL(file)

    try {
      const img = new Image()
      img.decoding = 'async'
      img.src = url

      await new Promise<void>((resolve, reject) => {
        img.onload = () => resolve()
        img.onerror = () => reject(new Error('Gagal membaca gambar.'))
      })

      return img
    } finally {
      URL.revokeObjectURL(url)
    }
  }

  async function uploadImageFromUrl(
    url: string,
    opts?: {
      folder?: string
      maxWidth?: number
      maxHeight?: number
      quality?: number
    }
  ) {
    uploadError.value = null
    uploading.value = true

    try {
      const res = await $fetch<CloudinaryUploadResult>('/api/cloudinary/upload-image-url', {
        method: 'POST',
        body: {
          url,
          folder: opts?.folder,
          maxWidth: opts?.maxWidth || 1600,
          maxHeight: opts?.maxHeight || 1600,
          quality: opts?.quality ?? 0.82
        }
      })

      return res
    } catch (err: any) {
      uploadError.value = getFetchErrorMessage(err, 'Upload gambar dari link gagal.')
      throw err
    } finally {
      uploading.value = false
    }
  }

  function getTargetSize(width: number, height: number, maxWidth: number, maxHeight: number) {
    const ratio = Math.min(maxWidth / width, maxHeight / height, 1)

    return {
      width: Math.max(1, Math.round(width * ratio)),
      height: Math.max(1, Math.round(height * ratio))
    }
  }

  async function resizeImageToWebp(
    file: File,
    opts?: {
      maxWidth?: number
      maxHeight?: number
      quality?: number
    }
  ): Promise<File> {
    validateImageFile(file)

    const maxWidth = opts?.maxWidth || 1600
    const maxHeight = opts?.maxHeight || 1600
    const quality = opts?.quality ?? 0.82

    let source: CanvasImageSource
    let sourceWidth = 0
    let sourceHeight = 0

    if ('createImageBitmap' in window) {
      const bitmap = await createImageBitmap(file, {
        imageOrientation: 'from-image'
      } as ImageBitmapOptions)

      source = bitmap
      sourceWidth = bitmap.width
      sourceHeight = bitmap.height
    } else {
      const img = await fileToImage(file)
      source = img
      sourceWidth = img.naturalWidth || img.width
      sourceHeight = img.naturalHeight || img.height
    }

    const target = getTargetSize(sourceWidth, sourceHeight, maxWidth, maxHeight)

    const canvas = document.createElement('canvas')
    canvas.width = target.width
    canvas.height = target.height

    const ctx = canvas.getContext('2d')
    if (!ctx) throw new Error('Browser tidak mendukung canvas resize.')

    ctx.imageSmoothingEnabled = true
    ctx.imageSmoothingQuality = 'high'
    ctx.drawImage(source, 0, 0, target.width, target.height)

    if ('close' in source && typeof source.close === 'function') {
      source.close()
    }

    const blob = await new Promise<Blob>((resolve, reject) => {
      canvas.toBlob(
        (result) => {
          if (!result) reject(new Error('Gagal mengubah gambar menjadi WebP.'))
          else resolve(result)
        },
        'image/webp',
        quality
      )
    })

    const baseName = file.name.replace(/\.[^.]+$/, '') || 'image'
    const safeName = baseName
      .toLowerCase()
      .replace(/[^a-z0-9]+/g, '-')
      .replace(/^-+|-+$/g, '')

    return new File([blob], `${safeName || 'image'}.webp`, {
      type: 'image/webp',
      lastModified: Date.now()
    })
  }

  async function uploadImage(file: File, opts?: ResizeOptions) {
    uploadError.value = null

    const maxBytes = opts?.maxBytes || 5 * 1024 * 1024

    try {
      validateImageFile(file, maxBytes)
    } catch (err: any) {
      uploadError.value = err?.message || 'File gambar tidak valid.'
      throw err
    }

    uploading.value = true

    try {
      const config = useRuntimeConfig()

      const cloudName = String(config.public.cloudinaryCloudName || '')
      const uploadPreset = String(config.public.cloudinaryUploadPreset || '')

      if (!cloudName || !uploadPreset) {
        throw new Error('Cloudinary cloud name atau upload preset belum diatur.')
      }

      const webpFile = await resizeImageToWebp(file, {
        maxWidth: opts?.maxWidth || 1600,
        maxHeight: opts?.maxHeight || 1600,
        quality: opts?.quality ?? 0.82
      })

      const form = new FormData()
      form.append('file', webpFile)
      form.append('upload_preset', uploadPreset)

      // Catatan:
      // folder hanya bisa dipakai jika upload preset Cloudinary mengizinkan.
      // Kalau Cloudinary menolak folder, hapus baris ini atau set folder langsung di upload preset.
      if (opts?.folder) {
        form.append('folder', opts.folder)
      }

      const res = await fetch(`https://api.cloudinary.com/v1_1/${cloudName}/image/upload`, {
        method: 'POST',
        body: form
      })

      const json = await res.json()

      if (!res.ok) {
        throw new Error(json?.error?.message || 'Upload gambar ke Cloudinary gagal.')
      }

      return {
        secure_url: json.secure_url,
        public_id: json.public_id,
        width: json.width,
        height: json.height,
        bytes: json.bytes,
        format: json.format
      } as CloudinaryUploadResult
    } catch (err: any) {
      uploadError.value =
        err?.data?.statusMessage ||
        err?.data?.message ||
        err?.statusMessage ||
        err?.message ||
        'Upload gambar gagal.'

      throw err
    } finally {
      uploading.value = false
    }
  }

  async function deleteImage(publicId?: string | null) {
    deleteError.value = null

    if (!publicId) return {
      ok: true,
      skipped: true
    }

    deleting.value = true

    try {
      const res = await $fetch<{ ok: boolean; result?: string }>('/api/cloudinary/delete', {
        method: 'POST',
        body: {
          publicId
        }
      })

      return res
    } catch (err: any) {
      deleteError.value = getFetchErrorMessage(err, 'Gagal menghapus gambar.')
      throw err
    } finally {
      deleting.value = false
    }
  }

  return {
    uploading,
    deleting,
    uploadError,
    deleteError,
    uploadImage,
    uploadImageFromUrl,
    deleteImage,
    resizeImageToWebp
  }
}