<template>
  <section class="min-h-full bg-neutral-50 text-neutral-950" :style="themeVars">
    <!-- Toast -->
    <Teleport to="body">
      <Transition
        enter-active-class="transition duration-300 ease-out"
        enter-from-class="translate-y-3 opacity-0 sm:translate-x-3 sm:translate-y-0"
        enter-to-class="translate-y-0 opacity-100 sm:translate-x-0"
        leave-active-class="transition duration-200 ease-in"
        leave-from-class="translate-y-0 opacity-100 sm:translate-x-0"
        leave-to-class="translate-y-3 opacity-0 sm:translate-x-3 sm:translate-y-0"
      >
        <div v-if="toast.show" class="fixed right-4 top-4 z-[9999] w-[calc(100%-2rem)] max-w-sm">
          <div
            class="rounded-[1.5rem] border bg-white/95 p-4 shadow-[0_24px_80px_rgba(15,23,42,0.16)] backdrop-blur-xl"
            :class="toast.type === 'success' ? 'border-emerald-200' : 'border-red-200'"
          >
            <div class="flex items-start gap-3">
              <div
                class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl"
                :class="toast.type === 'success' ? 'bg-emerald-100 text-emerald-700' : 'bg-red-100 text-red-700'"
              >
                <Icon
                  :icon="toast.type === 'success' ? 'solar:check-circle-bold-duotone' : 'solar:danger-circle-bold-duotone'"
                  class="h-5 w-5"
                />
              </div>

              <div class="min-w-0 flex-1">
                <p class="text-sm font-black text-neutral-950">{{ toast.title }}</p>
                <p class="mt-1 text-sm font-semibold leading-6 text-neutral-500">{{ toast.message }}</p>
              </div>

              <button
                type="button"
                class="grid h-8 w-8 shrink-0 place-items-center rounded-xl text-neutral-400 transition hover:bg-neutral-100 hover:text-neutral-700"
                aria-label="Tutup pemberitahuan"
                @click="closeToast"
              >
                <Icon icon="solar:close-circle-bold-duotone" class="h-5 w-5" />
              </button>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>

    <div class="space-y-4 p-4 sm:p-6">
      <!-- Header -->
      <section class="relative overflow-hidden rounded-[1.75rem] border border-neutral-200 bg-white p-4 shadow-sm sm:p-5">
        <div class="pointer-events-none absolute -right-20 -top-24 h-64 w-64 rounded-full bg-blue-100 blur-3xl"></div>
        <div class="pointer-events-none absolute -left-28 bottom-0 h-48 w-48 rounded-full bg-sky-100 blur-3xl"></div>

        <div class="relative flex flex-col gap-4 lg:flex-row lg:items-center lg:justify-between">
          <div class="flex min-w-0 items-start gap-3 sm:gap-4">
            <div class="grid h-14 w-14 shrink-0 place-items-center overflow-hidden rounded-[1.35rem] border border-blue-100 bg-white p-2 shadow-sm ring-4 ring-blue-50 sm:h-16 sm:w-16">
              <img
                v-if="appLogo"
                :src="appLogo"
                :alt="profile.name"
                class="h-full w-full object-contain"
              >
              <div v-else class="grid h-full w-full place-items-center rounded-2xl bg-blue-600 text-white">
                <Icon :icon="profile.icon" class="h-7 w-7" />
              </div>
            </div>

            <div class="min-w-0">
              <div class="mb-2 flex flex-wrap items-center gap-2">
                <span class="inline-flex items-center gap-1.5 rounded-full bg-blue-50 px-3 py-1 text-[11px] font-black uppercase tracking-[0.14em] text-blue-700">
                  <Icon icon="solar:document-text-bold-duotone" class="h-3.5 w-3.5" />
                  {{ profile.badge }}
                </span>

                <span class="rounded-full border border-neutral-200 bg-neutral-50 px-3 py-1 text-[11px] font-bold text-neutral-500">
                  {{ tenantSlug }}
                </span>
              </div>

              <h1 class="text-2xl font-black tracking-tight text-neutral-950 sm:text-3xl">
                {{ profile.title }}
              </h1>

              <p class="mt-1.5 max-w-3xl text-sm font-medium leading-6 text-neutral-500">
                {{ profile.description }}
              </p>
            </div>
          </div>

          <div class="flex flex-wrap gap-2">
            <button
              type="button"
              class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-black text-neutral-700 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
              @click="reloadNews"
            >
              <Icon icon="solar:refresh-bold-duotone" class="h-5 w-5" :class="isLoading ? 'animate-spin' : ''" />
              Refresh
            </button>

            <NuxtLink
              to="/news"
              class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl border border-blue-100 bg-blue-50 px-4 text-sm font-black text-blue-700 transition hover:border-blue-200 hover:bg-blue-100"
            >
              <Icon icon="solar:eye-bold-duotone" class="h-5 w-5" />
              Lihat Publik
            </NuxtLink>

            <button
              type="button"
              class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:-translate-y-0.5 hover:bg-blue-700"
              @click="openCreate"
            >
              <Icon icon="solar:add-circle-bold-duotone" class="h-5 w-5" />
              {{ profile.createLabel }}
            </button>
          </div>
        </div>
      </section>

      <!-- Toolbar -->
      <section class="rounded-[1.5rem] border border-neutral-200 bg-white p-3 shadow-sm sm:p-4">
        <div class="grid gap-3 lg:grid-cols-[1fr_190px_170px]">
          <div class="relative">
            <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-4 text-neutral-400">
              <Icon icon="solar:magnifer-linear" class="h-5 w-5" />
            </div>

            <input
              v-model.trim="search"
              type="text"
              :placeholder="profile.searchPlaceholder"
              class="input-field py-3 pl-12"
            >
          </div>

          <select v-model="selectedCategory" class="input-field">
            <option value="all">Semua Kategori</option>
            <option v-for="category in categoryOptions" :key="category" :value="category">
              {{ category }}
            </option>
          </select>

          <select v-model="selectedStatus" class="input-field">
            <option value="all">Semua Status</option>
            <option value="published">Terbit</option>
            <option value="draft">Draft</option>
            <option value="scheduled">Terjadwal</option>
          </select>
        </div>
      </section>

      <!-- Error -->
      <div v-if="visibleError" class="rounded-3xl border border-red-200 bg-red-50 p-4 text-sm font-bold leading-6 text-red-700">
        {{ visibleError }}
      </div>

      <!-- Loading -->
      <section v-if="isLoading" class="grid gap-3 sm:grid-cols-2 xl:grid-cols-3">
        <div v-for="item in 6" :key="item" class="h-72 animate-pulse rounded-[1.75rem] border border-neutral-200 bg-white p-3">
          <div class="h-36 rounded-[1.35rem] bg-neutral-100"></div>
          <div class="mt-4 h-4 w-2/3 rounded-full bg-neutral-100"></div>
          <div class="mt-3 h-3 w-full rounded-full bg-neutral-100"></div>
          <div class="mt-2 h-3 w-4/5 rounded-full bg-neutral-100"></div>
        </div>
      </section>

      <!-- Empty -->
      <section v-else-if="filteredNews.length === 0" class="rounded-[1.75rem] border border-dashed border-neutral-300 bg-white p-8 text-center shadow-sm">
        <div class="mx-auto grid h-14 w-14 place-items-center rounded-3xl bg-blue-50 text-blue-600">
          <Icon icon="solar:document-add-bold-duotone" class="h-7 w-7" />
        </div>

        <h2 class="mt-4 text-xl font-black text-neutral-950">Belum ada berita</h2>
        <p class="mx-auto mt-2 max-w-md text-sm font-medium leading-6 text-neutral-500">
          {{ profile.emptyDescription }}
        </p>

        <button
          type="button"
          class="mt-5 inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700"
          @click="openCreate"
        >
          <Icon icon="solar:add-circle-bold-duotone" class="h-5 w-5" />
          {{ profile.createLabel }}
        </button>
      </section>

      <!-- News Grid -->
      <section v-else class="grid gap-3 sm:grid-cols-2 xl:grid-cols-3">
        <article
          v-for="item in pagedNews"
          :key="item.id"
          class="group overflow-hidden rounded-[1.75rem] border border-neutral-200 bg-white shadow-sm transition hover:-translate-y-0.5 hover:border-blue-200 hover:shadow-xl hover:shadow-blue-900/5"
        >
          <div class="relative h-40 bg-neutral-100">
            <img v-if="item.cover" :src="item.cover" :alt="item.title" class="h-full w-full object-cover transition duration-500 group-hover:scale-105">

            <div v-else class="flex h-full w-full items-center justify-center bg-gradient-to-br from-blue-50 via-white to-sky-50 text-blue-600">
              <Icon icon="solar:gallery-wide-bold-duotone" class="h-10 w-10" />
            </div>

            <div class="absolute inset-0 bg-gradient-to-t from-neutral-950/55 via-neutral-950/10 to-transparent"></div>

            <div class="absolute left-3 top-3 flex flex-wrap gap-2">
              <span class="rounded-full bg-white/90 px-3 py-1 text-[11px] font-black text-neutral-900 shadow-sm backdrop-blur">
                {{ item.category || profile.defaultCategory }}
              </span>

              <span class="rounded-full px-3 py-1 text-[11px] font-black shadow-sm backdrop-blur" :class="statusClass(item.status)">
                {{ statusLabel(item.status) }}
              </span>
            </div>
          </div>

          <div class="p-4">
            <div class="mb-2 flex items-center justify-between gap-3">
              <p class="truncate text-[11px] font-black uppercase tracking-[0.14em] text-blue-600">
                {{ item.tenantSlug || tenantSlug }}
              </p>
              <p class="shrink-0 text-[11px] font-bold text-neutral-400">{{ formatDate(item.publishedAt) }}</p>
            </div>

            <h3 class="line-clamp-2 text-base font-black leading-6 text-neutral-950 group-hover:text-blue-700">
              {{ item.title }}
            </h3>

            <p class="mt-2 line-clamp-2 text-sm font-medium leading-6 text-neutral-500">
              {{ item.excerpt || plainTextFromContent(item.content).slice(0, 120) || 'Belum ada ringkasan.' }}
            </p>

            <div v-if="item.tags.length" class="mt-3 flex flex-wrap gap-1.5">
              <span v-for="tag in item.tags.slice(0, 3)" :key="tag" class="rounded-full bg-neutral-100 px-2.5 py-1 text-[11px] font-bold text-neutral-500">
                #{{ tag }}
              </span>
            </div>

            <div class="mt-4 flex items-center gap-2 border-t border-neutral-100 pt-3">
              <button type="button" class="action-button" @click="openEdit(item)">
                <Icon icon="solar:pen-2-bold-duotone" class="h-4 w-4" />
                Edit
              </button>

              <button type="button" class="action-button text-red-600 hover:border-red-200 hover:bg-red-50" @click="openDelete(item)">
                <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-4 w-4" />
                Hapus
              </button>

              <NuxtLink :to="publicNewsUrl(item)" class="ms-auto action-button text-blue-700 hover:border-blue-200 hover:bg-blue-50">
                Lihat
                <Icon icon="solar:arrow-right-linear" class="h-4 w-4" />
              </NuxtLink>
            </div>
          </div>
        </article>
      </section>

      <!-- Pagination -->
      <div v-if="hasMore && !isLoading" class="flex justify-center">
        <button
          type="button"
          class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-5 text-sm font-black text-neutral-700 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
          @click="page += 1"
        >
          <Icon icon="solar:alt-arrow-down-bold-duotone" class="h-5 w-5" />
          Muat Lainnya
        </button>
      </div>
    </div>

    <!-- Create / Edit Modal -->
    <Teleport to="body">
      <Transition
        enter-active-class="transition duration-200 ease-out"
        enter-from-class="opacity-0"
        enter-to-class="opacity-100"
        leave-active-class="transition duration-150 ease-in"
        leave-from-class="opacity-100"
        leave-to-class="opacity-0"
      >
        <div v-if="showForm" class="fixed inset-0 z-[9990] overflow-y-auto bg-neutral-950/50 p-3 backdrop-blur-sm sm:p-5">
          <div class="mx-auto min-h-full max-w-6xl py-3">
            <div class="overflow-hidden rounded-[1.75rem] border border-neutral-200 bg-white shadow-2xl">
              <!-- Modal Header -->
              <div class="sticky top-0 z-10 border-b border-neutral-200 bg-white/95 px-4 py-4 backdrop-blur-xl sm:px-5">
                <div class="flex items-start justify-between gap-4">
                  <div class="flex min-w-0 items-start gap-3">
                    <div class="grid h-12 w-12 shrink-0 place-items-center overflow-hidden rounded-2xl border border-blue-100 bg-white p-1.5 ring-4 ring-blue-50">
                      <img v-if="appLogo" :src="appLogo" :alt="profile.name" class="h-full w-full object-contain">
                      <Icon v-else :icon="profile.icon" class="h-6 w-6 text-blue-600" />
                    </div>

                    <div class="min-w-0">
                      <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">{{ profile.name }}</p>
                      <h2 class="text-xl font-black text-neutral-950 sm:text-2xl">
                        {{ formMode === 'create' ? profile.createLabel : 'Edit Berita' }}
                      </h2>
                    </div>
                  </div>

                  <button
                    type="button"
                    class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl text-neutral-500 transition hover:bg-neutral-100 hover:text-neutral-950"
                    aria-label="Tutup formulir"
                    @click="requestCloseForm"
                  >
                    <Icon icon="solar:close-circle-bold-duotone" class="h-6 w-6" />
                  </button>
                </div>

                <!-- Stepper -->
                <div class="mt-4">
                  <div class="mb-3 flex items-center justify-between gap-3">
                    <p class="text-xs font-black uppercase tracking-[0.16em] text-neutral-400">
                      Langkah {{ formStep }} dari {{ formSteps.length }}
                    </p>
                    <p class="text-xs font-black text-blue-600">{{ formStepProgress }}%</p>
                  </div>

                  <div class="h-2 overflow-hidden rounded-full bg-neutral-100">
                    <div class="h-full rounded-full bg-blue-600 transition-all duration-300" :style="{ width: `${formStepProgress}%` }"></div>
                  </div>

                  <div class="mt-4 grid gap-2 sm:grid-cols-4">
                    <button
                      v-for="step in formSteps"
                      :key="step.value"
                      type="button"
                      class="rounded-2xl border p-3 text-left transition"
                      :class="step.value === formStep
                        ? 'border-blue-600 bg-blue-50 ring-4 ring-blue-100'
                        : step.value < formStep
                          ? 'border-emerald-200 bg-emerald-50'
                          : 'border-neutral-200 bg-white hover:bg-neutral-50'"
                      @click="goToFormStep(step.value)"
                    >
                      <div class="flex items-center justify-between gap-2">
                        <div
                          class="grid h-8 w-8 place-items-center rounded-xl"
                          :class="step.value === formStep
                            ? 'bg-white text-blue-600'
                            : step.value < formStep
                              ? 'bg-white text-emerald-600'
                              : 'bg-neutral-100 text-neutral-400'"
                        >
                          <Icon :icon="step.value < formStep ? 'solar:check-circle-bold-duotone' : step.icon" class="h-4 w-4" />
                        </div>
                        <span class="text-xs font-black text-neutral-400">0{{ step.value }}</span>
                      </div>

                      <p class="mt-2 text-sm font-black text-neutral-950">{{ step.title }}</p>
                      <p class="mt-1 text-xs font-semibold leading-5 text-neutral-500">{{ step.description }}</p>
                    </button>
                  </div>
                </div>
              </div>

              <form class="p-4 sm:p-5" @submit.prevent="submitForm">
                <!-- Step 1: Informasi -->
                <div v-if="formStep === 1" class="space-y-4">
                  <StepIntro
                    icon="solar:document-add-bold-duotone"
                    title="Informasi Berita"
                    description="Tulis identitas utama berita agar mudah ditemukan dan nyaman dibaca publik."
                  />

                  <div class="grid gap-4 lg:grid-cols-2">
                    <div>
                      <label class="label-field">Judul</label>
                      <input
                        v-model.trim="form.title"
                        type="text"
                        required
                        :placeholder="profile.titlePlaceholder"
                        class="input-field"
                        @input="syncSlugFromTitle"
                      >
                      <p v-if="formTouched && !form.title.trim()" class="mt-2 text-xs font-bold text-red-600">Judul wajib diisi.</p>
                    </div>

                    <div>
                      <label class="label-field">Alamat Berita</label>
                      <input
                        v-model.trim="form.slug"
                        type="text"
                        placeholder="contoh-judul-berita"
                        class="input-field"
                        @input="manualSlugEdited = true"
                      >
                      <p class="mt-2 text-xs font-semibold leading-5 text-neutral-500">
                        Dipakai untuk tautan publik: <span class="font-black text-blue-600">/news?detail={{ form.slug || 'judul-berita' }}</span>
                      </p>
                    </div>

                    <div>
                      <label class="label-field">Kategori</label>
                      <input
                        v-model.trim="form.category"
                        list="news-category-options"
                        type="text"
                        placeholder="Contoh: Informasi Desa"
                        class="input-field"
                      >
                      <datalist id="news-category-options">
                        <option v-for="category in categoryOptions" :key="category" :value="category" />
                      </datalist>
                    </div>

                    <div>
                      <label class="label-field">Status</label>
                      <select v-model="form.status" class="input-field">
                        <option value="published">Terbit</option>
                        <option value="draft">Draft</option>
                        <option value="scheduled">Terjadwal</option>
                      </select>
                    </div>

                    <div>
                      <label class="label-field">Tanggal Terbit</label>
                      <input v-model="publishedAtLocal" type="datetime-local" class="input-field">
                    </div>

                    <div>
                      <label class="label-field">Tag</label>
                      <div class="rounded-2xl border border-neutral-200 bg-neutral-50 p-2 transition focus-within:border-blue-600 focus-within:bg-white focus-within:ring-4 focus-within:ring-blue-100">
                        <div class="flex min-h-[42px] flex-wrap items-center gap-2">
                          <span
                            v-for="tag in form.tags"
                            :key="tag"
                            class="inline-flex items-center gap-1.5 rounded-full bg-blue-600 px-3 py-1.5 text-xs font-black text-white"
                          >
                            #{{ tag }}
                            <button type="button" class="grid h-4 w-4 place-items-center rounded-full text-white/70 hover:text-white" @click="removeTag(tag)">
                              <Icon icon="solar:close-circle-bold-duotone" class="h-4 w-4" />
                            </button>
                          </span>

                          <input
                            v-model.trim="form.tagInput"
                            type="text"
                            placeholder="Ketik tag lalu Enter"
                            class="min-w-[180px] flex-1 border-0 bg-transparent px-2 py-2 text-sm font-semibold text-neutral-800 outline-none placeholder:text-neutral-400"
                            @keydown="handleTagKeydown"
                            @blur="addTagFromInput"
                            @paste="onPasteTags"
                          >
                        </div>
                      </div>
                    </div>
                  </div>

                  <div>
                    <label class="label-field">Ringkasan</label>
                    <textarea
                      v-model.trim="form.excerpt"
                      rows="3"
                      :placeholder="profile.excerptPlaceholder"
                      class="input-field resize-y leading-6"
                    ></textarea>
                  </div>
                </div>

                <!-- Step 2: Gambar -->
                <div v-if="formStep === 2" class="space-y-4">
                  <StepIntro
                    icon="solar:gallery-wide-bold-duotone"
                    title="Gambar Utama"
                    description="Tambahkan gambar agar berita terlihat lebih menarik di halaman publik."
                  />

                  <div class="grid gap-5 lg:grid-cols-[1fr_320px]">
                    <div class="space-y-4">
                      <div class="grid gap-3 sm:grid-cols-2">
                        <button type="button" class="select-card" :class="coverMode === 'upload' ? 'select-card-active' : ''" @click="setCoverMode('upload')">
                          <Icon icon="solar:upload-square-bold-duotone" class="h-6 w-6 text-blue-600" />
                          <span>Upload dari Perangkat</span>
                          <small>Pilih gambar dari laptop atau ponsel.</small>
                        </button>

                        <button type="button" class="select-card" :class="coverMode === 'url' ? 'select-card-active' : ''" @click="setCoverMode('url')">
                          <Icon icon="solar:link-bold-duotone" class="h-6 w-6 text-blue-600" />
                          <span>Gunakan Tautan</span>
                          <small>Tempel tautan gambar yang sudah tersedia.</small>
                        </button>
                      </div>

                      <div v-if="coverMode === 'upload'" class="rounded-[1.5rem] border border-neutral-200 bg-white p-4">
                        <input ref="coverInput" type="file" accept="image/jpeg,image/jpg,image/png,image/webp" class="hidden" @change="onPickCover">

                        <button
                          type="button"
                          class="flex w-full flex-col items-center justify-center rounded-[1.35rem] border border-dashed border-neutral-300 bg-neutral-50 px-5 py-8 text-center transition hover:border-blue-300 hover:bg-blue-50"
                          @click="triggerPickCover"
                        >
                          <div class="grid h-14 w-14 place-items-center rounded-3xl bg-white text-blue-600 shadow-sm">
                            <Icon icon="solar:cloud-upload-bold-duotone" class="h-7 w-7" />
                          </div>
                          <p class="mt-4 text-sm font-black text-neutral-950">Pilih gambar utama</p>
                          <p class="mt-1 text-xs font-semibold leading-5 text-neutral-500">JPG, PNG, atau WebP. Maksimal 5 MB.</p>
                        </button>

                        <div v-if="coverFile" class="mt-4 flex items-center justify-between gap-3 rounded-2xl border border-neutral-200 bg-neutral-50 px-4 py-3">
                          <div class="min-w-0">
                            <p class="truncate text-sm font-black text-neutral-800">{{ coverFile.name }}</p>
                            <p class="text-xs font-semibold text-neutral-500">{{ formatFileSize(coverFile.size) }}</p>
                          </div>

                          <button type="button" class="grid h-9 w-9 place-items-center rounded-xl text-red-600 transition hover:bg-red-50" @click="clearCover">
                            <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-5 w-5" />
                          </button>
                        </div>
                      </div>

                      <div v-else class="rounded-[1.5rem] border border-neutral-200 bg-white p-4">
                        <label class="label-field">Tautan Gambar</label>
                        <input v-model.trim="form.cover" type="url" placeholder="https://example.com/image.jpg" class="input-field">
                      </div>
                    </div>

                    <aside class="overflow-hidden rounded-[1.5rem] border border-neutral-200 bg-white shadow-sm">
                      <div class="h-56 bg-neutral-100">
                        <img v-if="coverPreviewUrl" :src="coverPreviewUrl" alt="Preview gambar utama" class="h-full w-full object-cover">
                        <div v-else class="flex h-full w-full items-center justify-center bg-gradient-to-br from-blue-50 via-white to-sky-50 text-blue-600">
                          <Icon icon="solar:gallery-wide-bold-duotone" class="h-12 w-12" />
                        </div>
                      </div>
                      <div class="p-4">
                        <p class="text-sm font-black text-neutral-950">Preview Gambar</p>
                        <p class="mt-1 text-xs font-semibold leading-5 text-neutral-500">Gambar ini akan tampil di kartu berita dan halaman detail.</p>
                      </div>
                    </aside>
                  </div>
                </div>

                <!-- Step 3: Konten -->
                <div v-if="formStep === 3" class="space-y-4">
                  <StepIntro
                    icon="solar:pen-new-square-bold-duotone"
                    title="Konten Berita"
                    description="Tulis isi berita dengan format yang rapi, lengkap dengan tabel, gambar, video, dokumen, peta, dan tautan."
                  />

                  <ClientOnly>
                    <div class="overflow-hidden rounded-[1.5rem] border border-neutral-200 bg-white">
                      <input ref="editorImageInput" type="file" accept="image/jpeg,image/jpg,image/png,image/webp" class="hidden" @change="onPickEditorImage">

                      <div class="sticky top-0 z-[2] border-b border-neutral-200 bg-neutral-50/95 p-3 backdrop-blur">
                        <div class="flex flex-wrap gap-1.5">
                          <button
                            v-for="button in editorButtons"
                            :key="button.label"
                            type="button"
                            class="toolbar-button"
                            :class="button.active() ? 'toolbar-button-active' : ''"
                            @click="button.action"
                          >
                            <Icon :icon="button.icon" class="h-4 w-4" />
                            {{ button.label }}
                          </button>

                          <span class="mx-1 hidden h-8 w-px bg-neutral-200 sm:block"></span>

                          <button type="button" class="toolbar-button" @click="openLinkModal">
                            <Icon icon="solar:link-bold-duotone" class="h-4 w-4" />
                            Link
                          </button>

                          <button type="button" class="toolbar-button" @click="removeEditorLink">
                            <Icon icon="solar:link-broken-bold-duotone" class="h-4 w-4" />
                            Lepas Link
                          </button>

                          <button type="button" class="toolbar-button" @click="insertTable">
                            <Icon icon="solar:table-2-bold-duotone" class="h-4 w-4" />
                            Tabel
                          </button>

                          <button type="button" class="toolbar-button" @click="addTableRow">
                            <Icon icon="solar:add-square-bold-duotone" class="h-4 w-4" />
                            Baris
                          </button>

                          <button type="button" class="toolbar-button" @click="addTableColumn">
                            <Icon icon="solar:add-circle-bold-duotone" class="h-4 w-4" />
                            Kolom
                          </button>

                          <button type="button" class="toolbar-button" @click="deleteTable">
                            <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-4 w-4" />
                            Hapus Tabel
                          </button>

                          <span class="mx-1 hidden h-8 w-px bg-neutral-200 sm:block"></span>

                          <button type="button" class="toolbar-button" @click="triggerEditorImageUpload">
                            <Icon icon="solar:upload-square-bold-duotone" class="h-4 w-4" />
                            Upload Gambar
                          </button>

                          <button type="button" class="toolbar-button" @click="openMediaModal('image-url')">
                            <Icon icon="solar:gallery-wide-bold-duotone" class="h-4 w-4" />
                            Gambar Link
                          </button>

                          <button type="button" class="toolbar-button" @click="openMediaModal('youtube')">
                            <Icon icon="solar:video-frame-play-horizontal-bold-duotone" class="h-4 w-4" />
                            YouTube
                          </button>

                          <button type="button" class="toolbar-button" @click="openMediaModal('pdf')">
                            <Icon icon="solar:file-text-bold-duotone" class="h-4 w-4" />
                            PDF
                          </button>

                          <button type="button" class="toolbar-button" @click="openMediaModal('map')">
                            <Icon icon="solar:map-point-bold-duotone" class="h-4 w-4" />
                            Maps
                          </button>
                        </div>
                      </div>

                      <EditorContent v-if="editor" :editor="editor" class="editor-content min-h-[420px] p-4" />
                    </div>
                  </ClientOnly>
                </div>

                <!-- Step 4: Review -->
                <div v-if="formStep === 4" class="space-y-4">
                  <StepIntro
                    icon="solar:clipboard-check-bold-duotone"
                    title="Review & Simpan"
                    description="Periksa kembali berita sebelum ditampilkan atau disimpan sebagai draft."
                  />

                  <div class="grid gap-5 lg:grid-cols-[320px_1fr]">
                    <div class="overflow-hidden rounded-[1.5rem] border border-neutral-200 bg-white shadow-sm">
                      <div class="h-52 bg-neutral-100">
                        <img v-if="coverPreviewUrl" :src="coverPreviewUrl" alt="Preview cover" class="h-full w-full object-cover">
                        <div v-else class="flex h-full w-full items-center justify-center text-neutral-400">
                          <Icon icon="solar:gallery-wide-bold-duotone" class="h-10 w-10" />
                        </div>
                      </div>

                      <div class="p-4">
                        <span class="rounded-full bg-blue-600 px-3 py-1 text-xs font-black text-white">{{ form.category }}</span>
                        <h3 class="mt-4 text-lg font-black leading-7 text-neutral-950">{{ form.title || 'Judul berita' }}</h3>
                        <p class="mt-2 text-sm font-medium leading-6 text-neutral-500">{{ form.excerpt || 'Ringkasan berita akan tampil di sini.' }}</p>
                      </div>
                    </div>

                    <div class="rounded-[1.5rem] border border-neutral-200 bg-white p-4 shadow-sm">
                      <div class="grid gap-3">
                        <div v-for="row in reviewRows" :key="row.label" class="flex items-center justify-between gap-4 rounded-2xl border border-neutral-200 bg-neutral-50 px-4 py-3">
                          <span class="text-sm font-bold text-neutral-500">{{ row.label }}</span>
                          <span class="min-w-0 truncate text-right text-sm font-black text-neutral-950">{{ row.value }}</span>
                        </div>
                      </div>

                      <div v-if="form.slug" class="mt-4 rounded-2xl border border-blue-100 bg-blue-50 p-4">
                        <p class="text-xs font-black uppercase tracking-[0.14em] text-blue-700">Tautan Publik</p>
                        <div class="mt-2 flex items-center gap-2">
                          <p class="min-w-0 flex-1 truncate text-sm font-bold text-blue-900">{{ publicUrlFromSlug(form.slug) }}</p>
                          <button type="button" class="grid h-9 w-9 place-items-center rounded-xl bg-white text-blue-700 transition hover:bg-blue-100" @click="copyPublicLink(form.slug)">
                            <Icon icon="solar:copy-bold-duotone" class="h-4 w-4" />
                          </button>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>

                <div v-if="formError" class="mt-5 rounded-2xl border border-red-200 bg-red-50 px-4 py-3 text-sm font-bold text-red-700">
                  {{ formError }}
                </div>

                <!-- Footer Navigation -->
                <div class="mt-5 flex flex-col-reverse gap-3 border-t border-neutral-200 pt-5 sm:flex-row sm:items-center sm:justify-between">
                  <button
                    type="button"
                    class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-5 text-sm font-black text-neutral-700 transition hover:bg-neutral-50 disabled:cursor-not-allowed disabled:opacity-50"
                    :disabled="formStep === 1 || saving || imageUploading"
                    @click="prevFormStep"
                  >
                    <Icon icon="solar:arrow-left-linear" class="h-5 w-5" />
                    Kembali
                  </button>

                  <div class="flex flex-col-reverse gap-3 sm:flex-row">
                    <button
                      type="button"
                      class="inline-flex h-11 items-center justify-center rounded-2xl border border-neutral-200 bg-white px-5 text-sm font-black text-neutral-700 transition hover:bg-neutral-50"
                      @click="requestCloseForm"
                    >
                      Batal
                    </button>

                    <button
                      v-if="formStep < formSteps.length"
                      type="button"
                      class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-5 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700"
                      @click="nextFormStep"
                    >
                      Lanjutkan
                      <Icon icon="solar:arrow-right-linear" class="h-5 w-5" />
                    </button>

                    <button
                      v-else
                      type="submit"
                      :disabled="saving || imageUploading"
                      class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-5 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700 disabled:cursor-not-allowed disabled:opacity-60"
                    >
                      <Icon
                        :icon="saving || imageUploading ? 'solar:refresh-bold-duotone' : 'solar:diskette-bold-duotone'"
                        class="h-5 w-5"
                        :class="saving || imageUploading ? 'animate-spin' : ''"
                      />
                      {{ imageUploading ? 'Mengunggah gambar...' : saving ? 'Menyimpan...' : formMode === 'create' ? 'Simpan Berita' : 'Simpan Perubahan' }}
                    </button>
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>

    <!-- Insert Link Modal -->
    <Teleport to="body">
      <Transition enter-active-class="transition duration-200 ease-out" enter-from-class="opacity-0" enter-to-class="opacity-100" leave-active-class="transition duration-150 ease-in" leave-from-class="opacity-100" leave-to-class="opacity-0">
        <div v-if="showLinkModal" class="fixed inset-0 z-[9993] flex items-center justify-center bg-neutral-950/50 p-4 backdrop-blur-sm">
          <div class="w-full max-w-lg rounded-[1.75rem] border border-neutral-200 bg-white p-5 shadow-2xl">
            <div class="flex items-start justify-between gap-4">
              <div>
                <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">Tautan</p>
                <h2 class="mt-1 text-xl font-black text-neutral-950">Tambahkan Link</h2>
              </div>

              <button type="button" class="grid h-10 w-10 place-items-center rounded-2xl text-neutral-500 transition hover:bg-neutral-100 hover:text-neutral-950" @click="closeLinkModal">
                <Icon icon="solar:close-circle-bold-duotone" class="h-6 w-6" />
              </button>
            </div>

            <div class="mt-5 space-y-4">
              <div>
                <label class="label-field">Tautan</label>
                <input v-model.trim="linkForm.url" type="url" placeholder="https://example.com" class="input-field">
              </div>

              <div>
                <label class="label-field">Teks Link</label>
                <input v-model.trim="linkForm.text" type="text" placeholder="Opsional, dipakai jika belum memilih teks di editor" class="input-field">
              </div>

              <div v-if="linkError" class="rounded-2xl border border-red-200 bg-red-50 px-4 py-3 text-sm font-bold text-red-700">
                {{ linkError }}
              </div>
            </div>

            <div class="mt-6 flex flex-col-reverse gap-3 sm:flex-row sm:justify-end">
              <button type="button" class="modal-secondary-button" @click="closeLinkModal">Batal</button>
              <button type="button" class="modal-primary-button" @click="confirmInsertLink">
                <Icon icon="solar:add-circle-bold-duotone" class="h-5 w-5" />
                Tambahkan
              </button>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>

    <!-- Insert Media Modal -->
    <Teleport to="body">
      <Transition enter-active-class="transition duration-200 ease-out" enter-from-class="opacity-0" enter-to-class="opacity-100" leave-active-class="transition duration-150 ease-in" leave-from-class="opacity-100" leave-to-class="opacity-0">
        <div v-if="showMediaModal" class="fixed inset-0 z-[9992] flex items-center justify-center bg-neutral-950/50 p-4 backdrop-blur-sm">
          <div class="w-full max-w-xl rounded-[1.75rem] border border-neutral-200 bg-white p-5 shadow-2xl">
            <div class="flex items-start justify-between gap-4">
              <div>
                <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">Media</p>
                <h2 class="mt-1 text-xl font-black text-neutral-950">{{ mediaTitle }}</h2>
              </div>

              <button type="button" class="grid h-10 w-10 place-items-center rounded-2xl text-neutral-500 transition hover:bg-neutral-100 hover:text-neutral-950" @click="closeMediaModal">
                <Icon icon="solar:close-circle-bold-duotone" class="h-6 w-6" />
              </button>
            </div>

            <div class="mt-5 space-y-4">
              <div>
                <label class="label-field">Tautan atau Kode Semat</label>
                <textarea
                  v-model.trim="mediaForm.url"
                  rows="4"
                  :placeholder="mediaPlaceholder"
                  class="input-field resize-y leading-6"
                ></textarea>
              </div>

              <div>
                <label class="label-field">Judul / Keterangan</label>
                <input v-model.trim="mediaForm.title" type="text" placeholder="Opsional" class="input-field">
              </div>

              <div v-if="mediaError" class="rounded-2xl border border-red-200 bg-red-50 px-4 py-3 text-sm font-bold text-red-700">
                {{ mediaError }}
              </div>
            </div>

            <div class="mt-6 flex flex-col-reverse gap-3 sm:flex-row sm:justify-end">
              <button type="button" class="modal-secondary-button" @click="closeMediaModal">Batal</button>
              <button type="button" class="modal-primary-button" @click="confirmInsertMedia">
                <Icon icon="solar:add-circle-bold-duotone" class="h-5 w-5" />
                Tambahkan
              </button>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>

    <!-- Close Guard Modal -->
    <Teleport to="body">
      <Transition enter-active-class="transition duration-200 ease-out" enter-from-class="opacity-0" enter-to-class="opacity-100" leave-active-class="transition duration-150 ease-in" leave-from-class="opacity-100" leave-to-class="opacity-0">
        <div v-if="showCloseGuard" class="fixed inset-0 z-[9994] flex items-center justify-center bg-neutral-950/50 p-4 backdrop-blur-sm">
          <div class="w-full max-w-md rounded-[1.75rem] border border-neutral-200 bg-white p-5 shadow-2xl">
            <div class="grid h-14 w-14 place-items-center rounded-3xl bg-amber-50 text-amber-600">
              <Icon icon="solar:shield-warning-bold-duotone" class="h-7 w-7" />
            </div>

            <h2 class="mt-5 text-xl font-black text-neutral-950">Tutup Formulir?</h2>
            <p class="mt-2 text-sm font-medium leading-6 text-neutral-500">
              Perubahan yang belum disimpan akan hilang. Simpan terlebih dahulu jika data sudah benar.
            </p>

            <div class="mt-6 flex flex-col-reverse gap-3 sm:flex-row sm:justify-end">
              <button type="button" class="modal-secondary-button" @click="showCloseGuard = false">Lanjut Edit</button>
              <button type="button" class="modal-primary-button bg-red-600 shadow-red-600/20 hover:bg-red-700" @click="forceCloseForm">
                Tutup
              </button>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>

    <!-- Delete Modal -->
    <Teleport to="body">
      <Transition enter-active-class="transition duration-200 ease-out" enter-from-class="opacity-0" enter-to-class="opacity-100" leave-active-class="transition duration-150 ease-in" leave-from-class="opacity-100" leave-to-class="opacity-0">
        <div v-if="showDelete" class="fixed inset-0 z-[9991] flex items-center justify-center bg-neutral-950/50 p-4 backdrop-blur-sm">
          <div class="w-full max-w-md rounded-[1.75rem] border border-neutral-200 bg-white p-5 shadow-2xl">
            <div class="grid h-14 w-14 place-items-center rounded-3xl bg-red-50 text-red-600">
              <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-7 w-7" />
            </div>

            <h2 class="mt-5 text-xl font-black text-neutral-950">Hapus Berita?</h2>
            <p class="mt-2 text-sm font-medium leading-6 text-neutral-500">
              Berita <strong class="text-neutral-900">{{ selectedNews?.title }}</strong> akan dihapus dari daftar.
            </p>

            <div class="mt-6 flex flex-col-reverse gap-3 sm:flex-row sm:justify-end">
              <button type="button" class="modal-secondary-button" @click="showDelete = false">Batal</button>
              <button
                type="button"
                :disabled="deleting"
                class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-red-600 px-5 text-sm font-black text-white transition hover:bg-red-700 disabled:cursor-not-allowed disabled:opacity-60"
                @click="confirmDelete"
              >
                <Icon :icon="deleting ? 'solar:refresh-bold-duotone' : 'solar:trash-bin-trash-bold-duotone'" class="h-5 w-5" :class="deleting ? 'animate-spin' : ''" />
                {{ deleting ? 'Menghapus...' : 'Hapus' }}
              </button>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>
  </section>
</template>

<script setup lang="ts">
import { Icon } from '@iconify/vue'
import { Editor, EditorContent } from '@tiptap/vue-3'
import StarterKit from '@tiptap/starter-kit'
import Image from '@tiptap/extension-image'
import Youtube from '@tiptap/extension-youtube'
import Link from '@tiptap/extension-link'
import Underline from '@tiptap/extension-underline'
import { Table } from '@tiptap/extension-table'
import TableRow from '@tiptap/extension-table-row'
import TableCell from '@tiptap/extension-table-cell'
import TableHeader from '@tiptap/extension-table-header'
import { Node, mergeAttributes } from '@tiptap/core'
import { computed, defineComponent, h, nextTick, onBeforeUnmount, onMounted, reactive, ref, shallowRef, unref, watch } from 'vue'
import { useHead, useRequestURL, useRuntimeConfig, useSeoMeta } from 'nuxt/app'
import { useNews } from '../../composables/data/useNews'
import { useCloudinaryUpload } from '../../composables/useCloudinaryUpload'

definePageMeta({
  layout: 'app',
  layoutProps: {
    title: 'Berita Informasi'
  }
})

type Mode = 'martopuro' | 'obayan'
type ToastType = 'success' | 'error'
type NewsStatus = 'published' | 'draft' | 'scheduled'

type NewsContent =
  | string
  | {
      kind?: string
      json?: any
      html?: string
    }

type NewsItem = {
  id: string
  title: string
  slug: string
  excerpt: string
  cover: string
  category: string
  tags: string[]
  status: NewsStatus
  publishedAt: number
  readTime: number
  tenantSlug?: string
  content?: NewsContent
  createdAt?: number
  updatedAt?: number
}

type NewsPayload = {
  tenantSlug: string
  title: string
  slug: string
  excerpt: string
  cover: string
  category: string
  tags: string[]
  status: NewsStatus
  publishedAt: number
  readTime: number
  content: {
    kind: 'tiptap'
    json: any
    html: string
  }
}

type CoverMode = 'upload' | 'url'
type MediaType = 'image-url' | 'pdf' | 'youtube' | 'map'

const config = useRuntimeConfig()
const requestUrl = useRequestURL()
const newsSQL = useNews() as any
const editor = shallowRef<Editor | null>(null)

const search = ref('')
const selectedCategory = ref('all')
const selectedStatus = ref<'all' | NewsStatus>('all')
const page = ref(1)
const pageSize = 12

const showForm = ref(false)
const showDelete = ref(false)
const showCloseGuard = ref(false)
const showLinkModal = ref(false)
const showMediaModal = ref(false)
const formMode = ref<'create' | 'edit'>('create')
const saving = ref(false)
const deleting = ref(false)
const formError = ref('')
const selectedNews = ref<NewsItem | null>(null)
const manualSlugEdited = ref(false)
const formStep = ref(1)
const formTouched = ref(false)

const coverMode = ref<CoverMode>('upload')
const coverInput = ref<HTMLInputElement | null>(null)
const coverFile = shallowRef<File | null>(null)
const coverLocalPreview = ref('')
const editorImageInput = ref<HTMLInputElement | null>(null)

const mediaType = ref<MediaType>('image-url')
const mediaError = ref('')
const linkError = ref('')

const { uploading: imageUploading, uploadImage } = useCloudinaryUpload()

const toast = reactive({
  show: false,
  type: 'success' as ToastType,
  title: '',
  message: ''
})

let toastTimer: ReturnType<typeof setTimeout> | null = null

const form = reactive({
  title: '',
  slug: '',
  excerpt: '',
  cover: '',
  category: '',
  tags: [] as string[],
  tagInput: '',
  status: 'published' as NewsStatus,
  publishedAt: Date.now()
})

const mediaForm = reactive({
  url: '',
  title: ''
})

const linkForm = reactive({
  url: '',
  text: ''
})

const formSteps = [
  { value: 1, title: 'Informasi', description: 'Judul & kategori', icon: 'solar:document-add-bold-duotone' },
  { value: 2, title: 'Gambar', description: 'Cover berita', icon: 'solar:gallery-wide-bold-duotone' },
  { value: 3, title: 'Konten', description: 'Isi artikel', icon: 'solar:pen-new-square-bold-duotone' },
  { value: 4, title: 'Review', description: 'Cek & simpan', icon: 'solar:clipboard-check-bold-duotone' }
]

const formStepProgress = computed(() => Math.round((formStep.value / formSteps.length) * 100))

const coverPreviewUrl = computed(() => {
  if (coverMode.value === 'upload') return coverLocalPreview.value || form.cover
  return form.cover
})

const hostname = computed(() => String(requestUrl.hostname || '').replace(/^www\./, '').toLowerCase())
const clientName = computed(() => String(config.public.clientName || '').trim().toLowerCase())

const mode = computed<Mode>(() => {
  if (hostname.value.includes('martopuro')) return 'martopuro'
  if (clientName.value.includes('martopuro')) return 'martopuro'
  return 'obayan'
})

const isMartopuro = computed(() => mode.value === 'martopuro')

const tenantSlug = computed(() => {
  if (isMartopuro.value) return 'martopuro'
  return String(config.public.clientName || 'obayan').trim().toLowerCase()
})

const appLogo = computed(() => {
  return String(
    config.public.appLogo ||
    config.public.logoUrl ||
    config.public.siteLogo ||
    config.public.favicon ||
    ''
  ).trim()
})

const profile = computed(() => {
  if (isMartopuro.value) {
    return {
      name: 'Desa Martopuro',
      title: 'Berita Informasi Desa',
      badge: 'Village News',
      icon: 'solar:buildings-3-bold-duotone',
      description: 'Kelola berita, agenda, pengumuman, layanan publik, dan informasi resmi desa dengan tampilan yang rapi.',
      createLabel: 'Tulis Berita Desa',
      searchPlaceholder: 'Cari berita desa, pengumuman, layanan...',
      emptyDescription: 'Belum ada berita desa. Mulai publikasikan informasi resmi, kegiatan, atau pengumuman untuk warga.',
      defaultCategory: 'Informasi Desa',
      titlePlaceholder: 'Contoh: Pemerintah Desa Martopuro Mengadakan Kegiatan Kerja Bakti',
      excerptPlaceholder: 'Tulis ringkasan singkat agar pembaca mudah memahami isi berita...',
      publicBase: '/news',
      brand: '#2563eb',
      brandSoft: '#eff6ff',
      brandRing: 'rgba(37, 99, 235, 0.14)',
      categories: ['Informasi Desa', 'Pengumuman', 'Kegiatan Desa', 'Layanan Publik', 'Pembangunan', 'APBDes', 'UMKM', 'Kesehatan', 'Pendidikan']
    }
  }

  return {
    name: 'Obayan',
    title: 'Berita Informasi Obayan',
    badge: 'Platform News',
    icon: 'solar:widget-5-bold-duotone',
    description: 'Kelola berita, update produk, artikel edukasi, case study, dan informasi resmi platform dengan layout yang bersih.',
    createLabel: 'Tulis Artikel',
    searchPlaceholder: 'Cari artikel, update produk, tutorial...',
    emptyDescription: 'Belum ada artikel. Mulai publikasikan update produk, tutorial, atau informasi resmi Obayan.',
    defaultCategory: 'Update Produk',
    titlePlaceholder: 'Contoh: Obayan Merilis Modul Website Desa dan Pesantren',
    excerptPlaceholder: 'Tulis ringkasan artikel agar pembaca memahami poin utamanya...',
    publicBase: '/news',
    brand: '#2563eb',
    brandSoft: '#eff6ff',
    brandRing: 'rgba(37, 99, 235, 0.14)',
    categories: ['Update Produk', 'Pengumuman', 'Tutorial', 'Case Study', 'Edukasi', 'Website', 'SIAKAD', 'CBT', 'Pembayaran']
  }
})

const themeVars = computed<Record<string, string>>(() => ({
  '--brand': profile.value.brand,
  '--brand-soft': profile.value.brandSoft,
  '--brand-ring': profile.value.brandRing
}))

const categoryOptions = computed(() => profile.value.categories)

const rawItems = computed<any[]>(() => {
  const direct = unref(newsSQL.items) || unref(newsSQL.news) || unref(newsSQL.rows) || unref(newsSQL.data)
  if (Array.isArray(direct)) return direct
  if (Array.isArray(direct?.data)) return direct.data
  return []
})

const isLoading = computed(() => Boolean(unref(newsSQL.pending) || unref(newsSQL.loading)))

const visibleError = computed(() => {
  const value = unref(newsSQL.error) || unref(newsSQL.errorMessage) || ''
  if (!value) return ''
  if (typeof value === 'string') return value
  return value?.message || 'Terjadi kesalahan saat memuat berita.'
})

const normalizedNews = computed<NewsItem[]>(() => {
  return rawItems.value
    .map(normalizeNewsItem)
    .filter((item) => {
      if (!item.id) return false
      const itemTenant = String(item.tenantSlug || tenantSlug.value).toLowerCase()
      return itemTenant === tenantSlug.value || !item.tenantSlug
    })
    .sort((a, b) => Number(b.publishedAt || 0) - Number(a.publishedAt || 0))
})

const filteredNews = computed(() => {
  const keyword = search.value.trim().toLowerCase()

  return normalizedNews.value.filter((item) => {
    const matchSearch =
      !keyword ||
      [item.title, item.slug, item.excerpt, item.category, ...item.tags]
        .join(' ')
        .toLowerCase()
        .includes(keyword)

    const matchCategory = selectedCategory.value === 'all' || item.category === selectedCategory.value
    const matchStatus = selectedStatus.value === 'all' || item.status === selectedStatus.value

    return matchSearch && matchCategory && matchStatus
  })
})

const pagedNews = computed(() => filteredNews.value.slice(0, page.value * pageSize))
const hasMore = computed(() => pagedNews.value.length < filteredNews.value.length)

const publishedAtLocal = computed({
  get() {
    const date = new Date(form.publishedAt || Date.now())
    const pad = (value: number) => String(value).padStart(2, '0')
    return `${date.getFullYear()}-${pad(date.getMonth() + 1)}-${pad(date.getDate())}T${pad(date.getHours())}:${pad(date.getMinutes())}`
  },
  set(value: string) {
    const time = value ? new Date(value).getTime() : Date.now()
    if (!Number.isNaN(time)) form.publishedAt = time
  }
})

const readTime = computed(() => estimateReadTime(editor.value?.getText() || ''))

const reviewRows = computed(() => [
  { label: 'Alamat Berita', value: form.slug || '-' },
  { label: 'Status', value: statusLabel(form.status) },
  { label: 'Tanggal Terbit', value: formatDate(form.publishedAt) },
  { label: 'Tag', value: form.tags.join(', ') || '-' },
  { label: 'Gambar', value: coverMode.value === 'upload' ? 'Upload Perangkat' : 'Tautan Gambar' },
  { label: 'Estimasi Baca', value: `${readTime.value} menit` }
])

const mediaTitle = computed(() => {
  if (mediaType.value === 'image-url') return 'Tambahkan Gambar'
  if (mediaType.value === 'pdf') return 'Tambahkan PDF'
  if (mediaType.value === 'youtube') return 'Tambahkan YouTube'
  return 'Tambahkan Maps'
})

const mediaPlaceholder = computed(() => {
  if (mediaType.value === 'image-url') return 'https://example.com/image.jpg'
  if (mediaType.value === 'pdf') return 'https://example.com/file.pdf atau kode semat PDF'
  if (mediaType.value === 'youtube') return 'https://www.youtube.com/watch?v=...'
  return 'Tempel tautan atau kode semat Google Maps'
})

const editorButtons = computed(() => {
  const ed = editor.value
  if (!ed) return []

  return [
    { label: 'P', icon: 'solar:text-bold-duotone', active: () => ed.isActive('paragraph'), action: () => ed.chain().focus().setParagraph().run() },
    { label: 'H1', icon: 'solar:text-square-bold-duotone', active: () => ed.isActive('heading', { level: 1 }), action: () => ed.chain().focus().toggleHeading({ level: 1 }).run() },
    { label: 'H2', icon: 'solar:text-square-2-bold-duotone', active: () => ed.isActive('heading', { level: 2 }), action: () => ed.chain().focus().toggleHeading({ level: 2 }).run() },
    { label: 'H3', icon: 'solar:text-square-bold-duotone', active: () => ed.isActive('heading', { level: 3 }), action: () => ed.chain().focus().toggleHeading({ level: 3 }).run() },
    { label: 'Bold', icon: 'solar:text-bold-bold-duotone', active: () => ed.isActive('bold'), action: () => ed.chain().focus().toggleBold().run() },
    { label: 'Italic', icon: 'solar:text-italic-bold-duotone', active: () => ed.isActive('italic'), action: () => ed.chain().focus().toggleItalic().run() },
    { label: 'List', icon: 'solar:list-bold-duotone', active: () => ed.isActive('bulletList'), action: () => ed.chain().focus().toggleBulletList().run() },
    { label: 'Number', icon: 'solar:list-down-bold-duotone', active: () => ed.isActive('orderedList'), action: () => ed.chain().focus().toggleOrderedList().run() },
    { label: 'Quote', icon: 'solar:quote-up-bold-duotone', active: () => ed.isActive('blockquote'), action: () => ed.chain().focus().toggleBlockquote().run() },
    { label: 'Undo', icon: 'solar:undo-left-bold-duotone', active: () => false, action: () => ed.chain().focus().undo().run() },
    { label: 'Redo', icon: 'solar:undo-right-bold-duotone', active: () => false, action: () => ed.chain().focus().redo().run() }
  ]
})

watch([search, selectedCategory, selectedStatus], () => {
  page.value = 1
})

useSeoMeta({
  title: () => `${profile.value.title} · ${profile.value.name}`,
  description: () => profile.value.description,
  ogTitle: () => `${profile.value.title} · ${profile.value.name}`,
  ogDescription: () => profile.value.description,
  robots: 'noindex, nofollow',
  themeColor: () => profile.value.brand
})

useHead(() => ({
  htmlAttrs: { lang: 'id' },
  meta: [{ name: 'theme-color', content: profile.value.brand }]
}))

onMounted(async () => {
  ensureEditor()
  await reloadNews()
})

onBeforeUnmount(() => {
  editor.value?.destroy()
  if (coverLocalPreview.value) URL.revokeObjectURL(coverLocalPreview.value)
})

const PdfEmbed = Node.create({
  name: 'pdfEmbed',
  group: 'block',
  atom: true,
  addAttributes() {
    return { src: { default: null }, title: { default: 'PDF Document' } }
  },
  parseHTML() {
    return [{ tag: 'iframe[data-type="pdf-embed"]' }]
  },
  renderHTML({ HTMLAttributes }) {
    return [
      'iframe',
      mergeAttributes(HTMLAttributes, {
        'data-type': 'pdf-embed',
        src: HTMLAttributes.src,
        title: HTMLAttributes.title || 'PDF Document',
        class: 'tiptap-embed tiptap-pdf',
        loading: 'lazy'
      })
    ]
  },
  addCommands() {
    return {
      setPdfEmbed:
        (attrs: any) =>
        ({ commands }: any) => commands.insertContent({ type: this.name, attrs })
    } as any
  }
})

const MapEmbed = Node.create({
  name: 'mapEmbed',
  group: 'block',
  atom: true,
  addAttributes() {
    return { src: { default: null }, title: { default: 'Map Location' } }
  },
  parseHTML() {
    return [{ tag: 'iframe[data-type="map-embed"]' }]
  },
  renderHTML({ HTMLAttributes }) {
    return [
      'iframe',
      mergeAttributes(HTMLAttributes, {
        'data-type': 'map-embed',
        src: HTMLAttributes.src,
        title: HTMLAttributes.title || 'Map Location',
        class: 'tiptap-embed tiptap-map',
        loading: 'lazy',
        allowfullscreen: 'true',
        referrerpolicy: 'no-referrer-when-downgrade'
      })
    ]
  },
  addCommands() {
    return {
      setMapEmbed:
        (attrs: any) =>
        ({ commands }: any) => commands.insertContent({ type: this.name, attrs })
    } as any
  }
})

const StepIntro = defineComponent({
  props: {
    icon: { type: String, required: true },
    title: { type: String, required: true },
    description: { type: String, required: true }
  },
  setup(props) {
    return () => h(
      'div',
      { class: 'rounded-[1.5rem] border border-neutral-200 bg-neutral-50 p-4' },
      [
        h('div', { class: 'flex items-start gap-3' }, [
          h('div', { class: 'grid h-10 w-10 shrink-0 place-items-center rounded-2xl bg-white text-blue-600 shadow-sm' }, [
            h(Icon, { icon: props.icon, class: 'h-5 w-5' })
          ]),
          h('div', {}, [
            h('h3', { class: 'text-base font-black text-neutral-950' }, props.title),
            h('p', { class: 'mt-1 text-sm font-medium leading-6 text-neutral-500' }, props.description)
          ])
        ])
      ]
    )
  }
})

function ensureEditor() {
  if (editor.value) return

  editor.value = new Editor({
    content: '<p></p>',
    extensions: [
      StarterKit.configure({
        heading: { levels: [1, 2, 3] }
      }),
      Underline,
      Link.configure({
        openOnClick: false,
        autolink: true,
        HTMLAttributes: {
          class: 'text-blue-600 font-bold underline underline-offset-4',
          target: '_blank',
          rel: 'noopener noreferrer'
        }
      }),
      Image.configure({
        inline: false,
        allowBase64: false,
        HTMLAttributes: { class: 'rounded-2xl border border-neutral-200' }
      }),
      Youtube.configure({
        controls: true,
        nocookie: true,
        HTMLAttributes: { class: 'rounded-2xl overflow-hidden' }
      }),
      Table.configure({ resizable: true }),
      TableRow,
      TableHeader,
      TableCell,
      PdfEmbed,
      MapEmbed
    ],
    editorProps: {
      attributes: { class: 'outline-none min-h-[360px] prose prose-neutral max-w-none' }
    }
  })
}

async function reloadNews() {
  try {
    const fn = newsSQL.loadNews || newsSQL.fetchNews || newsSQL.fetchItems || newsSQL.refresh
    if (typeof fn === 'function') await fn({ tenantSlug: tenantSlug.value })
  } catch (error: any) {
    showToast('error', 'Gagal Memuat Berita', error?.message || 'Data berita gagal dimuat.')
  }
}

function resetForm() {
  formStep.value = 1
  formTouched.value = false
  form.title = ''
  form.slug = ''
  form.excerpt = ''
  form.cover = ''
  form.category = profile.value.defaultCategory
  form.tags = []
  form.tagInput = ''
  form.status = 'published'
  form.publishedAt = Date.now()
  formError.value = ''
  selectedNews.value = null
  manualSlugEdited.value = false
  coverMode.value = 'upload'
  coverFile.value = null

  if (coverLocalPreview.value) URL.revokeObjectURL(coverLocalPreview.value)
  coverLocalPreview.value = ''
  if (coverInput.value) coverInput.value.value = ''

  ensureEditor()
  editor.value?.commands.setContent('<p></p>')
}

function openCreate() {
  formMode.value = 'create'
  resetForm()
  showForm.value = true
  nextTick(() => {
    ensureEditor()
    editor.value?.commands.focus()
  })
}

function openEdit(item: NewsItem) {
  formMode.value = 'edit'
  formStep.value = 1
  formTouched.value = false
  selectedNews.value = item
  form.title = item.title
  form.slug = item.slug
  form.excerpt = item.excerpt || ''
  form.cover = item.cover || ''
  form.category = item.category || profile.value.defaultCategory
  form.tags = [...(item.tags || [])]
  form.tagInput = ''
  form.status = item.status || 'published'
  form.publishedAt = item.publishedAt || Date.now()
  formError.value = ''
  manualSlugEdited.value = true
  coverMode.value = item.cover ? 'url' : 'upload'
  coverFile.value = null

  if (coverLocalPreview.value) URL.revokeObjectURL(coverLocalPreview.value)
  coverLocalPreview.value = ''
  if (coverInput.value) coverInput.value.value = ''

  ensureEditor()
  const rawItem = item as any
  setEditorContent(rawItem.content || rawItem.descriptionContent || '<p></p>')
  showForm.value = true
}

function requestCloseForm() {
  if (saving.value || imageUploading.value) return
  if (hasUnsavedFormData()) {
    showCloseGuard.value = true
    return
  }
  forceCloseForm()
}

function hasUnsavedFormData() {
  return Boolean(
    form.title ||
    form.excerpt ||
    form.cover ||
    form.tags.length ||
    coverFile.value ||
    (editor.value?.getText().trim() || '').length > 0
  )
}

function forceCloseForm() {
  showCloseGuard.value = false
  showForm.value = false
  formError.value = ''
}

function openDelete(item: NewsItem) {
  selectedNews.value = item
  showDelete.value = true
}

function validateCurrentFormStep() {
  formTouched.value = true
  formError.value = ''

  if (formStep.value === 1) {
    if (!form.title.trim()) {
      formError.value = 'Judul wajib diisi.'
      return false
    }

    if (!form.slug.trim()) form.slug = slugify(form.title)

    if (!form.category) {
      formError.value = 'Kategori wajib diisi.'
      return false
    }

    return true
  }

  if (formStep.value === 2) {
    if (coverMode.value === 'url' && form.cover && !isValidUrl(form.cover)) {
      formError.value = 'Tautan gambar tidak valid.'
      return false
    }
    return true
  }

  if (formStep.value === 3) {
    const text = editor.value?.getText().trim() || ''
    if (text.length < 10) {
      formError.value = 'Konten berita minimal 10 karakter.'
      return false
    }
    return true
  }

  return true
}

function validateAllFormSteps() {
  const current = formStep.value
  for (const step of formSteps) {
    formStep.value = step.value
    if (!validateCurrentFormStep()) return false
  }
  formStep.value = current
  formError.value = ''
  return true
}

function nextFormStep() {
  if (!validateCurrentFormStep()) return
  formTouched.value = false
  formError.value = ''
  formStep.value = Math.min(formStep.value + 1, formSteps.length)
}

function prevFormStep() {
  formTouched.value = false
  formError.value = ''
  formStep.value = Math.max(formStep.value - 1, 1)
}

function goToFormStep(targetStep: number) {
  if (targetStep <= formStep.value) {
    formTouched.value = false
    formError.value = ''
    formStep.value = targetStep
    return
  }
  nextFormStep()
}

function setCoverMode(mode: CoverMode) {
  coverMode.value = mode
  formError.value = ''
}

function triggerPickCover() {
  coverInput.value?.click()
}

function onPickCover(event: Event) {
  const input = event.target as HTMLInputElement
  const file = input.files?.[0] || null
  if (!file) return

  if (!validateImageFile(file)) {
    if (coverInput.value) coverInput.value.value = ''
    return
  }

  coverFile.value = file
  if (coverLocalPreview.value) URL.revokeObjectURL(coverLocalPreview.value)
  coverLocalPreview.value = URL.createObjectURL(file)
  formError.value = ''
}

function validateImageFile(file: File) {
  const allowed = ['image/jpeg', 'image/jpg', 'image/png', 'image/webp']

  if (!allowed.includes(file.type)) {
    showToast('error', 'Format Tidak Didukung', 'Gunakan gambar JPG, PNG, atau WebP.')
    return false
  }

  if (file.size > 5 * 1024 * 1024) {
    showToast('error', 'Ukuran Terlalu Besar', 'Ukuran gambar maksimal 5 MB.')
    return false
  }

  return true
}

function clearCover() {
  coverFile.value = null
  form.cover = ''
  if (coverLocalPreview.value) URL.revokeObjectURL(coverLocalPreview.value)
  coverLocalPreview.value = ''
  if (coverInput.value) coverInput.value.value = ''
}

function handleTagKeydown(event: KeyboardEvent) {
  if (event.key === 'Enter' || event.key === ' ' || event.key === ',') {
    event.preventDefault()
    addTagFromInput()
  }
}

function addTagFromInput() {
  const raw = form.tagInput.trim()
  if (!raw) return

  const tags = raw.split(/[,\s]+/).map((tag) => normalizeTag(tag)).filter(Boolean)

  for (const tag of tags) {
    if (!form.tags.includes(tag)) form.tags.push(tag)
  }

  form.tagInput = ''
}

function onPasteTags(event: ClipboardEvent) {
  const text = event.clipboardData?.getData('text') || ''
  if (!text.includes(',') && !text.includes(' ')) return

  event.preventDefault()
  const tags = text.split(/[,\s]+/).map((tag) => normalizeTag(tag)).filter(Boolean)

  for (const tag of tags) {
    if (!form.tags.includes(tag)) form.tags.push(tag)
  }

  form.tagInput = ''
}

function removeTag(tag: string) {
  form.tags = form.tags.filter((item) => item !== tag)
}

function normalizeTag(value: string) {
  return String(value || '').trim().replace(/^#/, '').replace(/\s+/g, '-').replace(/[^a-zA-Z0-9-_]/g, '').toLowerCase()
}

function triggerEditorImageUpload() {
  editorImageInput.value?.click()
}

async function onPickEditorImage(event: Event) {
  const input = event.target as HTMLInputElement
  const file = input.files?.[0] || null
  if (!file) return

  if (!validateImageFile(file)) {
    if (editorImageInput.value) editorImageInput.value.value = ''
    return
  }

  try {
    const result = await uploadImage(file, {
      folder: `${tenantSlug.value}/news/content`,
      maxWidth: 1600,
      maxHeight: 1600,
      quality: 0.82,
      maxBytes: 5 * 1024 * 1024
    })

    editor.value?.chain().focus().setImage({ src: result.secure_url, alt: file.name }).run()
    showToast('success', 'Gambar Ditambahkan', 'Gambar berhasil ditambahkan ke konten.')
  } catch (error: any) {
    showToast('error', 'Gagal Mengunggah', error?.message || 'Gambar gagal diunggah.')
  } finally {
    if (editorImageInput.value) editorImageInput.value.value = ''
  }
}

function openLinkModal() {
  ensureEditor()
  linkForm.url = editor.value?.getAttributes('link')?.href || ''
  linkForm.text = ''
  linkError.value = ''
  showLinkModal.value = true
}

function closeLinkModal() {
  showLinkModal.value = false
  linkError.value = ''
}

function confirmInsertLink() {
  linkError.value = ''
  const url = linkForm.url.trim()

  if (!isValidUrl(url)) {
    linkError.value = 'Tautan tidak valid.'
    return
  }

  ensureEditor()
  const ed = editor.value
  if (!ed) return

  const hasSelection = !ed.state.selection.empty

  if (hasSelection) {
    ed.chain().focus().extendMarkRange('link').setLink({ href: url, target: '_blank', rel: 'noopener noreferrer' }).run()
  } else if (linkForm.text.trim()) {
    ed.chain().focus().insertContent({
      type: 'text',
      text: linkForm.text.trim(),
      marks: [{ type: 'link', attrs: { href: url, target: '_blank', rel: 'noopener noreferrer' } }]
    }).run()
  } else {
    ed.chain().focus().insertContent({
      type: 'text',
      text: url,
      marks: [{ type: 'link', attrs: { href: url, target: '_blank', rel: 'noopener noreferrer' } }]
    }).run()
  }

  closeLinkModal()
}

function removeEditorLink() {
  ensureEditor()
  editor.value?.chain().focus().extendMarkRange('link').unsetLink().run()
}

function insertTable() {
  ensureEditor()
  editor.value?.chain().focus().insertTable({ rows: 3, cols: 3, withHeaderRow: true }).run()
}

function addTableRow() {
  ensureEditor()
  editor.value?.chain().focus().addRowAfter().run()
}

function addTableColumn() {
  ensureEditor()
  editor.value?.chain().focus().addColumnAfter().run()
}

function deleteTable() {
  ensureEditor()
  editor.value?.chain().focus().deleteTable().run()
}

function openMediaModal(type: MediaType) {
  mediaType.value = type
  mediaForm.url = ''
  mediaForm.title = ''
  mediaError.value = ''
  showMediaModal.value = true
}

function closeMediaModal() {
  showMediaModal.value = false
  mediaError.value = ''
}

function confirmInsertMedia() {
  mediaError.value = ''
  const rawUrl = mediaForm.url.trim()
  const url = extractIframeSrc(rawUrl)

  if (!url || !isValidUrl(url)) {
    mediaError.value = 'Tautan atau kode semat tidak valid.'
    return
  }

  ensureEditor()

  if (mediaType.value === 'image-url') {
    editor.value?.chain().focus().setImage({ src: url, alt: mediaForm.title || 'Image' }).run()
  }

  if (mediaType.value === 'pdf') {
    ;(editor.value?.commands as any).setPdfEmbed({ src: url, title: mediaForm.title || 'PDF Document' })
  }

  if (mediaType.value === 'youtube') {
    editor.value?.chain().focus().setYoutubeVideo({ src: url, width: 720, height: 405 }).run()
  }

  if (mediaType.value === 'map') {
    ;(editor.value?.commands as any).setMapEmbed({ src: url, title: mediaForm.title || 'Map Location' })
  }

  closeMediaModal()
}

function extractIframeSrc(value: string) {
  const source = String(value || '').trim()
  const match = source.match(/src=["']([^"']+)["']/i)
  return match?.[1] || source
}

async function resolveCoverUrlBeforeSubmit() {
  if (coverMode.value === 'url') {
    const url = form.cover.trim()
    if (url && !isValidUrl(url)) throw new Error('Tautan gambar tidak valid.')
    return url
  }

  if (!coverFile.value) return form.cover.trim()

  const result = await uploadImage(coverFile.value, {
    folder: `${tenantSlug.value}/news/covers`,
    maxWidth: 1600,
    maxHeight: 1600,
    quality: 0.82,
    maxBytes: 5 * 1024 * 1024
  })

  form.cover = result.secure_url
  return result.secure_url
}

async function submitForm() {
  formError.value = ''
  if (!validateAllFormSteps()) return

  saving.value = true

  try {
    ensureEditor()
    const coverUrl = await resolveCoverUrlBeforeSubmit()
    const html = editor.value?.getHTML() || '<p></p>'
    const json = editor.value?.getJSON() || {}

    const payload: NewsPayload = {
      tenantSlug: tenantSlug.value,
      title: form.title.trim(),
      slug: slugify(form.slug || form.title),
      excerpt: form.excerpt.trim(),
      cover: coverUrl,
      category: form.category || profile.value.defaultCategory,
      tags: form.tags,
      status: form.status,
      publishedAt: form.publishedAt || Date.now(),
      readTime: estimateReadTime(editor.value?.getText() || ''),
      content: { kind: 'tiptap', json, html }
    }

    if (formMode.value === 'create') {
      await callCreateNews(payload)
      showToast('success', 'Berita Berhasil Dibuat', 'Berita berhasil disimpan.')
    } else if (selectedNews.value) {
      await callUpdateNews(selectedNews.value.id, payload)
      showToast('success', 'Berita Berhasil Diupdate', 'Perubahan berita berhasil disimpan.')
    }

    showForm.value = false
    await reloadNews()
  } catch (error: any) {
    const message = error?.data?.statusMessage || error?.data?.message || error?.statusMessage || error?.message || 'Gagal menyimpan berita.'
    formError.value = message
    showToast('error', 'Gagal Menyimpan', message)
  } finally {
    saving.value = false
  }
}

async function confirmDelete() {
  if (!selectedNews.value) return
  deleting.value = true

  try {
    await callDeleteNews(selectedNews.value.id)
    showDelete.value = false
    showToast('success', 'Berita Dihapus', 'Data berita berhasil dihapus.')
    await reloadNews()
  } catch (error: any) {
    showToast('error', 'Gagal Menghapus', error?.message || 'Data berita gagal dihapus.')
  } finally {
    deleting.value = false
  }
}

async function callCreateNews(payload: NewsPayload) {
  const fn = newsSQL.createNews || newsSQL.createItem
  if (typeof fn !== 'function') throw new Error('Fitur simpan berita belum tersedia.')
  return await fn(payload)
}

async function callUpdateNews(id: string, payload: NewsPayload) {
  const fn = newsSQL.updateNews || newsSQL.updateItem
  if (typeof fn !== 'function') throw new Error('Fitur update berita belum tersedia.')
  if (!id) throw new Error('Data berita tidak ditemukan.')
  return await fn(id, payload)
}

async function callDeleteNews(id: string) {
  const fn = newsSQL.deleteNews || newsSQL.removeNews || newsSQL.deleteItem || newsSQL.remove || newsSQL.destroy
  if (typeof fn !== 'function') throw new Error('Fitur hapus berita belum tersedia.')
  return await fn(id)
}

function normalizeNewsItem(item: any): NewsItem {
  const content = normalizeContent(item?.content || item?.body || item?.description)
  const publishedAt = normalizeDate(item?.publishedAt || item?.published_at || item?.createdAt || item?.created_at)

  return {
    id: String(item?.id || item?.uuid || item?._id || ''),
    title: String(item?.title || 'Tanpa Judul'),
    slug: String(item?.slug || slugify(item?.title || 'tanpa-judul')),
    excerpt: String(item?.excerpt || item?.summary || ''),
    cover: String(item?.cover || item?.coverUrl || item?.cover_url || item?.image || ''),
    category: String(item?.category || profile.value.defaultCategory),
    tags: normalizeTags(item?.tags),
    status: normalizeStatus(item?.status),
    publishedAt,
    readTime: Number(item?.readTime || item?.read_time || estimateReadTime(plainTextFromContent(content))),
    tenantSlug: String(item?.tenantSlug || item?.tenant_slug || ''),
    content,
    createdAt: normalizeDate(item?.createdAt || item?.created_at),
    updatedAt: normalizeDate(item?.updatedAt || item?.updated_at)
  }
}

function normalizeStatus(value: any): NewsStatus {
  const status = String(value || 'published').toLowerCase()
  if (status === 'draft') return 'draft'
  if (status === 'scheduled') return 'scheduled'
  return 'published'
}

function normalizeDate(value: any) {
  if (!value) return Date.now()
  if (typeof value === 'number') return value < 10_000_000_000 ? value * 1000 : value
  const parsed = new Date(value).getTime()
  return Number.isNaN(parsed) ? Date.now() : parsed
}

function normalizeTags(value: any): string[] {
  if (Array.isArray(value)) return value.map((item) => String(item).trim()).filter(Boolean)

  if (typeof value === 'string') {
    try {
      const parsed = JSON.parse(value)
      if (Array.isArray(parsed)) return normalizeTags(parsed)
    } catch {
      return value.split(',').map((item) => item.trim()).filter(Boolean)
    }
  }

  return []
}

function normalizeContent(value: any): NewsContent {
  if (!value) return { kind: 'tiptap', html: '<p></p>' }
  if (typeof value === 'object') return value
  if (typeof value === 'string') {
    try {
      const parsed = JSON.parse(value)
      if (typeof parsed === 'object') return parsed
    } catch {
      return value
    }
  }
  return String(value)
}

function setEditorContent(content?: NewsContent) {
  ensureEditor()

  if (!content) {
    editor.value?.commands.setContent('<p></p>')
    return
  }

  if (typeof content === 'string') {
    editor.value?.commands.setContent(content.trim() || '<p></p>')
    return
  }

  if (content.kind === 'tiptap' && content.json) {
    editor.value?.commands.setContent(content.json)
    return
  }

  if (content.html) {
    editor.value?.commands.setContent(content.html)
    return
  }

  editor.value?.commands.setContent('<p></p>')
}

function syncSlugFromTitle() {
  if (formMode.value === 'edit') return
  if (manualSlugEdited.value && form.slug) return
  form.slug = slugify(form.title)
}

function slugify(value: string) {
  return String(value || '')
    .toLowerCase()
    .trim()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9\s-]/g, '')
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-')
    .replace(/^-|-$/g, '')
}

function plainTextFromContent(content?: NewsContent) {
  if (!content) return ''
  if (typeof content === 'string') return content.replace(/<[^>]+>/g, ' ').replace(/\s+/g, ' ').trim()
  if (content.html) return content.html.replace(/<[^>]+>/g, ' ').replace(/\s+/g, ' ').trim()
  return ''
}

function estimateReadTime(text: string) {
  const words = String(text || '').trim().split(/\s+/).filter(Boolean).length
  return Math.max(1, Math.ceil(words / 200))
}

function formatDate(value: number) {
  return new Intl.DateTimeFormat('id-ID', { day: '2-digit', month: 'short', year: 'numeric' }).format(new Date(value || Date.now()))
}

function statusLabel(status: NewsStatus) {
  if (status === 'draft') return 'Draft'
  if (status === 'scheduled') return 'Terjadwal'
  return 'Terbit'
}

function statusClass(status: NewsStatus) {
  if (status === 'draft') return 'bg-amber-100/90 text-amber-800'
  if (status === 'scheduled') return 'bg-blue-100/90 text-blue-800'
  return 'bg-emerald-100/90 text-emerald-800'
}

function publicNewsUrl(item: NewsItem) {
  return publicUrlFromSlug(item.slug)
}

function publicUrlFromSlug(slug: string) {
  const cleanSlug = String(slug || '').trim()
  if (!cleanSlug) return profile.value.publicBase
  return `${profile.value.publicBase}?detail=${encodeURIComponent(cleanSlug)}`
}

async function copyPublicLink(slug: string) {
  const path = publicUrlFromSlug(slug)
  const url = typeof window !== 'undefined' ? `${window.location.origin}${path}` : path

  try {
    await navigator.clipboard.writeText(url)
    showToast('success', 'Link Disalin', 'Tautan publik berhasil disalin.')
  } catch {
    showToast('error', 'Gagal Menyalin', 'Tautan belum bisa disalin otomatis.')
  }
}

function isValidUrl(value: string) {
  try {
    const url = new URL(value)
    return ['http:', 'https:'].includes(url.protocol)
  } catch {
    return false
  }
}

function formatFileSize(bytes: number) {
  if (!bytes) return '0 KB'
  const kb = bytes / 1024
  if (kb < 1024) return `${Math.round(kb)} KB`
  return `${(kb / 1024).toFixed(1)} MB`
}

function showToast(type: ToastType, title: string, message: string) {
  if (toastTimer) clearTimeout(toastTimer)
  toast.type = type
  toast.title = title
  toast.message = message
  toast.show = true
  toastTimer = setTimeout(() => {
    toast.show = false
  }, 3500)
}

function closeToast() {
  if (toastTimer) clearTimeout(toastTimer)
  toast.show = false
}
</script>

<style scoped>
.input-field {
  display: block;
  width: 100%;
  border-radius: 1rem;
  border: 1px solid rgb(229 229 229);
  background: rgb(250 250 250);
  padding: 0.75rem 1rem;
  font-size: 0.875rem;
  font-weight: 700;
  color: rgb(38 38 38);
  outline: none;
  transition: 160ms ease;
}

.input-field:focus {
  border-color: rgb(37 99 235);
  background: white;
  box-shadow: 0 0 0 4px rgb(219 234 254);
}

.label-field {
  margin-bottom: 0.5rem;
  display: block;
  font-size: 0.875rem;
  font-weight: 900;
  color: rgb(64 64 64);
}

.action-button {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 0.375rem;
  border-radius: 0.875rem;
  border: 1px solid rgb(229 229 229);
  background: white;
  padding: 0.5rem 0.75rem;
  font-size: 0.75rem;
  font-weight: 900;
  color: rgb(82 82 82);
  transition: 160ms ease;
}

.action-button:hover {
  background: rgb(250 250 250);
}

.select-card {
  display: flex;
  min-height: 8.25rem;
  flex-direction: column;
  gap: 0.5rem;
  border-radius: 1.25rem;
  border: 1px solid rgb(229 229 229);
  background: white;
  padding: 1rem;
  text-align: left;
  transition: 160ms ease;
}

.select-card span {
  font-size: 0.875rem;
  font-weight: 900;
  color: rgb(23 23 23);
}

.select-card small {
  font-size: 0.75rem;
  line-height: 1.25rem;
  font-weight: 700;
  color: rgb(115 115 115);
}

.select-card:hover {
  background: rgb(250 250 250);
}

.select-card-active {
  border-color: rgb(37 99 235);
  background: rgb(239 246 255);
  box-shadow: 0 0 0 4px rgb(219 234 254);
}

.toolbar-button {
  display: inline-flex;
  min-height: 2.25rem;
  align-items: center;
  justify-content: center;
  gap: 0.375rem;
  border-radius: 0.875rem;
  padding: 0.5rem 0.75rem;
  font-size: 0.75rem;
  font-weight: 900;
  color: rgb(82 82 82);
  transition: 160ms ease;
}

.toolbar-button:hover {
  background: white;
  color: rgb(23 23 23);
}

.toolbar-button-active {
  background: rgb(37 99 235);
  color: white;
}

.modal-primary-button {
  display: inline-flex;
  height: 2.75rem;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  border-radius: 1rem;
  background: rgb(37 99 235);
  padding: 0 1.25rem;
  font-size: 0.875rem;
  font-weight: 900;
  color: white;
  box-shadow: 0 12px 28px rgba(37, 99, 235, 0.2);
  transition: 160ms ease;
}

.modal-primary-button:hover {
  background: rgb(29 78 216);
}

.modal-secondary-button {
  display: inline-flex;
  height: 2.75rem;
  align-items: center;
  justify-content: center;
  border-radius: 1rem;
  border: 1px solid rgb(229 229 229);
  background: white;
  padding: 0 1.25rem;
  font-size: 0.875rem;
  font-weight: 900;
  color: rgb(64 64 64);
  transition: 160ms ease;
}

.modal-secondary-button:hover {
  background: rgb(250 250 250);
}

.editor-content :deep(.ProseMirror) {
  min-height: 360px;
  outline: none;
}

.editor-content :deep(.ProseMirror p) {
  margin: 0.75rem 0;
}

.editor-content :deep(.ProseMirror h1) {
  margin: 1.5rem 0 0.75rem;
  font-size: 2rem;
  font-weight: 950;
  line-height: 1.15;
  letter-spacing: -0.04em;
}

.editor-content :deep(.ProseMirror h2) {
  margin: 1.25rem 0 0.75rem;
  font-size: 1.5rem;
  font-weight: 950;
  line-height: 1.25;
}

.editor-content :deep(.ProseMirror h3) {
  margin: 1rem 0 0.5rem;
  font-size: 1.25rem;
  font-weight: 900;
  line-height: 1.3;
}

.editor-content :deep(.ProseMirror ul),
.editor-content :deep(.ProseMirror ol) {
  margin: 0.75rem 0;
  padding-left: 1.25rem;
}

.editor-content :deep(.ProseMirror blockquote) {
  margin: 1rem 0;
  border-left: 4px solid #2563eb;
  border-radius: 0.75rem;
  background: #eff6ff;
  padding: 0.75rem 1rem;
  color: #404040;
}

.editor-content :deep(.ProseMirror img) {
  max-width: 100%;
  height: auto;
  margin: 1rem 0;
  border-radius: 1rem;
}

.editor-content :deep(.ProseMirror iframe) {
  width: 100%;
  min-height: 380px;
  margin: 1rem 0;
  border: 0;
  border-radius: 1rem;
  background: #f5f5f5;
}

.editor-content :deep(.ProseMirror .tiptap-pdf) {
  min-height: 520px;
}

.editor-content :deep(.ProseMirror .tiptap-map) {
  min-height: 420px;
}

.editor-content :deep(.ProseMirror table) {
  width: 100%;
  border-collapse: collapse;
  margin: 1rem 0;
  table-layout: fixed;
  overflow: hidden;
  border-radius: 1rem;
}

.editor-content :deep(.ProseMirror th),
.editor-content :deep(.ProseMirror td) {
  min-width: 1em;
  border: 1px solid #e5e5e5;
  padding: 0.65rem 0.75rem;
  vertical-align: top;
}

.editor-content :deep(.ProseMirror th) {
  background: #eff6ff;
  font-weight: 900;
  color: #1d4ed8;
}

.editor-content :deep(.ProseMirror .selectedCell:after) {
  pointer-events: none;
  content: '';
  position: absolute;
  inset: 0;
  background: rgba(37, 99, 235, 0.12);
}

.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.line-clamp-3 {
  display: -webkit-box;
  -webkit-line-clamp: 3;
  line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>
