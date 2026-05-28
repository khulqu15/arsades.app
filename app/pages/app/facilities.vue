<template>
  <section class="min-h-full bg-neutral-50 text-neutral-950">
    <Teleport to="body">
      <Transition
        enter-active-class="transition duration-300 ease-out"
        enter-from-class="translate-y-3 opacity-0 sm:translate-x-3 sm:translate-y-0"
        enter-to-class="translate-y-0 opacity-100 sm:translate-x-0"
        leave-active-class="transition duration-200 ease-in"
        leave-from-class="translate-y-0 opacity-100 sm:translate-x-0"
        leave-to-class="translate-y-3 opacity-0 sm:translate-x-3 sm:translate-y-0"
      >
        <div v-if="toast.show" class="fixed right-4 top-4 z-[10000] w-[calc(100%-2rem)] max-w-sm">
          <div
            class="rounded-[1.5rem] border bg-white/95 p-4 shadow-2xl shadow-neutral-900/10 backdrop-blur-xl"
            :class="toast.type === 'success' ? 'border-emerald-200' : 'border-red-200'"
          >
            <div class="flex items-start gap-3">
              <div
                class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl"
                :class="toast.type === 'success' ? 'bg-emerald-50 text-emerald-700' : 'bg-red-50 text-red-700'"
              >
                <Icon
                  :icon="toast.type === 'success' ? 'solar:check-circle-bold-duotone' : 'solar:danger-circle-bold-duotone'"
                  class="h-5 w-5"
                />
              </div>

              <div class="min-w-0 flex-1">
                <p class="text-sm font-black text-neutral-950">
                  {{ toast.title }}
                </p>
                <p class="mt-1 text-sm font-semibold leading-6 text-neutral-500">
                  {{ toast.message }}
                </p>
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

    <div class="space-y-4 p-4 sm:p-6">
      <section class="relative overflow-hidden rounded-[1.75rem] border border-neutral-200 bg-white p-4 shadow-sm sm:p-5">
        <div class="pointer-events-none absolute -right-28 -top-28 h-72 w-72 rounded-full bg-blue-100 blur-3xl"></div>
        <div class="pointer-events-none absolute -bottom-24 left-1/3 h-52 w-52 rounded-full bg-sky-100/80 blur-3xl"></div>

        <div class="relative flex flex-col gap-4 lg:flex-row lg:items-center lg:justify-between">
          <div class="flex min-w-0 items-start gap-3 sm:items-center">
            <div class="grid h-12 w-12 shrink-0 place-items-center overflow-hidden rounded-2xl border border-blue-100 bg-white shadow-sm ring-4 ring-blue-50 sm:h-14 sm:w-14">
              <img
                v-if="appLogo"
                :src="appLogo"
                :alt="appName"
                class="h-9 w-9 object-contain sm:h-10 sm:w-10"
                @error="logoFailed = true"
              >
              <Icon v-else icon="solar:buildings-3-bold-duotone" class="h-7 w-7 text-blue-600" />
            </div>

            <div class="min-w-0">
              <div class="mb-1.5 flex flex-wrap items-center gap-2">
                <span class="inline-flex items-center gap-1.5 rounded-full bg-blue-50 px-2.5 py-1 text-[11px] font-black uppercase tracking-[0.12em] text-blue-700">
                  <Icon icon="solar:map-point-wave-bold-duotone" class="h-3.5 w-3.5" />
                  Fasilitas Desa
                </span>
                <span class="rounded-full border border-neutral-200 bg-neutral-50 px-2.5 py-1 text-[11px] font-bold text-neutral-500">
                  {{ tenantSlug }}
                </span>
              </div>

              <h1 class="truncate text-2xl font-black tracking-tight text-neutral-950 sm:text-3xl">
                Kelola Fasilitas
              </h1>
              <p class="mt-1 max-w-2xl text-sm font-medium leading-6 text-neutral-500">
                Buat dan perbarui fasilitas publik dengan alur yang rapi, ringkas, dan mudah dipahami.
              </p>
            </div>
          </div>

          <div class="flex flex-wrap gap-2">
            <NuxtLink
              to="/facilities"
              class="inline-flex h-10 items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-black text-neutral-700 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
            >
              <Icon icon="solar:eye-bold-duotone" class="h-5 w-5" />
              Halaman Publik
            </NuxtLink>

            <button
              type="button"
              class="inline-flex h-10 items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-black text-neutral-700 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
              @click="reloadFacilities"
            >
              <Icon icon="solar:refresh-bold-duotone" class="h-5 w-5" :class="pending ? 'animate-spin' : ''" />
              Muat Ulang
            </button>

            <button
              type="button"
              class="inline-flex h-10 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:-translate-y-0.5 hover:bg-blue-700"
              @click="openCreate"
            >
              <Icon icon="solar:add-circle-bold-duotone" class="h-5 w-5" />
              Tambah
            </button>
          </div>
        </div>
      </section>

      <section class="rounded-[1.75rem] border border-neutral-200 bg-white p-3 shadow-sm sm:p-4">
        <div class="grid gap-3 lg:grid-cols-[1fr_170px_160px_150px]">
          <div class="relative">
            <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-4 text-neutral-400">
              <Icon icon="solar:magnifer-linear" class="h-5 w-5" />
            </div>
            <input
              v-model.trim="q"
              type="search"
              placeholder="Cari nama, alamat, kontak, atau isi fasilitas..."
              class="input-field pl-12"
            >
          </div>

          <select v-model="selectedType" class="input-field">
            <option value="all">Semua Tipe</option>
            <option v-for="type in facilityTypeOptions" :key="type.value" :value="type.value">
              {{ type.label }}
            </option>
          </select>

          <select v-model="selectedStatus" class="input-field">
            <option value="all">Semua Status</option>
            <option value="active">Tampil</option>
            <option value="inactive">Disimpan</option>
          </select>

          <select v-model="sort" class="input-field">
            <option value="sort_order">Urutan</option>
            <option value="name">A-Z</option>
            <option value="newest">Terbaru</option>
            <option value="oldest">Terlama</option>
          </select>
        </div>

        <div class="mt-3 flex flex-wrap items-center justify-between gap-3">
          <p class="text-xs font-bold text-neutral-500">
            {{ filteredFacilities.length }} fasilitas sesuai pencarian.
          </p>

          <button
            type="button"
            class="inline-flex h-9 items-center justify-center gap-2 rounded-xl border border-neutral-200 bg-white px-3 text-xs font-black text-neutral-600 transition hover:bg-neutral-50"
            @click="resetFilters"
          >
            <Icon icon="solar:restart-bold-duotone" class="h-4 w-4" />
            Reset
          </button>
        </div>
      </section>

      <div v-if="visibleError" class="rounded-[1.5rem] border border-red-200 bg-red-50 p-4 text-sm font-bold leading-6 text-red-700">
        {{ visibleError }}
      </div>

      <section v-if="pending" class="grid gap-3 md:grid-cols-2 xl:grid-cols-3">
        <article
          v-for="item in 6"
          :key="item"
          class="h-48 animate-pulse rounded-[1.5rem] border border-neutral-200 bg-white p-3 shadow-sm"
        >
          <div class="flex gap-3">
            <div class="h-20 w-24 rounded-2xl bg-neutral-100"></div>
            <div class="flex-1">
              <div class="h-4 w-32 rounded-full bg-neutral-100"></div>
              <div class="mt-3 h-3 w-full rounded-full bg-neutral-100"></div>
              <div class="mt-2 h-3 w-3/4 rounded-full bg-neutral-100"></div>
            </div>
          </div>
        </article>
      </section>

      <section
        v-else-if="filteredFacilities.length === 0"
        class="rounded-[1.75rem] border border-dashed border-neutral-300 bg-white p-8 text-center shadow-sm"
      >
        <div class="mx-auto grid h-14 w-14 place-items-center rounded-2xl bg-blue-50 text-blue-600">
          <Icon icon="solar:map-point-wave-bold-duotone" class="h-7 w-7" />
        </div>
        <h2 class="mt-4 text-xl font-black text-neutral-950">
          Belum ada fasilitas
        </h2>
        <p class="mx-auto mt-2 max-w-md text-sm font-medium leading-6 text-neutral-500">
          Tambahkan fasilitas agar warga dapat melihat informasi, lokasi, dan kontaknya di halaman publik.
        </p>
        <button
          type="button"
          class="mt-5 inline-flex h-10 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700"
          @click="openCreate"
        >
          <Icon icon="solar:add-circle-bold-duotone" class="h-5 w-5" />
          Tambah Fasilitas
        </button>
      </section>

      <section v-else class="grid gap-3 md:grid-cols-2 xl:grid-cols-3">
        <article
          v-for="item in pagedFacilities"
          :key="item.id"
          class="group overflow-hidden rounded-[1.5rem] border border-neutral-200 bg-white p-3 shadow-sm transition hover:-translate-y-0.5 hover:border-blue-200 hover:shadow-xl hover:shadow-blue-900/5"
        >
          <div class="flex gap-3">
            <div class="relative h-24 w-28 shrink-0 overflow-hidden rounded-2xl bg-neutral-100">
              <img
                v-if="getFacilityCover(item) && !failedImages[item.id]"
                :src="getFacilityCover(item)"
                :alt="item.title || item.name || 'Fasilitas'"
                class="h-full w-full object-cover transition duration-500 group-hover:scale-105"
                @error="markImageFailed(item.id)"
              >
              <div v-else class="flex h-full w-full items-center justify-center bg-gradient-to-br from-blue-50 via-white to-sky-50 text-blue-600">
                <Icon :icon="item.icon || getFacilityTypeIcon(item.facilityType)" class="h-10 w-10" />
              </div>
            </div>

            <div class="min-w-0 flex-1">
              <div class="flex items-start justify-between gap-2">
                <div class="min-w-0">
                  <p class="truncate text-[11px] font-black uppercase tracking-[0.12em] text-blue-600">
                    {{ facilityTypeLabel(item.facilityType) }}
                  </p>
                  <h2 class="mt-1 line-clamp-2 text-base font-black leading-6 text-neutral-950">
                    {{ item.title || item.name || 'Tanpa Judul' }}
                  </h2>
                </div>

                <span
                  class="shrink-0 rounded-full px-2.5 py-1 text-[10px] font-black uppercase"
                  :class="item.status === 'active' ? 'bg-blue-50 text-blue-700' : 'bg-neutral-100 text-neutral-500'"
                >
                  {{ item.status === 'active' ? 'Tampil' : 'Disimpan' }}
                </span>
              </div>

              <p class="mt-2 line-clamp-2 text-xs font-medium leading-5 text-neutral-500">
                {{ item.subtitle || item.shortDescription || plainText(item.contentHtml || '').slice(0, 120) || 'Informasi fasilitas belum diisi.' }}
              </p>

              <div v-if="item.address" class="mt-2 flex items-center gap-1.5 text-xs font-bold text-neutral-500">
                <Icon icon="solar:map-point-bold-duotone" class="h-4 w-4 shrink-0 text-blue-600" />
                <span class="truncate">{{ item.address }}</span>
              </div>
            </div>
          </div>

          <div class="mt-3 flex flex-wrap items-center justify-between gap-2 border-t border-neutral-100 pt-3">
            <NuxtLink
              :to="facilityDetailTo(item.slug)"
              target="_blank"
              class="inline-flex h-9 items-center justify-center gap-2 rounded-xl bg-blue-50 px-3 text-xs font-black text-blue-700 transition hover:bg-blue-600 hover:text-white"
            >
              <Icon icon="solar:eye-bold-duotone" class="h-4 w-4" />
              Lihat
            </NuxtLink>

            <div class="flex items-center gap-1.5">
              <button
                type="button"
                class="grid h-9 w-9 place-items-center rounded-xl border border-neutral-200 bg-white text-neutral-500 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
                title="Salin link"
                @click="copyPublicLink(item)"
              >
                <Icon icon="solar:copy-bold-duotone" class="h-4 w-4" />
              </button>

              <button
                type="button"
                class="grid h-9 w-9 place-items-center rounded-xl border border-neutral-200 bg-white text-neutral-500 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
                title="Edit"
                @click="openEdit(item)"
              >
                <Icon icon="solar:pen-2-bold-duotone" class="h-4 w-4" />
              </button>

              <button
                type="button"
                class="grid h-9 w-9 place-items-center rounded-xl border border-red-100 bg-red-50 text-red-600 transition hover:bg-red-100"
                title="Hapus"
                @click="confirmDelete(item)"
              >
                <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-4 w-4" />
              </button>
            </div>
          </div>
        </article>
      </section>

      <div v-if="hasMore && !pending" class="flex justify-center pt-2">
        <button
          type="button"
          class="inline-flex h-10 items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-black text-neutral-700 shadow-sm transition hover:bg-neutral-50"
          @click="page += 1"
        >
          <Icon icon="solar:alt-arrow-down-bold-duotone" class="h-5 w-5" />
          Muat Lainnya
        </button>
      </div>
    </div>

    <Teleport to="body">
      <Transition
        enter-active-class="transition duration-200 ease-out"
        enter-from-class="opacity-0"
        enter-to-class="opacity-100"
        leave-active-class="transition duration-150 ease-in"
        leave-from-class="opacity-100"
        leave-to-class="opacity-0"
      >
        <div v-if="formModal.open" class="fixed inset-0 z-[9998] overflow-y-auto bg-neutral-950/45 p-3 backdrop-blur-sm sm:p-5">
          <div class="mx-auto my-4 max-w-6xl overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-2xl shadow-neutral-950/20">
            <div class="sticky top-0 z-20 border-b border-neutral-200 bg-white/95 px-4 py-4 backdrop-blur-xl sm:px-5">
              <div class="flex items-start justify-between gap-3">
                <div class="flex min-w-0 items-center gap-3">
                  <div class="grid h-11 w-11 shrink-0 place-items-center overflow-hidden rounded-2xl border border-blue-100 bg-white shadow-sm ring-4 ring-blue-50">
                    <img v-if="appLogo" :src="appLogo" :alt="appName" class="h-8 w-8 object-contain">
                    <Icon v-else icon="solar:map-point-wave-bold-duotone" class="h-6 w-6 text-blue-600" />
                  </div>
                  <div class="min-w-0">
                    <p class="text-[11px] font-black uppercase tracking-[0.14em] text-blue-600">
                      {{ formModal.mode === 'create' ? 'Tambah Fasilitas' : 'Perbarui Fasilitas' }}
                    </p>
                    <h2 class="mt-1 truncate text-xl font-black text-neutral-950">
                      {{ form.title || 'Informasi Fasilitas' }}
                    </h2>
                  </div>
                </div>

                <button
                  type="button"
                  class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl border border-neutral-200 text-neutral-500 transition hover:bg-neutral-50 hover:text-neutral-950"
                  @click="closeForm"
                >
                  <Icon icon="solar:close-circle-bold-duotone" class="h-5 w-5" />
                </button>
              </div>

              <div class="mt-4">
                <div class="mb-3 flex items-center justify-between gap-3">
                  <p class="text-xs font-black uppercase tracking-[0.14em] text-neutral-400">
                    Langkah {{ formStep }} dari {{ formSteps.length }}
                  </p>
                  <p class="text-xs font-black text-blue-600">
                    {{ formStepProgress }}%
                  </p>
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
                      ? 'border-blue-300 bg-blue-50 ring-4 ring-blue-100'
                      : step.value < formStep
                        ? 'border-emerald-200 bg-emerald-50'
                        : 'border-neutral-200 bg-white hover:bg-neutral-50'"
                    @click="goToStep(step.value)"
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

                    <p class="mt-2 text-sm font-black text-neutral-950">
                      {{ step.title }}
                    </p>
                    <p class="mt-1 hidden text-xs font-semibold leading-5 text-neutral-500 lg:block">
                      {{ step.description }}
                    </p>
                  </button>
                </div>
              </div>
            </div>

            <form @submit.prevent="submitForm">
              <div class="p-4 sm:p-5">
                <section v-show="formStep === 1" class="grid gap-4 lg:grid-cols-[1fr_320px]">
                  <div class="space-y-4">
                    <div class="rounded-[1.5rem] border border-blue-100 bg-blue-50 p-4">
                      <div class="flex items-start gap-3">
                        <div class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl bg-white text-blue-600 shadow-sm">
                          <Icon icon="solar:document-add-bold-duotone" class="h-5 w-5" />
                        </div>
                        <div>
                          <h3 class="text-base font-black text-neutral-950">Identitas Utama</h3>
                          <p class="mt-1 text-sm font-medium leading-6 text-neutral-500">
                            Isi nama, tautan singkat, kategori, dan pengaturan dasar fasilitas.
                          </p>
                        </div>
                      </div>
                    </div>

                    <div class="grid gap-3 sm:grid-cols-2">
                      <Field label="Nama Fasilitas" required>
                        <input v-model.trim="form.title" class="input-field" placeholder="Contoh: Balai Desa Martopuro" required>
                      </Field>

                      <Field label="Tautan Singkat" required>
                        <input
                          v-model.trim="form.slug"
                          class="input-field"
                          placeholder="balai-desa-martopuro"
                          required
                          @input="manualSlugEdited = true"
                        >
                      </Field>
                    </div>

                    <Field label="Kalimat Pembuka">
                      <input v-model.trim="form.subtitle" class="input-field" placeholder="Ringkasan pendek yang tampil di kartu dan halaman publik">
                    </Field>

                    <Field label="Ringkasan Singkat">
                      <textarea v-model.trim="form.shortDescription" rows="4" class="input-field min-h-28 resize-y" placeholder="Jelaskan fungsi, manfaat, dan layanan utama fasilitas ini."></textarea>
                    </Field>
                  </div>

                  <aside class="space-y-4 rounded-[1.5rem] border border-neutral-200 bg-neutral-50/70 p-4">
                    <Field label="Kategori">
                      <select v-model="form.facilityType" class="input-field bg-white">
                        <option v-for="type in facilityTypeOptions" :key="type.value" :value="type.value">
                          {{ type.label }}
                        </option>
                      </select>
                    </Field>

                    <Field label="Ikon">
                      <input v-model.trim="form.icon" class="input-field bg-white" placeholder="solar:map-point-wave-bold-duotone">
                      <div class="mt-2 flex items-center gap-2 rounded-2xl bg-white p-3 text-sm font-bold text-neutral-600">
                        <Icon :icon="form.icon || getFacilityTypeIcon(form.facilityType)" class="h-5 w-5 text-blue-600" />
                        <span class="truncate">{{ form.icon || getFacilityTypeIcon(form.facilityType) }}</span>
                      </div>
                    </Field>

                    <div class="grid grid-cols-2 gap-3">
                      <Field label="Status">
                        <select v-model="form.status" class="input-field bg-white">
                          <option value="active">Tampil</option>
                          <option value="inactive">Disimpan</option>
                        </select>
                      </Field>

                      <Field label="Urutan">
                        <input v-model.number="form.sortOrder" type="number" class="input-field bg-white" min="0">
                      </Field>
                    </div>

                    <label class="flex items-center justify-between gap-3 rounded-2xl border border-neutral-200 bg-white px-4 py-3">
                      <span>
                        <span class="block text-sm font-black text-neutral-800">Prioritaskan</span>
                        <span class="block text-xs font-semibold text-neutral-400">Tampilkan lebih menonjol</span>
                      </span>
                      <input v-model="form.isFeatured" type="checkbox" class="h-5 w-5 rounded border-neutral-300 text-blue-600 focus:ring-blue-500">
                    </label>
                  </aside>
                </section>

                <section v-show="formStep === 2" class="grid gap-4 lg:grid-cols-[1fr_340px]">
                  <div class="space-y-4">
                    <div class="rounded-[1.5rem] border border-blue-100 bg-blue-50 p-4">
                      <div class="flex items-start gap-3">
                        <div class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl bg-white text-blue-600 shadow-sm">
                          <Icon icon="solar:text-bold-duotone" class="h-5 w-5" />
                        </div>
                        <div>
                          <h3 class="text-base font-black text-neutral-950">Cerita Fasilitas</h3>
                          <p class="mt-1 text-sm font-medium leading-6 text-neutral-500">
                            Tulis detail fasilitas dengan format yang rapi, lengkap dengan gambar jika dibutuhkan.
                          </p>
                        </div>
                      </div>
                    </div>

                    <div class="overflow-hidden rounded-[1.5rem] border border-neutral-200 bg-white shadow-sm">
                      <div class="flex flex-wrap items-center gap-2 border-b border-neutral-200 bg-neutral-50 px-3 py-2">
                        <button type="button" class="editor-btn" :class="editor?.isActive('bold') ? 'editor-btn-active' : ''" @click="editor?.chain().focus().toggleBold().run()">
                          <Icon icon="solar:text-bold-bold" class="h-4 w-4" />
                        </button>
                        <button type="button" class="editor-btn" :class="editor?.isActive('italic') ? 'editor-btn-active' : ''" @click="editor?.chain().focus().toggleItalic().run()">
                          <Icon icon="solar:text-italic-bold" class="h-4 w-4" />
                        </button>
                        <button type="button" class="editor-btn" :class="editor?.isActive('underline') ? 'editor-btn-active' : ''" @click="editor?.chain().focus().toggleUnderline().run()">
                          <Icon icon="solar:text-underline-bold" class="h-4 w-4" />
                        </button>
                        <span class="mx-1 h-6 w-px bg-neutral-200"></span>
                        <button type="button" class="editor-btn" :class="editor?.isActive('heading', { level: 2 }) ? 'editor-btn-active' : ''" @click="editor?.chain().focus().toggleHeading({ level: 2 }).run()">
                          H2
                        </button>
                        <button type="button" class="editor-btn" :class="editor?.isActive('heading', { level: 3 }) ? 'editor-btn-active' : ''" @click="editor?.chain().focus().toggleHeading({ level: 3 }).run()">
                          H3
                        </button>
                        <button type="button" class="editor-btn" :class="editor?.isActive('bulletList') ? 'editor-btn-active' : ''" @click="editor?.chain().focus().toggleBulletList().run()">
                          <Icon icon="solar:list-bold" class="h-4 w-4" />
                        </button>
                        <button type="button" class="editor-btn" :class="editor?.isActive('orderedList') ? 'editor-btn-active' : ''" @click="editor?.chain().focus().toggleOrderedList().run()">
                          <Icon icon="solar:list-arrow-down-bold" class="h-4 w-4" />
                        </button>
                        <button type="button" class="editor-btn" :class="editor?.isActive('blockquote') ? 'editor-btn-active' : ''" @click="editor?.chain().focus().toggleBlockquote().run()">
                          <Icon icon="solar:quote-up-bold" class="h-4 w-4" />
                        </button>
                        <span class="mx-1 h-6 w-px bg-neutral-200"></span>
                        <button type="button" class="editor-btn" @click="setEditorLink">
                          <Icon icon="solar:link-bold" class="h-4 w-4" />
                        </button>
                        <button type="button" class="editor-btn" @click="editorImageInput?.click()">
                          <Icon icon="solar:gallery-add-bold-duotone" class="h-4 w-4" />
                        </button>
                      </div>

                      <EditorContent :editor="editor" class="rich-editor" />

                      <input
                        ref="editorImageInput"
                        type="file"
                        accept="image/jpeg,image/png,image/webp"
                        class="hidden"
                        @change="handleFileInput($event, 'editor')"
                      >
                    </div>
                  </div>

                  <aside class="space-y-4 rounded-[1.5rem] border border-neutral-200 bg-neutral-50/70 p-4">
                    <MediaBox
                      title="Gambar Utama"
                      description="Tampil sebagai cover utama di kartu dan halaman publik."
                      :image="form.imageUrl"
                      :busy="mediaBusy.cover"
                      @choose="coverInput?.click()"
                      @save-link="uploadFromLink('cover')"
                      @clear="form.imageUrl = ''"
                    >
                      <input v-model.trim="mediaLinks.cover" class="input-field bg-white" placeholder="Tempel tautan gambar">
                      <input ref="coverInput" type="file" accept="image/jpeg,image/png,image/webp" class="hidden" @change="handleFileInput($event, 'cover')">
                    </MediaBox>

                    <MediaBox
                      title="Logo Fasilitas"
                      description="Opsional, untuk identitas fasilitas."
                      :image="form.logoUrl"
                      :busy="mediaBusy.logo"
                      @choose="logoInput?.click()"
                      @save-link="uploadFromLink('logo')"
                      @clear="form.logoUrl = ''"
                    >
                      <input v-model.trim="mediaLinks.logo" class="input-field bg-white" placeholder="Tempel tautan gambar">
                      <input ref="logoInput" type="file" accept="image/jpeg,image/png,image/webp" class="hidden" @change="handleFileInput($event, 'logo')">
                    </MediaBox>

                    <div class="rounded-[1.5rem] border border-neutral-200 bg-white p-4">
                      <div class="flex items-start justify-between gap-3">
                        <div>
                          <h4 class="text-sm font-black text-neutral-950">Galeri</h4>
                          <p class="mt-1 text-xs font-semibold leading-5 text-neutral-500">Tambahkan beberapa gambar pendukung.</p>
                        </div>
                        <button type="button" class="grid h-9 w-9 place-items-center rounded-xl bg-blue-50 text-blue-600" @click="galleryInput?.click()">
                          <Icon icon="solar:add-circle-bold-duotone" class="h-5 w-5" />
                        </button>
                      </div>

                      <div class="mt-3 grid grid-cols-3 gap-2">
                        <div v-for="(image, index) in cleanGalleryImages" :key="`${image}-${index}`" class="group relative h-20 overflow-hidden rounded-2xl bg-neutral-100">
                          <img :src="image" alt="Gambar galeri" class="h-full w-full object-cover">
                          <button type="button" class="absolute right-1 top-1 grid h-7 w-7 place-items-center rounded-full bg-white/90 text-red-600 opacity-0 shadow-sm transition group-hover:opacity-100" @click="removeGalleryImage(index)">
                            <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-4 w-4" />
                          </button>
                        </div>
                        <button type="button" class="grid h-20 place-items-center rounded-2xl border border-dashed border-neutral-300 bg-neutral-50 text-neutral-400 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-600" @click="galleryInput?.click()">
                          <Icon icon="solar:gallery-add-bold-duotone" class="h-6 w-6" />
                        </button>
                      </div>

                      <div class="mt-3 flex gap-2">
                        <input v-model.trim="mediaLinks.gallery" class="input-field bg-white" placeholder="Tempel tautan gambar">
                        <button type="button" class="shrink-0 rounded-xl bg-blue-600 px-3 text-xs font-black text-white transition hover:bg-blue-700 disabled:opacity-60" :disabled="mediaBusy.gallery" @click="uploadFromLink('gallery')">
                          Simpan
                        </button>
                      </div>

                      <input ref="galleryInput" type="file" accept="image/jpeg,image/png,image/webp" multiple class="hidden" @change="handleGalleryInput">
                    </div>
                  </aside>
                </section>

                <section v-show="formStep === 3" class="grid gap-4 lg:grid-cols-[1fr_340px]">
                  <div class="space-y-4">
                    <div class="rounded-[1.5rem] border border-blue-100 bg-blue-50 p-4">
                      <div class="flex items-start gap-3">
                        <div class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl bg-white text-blue-600 shadow-sm">
                          <Icon icon="solar:map-point-bold-duotone" class="h-5 w-5" />
                        </div>
                        <div>
                          <h3 class="text-base font-black text-neutral-950">Kontak & Lokasi</h3>
                          <p class="mt-1 text-sm font-medium leading-6 text-neutral-500">
                            Lengkapi kontak, alamat, dan titik lokasi agar pengunjung mudah menemukan fasilitas.
                          </p>
                        </div>
                      </div>
                    </div>

                    <Field label="Alamat">
                      <textarea v-model.trim="form.address" rows="5" class="input-field min-h-32 resize-y" placeholder="Tuliskan alamat lengkap fasilitas"></textarea>
                    </Field>

                    <div class="grid gap-3 sm:grid-cols-2">
                      <Field label="Latitude">
                        <input v-model.trim="form.latitude" class="input-field" placeholder="-7.600000">
                      </Field>
                      <Field label="Longitude">
                        <input v-model.trim="form.longitude" class="input-field" placeholder="112.700000">
                      </Field>
                    </div>
                  </div>

                  <aside class="space-y-4 rounded-[1.5rem] border border-neutral-200 bg-neutral-50/70 p-4">
                    <Field label="Telepon">
                      <input v-model.trim="form.phone" class="input-field bg-white" placeholder="0343...">
                    </Field>
                    <Field label="WhatsApp">
                      <input v-model.trim="form.whatsapp" class="input-field bg-white" placeholder="62812...">
                    </Field>
                    <Field label="Email">
                      <input v-model.trim="form.email" type="email" class="input-field bg-white" placeholder="email@domain.com">
                    </Field>
                    <Field label="Website / Media Sosial">
                      <input v-model.trim="form.websiteUrl" type="url" class="input-field bg-white" placeholder="https://...">
                    </Field>
                  </aside>
                </section>

                <section v-show="formStep === 4" class="grid gap-4 lg:grid-cols-[1fr_340px]">
                  <div class="overflow-hidden rounded-[1.5rem] border border-neutral-200 bg-white shadow-sm">
                    <div class="relative h-56 overflow-hidden bg-neutral-100">
                      <img v-if="form.imageUrl" :src="form.imageUrl" alt="Preview fasilitas" class="h-full w-full object-cover">
                      <div v-else class="grid h-full place-items-center bg-gradient-to-br from-blue-50 via-white to-sky-50 text-blue-600">
                        <Icon :icon="form.icon || getFacilityTypeIcon(form.facilityType)" class="h-16 w-16" />
                      </div>
                      <div class="absolute inset-0 bg-gradient-to-t from-neutral-950/70 via-neutral-950/10 to-transparent"></div>
                      <div class="absolute bottom-4 left-4 right-4">
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/90 px-3 py-1 text-xs font-black text-blue-700 backdrop-blur">
                          <Icon :icon="form.icon || getFacilityTypeIcon(form.facilityType)" class="h-4 w-4" />
                          {{ facilityTypeLabel(form.facilityType) }}
                        </span>
                        <h3 class="mt-3 text-2xl font-black tracking-tight text-white">
                          {{ form.title || 'Nama Fasilitas' }}
                        </h3>
                        <p v-if="form.subtitle || form.shortDescription" class="mt-1 line-clamp-2 text-sm font-medium leading-6 text-white/80">
                          {{ form.subtitle || form.shortDescription }}
                        </p>
                      </div>
                    </div>

                    <div class="p-4">
                      <div class="flex flex-wrap gap-2">
                        <span class="rounded-full bg-blue-50 px-3 py-1 text-xs font-black text-blue-700">
                          {{ form.status === 'active' ? 'Tampil di publik' : 'Disimpan dulu' }}
                        </span>
                        <span v-if="form.isFeatured" class="rounded-full bg-neutral-100 px-3 py-1 text-xs font-black text-neutral-600">
                          Prioritas
                        </span>
                      </div>

                      <div class="mt-4 rounded-2xl border border-blue-100 bg-blue-50 p-4">
                        <p class="text-xs font-black uppercase tracking-[0.12em] text-blue-700">Link Publik</p>
                        <p class="mt-2 break-all text-sm font-bold leading-6 text-blue-900">
                          {{ facilityDetailTo(form.slug || 'nama-fasilitas') }}
                        </p>
                      </div>
                    </div>
                  </div>

                  <aside class="space-y-4 rounded-[1.5rem] border border-neutral-200 bg-neutral-50/70 p-4">
                    <div class="rounded-[1.5rem] border border-neutral-200 bg-white p-4">
                      <h4 class="text-sm font-black text-neutral-950">Cek sebelum menyimpan</h4>
                      <div class="mt-3 space-y-2 text-sm font-semibold text-neutral-600">
                        <div class="flex items-center justify-between gap-3">
                          <span>Nama</span>
                          <Icon :icon="form.title ? 'solar:check-circle-bold-duotone' : 'solar:close-circle-bold-duotone'" :class="form.title ? 'text-emerald-600' : 'text-red-500'" class="h-5 w-5" />
                        </div>
                        <div class="flex items-center justify-between gap-3">
                          <span>Tautan singkat</span>
                          <Icon :icon="form.slug ? 'solar:check-circle-bold-duotone' : 'solar:close-circle-bold-duotone'" :class="form.slug ? 'text-emerald-600' : 'text-red-500'" class="h-5 w-5" />
                        </div>
                        <div class="flex items-center justify-between gap-3">
                          <span>Gambar utama</span>
                          <Icon :icon="form.imageUrl ? 'solar:check-circle-bold-duotone' : 'solar:info-circle-bold-duotone'" :class="form.imageUrl ? 'text-emerald-600' : 'text-neutral-400'" class="h-5 w-5" />
                        </div>
                        <div class="flex items-center justify-between gap-3">
                          <span>Kontak/lokasi</span>
                          <Icon :icon="form.address || form.phone || form.whatsapp ? 'solar:check-circle-bold-duotone' : 'solar:info-circle-bold-duotone'" :class="form.address || form.phone || form.whatsapp ? 'text-emerald-600' : 'text-neutral-400'" class="h-5 w-5" />
                        </div>
                      </div>
                    </div>

                    <button
                      type="button"
                      class="inline-flex w-full h-11 items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-black text-neutral-700 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
                      @click="copyFormPublicLink"
                    >
                      <Icon icon="solar:copy-bold-duotone" class="h-5 w-5" />
                      Salin Link Publik
                    </button>
                  </aside>
                </section>
              </div>

              <div class="sticky bottom-0 z-10 border-t border-neutral-200 bg-white/95 px-4 py-4 backdrop-blur-xl sm:px-5">
                <div class="flex flex-col-reverse gap-2 sm:flex-row sm:items-center sm:justify-between">
                  <button
                    type="button"
                    class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-5 text-sm font-black text-neutral-700 transition hover:bg-neutral-50"
                    @click="closeForm"
                  >
                    Batal
                  </button>

                  <div class="flex flex-col-reverse gap-2 sm:flex-row">
                    <button
                      v-if="formStep > 1"
                      type="button"
                      class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-5 text-sm font-black text-neutral-700 transition hover:bg-neutral-50"
                      @click="goToStep(formStep - 1)"
                    >
                      <Icon icon="solar:arrow-left-linear" class="h-5 w-5" />
                      Kembali
                    </button>

                    <button
                      v-if="formStep < formSteps.length"
                      type="button"
                      class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-5 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700"
                      @click="nextStep"
                    >
                      Lanjutkan
                      <Icon icon="solar:arrow-right-linear" class="h-5 w-5" />
                    </button>

                    <button
                      v-else
                      type="submit"
                      class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-5 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700 disabled:cursor-not-allowed disabled:opacity-60"
                      :disabled="isSaving || anyMediaBusy"
                    >
                      <Icon icon="solar:diskette-bold-duotone" class="h-5 w-5" :class="isSaving ? 'animate-spin' : ''" />
                      {{ isSaving ? 'Menyimpan...' : 'Simpan Fasilitas' }}
                    </button>
                  </div>
                </div>
              </div>
            </form>
          </div>
        </div>
      </Transition>
    </Teleport>

    <Teleport to="body">
      <Transition
        enter-active-class="transition duration-200 ease-out"
        enter-from-class="opacity-0"
        enter-to-class="opacity-100"
        leave-active-class="transition duration-150 ease-in"
        leave-from-class="opacity-100"
        leave-to-class="opacity-0"
      >
        <div v-if="deleteTarget" class="fixed inset-0 z-[9999] grid place-items-center bg-neutral-950/40 p-4 backdrop-blur-sm">
          <div class="w-full max-w-md rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-2xl shadow-neutral-950/20">
            <div class="grid h-12 w-12 place-items-center rounded-2xl bg-red-50 text-red-600">
              <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-6 w-6" />
            </div>
            <h2 class="mt-4 text-xl font-black text-neutral-950">
              Hapus fasilitas?
            </h2>
            <p class="mt-2 text-sm font-medium leading-6 text-neutral-500">
              Data <span class="font-black text-neutral-900">{{ deleteTarget.title || deleteTarget.name }}</span> akan dihapus dari daftar fasilitas.
            </p>
            <div class="mt-5 flex flex-col-reverse gap-2 sm:flex-row sm:justify-end">
              <button
                type="button"
                class="inline-flex h-10 items-center justify-center rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-black text-neutral-700 transition hover:bg-neutral-50"
                @click="deleteTarget = null"
              >
                Batal
              </button>
              <button
                type="button"
                class="inline-flex h-10 items-center justify-center gap-2 rounded-2xl bg-red-600 px-4 text-sm font-black text-white transition hover:bg-red-700 disabled:opacity-60"
                :disabled="isDeleting"
                @click="deleteFacility"
              >
                <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-5 w-5" :class="isDeleting ? 'animate-spin' : ''" />
                Hapus
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
import { EditorContent, useEditor } from '@tiptap/vue-3'
import StarterKit from '@tiptap/starter-kit'
import Link from '@tiptap/extension-link'
import Image from '@tiptap/extension-image'
import Underline from '@tiptap/extension-underline'
import { computed, defineComponent, h, nextTick, onBeforeUnmount, reactive, ref, watch } from 'vue'

definePageMeta({
  layout: 'app'
})

type FacilityStatus = 'active' | 'inactive'

type FacilityType =
  | 'health'
  | 'education'
  | 'religious'
  | 'sport'
  | 'market'
  | 'public_service'
  | 'transportation'
  | 'security'
  | 'water'
  | 'tourism'
  | 'government'
  | 'community'
  | 'custom'
  | string

type FacilityItem = {
  id: string
  tenantId?: string
  title?: string | null
  name?: string | null
  subtitle?: string | null
  shortDescription?: string | null
  slug: string
  facilityType?: FacilityType | null
  icon?: string | null
  logoUrl?: string | null
  imageUrl?: string | null
  coverUrl?: string | null
  contentHtml?: string | null
  contentJson?: unknown | null
  phone?: string | null
  whatsapp?: string | null
  email?: string | null
  websiteUrl?: string | null
  address?: string | null
  latitude?: number | string | null
  longitude?: number | string | null
  status: FacilityStatus
  isFeatured?: boolean
  sortOrder?: number
  metadata?: Record<string, any> | null
  createdAt?: number | string | null
  updatedAt?: number | string | null
}

type FacilityListResponse = {
  data: FacilityItem[]
  meta?: {
    page: number
    limit: number
    total: number
    totalPages: number
  }
}

type FacilityForm = {
  id: string
  title: string
  slug: string
  subtitle: string
  shortDescription: string
  facilityType: FacilityType
  icon: string
  logoUrl: string
  imageUrl: string
  contentHtml: string
  phone: string
  whatsapp: string
  email: string
  websiteUrl: string
  address: string
  latitude: string
  longitude: string
  status: FacilityStatus
  isFeatured: boolean
  sortOrder: number
  images: string[]
}

type MediaTarget = 'cover' | 'logo' | 'gallery' | 'editor'

const runtime = useRuntimeConfig()
const requestUrl = useRequestURL()
const { tenantApiUrl } = useAppApi()
const { uploading: mediaUploading, uploadImage, uploadImageFromUrl } = useCloudinaryUpload()

const q = ref('')
const selectedType = ref<FacilityType | 'all'>('all')
const selectedStatus = ref<FacilityStatus | 'all'>('all')
const sort = ref<'newest' | 'oldest' | 'name' | 'sort_order'>('sort_order')
const page = ref(1)
const pageSize = 12
const logoFailed = ref(false)
const failedImages = ref<Record<string, boolean>>({})
const isSaving = ref(false)
const isDeleting = ref(false)
const deleteTarget = ref<FacilityItem | null>(null)
const formStep = ref(1)
const manualSlugEdited = ref(false)

const coverInput = ref<HTMLInputElement | null>(null)
const logoInput = ref<HTMLInputElement | null>(null)
const galleryInput = ref<HTMLInputElement | null>(null)
const editorImageInput = ref<HTMLInputElement | null>(null)

const mediaBusy = reactive<Record<MediaTarget, boolean>>({
  cover: false,
  logo: false,
  gallery: false,
  editor: false
})

const mediaLinks = reactive({
  cover: '',
  logo: '',
  gallery: ''
})

const toast = reactive({
  show: false,
  type: 'success' as 'success' | 'error',
  title: '',
  message: ''
})

const formModal = reactive({
  open: false,
  mode: 'create' as 'create' | 'edit'
})

const formSteps = [
  {
    value: 1,
    title: 'Identitas',
    description: 'Nama, kategori, dan status dasar.',
    icon: 'solar:document-add-bold-duotone'
  },
  {
    value: 2,
    title: 'Konten',
    description: 'Cerita, gambar utama, logo, dan galeri.',
    icon: 'solar:gallery-wide-bold-duotone'
  },
  {
    value: 3,
    title: 'Lokasi',
    description: 'Alamat, koordinat, dan kontak.',
    icon: 'solar:map-point-bold-duotone'
  },
  {
    value: 4,
    title: 'Preview',
    description: 'Tinjau sebelum diterbitkan.',
    icon: 'solar:eye-bold-duotone'
  }
]

const emptyForm = (): FacilityForm => ({
  id: '',
  title: '',
  slug: '',
  subtitle: '',
  shortDescription: '',
  facilityType: 'public_service',
  icon: 'solar:map-point-wave-bold-duotone',
  logoUrl: '',
  imageUrl: '',
  contentHtml: '<p>Jelaskan fasilitas ini secara singkat, mulai dari fungsi, layanan utama, dan manfaatnya untuk warga.</p>',
  phone: '',
  whatsapp: '',
  email: '',
  websiteUrl: '',
  address: '',
  latitude: '',
  longitude: '',
  status: 'active',
  isFeatured: false,
  sortOrder: 0,
  images: []
})

const form = reactive<FacilityForm>(emptyForm())

const editor = useEditor({
  content: form.contentHtml,
  extensions: [
    StarterKit,
    Underline,
    Link.configure({
      openOnClick: false,
      autolink: true,
      linkOnPaste: true,
      HTMLAttributes: {
        class: 'text-blue-600 underline underline-offset-4 font-bold'
      }
    }),
    Image.configure({
      inline: false,
      allowBase64: false,
      HTMLAttributes: {
        class: 'rounded-2xl border border-neutral-200 my-4 max-w-full'
      }
    })
  ],
  editorProps: {
    attributes: {
      class: 'prose prose-neutral max-w-none min-h-[260px] px-4 py-4 text-sm leading-7 focus:outline-none'
    }
  },
  onUpdate({ editor }) {
    form.contentHtml = editor.getHTML()
  }
})

const hostname = computed(() => {
  return String(requestUrl.hostname || '')
    .replace(/^www\./, '')
    .toLowerCase()
})

const tenantSlug = computed(() => {
  const envClient = String(runtime.public.clientName || 'martopuro')
    .trim()
    .toLowerCase()

  if (hostname.value.includes('martopuro')) return 'martopuro'
  if (hostname.value.includes('obayan')) return 'obayan'

  return envClient || 'martopuro'
})

const appName = computed(() => {
  return String(
    runtime.public.appName ||
    runtime.public.clientDisplayName ||
    runtime.public.siteName ||
    'ARSADES'
  )
})

const appLogo = computed(() => {
  if (logoFailed.value) return ''

  return String(
    runtime.public.appLogo ||
    runtime.public.appLogoUrl ||
    runtime.public.logoUrl ||
    runtime.public.faviconUrl ||
    ''
  )
})

const apiUrl = computed(() => tenantApiUrl(tenantSlug.value, '/facilities'))

const {
  data,
  pending,
  error,
  refresh
} = await useFetch<FacilityListResponse>(apiUrl, {
  key: computed(() => `app-facilities-${tenantSlug.value}-${selectedType.value}-${selectedStatus.value}-${sort.value}`),
  query: computed(() => ({
    q: q.value || undefined,
    type: selectedType.value === 'all' ? undefined : selectedType.value,
    facilityType: selectedType.value === 'all' ? undefined : selectedType.value,
    status: selectedStatus.value === 'all' ? undefined : selectedStatus.value,
    limit: 100,
    sort: sort.value
  })),
  watch: [tenantSlug, q, selectedType, selectedStatus, sort],
  default: () => ({
    data: [],
    meta: {
      page: 1,
      limit: 100,
      total: 0,
      totalPages: 1
    }
  })
})

const facilities = computed<FacilityItem[]>(() => data.value?.data || [])

const visibleError = computed(() => {
  if (!error.value) return ''
  return error.value?.message || 'Terjadi kesalahan saat memuat data fasilitas.'
})

const filteredFacilities = computed(() => {
  const keyword = q.value.trim().toLowerCase()

  return facilities.value
    .filter((item) => {
      if (selectedStatus.value !== 'all' && item.status !== selectedStatus.value) return false
      if (selectedType.value !== 'all' && item.facilityType !== selectedType.value) return false
      if (!keyword) return true

      return [
        item.title,
        item.name,
        item.subtitle,
        item.shortDescription,
        item.slug,
        item.address,
        item.email,
        item.phone,
        item.whatsapp,
        item.websiteUrl,
        plainText(item.contentHtml || '')
      ]
        .filter(Boolean)
        .join(' ')
        .toLowerCase()
        .includes(keyword)
    })
    .sort((a, b) => {
      if (sort.value === 'name') {
        return String(a.title || a.name || '').localeCompare(String(b.title || b.name || ''))
      }

      if (sort.value === 'newest') {
        return toTimestamp(b.createdAt) - toTimestamp(a.createdAt)
      }

      if (sort.value === 'oldest') {
        return toTimestamp(a.createdAt) - toTimestamp(b.createdAt)
      }

      const sortA = Number(a.sortOrder || 0)
      const sortB = Number(b.sortOrder || 0)

      if (sortA !== sortB) return sortA - sortB

      return String(a.title || a.name || '').localeCompare(String(b.title || b.name || ''))
    })
})

const pagedFacilities = computed(() => filteredFacilities.value.slice(0, page.value * pageSize))
const hasMore = computed(() => pagedFacilities.value.length < filteredFacilities.value.length)
const formStepProgress = computed(() => Math.round((formStep.value / formSteps.length) * 100))
const anyMediaBusy = computed(() => Object.values(mediaBusy).some(Boolean) || mediaUploading.value)

const cleanGalleryImages = computed(() => {
  return form.images
    .map((image) => String(image || '').trim())
    .filter(Boolean)
})

const facilityTypeOptions = [
  { value: 'public_service', label: 'Pelayanan Publik', icon: 'solar:buildings-3-bold-duotone' },
  { value: 'government', label: 'Pemerintahan', icon: 'solar:buildings-bold-duotone' },
  { value: 'health', label: 'Kesehatan', icon: 'solar:heart-pulse-bold-duotone' },
  { value: 'education', label: 'Pendidikan', icon: 'solar:notebook-bookmark-bold-duotone' },
  { value: 'religious', label: 'Keagamaan', icon: 'solar:stars-bold-duotone' },
  { value: 'sport', label: 'Olahraga', icon: 'solar:football-bold-duotone' },
  { value: 'market', label: 'Pasar / Ekonomi', icon: 'solar:shop-2-bold-duotone' },
  { value: 'transportation', label: 'Transportasi', icon: 'solar:bus-bold-duotone' },
  { value: 'security', label: 'Keamanan', icon: 'solar:shield-check-bold-duotone' },
  { value: 'water', label: 'Air / Irigasi', icon: 'solar:waterdrops-bold-duotone' },
  { value: 'tourism', label: 'Wisata', icon: 'solar:map-point-wave-bold-duotone' },
  { value: 'community', label: 'Komunitas', icon: 'solar:users-group-rounded-bold-duotone' },
  { value: 'custom', label: 'Lainnya', icon: 'solar:widget-5-bold-duotone' }
] as const

watch([q, selectedType, selectedStatus, sort], () => {
  page.value = 1
})

watch(
  () => form.title,
  (value) => {
    if (!formModal.open || formModal.mode !== 'create' || manualSlugEdited.value) return
    form.slug = slugify(value)
  }
)

watch(
  () => formModal.open,
  async (open) => {
    if (!open) return
    await nextTick()
    syncEditorContent()
  }
)

onBeforeUnmount(() => {
  editor.value?.destroy()
})

function resetFilters() {
  q.value = ''
  selectedType.value = 'all'
  selectedStatus.value = 'all'
  sort.value = 'sort_order'
  page.value = 1
}

async function reloadFacilities() {
  await refresh()
  showToast('success', 'Data diperbarui', 'Daftar fasilitas berhasil dimuat ulang.')
}

function openCreate() {
  Object.assign(form, emptyForm())
  formStep.value = 1
  manualSlugEdited.value = false
  resetMediaLinks()
  formModal.mode = 'create'
  formModal.open = true
  nextTick(syncEditorContent)
}

function openEdit(item: FacilityItem) {
  const images = getFacilityImages(item).filter((image) => image !== item.imageUrl && image !== item.coverUrl && image !== item.logoUrl)

  Object.assign(form, {
    id: item.id,
    title: String(item.title || item.name || ''),
    slug: String(item.slug || ''),
    subtitle: String(item.subtitle || ''),
    shortDescription: String(item.shortDescription || ''),
    facilityType: item.facilityType || 'public_service',
    icon: String(item.icon || getFacilityTypeIcon(item.facilityType)),
    logoUrl: String(item.logoUrl || ''),
    imageUrl: String(item.imageUrl || item.coverUrl || ''),
    contentHtml: String(item.contentHtml || '<p>Jelaskan fasilitas ini secara singkat.</p>'),
    phone: String(item.phone || ''),
    whatsapp: String(item.whatsapp || ''),
    email: String(item.email || ''),
    websiteUrl: String(item.websiteUrl || ''),
    address: String(item.address || ''),
    latitude: item.latitude == null ? '' : String(item.latitude),
    longitude: item.longitude == null ? '' : String(item.longitude),
    status: item.status || 'active',
    isFeatured: Boolean(item.isFeatured),
    sortOrder: Number(item.sortOrder || 0),
    images
  })

  formStep.value = 1
  manualSlugEdited.value = true
  resetMediaLinks()
  formModal.mode = 'edit'
  formModal.open = true
  nextTick(syncEditorContent)
}

function closeForm() {
  if (isSaving.value || anyMediaBusy.value) return
  formModal.open = false
}

function goToStep(step: number) {
  const target = Math.max(1, Math.min(step, formSteps.length))

  if (target > formStep.value && !canLeaveCurrentStep()) return

  formStep.value = target
}

function nextStep() {
  if (!canLeaveCurrentStep()) return
  goToStep(formStep.value + 1)
}

function canLeaveCurrentStep() {
  if (!form.title.trim()) {
    showToast('error', 'Nama belum diisi', 'Masukkan nama fasilitas terlebih dahulu.')
    formStep.value = 1
    return false
  }

  if (!form.slug.trim()) {
    showToast('error', 'Tautan belum diisi', 'Masukkan tautan singkat agar halaman publik mudah dibuka.')
    formStep.value = 1
    return false
  }

  return true
}

async function submitForm() {
  if (!canLeaveCurrentStep()) return

  form.contentHtml = editor.value?.getHTML() || form.contentHtml
  isSaving.value = true

  try {
    const payload = buildPayload()

    if (formModal.mode === 'create') {
      await $fetch<{ data: FacilityItem }>(apiUrl.value, {
        method: 'POST',
        body: payload
      })
    } else {
      await $fetch<{ data: FacilityItem }>(`${apiUrl.value}/${form.id}`, {
        method: 'PUT',
        body: payload
      })
    }

    await refresh()
    closeForm()

    showToast(
      'success',
      formModal.mode === 'create' ? 'Fasilitas dibuat' : 'Fasilitas diperbarui',
      'Data fasilitas berhasil disimpan.'
    )
  } catch (err: any) {
    showToast('error', 'Gagal menyimpan', err?.data?.message || err?.message || 'Periksa data dan coba lagi.')
  } finally {
    isSaving.value = false
  }
}

function confirmDelete(item: FacilityItem) {
  deleteTarget.value = item
}

async function deleteFacility() {
  if (!deleteTarget.value) return

  isDeleting.value = true

  try {
    await $fetch<{ message: string }>(`${apiUrl.value}/${deleteTarget.value.id}`, {
      method: 'DELETE'
    })

    await refresh()
    showToast('success', 'Fasilitas dihapus', 'Data fasilitas berhasil dihapus.')
    deleteTarget.value = null
  } catch (err: any) {
    showToast('error', 'Gagal menghapus', err?.data?.message || err?.message || 'Coba ulang beberapa saat lagi.')
  } finally {
    isDeleting.value = false
  }
}

function buildPayload() {
  const images = cleanGalleryImages.value

  return {
    title: clean(form.title),
    name: clean(form.title),
    slug: slugify(form.slug),
    subtitle: clean(form.subtitle),
    shortDescription: clean(form.shortDescription),
    facilityType: form.facilityType,
    icon: clean(form.icon) || getFacilityTypeIcon(form.facilityType),
    logoUrl: clean(form.logoUrl),
    imageUrl: clean(form.imageUrl),
    coverUrl: clean(form.imageUrl),
    contentHtml: form.contentHtml || '',
    phone: clean(form.phone),
    whatsapp: clean(form.whatsapp),
    email: clean(form.email),
    websiteUrl: clean(form.websiteUrl),
    address: clean(form.address),
    latitude: parseNullableNumber(form.latitude),
    longitude: parseNullableNumber(form.longitude),
    status: form.status,
    isFeatured: Boolean(form.isFeatured),
    sortOrder: Number(form.sortOrder || 0),
    metadata: {
      images
    }
  }
}

async function handleFileInput(event: Event, target: MediaTarget) {
  const input = event.target as HTMLInputElement
  const file = input.files?.[0]

  if (!file) return

  try {
    await uploadLocalImage(file, target)
  } finally {
    input.value = ''
  }
}

async function handleGalleryInput(event: Event) {
  const input = event.target as HTMLInputElement
  const files = Array.from(input.files || [])

  for (const file of files) {
    await uploadLocalImage(file, 'gallery')
  }

  input.value = ''
}

async function uploadLocalImage(file: File, target: MediaTarget) {
  mediaBusy[target] = true

  try {
    const result = await uploadImage(file, {
      folder: `${tenantSlug.value}/facilities`,
      maxWidth: 1800,
      maxHeight: 1800,
      quality: 0.84,
      maxBytes: 5 * 1024 * 1024
    })

    applyMediaUrl(target, result.secure_url)
    showToast('success', 'Gambar tersimpan', 'Gambar berhasil ditambahkan.')
  } catch {
    showToast('error', 'Gambar belum tersimpan', 'Pastikan gambar berformat JPG, PNG, atau WebP dengan ukuran yang sesuai.')
  } finally {
    mediaBusy[target] = false
  }
}

async function uploadFromLink(target: Exclude<MediaTarget, 'editor'>) {
  const url = mediaLinks[target].trim()

  if (!url) {
    showToast('error', 'Link belum diisi', 'Tempel tautan gambar terlebih dahulu.')
    return
  }

  mediaBusy[target] = true

  try {
    const result = await uploadImageFromUrl(url, {
      folder: `${tenantSlug.value}/facilities`,
      maxWidth: 1800,
      maxHeight: 1800,
      quality: 0.84
    })

    applyMediaUrl(target, result.secure_url)
    mediaLinks[target] = ''
    showToast('success', 'Gambar tersimpan', 'Gambar berhasil ditambahkan.')
  } catch {
    showToast('error', 'Gambar belum tersimpan', 'Periksa kembali tautan gambar yang dimasukkan.')
  } finally {
    mediaBusy[target] = false
  }
}

function applyMediaUrl(target: MediaTarget, url: string) {
  if (!url) return

  if (target === 'cover') {
    form.imageUrl = url
    return
  }

  if (target === 'logo') {
    form.logoUrl = url
    return
  }

  if (target === 'editor') {
    editor.value?.chain().focus().setImage({ src: url }).run()
    return
  }

  if (!form.images.includes(url)) {
    form.images.push(url)
  }
}

function removeGalleryImage(index: number) {
  const current = cleanGalleryImages.value
  current.splice(index, 1)
  form.images = current
}

function setEditorLink() {
  if (!editor.value) return

  const previousUrl = editor.value.getAttributes('link').href || ''
  const url = window.prompt('Tempel tautan halaman', previousUrl)

  if (url === null) return

  if (!url.trim()) {
    editor.value.chain().focus().extendMarkRange('link').unsetLink().run()
    return
  }

  editor.value.chain().focus().extendMarkRange('link').setLink({ href: url.trim() }).run()
}

function syncEditorContent() {
  const value = form.contentHtml || '<p>Jelaskan fasilitas ini secara singkat.</p>'
  editor.value?.commands.setContent(value, false)
}

function resetMediaLinks() {
  mediaLinks.cover = ''
  mediaLinks.logo = ''
  mediaLinks.gallery = ''
}

function facilityDetailTo(slug?: string | null) {
  const cleanSlug = String(slug || '').trim()
  if (!cleanSlug) return '/facilities'
  return `/facilities?detail=${encodeURIComponent(cleanSlug)}`
}

async function copyPublicLink(item: FacilityItem) {
  const relativeUrl = facilityDetailTo(item.slug)
  const fullUrl = `${requestUrl.origin}${relativeUrl}`

  try {
    await navigator.clipboard.writeText(fullUrl)
    showToast('success', 'Link disalin', fullUrl)
  } catch {
    showToast('error', 'Gagal menyalin', 'Browser tidak mengizinkan akses clipboard.')
  }
}

async function copyFormPublicLink() {
  const fullUrl = `${requestUrl.origin}${facilityDetailTo(form.slug || 'nama-fasilitas')}`

  try {
    await navigator.clipboard.writeText(fullUrl)
    showToast('success', 'Link disalin', fullUrl)
  } catch {
    showToast('error', 'Gagal menyalin', 'Browser tidak mengizinkan akses clipboard.')
  }
}

function getFacilityImages(item: FacilityItem) {
  const metadataImages = Array.isArray(item.metadata?.images)
    ? item.metadata?.images
    : []

  const images = [
    item.imageUrl,
    item.coverUrl,
    ...metadataImages,
    item.logoUrl
  ]
    .map((value) => String(value || '').trim())
    .filter(Boolean)

  return Array.from(new Set(images))
}

function getFacilityCover(item: FacilityItem) {
  return getFacilityImages(item)[0] || ''
}

function markImageFailed(id: string) {
  failedImages.value = {
    ...failedImages.value,
    [id]: true
  }
}

function getFacilityTypeIcon(type?: FacilityType | null) {
  return facilityTypeOptions.find((item) => item.value === type)?.icon || 'solar:map-point-wave-bold-duotone'
}

function facilityTypeLabel(type?: FacilityType | null) {
  return facilityTypeOptions.find((item) => item.value === type)?.label || 'Fasilitas'
}

function plainText(value: string) {
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

function slugify(value: string) {
  return String(value || '')
    .toLowerCase()
    .trim()
    .replace(/[^a-z0-9\s-]/g, '')
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-')
    .replace(/^-|-$/g, '')
}

function clean(value: string) {
  return String(value || '').trim()
}

function parseNullableNumber(value: string) {
  const cleanValue = String(value || '').trim()
  if (!cleanValue) return null

  const parsed = Number(cleanValue)
  return Number.isFinite(parsed) ? parsed : null
}

function toTimestamp(value?: number | string | null) {
  if (!value) return 0
  if (typeof value === 'number') return value

  const time = new Date(value).getTime()
  return Number.isFinite(time) ? time : 0
}

function showToast(type: 'success' | 'error', title: string, message: string) {
  toast.type = type
  toast.title = title
  toast.message = message
  toast.show = true

  window.setTimeout(() => {
    toast.show = false
  }, 2500)
}

function closeToast() {
  toast.show = false
}

const Field = defineComponent({
  props: {
    label: {
      type: String,
      required: true
    },
    required: {
      type: Boolean,
      default: false
    }
  },
  setup(props, { slots }) {
    return () => h('label', { class: 'block' }, [
      h('span', { class: 'mb-1.5 block text-xs font-black uppercase tracking-[0.12em] text-neutral-500' }, [
        props.label,
        props.required ? h('span', { class: 'ml-1 text-red-500' }, '*') : null
      ]),
      slots.default?.()
    ])
  }
})

const MediaBox = defineComponent({
  props: {
    title: {
      type: String,
      required: true
    },
    description: {
      type: String,
      required: true
    },
    image: {
      type: String,
      default: ''
    },
    busy: {
      type: Boolean,
      default: false
    }
  },
  emits: ['choose', 'save-link', 'clear'],
  setup(props, { emit, slots }) {
    return () => h('div', { class: 'rounded-[1.5rem] border border-neutral-200 bg-white p-4' }, [
      h('div', { class: 'flex items-start justify-between gap-3' }, [
        h('div', null, [
          h('h4', { class: 'text-sm font-black text-neutral-950' }, props.title),
          h('p', { class: 'mt-1 text-xs font-semibold leading-5 text-neutral-500' }, props.description)
        ]),
        props.image
          ? h('button', {
            type: 'button',
            class: 'grid h-8 w-8 place-items-center rounded-xl bg-red-50 text-red-600 transition hover:bg-red-100',
            onClick: () => emit('clear')
          }, [h(Icon, { icon: 'solar:trash-bin-trash-bold-duotone', class: 'h-4 w-4' })])
          : null
      ]),
      h('div', { class: 'mt-3 overflow-hidden rounded-2xl bg-neutral-100' }, [
        props.image
          ? h('img', { src: props.image, alt: props.title, class: 'h-32 w-full object-cover' })
          : h('div', { class: 'grid h-32 place-items-center text-neutral-400' }, [
            h(Icon, { icon: 'solar:gallery-add-bold-duotone', class: 'h-8 w-8' })
          ])
      ]),
      h('div', { class: 'mt-3 flex gap-2' }, [
        h('button', {
          type: 'button',
          class: 'inline-flex h-10 flex-1 items-center justify-center gap-2 rounded-xl border border-neutral-200 bg-white px-3 text-xs font-black text-neutral-700 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700 disabled:opacity-60',
          disabled: props.busy,
          onClick: () => emit('choose')
        }, [
          h(Icon, { icon: props.busy ? 'solar:refresh-bold-duotone' : 'solar:upload-square-bold-duotone', class: ['h-4 w-4', props.busy ? 'animate-spin' : ''] }),
          props.busy ? 'Menyimpan...' : 'Pilih Gambar'
        ]),
        h('button', {
          type: 'button',
          class: 'inline-flex h-10 items-center justify-center rounded-xl bg-blue-600 px-3 text-xs font-black text-white transition hover:bg-blue-700 disabled:opacity-60',
          disabled: props.busy,
          onClick: () => emit('save-link')
        }, 'Simpan')
      ]),
      h('div', { class: 'mt-2' }, slots.default?.())
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
  padding: 0.7rem 0.9rem;
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

.editor-btn {
  display: inline-flex;
  min-height: 2.25rem;
  align-items: center;
  justify-content: center;
  gap: 0.35rem;
  border-radius: 0.75rem;
  border: 1px solid rgb(229 229 229);
  background: white;
  padding: 0 0.75rem;
  font-size: 0.75rem;
  font-weight: 900;
  color: rgb(82 82 82);
  transition: 160ms ease;
}

.editor-btn:hover,
.editor-btn-active {
  border-color: rgb(191 219 254);
  background: rgb(239 246 255);
  color: rgb(37 99 235);
}

.rich-editor :deep(.ProseMirror) {
  min-height: 260px;
  outline: none;
}

.rich-editor :deep(.ProseMirror p) {
  margin: 0.75rem 0;
}

.rich-editor :deep(.ProseMirror h2) {
  margin-top: 1.25rem;
  margin-bottom: 0.65rem;
  font-size: 1.45rem;
  font-weight: 900;
  letter-spacing: -0.03em;
}

.rich-editor :deep(.ProseMirror h3) {
  margin-top: 1rem;
  margin-bottom: 0.55rem;
  font-size: 1.15rem;
  font-weight: 900;
}

.rich-editor :deep(.ProseMirror ul),
.rich-editor :deep(.ProseMirror ol) {
  padding-left: 1.25rem;
}

.rich-editor :deep(.ProseMirror blockquote) {
  margin: 1rem 0;
  border-left: 4px solid rgb(37 99 235);
  border-radius: 0.75rem;
  background: rgb(239 246 255);
  padding: 0.85rem 1rem;
  color: rgb(64 64 64);
}

.rich-editor :deep(.ProseMirror img) {
  margin: 1rem 0;
  max-width: 100%;
  border-radius: 1rem;
  border: 1px solid rgb(229 229 229);
}

.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>
