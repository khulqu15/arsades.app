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
        <div v-if="toast.show" class="fixed right-4 top-4 z-[10020] w-[calc(100%-2rem)] max-w-sm">
          <div
            class="rounded-[1.35rem] border bg-white/95 p-4 shadow-[0_24px_80px_rgba(15,23,42,0.16)] backdrop-blur-xl"
            :class="toast.type === 'success' ? 'border-emerald-200' : 'border-red-200'"
          >
            <div class="flex items-start gap-3">
              <div
                class="grid h-11 w-11 shrink-0 place-items-center rounded-2xl"
                :class="toast.type === 'success' ? 'bg-emerald-50 text-emerald-700' : 'bg-red-50 text-red-700'"
              >
                <Icon
                  :icon="toast.type === 'success' ? 'solar:check-circle-bold-duotone' : 'solar:danger-circle-bold-duotone'"
                  class="h-6 w-6"
                />
              </div>

              <div class="min-w-0 flex-1">
                <p class="text-sm font-black text-neutral-950">{{ toast.title }}</p>
                <p class="mt-1 text-sm font-semibold leading-6 text-neutral-500">{{ toast.message }}</p>
              </div>

              <button
                type="button"
                class="grid h-8 w-8 shrink-0 place-items-center rounded-xl text-neutral-400 transition hover:bg-neutral-100 hover:text-neutral-700"
                @click="closeToast"
              >
                <Icon icon="solar:close-circle-bold-duotone" class="h-5 w-5" />
              </button>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>

    <div class="space-y-4 p-4 sm:p-5 lg:p-6">
      <!-- Header -->
      <section class="relative overflow-hidden rounded-[1.75rem] border border-neutral-200 bg-white p-4 shadow-sm sm:p-5">
        <div class="pointer-events-none absolute -right-16 -top-20 h-64 w-64 rounded-full bg-blue-100 blur-3xl"></div>
        <div class="pointer-events-none absolute -left-24 bottom-0 h-48 w-48 rounded-full bg-sky-50 blur-3xl"></div>

        <div class="relative flex flex-col gap-4 lg:flex-row lg:items-center lg:justify-between">
          <div class="flex min-w-0 items-start gap-3 sm:gap-4">
            <div class="grid h-14 w-14 shrink-0 place-items-center overflow-hidden rounded-3xl border border-blue-100 bg-blue-50 text-blue-600 shadow-sm sm:h-16 sm:w-16">
              <img
                v-if="appLogo"
                :src="appLogo"
                :alt="`${appName} logo`"
                class="h-11 w-11 rounded-2xl object-contain sm:h-12 sm:w-12"
              >
              <Icon v-else icon="solar:buildings-2-bold-duotone" class="h-8 w-8" />
            </div>

            <div class="min-w-0">
              <div class="mb-2 flex flex-wrap items-center gap-2">
                <span class="inline-flex items-center gap-1.5 rounded-full bg-blue-50 px-3 py-1 text-[11px] font-black uppercase tracking-[0.14em] text-blue-700">
                  <Icon icon="solar:buildings-2-bold-duotone" class="h-3.5 w-3.5" />
                  Lembaga
                </span>
                <span class="rounded-full border border-neutral-200 bg-neutral-50 px-3 py-1 text-[11px] font-bold text-neutral-500">
                  {{ tenantSlug }}
                </span>
              </div>

              <h1 class="text-2xl font-black tracking-tight text-neutral-950 sm:text-3xl">
                Kelola Lembaga
              </h1>

              <p class="mt-1.5 max-w-3xl text-sm font-medium leading-6 text-neutral-500">
                Atur data lembaga, logo, konten profil, dan tautan publik dalam satu halaman yang ringkas.
              </p>
            </div>
          </div>

          <div class="flex flex-wrap gap-2">
            <button
              type="button"
              class="inline-flex items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-4 py-2.5 text-sm font-black text-neutral-700 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
              @click="reloadInstitutions"
            >
              <Icon icon="solar:refresh-bold-duotone" class="h-5 w-5" :class="isLoading ? 'animate-spin' : ''" />
              Refresh
            </button>

            <button
              type="button"
              class="inline-flex items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 py-2.5 text-sm font-black text-white shadow-sm shadow-blue-600/20 transition hover:bg-blue-700"
              @click="openCreate"
            >
              <Icon icon="solar:add-circle-bold-duotone" class="h-5 w-5" />
              Tambah Lembaga
            </button>
          </div>
        </div>
      </section>

      <!-- Toolbar -->
      <section class="rounded-[1.5rem] border border-neutral-200 bg-white p-3 shadow-sm sm:p-4">
        <div class="grid gap-3 lg:grid-cols-[1fr_160px_160px]">
          <div class="relative">
            <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-4 text-neutral-400">
              <Icon icon="solar:magnifer-linear" class="h-5 w-5" />
            </div>

            <input
              v-model.trim="search"
              type="text"
              placeholder="Cari nama lembaga, deskripsi, atau slug..."
              class="input-field py-3 pl-12"
            >
          </div>

          <select v-model="selectedStatus" class="input-field">
            <option value="all">Semua Status</option>
            <option value="active">Aktif</option>
            <option value="inactive">Nonaktif</option>
          </select>

          <select v-model="sortBy" class="input-field">
            <option value="sort_order">Urutan</option>
            <option value="title">Nama A-Z</option>
            <option value="newest">Terbaru</option>
            <option value="oldest">Terlama</option>
          </select>
        </div>

        <div class="mt-3 flex flex-wrap items-center justify-between gap-3">
          <p class="text-xs font-bold text-neutral-500">
            Menampilkan {{ filteredInstitutions.length }} lembaga.
          </p>

          <button
            type="button"
            class="inline-flex items-center gap-2 rounded-2xl border border-neutral-200 bg-white px-3.5 py-2 text-xs font-black text-neutral-600 transition hover:bg-neutral-50"
            @click="resetFilters"
          >
            <Icon icon="solar:restart-bold-duotone" class="h-4 w-4" />
            Reset
          </button>
        </div>
      </section>

      <div v-if="visibleError" class="rounded-3xl border border-red-200 bg-red-50 p-4 text-sm font-bold leading-6 text-red-700">
        {{ visibleError }}
      </div>

      <!-- Loading -->
      <section v-if="isLoading" class="grid gap-3 sm:grid-cols-2 xl:grid-cols-3">
        <div v-for="item in 6" :key="item" class="h-64 animate-pulse rounded-[1.5rem] border border-neutral-200 bg-white p-4">
          <div class="flex gap-3">
            <div class="h-14 w-14 rounded-3xl bg-neutral-100"></div>
            <div class="flex-1">
              <div class="h-4 w-2/3 rounded-full bg-neutral-100"></div>
              <div class="mt-3 h-3 w-full rounded-full bg-neutral-100"></div>
              <div class="mt-2 h-3 w-4/5 rounded-full bg-neutral-100"></div>
            </div>
          </div>
          <div class="mt-5 h-24 rounded-3xl bg-neutral-100"></div>
        </div>
      </section>

      <!-- Empty -->
      <section
        v-else-if="filteredInstitutions.length === 0"
        class="rounded-[1.75rem] border border-dashed border-neutral-300 bg-white p-10 text-center shadow-sm"
      >
        <div class="mx-auto grid h-16 w-16 place-items-center rounded-3xl bg-blue-50 text-blue-600">
          <Icon icon="solar:buildings-2-bold-duotone" class="h-8 w-8" />
        </div>

        <h2 class="mt-5 text-xl font-black text-neutral-950">Belum ada lembaga</h2>
        <p class="mx-auto mt-2 max-w-md text-sm font-medium leading-6 text-neutral-500">
          Tambahkan data lembaga agar bisa tampil di halaman publik.
        </p>

        <button
          type="button"
          class="mt-5 inline-flex items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 py-3 text-sm font-black text-white shadow-sm shadow-blue-600/20 transition hover:bg-blue-700"
          @click="openCreate"
        >
          <Icon icon="solar:add-circle-bold-duotone" class="h-5 w-5" />
          Tambah Lembaga
        </button>
      </section>

      <!-- Grid -->
      <section v-else class="grid gap-3 sm:grid-cols-2 xl:grid-cols-3">
        <article
          v-for="item in pagedInstitutions"
          :key="item.id"
          class="group rounded-[1.5rem] border border-neutral-200 bg-white p-4 shadow-sm transition hover:-translate-y-0.5 hover:border-blue-200 hover:shadow-xl hover:shadow-blue-900/5"
        >
          <div class="flex items-start gap-3">
            <div class="grid h-14 w-14 shrink-0 place-items-center overflow-hidden rounded-3xl border border-blue-100 bg-blue-50 text-blue-600">
              <img
                v-if="item.logoUrl"
                :src="item.logoUrl"
                :alt="item.title || 'Logo lembaga'"
                class="h-11 w-11 rounded-2xl object-contain"
              >
              <Icon v-else :icon="item.icon || defaultInstitutionIcon" class="h-7 w-7" />
            </div>

            <div class="min-w-0 flex-1">
              <div class="mb-2 flex flex-wrap items-center gap-1.5">
                <span class="rounded-full px-2.5 py-1 text-[11px] font-black" :class="statusClass(item.status)">
                  {{ statusLabel(item.status) }}
                </span>

                <span v-if="item.isFeatured" class="rounded-full bg-blue-600 px-2.5 py-1 text-[11px] font-black text-white">
                  Unggulan
                </span>
              </div>

              <h3 class="line-clamp-2 text-base font-black leading-6 text-neutral-950 group-hover:text-blue-700">
                {{ item.title }}
              </h3>

              <p class="mt-1.5 line-clamp-3 text-sm font-medium leading-6 text-neutral-500">
                {{ item.subtitle || contentPreview(item) || 'Belum ada ringkasan lembaga.' }}
              </p>
            </div>
          </div>

          <div class="mt-4 flex flex-wrap items-center gap-2 border-t border-neutral-100 pt-4">
            <NuxtLink
              :to="institutionDetailTo(item.slug)"
              class="inline-flex items-center justify-center gap-1.5 rounded-xl bg-blue-50 px-3 py-2 text-xs font-black text-blue-700 transition hover:bg-blue-600 hover:text-white"
            >
              <Icon icon="solar:eye-bold-duotone" class="h-4 w-4" />
              Lihat
            </NuxtLink>

            <button
              type="button"
              class="inline-flex items-center justify-center gap-1.5 rounded-xl border border-neutral-200 bg-white px-3 py-2 text-xs font-black text-neutral-600 transition hover:bg-neutral-50"
              @click="copyPublicLink(item)"
            >
              <Icon icon="solar:copy-bold-duotone" class="h-4 w-4" />
              Salin
            </button>

            <button
              type="button"
              class="inline-flex items-center justify-center gap-1.5 rounded-xl border border-neutral-200 bg-white px-3 py-2 text-xs font-black text-neutral-600 transition hover:bg-neutral-50"
              @click="openEdit(item)"
            >
              <Icon icon="solar:pen-2-bold-duotone" class="h-4 w-4" />
              Edit
            </button>

            <button
              type="button"
              class="ms-auto inline-flex items-center justify-center gap-1.5 rounded-xl border border-red-200 bg-red-50 px-3 py-2 text-xs font-black text-red-600 transition hover:bg-red-100"
              @click="openDelete(item)"
            >
              <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-4 w-4" />
              Hapus
            </button>
          </div>
        </article>
      </section>

      <div v-if="hasMore && !isLoading" class="flex justify-center">
        <button
          type="button"
          class="inline-flex items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-5 py-3 text-sm font-black text-neutral-700 transition hover:bg-neutral-50"
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
          <div class="mx-auto min-h-full max-w-6xl py-4">
            <div class="overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-2xl">
              <!-- Modal Header + Stepper -->
              <div class="sticky top-0 z-10 border-b border-neutral-200 bg-white/95 px-5 py-4 backdrop-blur-xl">
                <div class="flex items-start justify-between gap-4">
                  <div class="flex min-w-0 items-center gap-3">
                    <div class="grid h-12 w-12 shrink-0 place-items-center overflow-hidden rounded-2xl border border-blue-100 bg-blue-50 text-blue-600">
                      <img v-if="appLogo" :src="appLogo" :alt="`${appName} logo`" class="h-9 w-9 rounded-xl object-contain">
                      <Icon v-else icon="solar:buildings-2-bold-duotone" class="h-6 w-6" />
                    </div>
                    <div class="min-w-0">
                      <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">Editor Lembaga</p>
                      <h2 class="truncate text-xl font-black text-neutral-950">
                        {{ formMode === 'create' ? 'Tambah Lembaga' : 'Edit Lembaga' }}
                      </h2>
                    </div>
                  </div>

                  <button
                    type="button"
                    class="grid h-10 w-10 place-items-center rounded-2xl text-neutral-500 transition hover:bg-neutral-100 hover:text-neutral-950"
                    @click="requestCloseForm"
                  >
                    <Icon icon="solar:close-circle-bold-duotone" class="h-6 w-6" />
                  </button>
                </div>

                <div class="mt-5">
                  <div class="mb-3 flex items-center justify-between gap-3">
                    <p class="text-xs font-black uppercase tracking-[0.16em] text-neutral-400">
                      Langkah {{ formStep }} dari {{ formSteps.length }}
                    </p>
                    <p class="text-xs font-black text-blue-600">{{ formStepProgress }}%</p>
                  </div>

                  <div class="h-2 overflow-hidden rounded-full bg-neutral-100">
                    <div class="h-full rounded-full bg-blue-600 transition-all duration-300" :style="{ width: `${formStepProgress}%` }"></div>
                  </div>

                  <div class="mt-4 grid gap-2 sm:grid-cols-3">
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
                          class="grid h-9 w-9 place-items-center rounded-xl"
                          :class="step.value === formStep
                            ? 'bg-white text-blue-600'
                            : step.value < formStep
                              ? 'bg-white text-emerald-600'
                              : 'bg-neutral-100 text-neutral-400'"
                        >
                          <Icon :icon="step.value < formStep ? 'solar:check-circle-bold-duotone' : step.icon" class="h-5 w-5" />
                        </div>
                        <span class="text-xs font-black text-neutral-400">0{{ step.value }}</span>
                      </div>

                      <p class="mt-2 text-sm font-black text-neutral-950">{{ step.title }}</p>
                      <p class="mt-1 text-xs font-semibold leading-5 text-neutral-500">{{ step.description }}</p>
                    </button>
                  </div>
                </div>
              </div>

              <form class="space-y-5 p-5" @submit.prevent="submitForm">
                <!-- Step 1 -->
                <div v-if="formStep === 1" class="space-y-5">
                  <div class="rounded-[1.5rem] border border-neutral-200 bg-neutral-50 p-5">
                    <div class="flex items-start gap-4">
                      <div class="grid h-11 w-11 shrink-0 place-items-center rounded-2xl bg-white text-blue-600 shadow-sm">
                        <Icon icon="solar:buildings-2-bold-duotone" class="h-5 w-5" />
                      </div>
                      <div>
                        <h3 class="text-base font-black text-neutral-950">Identitas Lembaga</h3>
                        <p class="mt-1 text-sm font-medium leading-6 text-neutral-500">
                          Lengkapi nama, slug, ikon, logo, status, dan urutan tampil.
                        </p>
                      </div>
                    </div>
                  </div>

                  <div class="grid gap-4 lg:grid-cols-2">
                    <div>
                      <label class="mb-2 block text-sm font-black text-neutral-700">Nama Lembaga</label>
                      <input
                        v-model.trim="form.title"
                        type="text"
                        required
                        placeholder="Contoh: Badan Permusyawaratan Desa"
                        class="input-field"
                        @input="syncSlugFromTitle"
                      >
                      <p v-if="formTouched && !form.title.trim()" class="mt-2 text-xs font-bold text-red-600">
                        Nama lembaga wajib diisi.
                      </p>
                    </div>

                    <div>
                      <div class="mb-2 flex items-center justify-between gap-2">
                        <label class="block text-sm font-black text-neutral-700">Slug</label>
                        <button type="button" class="text-xs font-black text-blue-600 transition hover:text-blue-700" @click="regenerateSlug">
                          Generate ulang
                        </button>
                      </div>

                      <input
                        v-model.trim="form.slug"
                        type="text"
                        required
                        placeholder="badan-permusyawaratan-desa"
                        class="input-field"
                        @input="onSlugInput"
                      >
                      <p class="mt-2 text-xs font-semibold leading-5 text-neutral-500">
                        Dipakai untuk tautan publik: <b>{{ institutionDetailTo(form.slug || 'slug-lembaga') }}</b>
                      </p>
                    </div>

                    <div class="lg:col-span-2">
                      <label class="mb-2 block text-sm font-black text-neutral-700">Ringkasan Singkat</label>
                      <input
                        v-model.trim="form.subtitle"
                        type="text"
                        placeholder="Contoh: Lembaga yang mendukung pelayanan dan aspirasi masyarakat."
                        class="input-field"
                      >
                    </div>

                    <div>
                      <label class="mb-2 block text-sm font-black text-neutral-700">Ikon</label>
                      <button
                        type="button"
                        class="flex w-full items-center justify-between gap-3 rounded-2xl border border-neutral-200 bg-neutral-50 px-4 py-3 text-left transition hover:border-blue-300 hover:bg-white focus:border-blue-600 focus:bg-white focus:ring-4 focus:ring-blue-100"
                        @click="openIconPicker"
                      >
                        <span class="flex min-w-0 items-center gap-3">
                          <span class="grid h-11 w-11 shrink-0 place-items-center rounded-2xl bg-white text-blue-600 shadow-sm">
                            <Icon :key="form.icon || defaultInstitutionIcon" :icon="form.icon || defaultInstitutionIcon" class="h-6 w-6" />
                          </span>
                          <span class="min-w-0">
                            <span class="block text-sm font-black text-neutral-900">{{ selectedIconLabel }}</span>
                            <span class="block truncate text-xs font-semibold text-neutral-500">Cari berdasarkan kata kunci</span>
                          </span>
                        </span>
                        <Icon icon="solar:magnifer-linear" class="h-5 w-5 shrink-0 text-neutral-400" />
                      </button>
                    </div>

                    <div>
                      <label class="mb-2 block text-sm font-black text-neutral-700">Logo</label>
                      <div class="grid gap-2 sm:grid-cols-[1fr_auto]">
                        <input v-model.trim="form.logoUrl" type="url" placeholder="Tempel tautan gambar" class="input-field">
                        <button
                          type="button"
                          class="inline-flex items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 py-3 text-sm font-black text-white shadow-sm shadow-blue-600/20 transition hover:bg-blue-700"
                          @click="triggerPickLogo"
                        >
                          <Icon icon="solar:upload-bold-duotone" class="h-5 w-5" />
                          Pilih
                        </button>
                      </div>
                      <input ref="logoInput" type="file" accept="image/jpeg,image/jpg,image/png,image/webp" class="hidden" @change="onPickLogo">
                    </div>

                    <div>
                      <label class="mb-2 block text-sm font-black text-neutral-700">Status</label>
                      <select v-model="form.status" class="input-field">
                        <option value="active">Aktif</option>
                        <option value="inactive">Nonaktif</option>
                      </select>
                    </div>

                    <div>
                      <label class="mb-2 block text-sm font-black text-neutral-700">Urutan Tampil</label>
                      <input v-model.number="form.sortOrder" type="number" min="0" class="input-field">
                    </div>

                    <div class="lg:col-span-2">
                      <label class="inline-flex cursor-pointer items-center gap-3 rounded-2xl border border-neutral-200 bg-neutral-50 px-4 py-3 transition hover:bg-white">
                        <input v-model="form.isFeatured" type="checkbox" class="h-4 w-4 rounded border-neutral-300 text-blue-600 focus:ring-blue-600">
                        <span>
                          <span class="block text-sm font-black text-neutral-800">Tampilkan sebagai unggulan</span>
                          <span class="block text-xs font-semibold text-neutral-500">Data ini akan lebih diprioritaskan pada halaman publik.</span>
                        </span>
                      </label>
                    </div>
                  </div>
                </div>

                <!-- Step 2 -->
                <div v-if="formStep === 2" class="space-y-5">
                  <div class="rounded-[1.5rem] border border-neutral-200 bg-neutral-50 p-5">
                    <div class="flex items-start gap-4">
                      <div class="grid h-11 w-11 shrink-0 place-items-center rounded-2xl bg-white text-blue-600 shadow-sm">
                        <Icon icon="solar:pen-new-square-bold-duotone" class="h-5 w-5" />
                      </div>
                      <div>
                        <h3 class="text-base font-black text-neutral-950">Konten Profil</h3>
                        <p class="mt-1 text-sm font-medium leading-6 text-neutral-500">
                          Tulis profil lengkap. Gunakan menu tambahan untuk tautan, tabel, gambar, video, dokumen, dan peta.
                        </p>
                      </div>
                    </div>
                  </div>

                  <div>
                    <div class="mb-2 flex items-center justify-between gap-3">
                      <label class="block text-sm font-black text-neutral-700">Konten</label>
                      <span class="text-xs font-bold text-neutral-400">Estimasi baca: {{ readTime }} menit</span>
                    </div>

                    <ClientOnly>
                      <div class="relative overflow-hidden rounded-3xl border border-neutral-200 bg-white">
                        <div v-if="editor" class="flex flex-wrap items-center gap-1 border-b border-neutral-200 bg-neutral-50 p-2">
                          <button
                            v-for="button in primaryEditorButtons"
                            :key="button.label"
                            type="button"
                            class="editor-btn group relative"
                            :class="button.active() ? 'bg-blue-600 text-white' : 'text-neutral-600 hover:bg-white hover:text-blue-700'"
                            @click="button.action"
                          >
                            <Icon :icon="button.icon" class="h-4 w-4" />
                            <span class="editor-tooltip">{{ button.label }}</span>
                          </button>

                          <div class="ms-auto flex items-center gap-1">
                            <button type="button" class="editor-btn group relative text-neutral-600 hover:bg-white hover:text-blue-700" @click="openLinkModal">
                              <Icon icon="solar:link-circle-bold-duotone" class="h-4 w-4" />
                              <span class="editor-tooltip">Tautan</span>
                            </button>

                            <button type="button" class="editor-btn group relative text-neutral-600 hover:bg-white hover:text-blue-700" @click="triggerEditorImageUpload">
                              <Icon icon="solar:upload-bold-duotone" class="h-4 w-4" />
                              <span class="editor-tooltip">Unggah Gambar</span>
                            </button>

                            <div class="relative">
                              <button type="button" class="editor-btn group relative text-neutral-600 hover:bg-white hover:text-blue-700" @click="moreToolbarOpen = !moreToolbarOpen">
                                <Icon icon="solar:menu-dots-bold" class="h-4 w-4" />
                                <span class="editor-tooltip">Lainnya</span>
                              </button>

                              <Transition
                                enter-active-class="transition duration-150 ease-out"
                                enter-from-class="translate-y-1 opacity-0"
                                enter-to-class="translate-y-0 opacity-100"
                                leave-active-class="transition duration-100 ease-in"
                                leave-from-class="translate-y-0 opacity-100"
                                leave-to-class="translate-y-1 opacity-0"
                              >
                                <div
                                  v-if="moreToolbarOpen"
                                  class="absolute right-0 top-11 z-40 w-72 rounded-3xl border border-neutral-200 bg-white p-2 shadow-[0_24px_80px_rgba(15,23,42,0.16)]"
                                >
                                  <button
                                    v-for="button in secondaryEditorButtons"
                                    :key="button.label"
                                    type="button"
                                    class="flex w-full items-center gap-3 rounded-2xl px-3 py-2.5 text-left text-sm font-bold text-neutral-600 transition hover:bg-neutral-50 hover:text-blue-700"
                                    @click="runMoreEditorAction(button.action)"
                                  >
                                    <Icon :icon="button.icon" class="h-5 w-5 text-neutral-400" />
                                    {{ button.label }}
                                  </button>

                                  <div class="my-2 border-t border-neutral-100"></div>

                                  <button
                                    v-for="item in mediaMenu"
                                    :key="item.type"
                                    type="button"
                                    class="flex w-full items-center gap-3 rounded-2xl px-3 py-2.5 text-left text-sm font-bold text-neutral-600 transition hover:bg-neutral-50 hover:text-blue-700"
                                    @click="openMediaFromMore(item.type)"
                                  >
                                    <Icon :icon="item.icon" class="h-5 w-5 text-neutral-400" />
                                    {{ item.label }}
                                  </button>
                                </div>
                              </Transition>
                            </div>
                          </div>

                          <input ref="editorImageInput" type="file" accept="image/jpeg,image/jpg,image/png,image/webp" class="hidden" @change="onPickEditorImage">
                        </div>

                        <div class="relative bg-white" @contextmenu.prevent="openEditorContextMenu" @click="contextToolbarOpen = false">
                          <EditorContent v-if="editor" :editor="editor" class="editor-content min-h-[360px] p-4" />

                          <Transition
                            enter-active-class="transition duration-150 ease-out"
                            enter-from-class="scale-95 opacity-0"
                            enter-to-class="scale-100 opacity-100"
                            leave-active-class="transition duration-100 ease-in"
                            leave-from-class="scale-100 opacity-100"
                            leave-to-class="scale-95 opacity-0"
                          >
                            <div
                              v-if="contextToolbarOpen"
                              class="fixed z-[10000] w-64 rounded-3xl border border-neutral-200 bg-white p-2 shadow-[0_24px_80px_rgba(15,23,42,0.18)]"
                              :style="{ left: `${contextToolbar.x}px`, top: `${contextToolbar.y}px` }"
                              @click.stop
                            >
                              <p class="px-3 py-2 text-[11px] font-black uppercase tracking-[0.16em] text-neutral-400">Menu Cepat</p>
                              <button
                                v-for="button in contextEditorButtons"
                                :key="button.label"
                                type="button"
                                class="flex w-full items-center gap-3 rounded-2xl px-3 py-2.5 text-sm font-bold text-neutral-600 transition hover:bg-neutral-50 hover:text-blue-700"
                                @click="runContextAction(button.action)"
                              >
                                <Icon :icon="button.icon" class="h-5 w-5 text-neutral-400" />
                                {{ button.label }}
                              </button>
                            </div>
                          </Transition>
                        </div>

                        <div class="flex flex-col gap-2 border-t border-neutral-200 bg-neutral-50 px-4 py-3 text-xs font-semibold text-neutral-500 sm:flex-row sm:items-center sm:justify-between">
                          <span>Klik menu titik tiga untuk tabel, dokumen, video, dan peta.</span>
                          <span>Klik kanan di area tulisan untuk menu cepat.</span>
                        </div>
                      </div>
                    </ClientOnly>
                  </div>
                </div>

                <!-- Step 3 -->
                <div v-if="formStep === 3" class="space-y-5">
                  <div class="rounded-[1.5rem] border border-neutral-200 bg-neutral-50 p-5">
                    <div class="flex items-start gap-4">
                      <div class="grid h-11 w-11 shrink-0 place-items-center rounded-2xl bg-white text-blue-600 shadow-sm">
                        <Icon icon="solar:clipboard-check-bold-duotone" class="h-5 w-5" />
                      </div>
                      <div>
                        <h3 class="text-base font-black text-neutral-950">Review & Simpan</h3>
                        <p class="mt-1 text-sm font-medium leading-6 text-neutral-500">
                          Periksa tampilan ringkas sebelum data disimpan.
                        </p>
                      </div>
                    </div>
                  </div>

                  <div class="grid gap-5 lg:grid-cols-[330px_1fr]">
                    <aside class="rounded-[1.5rem] border border-neutral-200 bg-white p-4">
                      <p class="mb-3 text-sm font-black text-neutral-950">Preview Card</p>

                      <div class="rounded-3xl border border-neutral-200 bg-neutral-50 p-4">
                        <div class="flex items-start gap-3">
                          <div class="grid h-14 w-14 shrink-0 place-items-center overflow-hidden rounded-2xl bg-white text-blue-600 shadow-sm">
                            <img v-if="form.logoUrl" :src="form.logoUrl" alt="Logo preview" class="h-11 w-11 rounded-xl object-contain">
                            <Icon v-else :key="form.icon || defaultInstitutionIcon" :icon="form.icon || defaultInstitutionIcon" class="h-7 w-7" />
                          </div>
                          <div class="min-w-0">
                            <p class="line-clamp-2 text-sm font-black text-neutral-950">{{ form.title || 'Nama lembaga' }}</p>
                            <p class="mt-1 line-clamp-3 text-xs font-semibold leading-5 text-neutral-500">
                              {{ form.subtitle || contentTextPreview || 'Ringkasan lembaga akan tampil di sini.' }}
                            </p>
                          </div>
                        </div>

                        <NuxtLink
                          :to="institutionDetailTo(form.slug || 'slug-lembaga')"
                          class="mt-4 inline-flex items-center gap-2 rounded-2xl bg-blue-600 px-4 py-2 text-xs font-black text-white"
                        >
                          <Icon icon="solar:eye-bold-duotone" class="h-4 w-4" />
                          Lihat publik
                        </NuxtLink>
                      </div>
                    </aside>

                    <div class="rounded-[1.5rem] border border-neutral-200 bg-white p-5">
                      <div class="grid gap-3">
                        <InfoRow label="Nama" :value="form.title || '-'" />
                        <InfoRow label="Slug" :value="form.slug || '-'" />
                        <InfoRow label="Status" :value="statusLabel(form.status)" />
                        <InfoRow label="Unggulan" :value="form.isFeatured ? 'Ya' : 'Tidak'" />
                        <InfoRow label="Urutan" :value="String(form.sortOrder || 0)" />
                        <div class="flex items-center justify-between gap-4 rounded-2xl border border-neutral-200 bg-neutral-50 px-4 py-3">
                          <span class="text-sm font-bold text-neutral-500">Ikon</span>
                          <span class="inline-flex min-w-0 items-center gap-2 truncate text-right text-sm font-black text-neutral-950">
                            <Icon :key="form.icon || defaultInstitutionIcon" :icon="form.icon || defaultInstitutionIcon" class="h-4 w-4 text-blue-600" />
                            {{ form.icon || 'Default' }}
                          </span>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>

                <div v-if="formError" class="rounded-2xl border border-red-200 bg-red-50 px-4 py-3 text-sm font-bold text-red-700">
                  {{ formError }}
                </div>

                <div class="flex flex-col-reverse gap-3 border-t border-neutral-200 pt-5 sm:flex-row sm:items-center sm:justify-between">
                  <button
                    type="button"
                    class="inline-flex items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-5 py-3 text-sm font-black text-neutral-700 transition hover:bg-neutral-50 disabled:cursor-not-allowed disabled:opacity-50"
                    :disabled="formStep === 1 || saving || imageUploading"
                    @click="prevFormStep"
                  >
                    <Icon icon="solar:arrow-left-linear" class="h-5 w-5" />
                    Kembali
                  </button>

                  <div class="flex flex-col-reverse gap-3 sm:flex-row">
                    <button
                      type="button"
                      class="inline-flex items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-5 py-3 text-sm font-black text-neutral-700 transition hover:bg-neutral-50"
                      @click="requestCloseForm"
                    >
                      Batal
                    </button>

                    <button
                      v-if="formStep < formSteps.length"
                      type="button"
                      class="inline-flex items-center justify-center gap-2 rounded-2xl bg-blue-600 px-5 py-3 text-sm font-black text-white shadow-sm shadow-blue-600/20 transition hover:bg-blue-700"
                      @click="nextFormStep"
                    >
                      Lanjutkan
                      <Icon icon="solar:arrow-right-linear" class="h-5 w-5" />
                    </button>

                    <button
                      v-else
                      type="submit"
                      :disabled="saving || imageUploading"
                      class="inline-flex items-center justify-center gap-2 rounded-2xl bg-blue-600 px-5 py-3 text-sm font-black text-white shadow-sm shadow-blue-600/20 transition hover:bg-blue-700 disabled:cursor-not-allowed disabled:opacity-60"
                    >
                      <Icon
                        :icon="saving || imageUploading ? 'solar:refresh-bold-duotone' : 'solar:diskette-bold-duotone'"
                        class="h-5 w-5"
                        :class="saving || imageUploading ? 'animate-spin' : ''"
                      />
                      {{ imageUploading ? 'Mengunggah gambar...' : saving ? 'Menyimpan...' : formMode === 'create' ? 'Simpan Lembaga' : 'Update Lembaga' }}
                    </button>
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>

    <!-- Link Modal -->
    <Teleport to="body">
      <Transition enter-active-class="transition duration-200 ease-out" enter-from-class="opacity-0" enter-to-class="opacity-100" leave-active-class="transition duration-150 ease-in" leave-from-class="opacity-100" leave-to-class="opacity-0">
        <div v-if="linkModal.open" class="fixed inset-0 z-[10002] grid place-items-center bg-neutral-950/45 p-4 backdrop-blur-sm">
          <div class="w-full max-w-lg rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-2xl">
            <div class="flex items-start justify-between gap-4">
              <div>
                <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">Tambah Tautan</p>
                <h2 class="mt-1 text-xl font-black text-neutral-950">Masukkan alamat tautan</h2>
              </div>
              <button type="button" class="grid h-10 w-10 place-items-center rounded-2xl text-neutral-500 transition hover:bg-neutral-100 hover:text-neutral-950" @click="closeLinkModal">
                <Icon icon="solar:close-circle-bold-duotone" class="h-6 w-6" />
              </button>
            </div>

            <div class="mt-5 space-y-4">
              <div>
                <label class="mb-2 block text-sm font-black text-neutral-700">Alamat Tautan</label>
                <input v-model.trim="linkModal.url" type="url" placeholder="https://contoh.com/halaman" class="input-field">
              </div>
              <div>
                <label class="mb-2 block text-sm font-black text-neutral-700">Teks Tautan</label>
                <input v-model.trim="linkModal.text" type="text" placeholder="Contoh: Lihat informasi lengkap" class="input-field">
              </div>
              <div v-if="linkModal.error" class="rounded-2xl border border-red-200 bg-red-50 px-4 py-3 text-sm font-bold text-red-700">
                {{ linkModal.error }}
              </div>
            </div>

            <div class="mt-6 flex flex-col-reverse gap-3 sm:flex-row sm:justify-end">
              <button type="button" class="inline-flex items-center justify-center rounded-2xl border border-neutral-200 bg-white px-5 py-3 text-sm font-black text-neutral-700 transition hover:bg-neutral-50" @click="closeLinkModal">
                Batal
              </button>
              <button type="button" class="inline-flex items-center justify-center gap-2 rounded-2xl bg-blue-600 px-5 py-3 text-sm font-black text-white shadow-sm shadow-blue-600/20 transition hover:bg-blue-700" @click="insertLink">
                <Icon icon="solar:link-circle-bold-duotone" class="h-5 w-5" />
                Pasang Tautan
              </button>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>

    <!-- Icon Picker Modal -->
    <Teleport to="body">
      <Transition enter-active-class="transition duration-200 ease-out" enter-from-class="opacity-0" enter-to-class="opacity-100" leave-active-class="transition duration-150 ease-in" leave-from-class="opacity-100" leave-to-class="opacity-0">
        <div v-if="showIconPicker" class="fixed inset-0 z-[10003] overflow-y-auto bg-neutral-950/50 p-3 backdrop-blur-sm sm:p-5">
          <div class="mx-auto flex min-h-full max-w-5xl items-center py-4">
            <div class="w-full overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-2xl">
              <div class="border-b border-neutral-200 bg-white/95 p-5 backdrop-blur-xl">
                <div class="flex items-start justify-between gap-4">
                  <div>
                    <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">Pilih Ikon</p>
                    <h2 class="mt-1 text-xl font-black text-neutral-950">Cari berdasarkan keyword</h2>
                    <p class="mt-1 text-sm font-medium leading-6 text-neutral-500">
                      Ketik kata seperti sekolah, keamanan, kesehatan, tani, usaha, air, atau budaya.
                    </p>
                  </div>

                  <button type="button" class="grid h-10 w-10 place-items-center rounded-2xl text-neutral-500 transition hover:bg-neutral-100 hover:text-neutral-950" @click="closeIconPicker">
                    <Icon icon="solar:close-circle-bold-duotone" class="h-6 w-6" />
                  </button>
                </div>

                <div class="mt-5 grid gap-3 lg:grid-cols-[1fr_auto]">
                  <div class="relative">
                    <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-4 text-neutral-400">
                      <Icon icon="solar:magnifer-linear" class="h-5 w-5" />
                    </div>
                    <input v-model.trim="iconQuery" type="text" placeholder="Contoh: desa, sekolah, kesehatan, usaha, tani..." class="input-field py-3 pl-12">
                  </div>

                  <button type="button" class="inline-flex items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-5 py-3 text-sm font-black text-neutral-700 transition hover:bg-neutral-50" @click="clearIcon">
                    <Icon icon="solar:refresh-circle-bold-duotone" class="h-5 w-5" />
                    Default
                  </button>
                </div>

                <div class="mt-4 flex flex-wrap items-center gap-2">
                  <button
                    v-for="keyword in iconKeywordChips"
                    :key="keyword"
                    type="button"
                    class="rounded-full border px-3 py-1.5 text-xs font-black transition"
                    :class="iconQuery.toLowerCase() === keyword.toLowerCase() ? 'border-blue-600 bg-blue-600 text-white' : 'border-neutral-200 bg-neutral-50 text-neutral-600 hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700'"
                    @click="iconQuery = keyword"
                  >
                    {{ keyword }}
                  </button>
                </div>

                <div class="mt-4 flex flex-wrap items-center gap-2">
                  <span class="rounded-full border border-neutral-200 bg-neutral-50 px-3 py-1 text-xs font-black text-neutral-500">Dipilih:</span>
                  <span class="inline-flex items-center gap-2 rounded-full bg-blue-50 px-3 py-1 text-xs font-black text-blue-700">
                    <Icon :key="form.icon || defaultInstitutionIcon" :icon="form.icon || defaultInstitutionIcon" class="h-4 w-4" />
                    {{ selectedIconLabel }}
                  </span>
                  <span class="rounded-full border border-neutral-200 bg-neutral-50 px-3 py-1 text-xs font-black text-neutral-500">
                    {{ filteredIconResults.length }} ikon
                  </span>
                </div>
              </div>

              <div class="max-h-[62vh] overflow-y-auto p-5">
                <div v-if="filteredIconResults.length === 0" class="rounded-[2rem] border border-dashed border-neutral-300 bg-neutral-50 p-10 text-center">
                  <div class="mx-auto grid h-16 w-16 place-items-center rounded-3xl bg-white text-neutral-400">
                    <Icon icon="solar:gallery-minimalistic-bold-duotone" class="h-8 w-8" />
                  </div>
                  <h3 class="mt-4 text-lg font-black text-neutral-950">Ikon tidak ditemukan</h3>
                  <p class="mx-auto mt-2 max-w-md text-sm font-medium leading-6 text-neutral-500">
                    Coba keyword lain seperti <b>desa</b>, <b>sekolah</b>, <b>tani</b>, <b>kesehatan</b>, atau <b>usaha</b>.
                  </p>
                </div>

                <div v-else class="grid grid-cols-3 gap-3 sm:grid-cols-5 md:grid-cols-7 lg:grid-cols-9">
                  <button
                    v-for="icon in filteredIconResults"
                    :key="icon.name"
                    type="button"
                    class="group rounded-3xl border p-3 text-center transition hover:-translate-y-0.5 hover:border-blue-300 hover:bg-blue-50"
                    :class="form.icon === icon.name ? 'border-blue-600 bg-blue-50 ring-4 ring-blue-100' : 'border-neutral-200 bg-white'"
                    @click="selectIcon(icon.name)"
                  >
                    <div class="mx-auto grid h-11 w-11 place-items-center rounded-2xl bg-neutral-50 text-blue-600 transition group-hover:bg-white">
                      <Icon :key="icon.name" :icon="icon.name" class="h-6 w-6" />
                    </div>
                    <p class="mt-2 line-clamp-2 text-[10px] font-bold leading-4 text-neutral-500">{{ icon.label }}</p>
                  </button>
                </div>
              </div>

              <div class="border-t border-neutral-200 bg-neutral-50 p-4">
                <div class="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
                  <p class="text-xs font-semibold leading-5 text-neutral-500">
                    Pilih ikon yang paling mendekati fungsi lembaga. Ikon langsung tampil di form dan card.
                  </p>
                  <button type="button" class="inline-flex items-center justify-center gap-2 rounded-2xl bg-blue-600 px-5 py-3 text-sm font-black text-white shadow-sm shadow-blue-600/20 transition hover:bg-blue-700" @click="closeIconPicker">
                    Pakai Ikon
                    <Icon icon="solar:check-circle-bold-duotone" class="h-5 w-5" />
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>

    <!-- Insert Media Modal -->
    <Teleport to="body">
      <Transition enter-active-class="transition duration-200 ease-out" enter-from-class="opacity-0" enter-to-class="opacity-100" leave-active-class="transition duration-150 ease-in" leave-from-class="opacity-100" leave-to-class="opacity-0">
        <div v-if="showMediaModal" class="fixed inset-0 z-[9992] flex items-center justify-center bg-neutral-950/50 p-4 backdrop-blur-sm">
          <div class="w-full max-w-xl rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-2xl">
            <div class="flex items-start justify-between gap-4">
              <div>
                <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">Tambah Media</p>
                <h2 class="mt-1 text-xl font-black text-neutral-950">{{ mediaTitle }}</h2>
              </div>
              <button type="button" class="grid h-10 w-10 place-items-center rounded-2xl text-neutral-500 transition hover:bg-neutral-100 hover:text-neutral-950" @click="closeMediaModal">
                <Icon icon="solar:close-circle-bold-duotone" class="h-6 w-6" />
              </button>
            </div>

            <div class="mt-5 space-y-4">
              <div>
                <label class="mb-2 block text-sm font-black text-neutral-700">Alamat / Embed</label>
                <textarea v-model.trim="mediaForm.url" rows="4" :placeholder="mediaPlaceholder" class="textarea-field"></textarea>
              </div>
              <div>
                <label class="mb-2 block text-sm font-black text-neutral-700">Judul / Keterangan</label>
                <input v-model.trim="mediaForm.title" type="text" placeholder="Opsional" class="input-field">
              </div>
              <div v-if="mediaError" class="rounded-2xl border border-red-200 bg-red-50 px-4 py-3 text-sm font-bold text-red-700">
                {{ mediaError }}
              </div>
            </div>

            <div class="mt-6 flex flex-col-reverse gap-3 sm:flex-row sm:justify-end">
              <button type="button" class="inline-flex items-center justify-center rounded-2xl border border-neutral-200 bg-white px-5 py-3 text-sm font-black text-neutral-700 transition hover:bg-neutral-50" @click="closeMediaModal">
                Batal
              </button>
              <button type="button" class="inline-flex items-center justify-center gap-2 rounded-2xl bg-blue-600 px-5 py-3 text-sm font-black text-white shadow-sm shadow-blue-600/20 transition hover:bg-blue-700" @click="confirmInsertMedia">
                <Icon icon="solar:add-circle-bold-duotone" class="h-5 w-5" />
                Tambahkan
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
          <div class="w-full max-w-md rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-2xl">
            <div class="grid h-14 w-14 place-items-center rounded-3xl bg-red-50 text-red-600">
              <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-7 w-7" />
            </div>
            <h2 class="mt-5 text-xl font-black text-neutral-950">Hapus lembaga?</h2>
            <p class="mt-2 text-sm font-medium leading-6 text-neutral-500">
              Data <strong class="text-neutral-900">{{ selectedInstitution?.title }}</strong> akan dihapus dari daftar.
            </p>
            <div class="mt-6 flex flex-col-reverse gap-3 sm:flex-row sm:justify-end">
              <button type="button" class="inline-flex items-center justify-center rounded-2xl border border-neutral-200 bg-white px-5 py-3 text-sm font-black text-neutral-700 transition hover:bg-neutral-50" @click="showDelete = false">
                Batal
              </button>
              <button type="button" :disabled="deleting" class="inline-flex items-center justify-center gap-2 rounded-2xl bg-red-600 px-5 py-3 text-sm font-black text-white transition hover:bg-red-700 disabled:cursor-not-allowed disabled:opacity-60" @click="confirmDelete">
                <Icon :icon="deleting ? 'solar:refresh-bold-duotone' : 'solar:trash-bin-trash-bold-duotone'" class="h-5 w-5" :class="deleting ? 'animate-spin' : ''" />
                {{ deleting ? 'Menghapus...' : 'Hapus' }}
              </button>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>

    <!-- Close Form Modal -->
    <Teleport to="body">
      <Transition enter-active-class="transition duration-200 ease-out" enter-from-class="opacity-0" enter-to-class="opacity-100" leave-active-class="transition duration-150 ease-in" leave-from-class="opacity-100" leave-to-class="opacity-0">
        <div v-if="showCloseConfirm" class="fixed inset-0 z-[10004] flex items-center justify-center bg-neutral-950/50 p-4 backdrop-blur-sm">
          <div class="w-full max-w-md rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-2xl">
            <div class="grid h-14 w-14 place-items-center rounded-3xl bg-blue-50 text-blue-600">
              <Icon icon="solar:info-circle-bold-duotone" class="h-7 w-7" />
            </div>
            <h2 class="mt-5 text-xl font-black text-neutral-950">Tutup editor?</h2>
            <p class="mt-2 text-sm font-medium leading-6 text-neutral-500">
              Perubahan yang belum disimpan tidak akan diterapkan.
            </p>
            <div class="mt-6 flex flex-col-reverse gap-3 sm:flex-row sm:justify-end">
              <button type="button" class="inline-flex items-center justify-center rounded-2xl border border-neutral-200 bg-white px-5 py-3 text-sm font-black text-neutral-700 transition hover:bg-neutral-50" @click="showCloseConfirm = false">
                Lanjut Edit
              </button>
              <button type="button" class="inline-flex items-center justify-center gap-2 rounded-2xl bg-blue-600 px-5 py-3 text-sm font-black text-white shadow-sm shadow-blue-600/20 transition hover:bg-blue-700" @click="forceCloseForm">
                Tutup
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
import Placeholder from '@tiptap/extension-placeholder'
import { Table } from '@tiptap/extension-table'
import { TableRow } from '@tiptap/extension-table-row'
import { TableCell } from '@tiptap/extension-table-cell'
import { TableHeader } from '@tiptap/extension-table-header'
import { Node, mergeAttributes } from '@tiptap/core'
import { computed, defineComponent, h, nextTick, onBeforeUnmount, onMounted, reactive, ref, shallowRef, unref, watch } from 'vue'
import { useHead, useRequestURL, useRuntimeConfig, useSeoMeta } from 'nuxt/app'
import type {
  CreateInstitutionPayload,
  InstitutionItem,
  InstitutionListResponse,
  InstitutionStatus,
  UpdateInstitutionPayload
} from '~/types/institution'
import { useCloudinaryUpload } from '~/composables/useCloudinaryUpload'
import { useAppApi } from '../../composables/useAppApi'

definePageMeta({
  layout: 'app',
  layoutProps: { title: 'Lembaga' }
})

type ToastType = 'success' | 'error'
type MediaType = 'image-url' | 'pdf' | 'youtube' | 'map'
type IconItem = { name: string; label: string; keywords: string[] }

const config = useRuntimeConfig()
const requestUrl = useRequestURL()
const editor = shallowRef<Editor | null>(null)

const search = ref('')
const selectedStatus = ref<InstitutionStatus | 'all'>('all')
const sortBy = ref<'newest' | 'oldest' | 'title' | 'sort_order'>('sort_order')
const page = ref(1)
const pageSize = 12

const showForm = ref(false)
const showDelete = ref(false)
const showCloseConfirm = ref(false)
const formMode = ref<'create' | 'edit'>('create')
const saving = ref(false)
const deleting = ref(false)
const formError = ref('')
const selectedInstitution = ref<InstitutionItem | null>(null)
const manualSlugEdited = ref(false)
const formTouched = ref(false)
const formStep = ref(1)

const logoInput = ref<HTMLInputElement | null>(null)
const moreToolbarOpen = ref(false)
const contextToolbarOpen = ref(false)
const contextToolbar = reactive({ x: 0, y: 0 })

const showMediaModal = ref(false)
const mediaType = ref<MediaType>('image-url')
const mediaError = ref('')
const editorImageInput = ref<HTMLInputElement | null>(null)
const mediaForm = reactive({ url: '', title: '' })

const showIconPicker = ref(false)
const iconQuery = ref('desa')

const linkModal = reactive({
  open: false,
  url: '',
  text: '',
  error: ''
})

const {
  uploading: imageUploading,
  uploadError: imageUploadError,
  uploadImage
} = useCloudinaryUpload()

const formSteps = [
  { value: 1, title: 'Identitas', description: 'Nama, logo, ikon', icon: 'solar:buildings-2-bold-duotone' },
  { value: 2, title: 'Konten', description: 'Editor lengkap', icon: 'solar:pen-new-square-bold-duotone' },
  { value: 3, title: 'Review', description: 'Cek & simpan', icon: 'solar:clipboard-check-bold-duotone' }
]

const hostname = computed(() => String(requestUrl.hostname || '').replace(/^www\./, '').toLowerCase())
const tenantSlug = computed(() => {
  const envClient = String(config.public.clientName || '').trim().toLowerCase()
  if (hostname.value.includes('martopuro')) return 'martopuro'
  if (hostname.value.includes('obayan')) return 'obayan'
  return envClient || 'martopuro'
})
const appName = computed(() => String(config.public.appName || config.public.clientDisplayName || config.public.siteName || 'Arsades'))
const appLogo = computed(() => String(config.public.appLogo || config.public.logoUrl || config.public.siteLogo || '').trim())

const themeVars = computed<Record<string, string>>(() => ({
  '--brand': '#2563eb',
  '--brand-soft': '#eff6ff',
  '--brand-ring': 'rgba(37, 99, 235, 0.14)'
}))

const { tenantApiUrl } = useAppApi()
const apiUrl = computed(() => tenantApiUrl(tenantSlug.value, '/institutions'))
const queryParams = computed(() => ({
  status: selectedStatus.value === 'all' ? undefined : selectedStatus.value,
  limit: 100,
  sort: sortBy.value
}))

const { data, pending, error, refresh } = useFetch<InstitutionListResponse>(apiUrl, {
  key: computed(() => `tenant-institutions-${tenantSlug.value}-${selectedStatus.value}-${sortBy.value}`),
  query: queryParams,
  watch: [tenantSlug, selectedStatus, sortBy],
  default: () => ({
    data: [],
    meta: { page: 1, limit: 100, total: 0, totalPages: 1 }
  })
})

const toast = reactive({ show: false, type: 'success' as ToastType, title: '', message: '' })
let toastTimer: ReturnType<typeof setTimeout> | null = null

const defaultInstitutionIcon = 'solar:buildings-2-bold-duotone'
const form = reactive({
  title: '',
  subtitle: '',
  slug: '',
  icon: '' as string | null,
  logoUrl: '',
  status: 'active' as InstitutionStatus,
  isFeatured: true,
  sortOrder: 0
})

const institutions = computed(() => data.value?.data || [])
const isLoading = computed(() => Boolean(unref(pending)))
const visibleError = computed(() => {
  const value = unref(error)
  if (!value) return ''
  if (typeof value === 'string') return value
  return value?.message || 'Data lembaga belum bisa dimuat.'
})

const filteredInstitutions = computed(() => {
  const keyword = search.value.trim().toLowerCase()
  const rows = institutions.value.filter((item) => {
    if (!keyword) return true
    return [item.title, item.subtitle, item.slug, stripHtml(item.contentHtml || '')]
      .filter(Boolean)
      .join(' ')
      .toLowerCase()
      .includes(keyword)
  })

  return rows.sort((a, b) => {
    if (sortBy.value === 'title') return String(a.title || '').localeCompare(String(b.title || ''))
    if (sortBy.value === 'newest') return Number(b.createdAt || 0) - Number(a.createdAt || 0)
    if (sortBy.value === 'oldest') return Number(a.createdAt || 0) - Number(b.createdAt || 0)

    const sortA = Number(a.sortOrder || 0)
    const sortB = Number(b.sortOrder || 0)
    if (sortA !== sortB) return sortA - sortB
    return String(a.title || '').localeCompare(String(b.title || ''))
  })
})

const pagedInstitutions = computed(() => filteredInstitutions.value.slice(0, page.value * pageSize))
const hasMore = computed(() => pagedInstitutions.value.length < filteredInstitutions.value.length)
const readTime = computed(() => estimateReadTime(editor.value?.getText() || ''))
const formStepProgress = computed(() => Math.round((formStep.value / formSteps.length) * 100))
const contentTextPreview = computed(() => stripHtml(editor.value?.getHTML() || '').slice(0, 140))
const selectedIconLabel = computed(() => form.icon || 'Default')

const mediaTitle = computed(() => {
  if (mediaType.value === 'image-url') return 'Tambah Gambar'
  if (mediaType.value === 'pdf') return 'Tambah Dokumen'
  if (mediaType.value === 'youtube') return 'Tambah Video'
  return 'Tambah Peta'
})
const mediaPlaceholder = computed(() => {
  if (mediaType.value === 'image-url') return 'https://contoh.com/gambar.jpg'
  if (mediaType.value === 'pdf') return 'Tempel alamat dokumen atau iframe embed'
  if (mediaType.value === 'youtube') return 'https://www.youtube.com/watch?v=...'
  return 'Tempel alamat embed peta atau iframe'
})

const mediaMenu = [
  { label: 'Gambar dari Link', icon: 'solar:gallery-add-bold-duotone', type: 'image-url' as MediaType },
  { label: 'Dokumen PDF', icon: 'solar:file-text-bold-duotone', type: 'pdf' as MediaType },
  { label: 'Video YouTube', icon: 'solar:video-frame-play-horizontal-bold-duotone', type: 'youtube' as MediaType },
  { label: 'Peta Lokasi', icon: 'solar:map-point-bold-duotone', type: 'map' as MediaType }
]

const primaryEditorButtons = computed(() => {
  const ed = editor.value
  if (!ed) return []

  return [
    { label: 'Paragraf', icon: 'solar:text-bold-duotone', active: () => ed.isActive('paragraph'), action: () => ed.chain().focus().setParagraph().run() },
    { label: 'H1', icon: 'solar:text-square-bold-duotone', active: () => ed.isActive('heading', { level: 1 }), action: () => ed.chain().focus().toggleHeading({ level: 1 }).run() },
    { label: 'H2', icon: 'solar:text-square-2-bold-duotone', active: () => ed.isActive('heading', { level: 2 }), action: () => ed.chain().focus().toggleHeading({ level: 2 }).run() },
    { label: 'H3', icon: 'solar:text-square-2-bold-duotone', active: () => ed.isActive('heading', { level: 3 }), action: () => ed.chain().focus().toggleHeading({ level: 3 }).run() },
    { label: 'Bold', icon: 'solar:text-bold-bold-duotone', active: () => ed.isActive('bold'), action: () => ed.chain().focus().toggleBold().run() },
    { label: 'Italic', icon: 'solar:text-italic-bold-duotone', active: () => ed.isActive('italic'), action: () => ed.chain().focus().toggleItalic().run() },
    { label: 'Bullet', icon: 'solar:list-bold-duotone', active: () => ed.isActive('bulletList'), action: () => ed.chain().focus().toggleBulletList().run() },
    { label: 'Nomor', icon: 'solar:list-down-bold-duotone', active: () => ed.isActive('orderedList'), action: () => ed.chain().focus().toggleOrderedList().run() }
  ]
})

const secondaryEditorButtons = computed(() => {
  const ed = editor.value
  if (!ed) return []

  return [
    { label: 'Quote', icon: 'solar:quote-up-bold-duotone', action: () => ed.chain().focus().toggleBlockquote().run() },
    { label: 'Buat Tabel', icon: 'solar:table-bold-duotone', action: () => ed.chain().focus().insertTable({ rows: 3, cols: 3, withHeaderRow: true }).run() },
    { label: 'Tambah Baris', icon: 'solar:row-horizontal-bold-duotone', action: () => ed.chain().focus().addRowAfter().run() },
    { label: 'Tambah Kolom', icon: 'solar:slider-horizontal-bold-duotone', action: () => ed.chain().focus().addColumnAfter().run() },
    { label: 'Hapus Tabel', icon: 'solar:trash-bin-trash-bold-duotone', action: () => ed.chain().focus().deleteTable().run() },
    { label: 'Undo', icon: 'solar:undo-left-bold-duotone', action: () => ed.chain().focus().undo().run() },
    { label: 'Redo', icon: 'solar:undo-right-bold-duotone', action: () => ed.chain().focus().redo().run() }
  ]
})

const contextEditorButtons = computed(() => {
  const ed = editor.value
  if (!ed) return []

  return [
    { label: 'Bold', icon: 'solar:text-bold-bold-duotone', action: () => ed.chain().focus().toggleBold().run() },
    { label: 'Italic', icon: 'solar:text-italic-bold-duotone', action: () => ed.chain().focus().toggleItalic().run() },
    { label: 'Tautan', icon: 'solar:link-circle-bold-duotone', action: () => openLinkModal() },
    { label: 'Tabel', icon: 'solar:table-bold-duotone', action: () => ed.chain().focus().insertTable({ rows: 3, cols: 3, withHeaderRow: true }).run() },
    { label: 'Gambar / Video / Peta', icon: 'solar:menu-dots-bold', action: () => { moreToolbarOpen.value = true } }
  ]
})

const iconKeywordChips = ['desa', 'pemerintah', 'sekolah', 'kesehatan', 'keamanan', 'tani', 'usaha', 'wanita', 'pemuda', 'agama', 'air', 'budaya']
const iconDatabase: IconItem[] = [
  { name: 'solar:buildings-2-bold-duotone', label: 'Gedung', keywords: ['desa', 'lembaga', 'kantor', 'pemerintah', 'building'] },
  { name: 'solar:buildings-3-bold-duotone', label: 'Kantor', keywords: ['desa', 'kantor', 'pemerintah', 'office'] },
  { name: 'solar:home-2-bold-duotone', label: 'Rumah', keywords: ['desa', 'warga', 'rumah'] },
  { name: 'solar:city-bold-duotone', label: 'Wilayah', keywords: ['desa', 'kota', 'wilayah'] },
  { name: 'solar:map-point-bold-duotone', label: 'Lokasi', keywords: ['lokasi', 'map', 'desa'] },
  { name: 'solar:users-group-rounded-bold-duotone', label: 'Kelompok', keywords: ['warga', 'komunitas', 'pemuda', 'lembaga'] },
  { name: 'solar:user-hands-bold-duotone', label: 'Pelayanan', keywords: ['pelayanan', 'masyarakat', 'sosial'] },
  { name: 'solar:hand-heart-bold-duotone', label: 'Sosial', keywords: ['sosial', 'wanita', 'pkk', 'kesehatan'] },
  { name: 'solar:shield-check-bold-duotone', label: 'Keamanan', keywords: ['keamanan', 'linmas', 'babinsa', 'perlindungan'] },
  { name: 'solar:shield-user-bold-duotone', label: 'Petugas', keywords: ['keamanan', 'petugas', 'linmas'] },
  { name: 'solar:health-bold-duotone', label: 'Kesehatan', keywords: ['kesehatan', 'posyandu', 'medis'] },
  { name: 'solar:heart-pulse-bold-duotone', label: 'Posyandu', keywords: ['kesehatan', 'posyandu', 'anak'] },
  { name: 'solar:book-bookmark-bold-duotone', label: 'Pendidikan', keywords: ['sekolah', 'pendidikan', 'paud', 'buku'] },
  { name: 'solar:diploma-bold-duotone', label: 'Sekolah', keywords: ['sekolah', 'pendidikan', 'paud'] },
  { name: 'solar:case-round-bold-duotone', label: 'Usaha', keywords: ['usaha', 'bumdes', 'bisnis', 'ekonomi'] },
  { name: 'solar:shop-2-bold-duotone', label: 'Toko', keywords: ['usaha', 'umkm', 'ekonomi', 'pasar'] },
  { name: 'solar:chart-2-bold-duotone', label: 'Ekonomi', keywords: ['usaha', 'ekonomi', 'bumdes'] },
  { name: 'solar:leaf-bold-duotone', label: 'Tani', keywords: ['tani', 'gapoktan', 'pertanian', 'hijau'] },
  { name: 'solar:waterdrop-bold-duotone', label: 'Air', keywords: ['air', 'hippam', 'hippa', 'irigasi'] },
  { name: 'solar:dropper-3-bold-duotone', label: 'Irigasi', keywords: ['air', 'irigasi', 'hippa'] },
  { name: 'solar:flag-bold-duotone', label: 'Pemuda', keywords: ['pemuda', 'karang taruna', 'kegiatan'] },
  { name: 'solar:star-fall-bold-duotone', label: 'Unggulan', keywords: ['featured', 'unggulan', 'budaya'] },
  { name: 'solar:palette-bold-duotone', label: 'Budaya', keywords: ['budaya', 'seni', 'kegiatan'] },
  { name: 'solar:music-note-3-bold-duotone', label: 'Seni', keywords: ['budaya', 'seni', 'musik'] },
  { name: 'solar:moon-bold-duotone', label: 'Agama', keywords: ['agama', 'religius', 'keagamaan'] },
  { name: 'solar:stars-bold-duotone', label: 'Keagamaan', keywords: ['agama', 'keagamaan', 'masjid'] },
  { name: 'lucide:landmark', label: 'Pemerintah', keywords: ['pemerintah', 'desa', 'kantor'] },
  { name: 'lucide:building-2', label: 'Bangunan', keywords: ['desa', 'lembaga', 'gedung'] },
  { name: 'lucide:users-round', label: 'Warga', keywords: ['warga', 'komunitas', 'pemuda'] },
  { name: 'lucide:graduation-cap', label: 'Pendidikan', keywords: ['sekolah', 'pendidikan'] },
  { name: 'lucide:heart-pulse', label: 'Kesehatan', keywords: ['kesehatan', 'posyandu'] },
  { name: 'lucide:shield-check', label: 'Aman', keywords: ['keamanan', 'linmas'] },
  { name: 'lucide:store', label: 'UMKM', keywords: ['usaha', 'umkm', 'ekonomi'] },
  { name: 'lucide:sprout', label: 'Pertanian', keywords: ['tani', 'gapoktan'] },
  { name: 'lucide:droplets', label: 'Air', keywords: ['air', 'hippam', 'irigasi'] },
  { name: 'lucide:hand-heart', label: 'PKK', keywords: ['wanita', 'pkk', 'sosial'] },
  { name: 'lucide:mosque', label: 'Masjid', keywords: ['agama', 'masjid', 'religius'] },
  { name: 'mdi:account-group', label: 'Kelompok', keywords: ['komunitas', 'warga', 'lembaga'] },
  { name: 'mdi:office-building', label: 'Kantor', keywords: ['kantor', 'desa', 'pemerintah'] },
  { name: 'mdi:school', label: 'Sekolah', keywords: ['sekolah', 'pendidikan'] },
  { name: 'mdi:medical-bag', label: 'Kesehatan', keywords: ['kesehatan', 'medis'] },
  { name: 'mdi:shield-account', label: 'Keamanan', keywords: ['keamanan', 'linmas'] },
  { name: 'mdi:storefront', label: 'Usaha', keywords: ['usaha', 'umkm'] },
  { name: 'mdi:rice', label: 'Tani', keywords: ['tani', 'pertanian'] },
  { name: 'mdi:water', label: 'Air', keywords: ['air', 'irigasi'] },
  { name: 'tabler:building-community', label: 'Komunitas', keywords: ['desa', 'komunitas'] },
  { name: 'tabler:users-group', label: 'Grup', keywords: ['warga', 'kelompok'] },
  { name: 'tabler:school', label: 'Pendidikan', keywords: ['sekolah', 'pendidikan'] },
  { name: 'tabler:heart-handshake', label: 'Sosial', keywords: ['sosial', 'pkk', 'wanita'] },
  { name: 'tabler:shield-check', label: 'Keamanan', keywords: ['keamanan', 'linmas'] },
  { name: 'tabler:plant-2', label: 'Tanaman', keywords: ['tani', 'pertanian'] },
  { name: 'tabler:droplet', label: 'Air', keywords: ['air', 'hippam'] }
]

const filteredIconResults = computed(() => {
  const keyword = iconQuery.value.trim().toLowerCase()
  if (!keyword) return iconDatabase

  const terms = keyword.split(/\s+/).filter(Boolean)
  return iconDatabase.filter((icon) => {
    const source = [icon.name, icon.label, ...icon.keywords].join(' ').toLowerCase()
    return terms.every((term) => source.includes(term))
  })
})

watch([search, selectedStatus, sortBy], () => { page.value = 1 })

useSeoMeta({
  title: () => `Kelola Lembaga · ${appName.value}`,
  description: () => `Kelola data lembaga untuk ${appName.value}.`,
  ogTitle: () => `Kelola Lembaga · ${appName.value}`,
  ogDescription: () => `Kelola data lembaga untuk ${appName.value}.`,
  robots: 'noindex, nofollow',
  themeColor: '#2563eb'
})

useHead(() => ({
  htmlAttrs: { lang: 'id' },
  meta: [{ name: 'theme-color', content: '#2563eb' }]
}))

onMounted(() => {
  ensureEditor()
})

onBeforeUnmount(() => {
  editor.value?.destroy()
})

const PdfEmbed = Node.create({
  name: 'pdfEmbed',
  group: 'block',
  atom: true,
  addAttributes() {
    return { src: { default: null }, title: { default: 'Dokumen' } }
  },
  parseHTML() { return [{ tag: 'iframe[data-type="pdf-embed"]' }] },
  renderHTML({ HTMLAttributes }) {
    return ['iframe', mergeAttributes(HTMLAttributes, {
      'data-type': 'pdf-embed',
      src: HTMLAttributes.src,
      title: HTMLAttributes.title || 'Dokumen',
      class: 'tiptap-embed tiptap-pdf',
      loading: 'lazy'
    })]
  },
  addCommands() {
    return {
      setPdfEmbed: (attrs: any) => ({ commands }: any) => commands.insertContent({ type: this.name, attrs })
    } as any
  }
})

const MapEmbed = Node.create({
  name: 'mapEmbed',
  group: 'block',
  atom: true,
  addAttributes() {
    return { src: { default: null }, title: { default: 'Peta Lokasi' } }
  },
  parseHTML() { return [{ tag: 'iframe[data-type="map-embed"]' }] },
  renderHTML({ HTMLAttributes }) {
    return ['iframe', mergeAttributes(HTMLAttributes, {
      'data-type': 'map-embed',
      src: HTMLAttributes.src,
      title: HTMLAttributes.title || 'Peta Lokasi',
      class: 'tiptap-embed tiptap-map',
      loading: 'lazy',
      allowfullscreen: 'true',
      referrerpolicy: 'no-referrer-when-downgrade'
    })]
  },
  addCommands() {
    return {
      setMapEmbed: (attrs: any) => ({ commands }: any) => commands.insertContent({ type: this.name, attrs })
    } as any
  }
})

function ensureEditor() {
  if (editor.value) return

  editor.value = new Editor({
    content: '<p></p>',
    extensions: [
      StarterKit.configure({ heading: { levels: [1, 2, 3] } }),
      Link.configure({
        openOnClick: false,
        HTMLAttributes: { class: 'text-blue-600 underline underline-offset-4' }
      }),
      Placeholder.configure({ placeholder: 'Tulis profil lembaga di sini...' }),
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
      Table.configure({
        resizable: true,
        HTMLAttributes: { class: 'tiptap-table' }
      }),
      TableRow,
      TableHeader,
      TableCell,
      PdfEmbed,
      MapEmbed
    ],
    editorProps: {
      attributes: { class: 'outline-none min-h-[320px] prose prose-neutral max-w-none' }
    }
  })
}

async function reloadInstitutions() {
  try {
    await refresh()
  } catch (error: any) {
    showToast('error', 'Gagal Memuat Data', error?.message || 'Data lembaga gagal dimuat.')
  }
}

function resetFilters() {
  search.value = ''
  selectedStatus.value = 'all'
  sortBy.value = 'sort_order'
  page.value = 1
}

function resetForm() {
  formStep.value = 1
  form.title = ''
  form.subtitle = ''
  form.slug = ''
  form.icon = null
  form.logoUrl = ''
  form.status = 'active'
  form.isFeatured = true
  form.sortOrder = 0
  formError.value = ''
  selectedInstitution.value = null
  manualSlugEdited.value = false
  formTouched.value = false
  moreToolbarOpen.value = false
  contextToolbarOpen.value = false

  if (logoInput.value) logoInput.value.value = ''

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

function openEdit(item: InstitutionItem) {
  formMode.value = 'edit'
  formStep.value = 1
  formTouched.value = false
  selectedInstitution.value = item
  form.title = item.title || ''
  form.subtitle = item.subtitle || ''
  form.slug = item.slug || ''
  form.icon = item.icon || null
  form.logoUrl = item.logoUrl || ''
  form.status = item.status || 'active'
  form.isFeatured = Boolean(item.isFeatured)
  form.sortOrder = Number(item.sortOrder || 0)
  formError.value = ''
  manualSlugEdited.value = true

  ensureEditor()

  if (item.contentJson) editor.value?.commands.setContent(item.contentJson)
  else if (item.contentHtml) editor.value?.commands.setContent(item.contentHtml)
  else editor.value?.commands.setContent('<p></p>')

  showForm.value = true
}

function requestCloseForm() {
  showCloseConfirm.value = true
}

function forceCloseForm() {
  showCloseConfirm.value = false
  closeForm()
}

function closeForm() {
  showForm.value = false
  formError.value = ''
  moreToolbarOpen.value = false
  contextToolbarOpen.value = false
}

function openDelete(item: InstitutionItem) {
  selectedInstitution.value = item
  showDelete.value = true
}

function validateCurrentFormStep() {
  formTouched.value = true
  formError.value = ''

  if (formStep.value === 1) {
    if (!form.title.trim()) {
      formError.value = 'Nama lembaga wajib diisi.'
      return false
    }

    if (!form.slug.trim()) form.slug = slugify(form.title)
    form.slug = slugify(form.slug)

    if (!form.slug) {
      formError.value = 'Slug belum valid.'
      return false
    }

    if (form.logoUrl && !isValidUrl(form.logoUrl)) {
      formError.value = 'Tautan logo belum valid.'
      return false
    }

    return true
  }

  if (formStep.value === 2) {
    const text = editor.value?.getText().trim() || ''
    if (text.length < 3) {
      formError.value = 'Konten minimal 3 karakter.'
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

async function submitForm() {
  if (!validateAllFormSteps()) return

  saving.value = true

  try {
    ensureEditor()
    const html = editor.value?.getHTML() || '<p></p>'
    const json = editor.value?.getJSON() || {}

    const payload: CreateInstitutionPayload | UpdateInstitutionPayload = {
      title: form.title.trim(),
      subtitle: form.subtitle.trim() || null,
      slug: slugify(form.slug || form.title),
      icon: form.icon || null,
      logoUrl: form.logoUrl.trim() || null,
      contentHtml: html,
      contentJson: json,
      status: form.status,
      isFeatured: form.isFeatured,
      sortOrder: Number(form.sortOrder || 0)
    }

    if (formMode.value === 'create') {
      await $fetch(apiUrl.value, { method: 'POST', body: payload })
      showToast('success', 'Berhasil Disimpan', 'Data lembaga berhasil ditambahkan.')
    } else if (selectedInstitution.value) {
      await $fetch(`${apiUrl.value}/${selectedInstitution.value.id}`, { method: 'PUT', body: payload })
      showToast('success', 'Berhasil Diupdate', 'Perubahan lembaga berhasil disimpan.')
    }

    showForm.value = false
    await reloadInstitutions()
  } catch (error: any) {
    const message = error?.data?.statusMessage || error?.data?.message || error?.statusMessage || error?.message || 'Data lembaga gagal disimpan.'
    formError.value = message
    showToast('error', 'Gagal Menyimpan', message)
  } finally {
    saving.value = false
  }
}

async function confirmDelete() {
  if (!selectedInstitution.value) return
  deleting.value = true

  try {
    await $fetch(`${apiUrl.value}/${selectedInstitution.value.id}`, { method: 'DELETE' })
    showDelete.value = false
    showToast('success', 'Data Dihapus', 'Data lembaga berhasil dihapus.')
    await reloadInstitutions()
  } catch (error: any) {
    showToast('error', 'Gagal Menghapus', error?.message || 'Data lembaga gagal dihapus.')
  } finally {
    deleting.value = false
  }
}

function triggerPickLogo() {
  logoInput.value?.click()
}

async function onPickLogo(event: Event) {
  const input = event.target as HTMLInputElement
  const file = input.files?.[0] || null
  if (!file) return

  try {
    const result = await uploadImage(file, {
      folder: `${tenantSlug.value}/institutions/logos`,
      maxWidth: 900,
      maxHeight: 900,
      quality: 0.85,
      maxBytes: 4 * 1024 * 1024
    })
    form.logoUrl = result.secure_url
    showToast('success', 'Logo Ditambahkan', 'Logo berhasil dipasang.')
  } catch (error: any) {
    showToast('error', 'Gagal Mengunggah', error?.message || imageUploadError.value || 'Logo belum bisa dipasang.')
  } finally {
    if (logoInput.value) logoInput.value.value = ''
  }
}

function syncSlugFromTitle() {
  if (manualSlugEdited.value && form.slug) return
  form.slug = slugify(form.title)
}

function onSlugInput() {
  manualSlugEdited.value = true
  form.slug = slugify(form.slug)
}

function regenerateSlug() {
  form.slug = slugify(form.title)
  manualSlugEdited.value = false
}

function statusClass(status: InstitutionStatus) {
  if (status === 'active') return 'bg-emerald-100/90 text-emerald-800'
  return 'bg-neutral-100/90 text-neutral-700'
}

function statusLabel(status: InstitutionStatus) {
  return status === 'active' ? 'Aktif' : 'Nonaktif'
}

function contentPreview(item: InstitutionItem) {
  return stripHtml(item.contentHtml || '').slice(0, 140)
}

function institutionDetailTo(slug?: string | null) {
  const cleanSlug = String(slug || '').trim()
  if (!cleanSlug) return '/institutions'
  return `/institutions?detail=${encodeURIComponent(cleanSlug)}`
}

async function copyPublicLink(item: InstitutionItem) {
  const url = `${requestUrl.origin}${institutionDetailTo(item.slug)}`
  try {
    await navigator.clipboard.writeText(url)
    showToast('success', 'Tautan Disalin', 'Tautan halaman publik berhasil disalin.')
  } catch {
    showToast('error', 'Gagal Menyalin', 'Tautan belum bisa disalin dari browser ini.')
  }
}

function openIconPicker() {
  showIconPicker.value = true
}

function closeIconPicker() {
  showIconPicker.value = false
}

function selectIcon(iconName: string) {
  form.icon = iconName
}

function clearIcon() {
  form.icon = null
}

function runMoreEditorAction(action: () => void) {
  action()
  moreToolbarOpen.value = false
}

function runContextAction(action: () => void) {
  action()
  contextToolbarOpen.value = false
}

function openMediaFromMore(type: MediaType) {
  moreToolbarOpen.value = false
  openMediaModal(type)
}

function openEditorContextMenu(event: MouseEvent) {
  contextToolbar.x = Math.min(event.clientX, window.innerWidth - 280)
  contextToolbar.y = Math.min(event.clientY, window.innerHeight - 360)
  contextToolbarOpen.value = true
  moreToolbarOpen.value = false
}

function triggerEditorImageUpload() {
  editorImageInput.value?.click()
}

async function onPickEditorImage(event: Event) {
  const input = event.target as HTMLInputElement
  const file = input.files?.[0] || null
  if (!file) return

  try {
    const result = await uploadImage(file, {
      folder: `${tenantSlug.value}/institutions/content`,
      maxWidth: 1600,
      maxHeight: 1600,
      quality: 0.82,
      maxBytes: 5 * 1024 * 1024
    })
    editor.value?.chain().focus().setImage({ src: result.secure_url, alt: file.name }).run()
    showToast('success', 'Gambar Ditambahkan', 'Gambar berhasil dimasukkan ke konten.')
  } catch (error: any) {
    showToast('error', 'Gagal Mengunggah', error?.message || imageUploadError.value || 'Gambar belum bisa ditambahkan.')
  } finally {
    if (editorImageInput.value) editorImageInput.value.value = ''
  }
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
    mediaError.value = 'Alamat atau embed belum valid.'
    return
  }

  ensureEditor()

  if (mediaType.value === 'image-url') editor.value?.chain().focus().setImage({ src: url, alt: mediaForm.title || 'Gambar' }).run()
  if (mediaType.value === 'pdf') (editor.value?.commands as any).setPdfEmbed({ src: embedPdfUrl(url), title: mediaForm.title || 'Dokumen' })
  if (mediaType.value === 'youtube') editor.value?.chain().focus().setYoutubeVideo({ src: url, width: 720, height: 405 }).run()
  if (mediaType.value === 'map') (editor.value?.commands as any).setMapEmbed({ src: url, title: mediaForm.title || 'Peta Lokasi' })

  closeMediaModal()
}

function openLinkModal() {
  ensureEditor()
  const { from, to } = editor.value?.state.selection || { from: 0, to: 0 }
  const selectedText = from !== to ? editor.value?.state.doc.textBetween(from, to, ' ') || '' : ''
  linkModal.open = true
  linkModal.text = selectedText
  linkModal.url = editor.value?.getAttributes('link')?.href || ''
  linkModal.error = ''
}

function closeLinkModal() {
  linkModal.open = false
  linkModal.error = ''
}

function insertLink() {
  const url = linkModal.url.trim()
  const text = linkModal.text.trim()

  if (!isValidUrl(url)) {
    linkModal.error = 'Tautan belum valid. Gunakan alamat yang dimulai dengan https:// atau http://.'
    return
  }

  ensureEditor()

  if (text) {
    editor.value?.chain().focus().insertContent(`<a href="${escapeHtml(url)}" target="_blank" rel="noopener">${escapeHtml(text)}</a>`).run()
  } else {
    editor.value?.chain().focus().extendMarkRange('link').setLink({ href: url, target: '_blank', rel: 'noopener' }).run()
  }

  closeLinkModal()
}

function extractIframeSrc(value: string) {
  const source = String(value || '').trim()
  const match = source.match(/src=["']([^"']+)["']/i)
  return match?.[1] || source
}

function embedPdfUrl(url: string) {
  const driveMatch = url.match(/drive\.google\.com\/file\/d\/([^/]+)/)
  if (driveMatch?.[1]) return `https://drive.google.com/file/d/${driveMatch[1]}/preview`
  return url
}

function isValidUrl(value: string) {
  try {
    const url = new URL(value)
    return ['http:', 'https:'].includes(url.protocol)
  } catch {
    return false
  }
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

function stripHtml(value: string) {
  return String(value || '')
    .replace(/<script[\s\S]*?>[\s\S]*?<\/script>/gi, ' ')
    .replace(/<style[\s\S]*?>[\s\S]*?<\/style>/gi, ' ')
    .replace(/<[^>]*>/g, ' ')
    .replace(/&nbsp;/g, ' ')
    .replace(/&amp;/g, '&')
    .replace(/&lt;/g, '<')
    .replace(/&gt;/g, '>')
    .replace(/&quot;/g, '"')
    .replace(/&#39;/g, "'")
    .replace(/\s+/g, ' ')
    .trim()
}

function estimateReadTime(text: string) {
  const words = String(text || '').trim().split(/\s+/).filter(Boolean).length
  return Math.max(1, Math.ceil(words / 200))
}

function escapeHtml(value: string) {
  return String(value || '')
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#039;')
}

function showToast(type: ToastType, title: string, message: string) {
  if (toastTimer) clearTimeout(toastTimer)
  toast.type = type
  toast.title = title
  toast.message = message
  toast.show = true
  toastTimer = setTimeout(() => { toast.show = false }, 3500)
}

function closeToast() {
  if (toastTimer) clearTimeout(toastTimer)
  toast.show = false
}

const InfoRow = defineComponent({
  props: {
    label: { type: String, required: true },
    value: { type: String, required: true }
  },
  setup(props) {
    return () => h('div', { class: 'flex items-center justify-between gap-4 rounded-2xl border border-neutral-200 bg-neutral-50 px-4 py-3' }, [
      h('span', { class: 'text-sm font-bold text-neutral-500' }, props.label),
      h('span', { class: 'min-w-0 truncate text-right text-sm font-black text-neutral-950' }, props.value)
    ])
  }
})
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
  font-weight: 650;
  color: rgb(38 38 38);
  outline: none;
  transition: 160ms ease;
}

.input-field:focus {
  border-color: #2563eb;
  background: white;
  box-shadow: 0 0 0 4px rgb(219 234 254);
}

.textarea-field {
  display: block;
  width: 100%;
  border-radius: 1rem;
  border: 1px solid rgb(229 229 229);
  background: rgb(250 250 250);
  padding: 0.75rem 1rem;
  font-size: 0.875rem;
  font-weight: 650;
  line-height: 1.6;
  color: rgb(38 38 38);
  outline: none;
  transition: 160ms ease;
}

.textarea-field:focus {
  border-color: #2563eb;
  background: white;
  box-shadow: 0 0 0 4px rgb(219 234 254);
}

.editor-btn {
  position: relative;
  display: inline-flex;
  height: 2.25rem;
  width: 2.25rem;
  align-items: center;
  justify-content: center;
  border-radius: 0.75rem;
  font-size: 0.75rem;
  font-weight: 900;
  transition: 160ms ease;
}

.editor-tooltip {
  pointer-events: none;
  position: absolute;
  bottom: calc(100% + 8px);
  left: 50%;
  z-index: 50;
  min-width: max-content;
  transform: translateX(-50%) translateY(4px);
  border-radius: 0.75rem;
  background: rgb(23 23 23);
  padding: 0.35rem 0.6rem;
  color: white;
  font-size: 0.7rem;
  opacity: 0;
  transition: 160ms ease;
}

.group:hover .editor-tooltip {
  transform: translateX(-50%) translateY(0);
  opacity: 1;
}

.editor-content :deep(.ProseMirror) {
  min-height: 320px;
  outline: none;
}

.editor-content :deep(.ProseMirror h1) {
  margin: 1.25rem 0 0.7rem;
  font-size: 2rem;
  line-height: 1.15;
  font-weight: 900;
  letter-spacing: -0.04em;
}

.editor-content :deep(.ProseMirror h2) {
  margin: 1.15rem 0 0.65rem;
  font-size: 1.5rem;
  line-height: 1.2;
  font-weight: 900;
  letter-spacing: -0.03em;
}

.editor-content :deep(.ProseMirror h3) {
  margin: 1rem 0 0.55rem;
  font-size: 1.2rem;
  line-height: 1.3;
  font-weight: 900;
}

.editor-content :deep(.ProseMirror p) {
  margin: 0.75rem 0;
  line-height: 1.8;
}

.editor-content :deep(.ProseMirror ul),
.editor-content :deep(.ProseMirror ol) {
  margin: 1rem 0;
  padding-left: 1.5rem;
}

.editor-content :deep(.ProseMirror li) {
  margin: 0.35rem 0;
}

.editor-content :deep(.ProseMirror blockquote) {
  margin: 1rem 0;
  border-left: 4px solid #2563eb;
  border-radius: 1rem;
  background: #f8fafc;
  padding: 0.85rem 1rem;
  color: #525252;
}

.editor-content :deep(.ProseMirror a) {
  color: #2563eb;
  font-weight: 800;
  text-decoration: underline;
  text-underline-offset: 4px;
}

.editor-content :deep(.ProseMirror img) {
  margin: 1rem 0;
  max-width: 100%;
  height: auto;
  border-radius: 1rem;
  border: 1px solid #e5e5e5;
}

.editor-content :deep(.ProseMirror iframe) {
  margin: 1rem 0;
  min-height: 360px;
  width: 100%;
  border: 0;
  border-radius: 1rem;
  background: #f5f5f5;
}

.editor-content :deep(.tiptap-table) {
  width: 100%;
  border-collapse: collapse;
  overflow: hidden;
  border-radius: 1rem;
}

.editor-content :deep(.tiptap-table th),
.editor-content :deep(.tiptap-table td) {
  min-width: 120px;
  border: 1px solid #d4d4d4;
  padding: 0.65rem 0.75rem;
  vertical-align: top;
}

.editor-content :deep(.tiptap-table th) {
  background: #eff6ff;
  color: #1d4ed8;
  font-weight: 900;
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
