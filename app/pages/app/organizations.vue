<template>
  <section class="min-h-screen bg-neutral-50 text-neutral-950">
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
            class="rounded-3xl border bg-white/95 p-4 shadow-[0_24px_90px_rgba(15,23,42,0.16)] backdrop-blur-xl"
            :class="toast.type === 'success' ? 'border-blue-100' : 'border-red-200'"
          >
            <div class="flex items-start gap-3">
              <div
                class="grid h-11 w-11 shrink-0 place-items-center rounded-2xl"
                :class="toast.type === 'success' ? 'bg-blue-50 text-blue-600' : 'bg-red-50 text-red-600'"
              >
                <Icon :icon="toast.type === 'success' ? 'solar:check-circle-bold-duotone' : 'solar:danger-circle-bold-duotone'" class="h-6 w-6" />
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

    <div class="mx-auto space-y-4 p-4 sm:p-6">
      <!-- Compact Header -->
      <section class="relative overflow-hidden rounded-[2rem] border border-neutral-200 bg-white p-4 shadow-sm sm:p-5">
        <div class="pointer-events-none absolute -right-24 -top-24 h-72 w-72 rounded-full bg-blue-100 blur-3xl"></div>
        <div class="pointer-events-none absolute -left-20 bottom-0 h-56 w-56 rounded-full bg-sky-50 blur-3xl"></div>

        <div class="relative flex flex-col gap-4 lg:flex-row lg:items-center lg:justify-between">
          <div class="flex min-w-0 items-start gap-3 sm:items-center">
            <div class="grid h-14 w-14 shrink-0 place-items-center rounded-3xl border border-blue-100 bg-white p-2 shadow-sm">
              <img
                v-if="appLogo"
                :src="appLogo"
                :alt="appName"
                class="h-full w-full object-contain"
                @error="logoFailed = true"
              >
              <Icon v-else icon="solar:buildings-3-bold-duotone" class="h-7 w-7 text-blue-600" />
            </div>

            <div class="min-w-0">
              <div class="mb-1.5 flex flex-wrap items-center gap-2">
                <span class="inline-flex items-center gap-1.5 rounded-full bg-blue-50 px-3 py-1 text-[11px] font-black uppercase tracking-[0.14em] text-blue-700">
                  <Icon icon="solar:users-group-rounded-bold-duotone" class="h-3.5 w-3.5" />
                  Organisasi
                </span>
                <span class="rounded-full border border-neutral-200 bg-neutral-50 px-3 py-1 text-[11px] font-bold text-neutral-500">
                  {{ tenantSlug }}
                </span>
              </div>

              <h1 class="truncate text-2xl font-black tracking-tight text-neutral-950 sm:text-3xl">
                Kelola Organisasi
              </h1>
              <p class="mt-1 max-w-2xl text-sm font-medium leading-6 text-neutral-500">
                Atur profil organisasi, konten publik, kontak, logo, dan tampilan detail dalam satu workspace yang ringan.
              </p>
            </div>
          </div>

          <div class="flex flex-wrap items-center gap-2">
            <button
              type="button"
              class="inline-flex items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-4 py-2.5 text-sm font-black text-neutral-700 transition hover:-translate-y-0.5 hover:border-neutral-300 hover:bg-neutral-50"
              @click="reloadOrganizations"
            >
              <Icon icon="solar:refresh-bold-duotone" class="h-5 w-5" :class="pending ? 'animate-spin' : ''" />
              Refresh
            </button>

            <button
              type="button"
              class="inline-flex items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 py-2.5 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:-translate-y-0.5 hover:bg-blue-700"
              @click="openCreate"
            >
              <Icon icon="solar:add-circle-bold-duotone" class="h-5 w-5" />
              Tambah
            </button>
          </div>
        </div>
      </section>

      <!-- Toolbar -->
      <section class="rounded-[2rem] border border-neutral-200 bg-white p-3 shadow-sm sm:p-4">
        <div class="grid gap-3 lg:grid-cols-[1fr_180px_160px_150px]">
          <div class="relative">
            <Icon icon="solar:magnifer-linear" class="pointer-events-none absolute right-4 top-1/2 h-5 w-5 -translate-y-1/2 text-neutral-400" />
            <input
              v-model.trim="q"
              type="text"
              placeholder="Cari nama, slug, kontak, atau deskripsi..."
              class="field pl-12"
            >
          </div>

          <select v-model="selectedType" class="field">
            <option value="all">Semua tipe</option>
            <option v-for="item in typeOptions" :key="item.value" :value="item.value">
              {{ item.label }}
            </option>
          </select>

          <select v-model="selectedStatus" class="field">
            <option value="active">Aktif</option>
            <option value="inactive">Nonaktif</option>
            <option value="all">Semua status</option>
          </select>

          <select v-model="sort" class="field">
            <option value="sort_order">Urutan</option>
            <option value="name">Nama A-Z</option>
            <option value="newest">Terbaru</option>
            <option value="oldest">Terlama</option>
          </select>
        </div>

        <div class="mt-3 flex flex-wrap items-center justify-between gap-2">
          <p class="text-xs font-bold text-neutral-500">
            {{ organizations.length }} data ditemukan
          </p>

          <div class="flex flex-wrap gap-2">
            <button
              type="button"
              class="inline-flex items-center gap-2 rounded-2xl px-3 py-2 text-xs font-black transition"
              :class="featuredOnly ? 'bg-blue-600 text-white shadow-lg shadow-blue-600/20' : 'border border-neutral-200 bg-white text-neutral-600 hover:bg-neutral-50'"
              @click="featuredOnly = !featuredOnly"
            >
              <Icon icon="solar:star-bold-duotone" class="h-4 w-4" />
              Unggulan
            </button>

            <button
              type="button"
              class="inline-flex items-center gap-2 rounded-2xl border border-neutral-200 bg-white px-3 py-2 text-xs font-black text-neutral-600 transition hover:bg-neutral-50"
              @click="resetFilters"
            >
              <Icon icon="solar:restart-bold-duotone" class="h-4 w-4" />
              Reset
            </button>
          </div>
        </div>
      </section>

      <div
        v-if="visibleError"
        class="rounded-3xl border border-red-200 bg-red-50 p-4 text-sm font-bold leading-6 text-red-700"
      >
        {{ visibleError }}
      </div>

      <!-- Loading -->
      <section v-if="pending" class="grid gap-3 sm:grid-cols-2 xl:grid-cols-3">
        <div
          v-for="item in 6"
          :key="item"
          class="h-56 animate-pulse rounded-[2rem] border border-neutral-200 bg-white p-4 shadow-sm"
        >
          <div class="flex gap-3">
            <div class="h-16 w-16 rounded-3xl bg-neutral-100"></div>
            <div class="flex-1">
              <div class="h-5 w-2/3 rounded-full bg-neutral-100"></div>
              <div class="mt-3 h-3 w-full rounded-full bg-neutral-100"></div>
              <div class="mt-2 h-3 w-4/5 rounded-full bg-neutral-100"></div>
            </div>
          </div>
          <div class="mt-6 h-24 rounded-3xl bg-neutral-100"></div>
        </div>
      </section>

      <!-- Empty -->
      <section
        v-else-if="organizations.length === 0"
        class="rounded-[2rem] border border-dashed border-neutral-300 bg-white p-10 text-center shadow-sm"
      >
        <div class="mx-auto grid h-16 w-16 place-items-center rounded-3xl bg-blue-50 text-blue-600">
          <Icon icon="solar:users-group-rounded-bold-duotone" class="h-8 w-8" />
        </div>
        <h2 class="mt-4 text-xl font-black text-neutral-950">Belum ada organisasi</h2>
        <p class="mx-auto mt-2 max-w-md text-sm font-medium leading-6 text-neutral-500">
          Tambahkan organisasi pertama agar tampil pada halaman public.
        </p>
        <button
          type="button"
          class="mt-5 inline-flex items-center justify-center gap-2 rounded-2xl bg-blue-600 px-5 py-3 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700"
          @click="openCreate"
        >
          <Icon icon="solar:add-circle-bold-duotone" class="h-5 w-5" />
          Tambah Organisasi
        </button>
      </section>

      <!-- List -->
      <section v-else class="grid gap-3 sm:grid-cols-2 xl:grid-cols-3">
        <article
          v-for="item in organizations"
          :key="item.id"
          class="group overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-sm transition hover:-translate-y-1 hover:border-blue-200 hover:shadow-xl hover:shadow-blue-900/5"
        >
          <div class="relative h-28 overflow-hidden bg-neutral-100">
            <img
              v-if="getOrganizationCover(item) && !failedImages[item.id]"
              :src="getOrganizationCover(item)"
              :alt="item.displayName || item.name || 'Organisasi'"
              class="h-full w-full object-cover transition duration-500 group-hover:scale-105"
              @error="markImageFailed(item.id)"
            >
            <div
              v-else
              class="flex h-full w-full items-center justify-center bg-gradient-to-br from-blue-50 via-white to-sky-50 text-blue-600"
            >
              <Icon :icon="getOrganizationIcon(item)" class="h-12 w-12" />
            </div>
            <div class="absolute inset-0 bg-gradient-to-t from-neutral-950/50 via-neutral-950/10 to-transparent"></div>

            <div class="absolute left-3 top-3 flex flex-wrap gap-2">
              <span class="inline-flex items-center gap-1.5 rounded-full bg-white/90 px-2.5 py-1 text-[11px] font-black text-neutral-800 backdrop-blur">
                <Icon :icon="getOrganizationIcon(item)" class="h-3.5 w-3.5 text-blue-600" />
                {{ organizationTypeLabel(item.organizationType) }}
              </span>
              <span
                v-if="item.isFeatured"
                class="rounded-full bg-blue-600 px-2.5 py-1 text-[11px] font-black text-white shadow-lg shadow-blue-900/20"
              >
                Unggulan
              </span>
            </div>
          </div>

          <div class="p-4">
            <div class="flex items-start gap-3">
              <div class="grid h-12 w-12 shrink-0 place-items-center overflow-hidden rounded-2xl border border-blue-100 bg-white p-1.5 shadow-sm">
                <img
                  v-if="item.logoUrl && !failedLogos[item.id]"
                  :src="item.logoUrl"
                  :alt="item.displayName || item.name || 'Logo'"
                  class="h-full w-full object-contain"
                  @error="markLogoFailed(item.id)"
                >
                <Icon v-else :icon="getOrganizationIcon(item)" class="h-6 w-6 text-blue-600" />
              </div>

              <div class="min-w-0 flex-1">
                <h2 class="line-clamp-1 text-base font-black text-neutral-950">
                  {{ item.displayName || item.name }}
                </h2>
                <p class="mt-1 line-clamp-2 text-sm font-medium leading-6 text-neutral-500">
                  {{ item.shortDescription || plainDescription(item).slice(0, 120) || 'Informasi organisasi belum ditambahkan.' }}
                </p>
              </div>
            </div>

            <div class="mt-4 grid grid-cols-2 gap-2 border-t border-neutral-100 pt-4">
              <button
                type="button"
                class="inline-flex items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-3 py-2.5 text-xs font-black text-neutral-700 transition hover:bg-neutral-50"
                @click="openEdit(item)"
              >
                <Icon icon="solar:pen-bold-duotone" class="h-4 w-4" />
                Edit
              </button>

              <button
                type="button"
                class="inline-flex items-center justify-center gap-2 rounded-2xl border border-red-100 bg-red-50 px-3 py-2.5 text-xs font-black text-red-700 transition hover:bg-red-100"
                @click="openDelete(item)"
              >
                <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-4 w-4" />
                Hapus
              </button>
            </div>
          </div>
        </article>
      </section>
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
        <div
          v-if="showForm"
          class="fixed inset-0 z-[9990] flex items-center justify-center bg-neutral-950/50 p-3 backdrop-blur-sm sm:p-4"
        >
          <div class="flex max-h-[94vh] w-full max-w-6xl flex-col overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-2xl">
            <header class="border-b border-neutral-200 bg-white px-4 py-4 sm:px-5">
              <div class="flex items-start justify-between gap-4">
                <div class="flex min-w-0 items-start gap-3">
                  <div class="grid h-12 w-12 shrink-0 place-items-center rounded-2xl bg-blue-600 text-white shadow-lg shadow-blue-600/20">
                    <Icon :icon="formMode === 'create' ? 'solar:add-circle-bold-duotone' : 'solar:pen-bold-duotone'" class="h-6 w-6" />
                  </div>
                  <div class="min-w-0">
                    <p class="text-xs font-black uppercase tracking-[0.14em] text-blue-600">
                      {{ formMode === 'create' ? 'Data Baru' : 'Ubah Data' }}
                    </p>
                    <h2 class="truncate text-xl font-black text-neutral-950">
                      {{ formMode === 'create' ? 'Tambah Organisasi' : form.displayName || form.name || 'Edit Organisasi' }}
                    </h2>
                    <p class="mt-1 text-sm font-medium text-neutral-500">
                      Isi bertahap agar data public tampil rapi dan mudah dipahami.
                    </p>
                  </div>
                </div>

                <button
                  type="button"
                  class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl text-neutral-500 transition hover:bg-neutral-100 hover:text-neutral-950"
                  @click="requestCloseForm"
                >
                  <Icon icon="solar:close-circle-bold-duotone" class="h-6 w-6" />
                </button>
              </div>

              <div class="mt-4 grid gap-2 sm:grid-cols-4">
                <button
                  v-for="step in formSteps"
                  :key="step.value"
                  type="button"
                  class="flex items-center gap-3 rounded-2xl border px-3 py-3 text-left transition"
                  :class="formStep === step.value
                    ? 'border-blue-200 bg-blue-50 text-blue-700 ring-4 ring-blue-50'
                    : formStep > step.value
                      ? 'border-blue-100 bg-white text-blue-700'
                      : 'border-neutral-200 bg-white text-neutral-500 hover:bg-neutral-50'"
                  @click="goToStep(step.value)"
                >
                  <span
                    class="grid h-8 w-8 shrink-0 place-items-center rounded-xl text-xs font-black"
                    :class="formStep === step.value
                      ? 'bg-blue-600 text-white'
                      : formStep > step.value
                        ? 'bg-blue-50 text-blue-700'
                        : 'bg-neutral-100 text-neutral-500'"
                  >
                    {{ step.value }}
                  </span>
                  <span class="min-w-0">
                    <span class="block truncate text-sm font-black">{{ step.title }}</span>
                    <span class="block truncate text-[11px] font-semibold opacity-70">{{ step.subtitle }}</span>
                  </span>
                </button>
              </div>
            </header>

            <div class="flex-1 overflow-y-auto bg-neutral-50 p-4 sm:p-5">
              <div
                v-if="formError"
                class="mb-4 rounded-3xl border border-red-200 bg-red-50 p-4 text-sm font-bold leading-6 text-red-700"
              >
                {{ formError }}
              </div>

              <!-- Step 1 -->
              <div v-if="formStep === 1" class="grid gap-4 lg:grid-cols-[1fr_320px]">
                <section class="rounded-[2rem] border border-neutral-200 bg-white p-4 shadow-sm">
                  <div class="mb-4">
                    <h3 class="text-lg font-black text-neutral-950">Identitas Organisasi</h3>
                    <p class="mt-1 text-sm font-medium text-neutral-500">Nama, tipe, slug, dan ringkasan singkat.</p>
                  </div>

                  <div class="grid gap-4 sm:grid-cols-2">
                    <div>
                      <label class="label">Nama organisasi</label>
                      <input
                        v-model.trim="form.name"
                        type="text"
                        class="field"
                        placeholder="Contoh: Karang Taruna Martopuro"
                        @input="syncSlugFromName"
                      >
                    </div>

                    <div>
                      <label class="label">Nama tampilan</label>
                      <input
                        v-model.trim="form.displayName"
                        type="text"
                        class="field"
                        placeholder="Nama yang tampil di website"
                      >
                    </div>

                    <div>
                      <label class="label">Link halaman</label>
                      <div class="flex rounded-2xl border border-neutral-200 bg-neutral-50 focus-within:border-blue-500 focus-within:bg-white focus-within:ring-4 focus-within:ring-blue-100">
                        <span class="hidden items-center border-r border-neutral-200 px-3 text-xs font-black text-neutral-400 sm:inline-flex">
                          /organizations?detail=
                        </span>
                        <input
                          v-model.trim="form.slug"
                          type="text"
                          class="w-full rounded-2xl bg-transparent px-4 py-3 text-sm font-bold text-neutral-800 outline-none"
                          placeholder="karang-taruna"
                          @input="manualSlugEdited = true"
                        >
                      </div>
                    </div>

                    <div>
                      <label class="label">Tipe organisasi</label>
                      <select v-model="form.organizationType" class="field" @change="syncIconFromType">
                        <option v-for="item in typeOptions" :key="item.value" :value="item.value">
                          {{ item.label }}
                        </option>
                      </select>
                    </div>

                    <div class="sm:col-span-2">
                      <label class="label">Ringkasan singkat</label>
                      <textarea
                        v-model.trim="form.shortDescription"
                        rows="4"
                        class="textarea-field"
                        placeholder="Tulis ringkasan pendek yang mudah dipahami warga..."
                      ></textarea>
                    </div>
                  </div>
                </section>

                <aside class="space-y-4">
                  <section class="rounded-[2rem] border border-neutral-200 bg-white p-4 shadow-sm">
                    <h3 class="text-sm font-black text-neutral-950">Ikon</h3>
                    <p class="mt-1 text-xs font-semibold leading-5 text-neutral-500">Pilih visual kecil untuk membedakan organisasi.</p>

                    <button
                      type="button"
                      class="mt-4 flex w-full items-center gap-3 rounded-2xl border border-neutral-200 bg-white p-3 text-left transition hover:border-blue-200 hover:bg-blue-50"
                      @click="showIconPicker = true"
                    >
                      <div class="grid h-12 w-12 place-items-center rounded-2xl bg-blue-50 text-blue-600">
                        <Icon :icon="form.icon || defaultIconByType(form.organizationType)" class="h-6 w-6" />
                      </div>
                      <div class="min-w-0">
                        <p class="text-sm font-black text-neutral-950">Ganti ikon</p>
                        <p class="truncate text-xs font-semibold text-neutral-500">{{ form.icon }}</p>
                      </div>
                    </button>
                  </section>

                  <section class="rounded-[2rem] border border-blue-100 bg-blue-50 p-4">
                    <p class="text-sm font-black text-blue-900">Link public</p>
                    <p class="mt-2 break-all rounded-2xl bg-white px-3 py-3 text-xs font-bold leading-5 text-blue-700">
                      {{ formPublicUrl }}
                    </p>
                  </section>
                </aside>
              </div>

              <!-- Step 2 -->
              <div v-if="formStep === 2" class="grid gap-4 lg:grid-cols-[320px_1fr]">
                <aside class="space-y-4">
                  <section class="rounded-[2rem] border border-neutral-200 bg-white p-4 shadow-sm">
                    <h3 class="text-lg font-black text-neutral-950">Logo & Gambar</h3>
                    <p class="mt-1 text-sm font-medium leading-6 text-neutral-500">Gunakan gambar yang jelas agar tampilan public terlihat profesional.</p>

                    <div class="mt-4 space-y-4">
                      <div>
                        <label class="label">Logo organisasi</label>
                        <div class="flex items-center gap-3">
                          <div class="grid h-16 w-16 shrink-0 place-items-center overflow-hidden rounded-3xl border border-neutral-200 bg-neutral-50 p-2">
                            <img v-if="form.logoUrl" :src="form.logoUrl" alt="Logo" class="h-full w-full object-contain">
                            <Icon v-else :icon="form.icon || defaultIconByType(form.organizationType)" class="h-7 w-7 text-blue-600" />
                          </div>
                          <div class="flex min-w-0 flex-1 flex-col gap-2">
                            <button type="button" class="btn-secondary w-full" :disabled="imageUploading" @click="logoInput?.click()">
                              <Icon icon="solar:upload-bold-duotone" class="h-4 w-4" />
                              Unggah
                            </button>
                            <input ref="logoInput" type="file" accept="image/*" class="hidden" @change="onPickLogo">
                          </div>
                        </div>
                        <input v-model.trim="form.logoUrl" type="url" class="field mt-3" placeholder="Atau tempel link gambar logo">
                      </div>

                      <div>
                        <label class="label">Gambar utama</label>
                        <div class="overflow-hidden rounded-3xl border border-neutral-200 bg-neutral-50">
                          <img
                            v-if="form.coverUrl"
                            :src="form.coverUrl"
                            alt="Gambar utama"
                            class="h-36 w-full object-cover"
                          >
                          <div v-else class="grid h-36 place-items-center text-blue-600">
                            <Icon icon="solar:gallery-wide-bold-duotone" class="h-10 w-10" />
                          </div>
                        </div>
                        <div class="mt-3 grid grid-cols-2 gap-2">
                          <button type="button" class="btn-secondary" :disabled="imageUploading" @click="coverInput?.click()">
                            <Icon icon="solar:upload-bold-duotone" class="h-4 w-4" />
                            Unggah
                          </button>
                          <button type="button" class="btn-secondary" @click="form.coverUrl = ''">
                            <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-4 w-4" />
                            Hapus
                          </button>
                          <input ref="coverInput" type="file" accept="image/*" class="hidden" @change="onPickCover">
                        </div>
                        <input v-model.trim="form.coverUrl" type="url" class="field mt-3" placeholder="Atau tempel link gambar utama">
                      </div>

                      <div>
                        <label class="label">Galeri</label>
                        <div class="grid grid-cols-3 gap-2">
                          <div
                            v-for="(image, index) in form.images"
                            :key="`${image}-${index}`"
                            class="group relative overflow-hidden rounded-2xl border border-neutral-200 bg-neutral-50"
                          >
                            <img :src="image" alt="Galeri" class="h-20 w-full object-cover">
                            <button
                              type="button"
                              class="absolute right-1 top-1 grid h-7 w-7 place-items-center rounded-full bg-white/90 text-red-600 opacity-0 shadow-sm transition group-hover:opacity-100"
                              @click="removeGalleryImage(index)"
                            >
                              <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-4 w-4" />
                            </button>
                          </div>

                          <button
                            type="button"
                            class="grid h-20 place-items-center rounded-2xl border border-dashed border-blue-200 bg-blue-50 text-blue-600 transition hover:bg-blue-100"
                            :disabled="imageUploading"
                            @click="galleryInput?.click()"
                          >
                            <Icon icon="solar:add-circle-bold-duotone" class="h-6 w-6" />
                          </button>
                        </div>
                        <input ref="galleryInput" type="file" accept="image/*" multiple class="hidden" @change="onPickGallery">
                        <div class="mt-3 flex gap-2">
                          <input v-model.trim="galleryUrlDraft" type="url" class="field" placeholder="Tempel link gambar">
                          <button type="button" class="btn-primary shrink-0" @click="addGalleryUrl">Tambah</button>
                        </div>
                      </div>
                    </div>
                  </section>
                </aside>

                <section class="rounded-[2rem] border border-neutral-200 bg-white p-4 shadow-sm">
                  <div class="mb-4 flex flex-col gap-3 lg:flex-row lg:items-center lg:justify-between">
                    <div>
                      <h3 class="text-lg font-black text-neutral-950">Konten Detail</h3>
                      <p class="mt-1 text-sm font-medium text-neutral-500">Tulis informasi lengkap untuk halaman public.</p>
                    </div>

                    <div class="flex flex-wrap gap-2">
                      <button type="button" class="editor-btn" :class="{ active: editor?.isActive('bold') }" @click="editor?.chain().focus().toggleBold().run()">
                        <Icon icon="solar:text-bold-bold" class="h-4 w-4" />
                        Bold
                      </button>
                      <button type="button" class="editor-btn" :class="{ active: editor?.isActive('italic') }" @click="editor?.chain().focus().toggleItalic().run()">
                        <Icon icon="solar:text-italic-bold" class="h-4 w-4" />
                        Italic
                      </button>
                    </div>
                  </div>

                  <div class="overflow-hidden rounded-[1.5rem] border border-neutral-200 bg-white">
                    <div class="flex flex-wrap items-center gap-1 border-b border-neutral-200 bg-neutral-50 p-2">
                      <button type="button" class="toolbar-btn" :class="{ active: editor?.isActive('paragraph') }" @click="editor?.chain().focus().setParagraph().run()">P</button>
                      <button type="button" class="toolbar-btn" :class="{ active: editor?.isActive('heading', { level: 1 }) }" @click="editor?.chain().focus().toggleHeading({ level: 1 }).run()">H1</button>
                      <button type="button" class="toolbar-btn" :class="{ active: editor?.isActive('heading', { level: 2 }) }" @click="editor?.chain().focus().toggleHeading({ level: 2 }).run()">H2</button>
                      <button type="button" class="toolbar-btn" :class="{ active: editor?.isActive('heading', { level: 3 }) }" @click="editor?.chain().focus().toggleHeading({ level: 3 }).run()">H3</button>
                      <span class="mx-1 h-6 w-px bg-neutral-200"></span>
                      <button type="button" class="toolbar-btn" :class="{ active: editor?.isActive('bulletList') }" @click="editor?.chain().focus().toggleBulletList().run()">
                        <Icon icon="solar:list-bold" class="h-4 w-4" />
                      </button>
                      <button type="button" class="toolbar-btn" :class="{ active: editor?.isActive('orderedList') }" @click="editor?.chain().focus().toggleOrderedList().run()">
                        <Icon icon="solar:list-check-bold" class="h-4 w-4" />
                      </button>
                      <button type="button" class="toolbar-btn" :class="{ active: editor?.isActive('blockquote') }" @click="editor?.chain().focus().toggleBlockquote().run()">
                        <Icon icon="solar:quote-down-bold" class="h-4 w-4" />
                      </button>
                      <span class="mx-1 h-6 w-px bg-neutral-200"></span>
                      <button type="button" class="toolbar-btn" @click="openLinkModal">
                        <Icon icon="solar:link-bold-duotone" class="h-4 w-4" />
                        Link
                      </button>
                      <button type="button" class="toolbar-btn" @click="editorImageInput?.click()">
                        <Icon icon="solar:gallery-add-bold-duotone" class="h-4 w-4" />
                        Gambar
                      </button>
                      <button type="button" class="toolbar-btn" @click="openMediaModal('image-url')">
                        <Icon icon="solar:link-circle-bold-duotone" class="h-4 w-4" />
                        Gambar URL
                      </button>
                      <button type="button" class="toolbar-btn" @click="openMediaModal('youtube')">
                        <Icon icon="solar:video-library-bold-duotone" class="h-4 w-4" />
                        YouTube
                      </button>
                      <button type="button" class="toolbar-btn" @click="openMediaModal('pdf')">
                        <Icon icon="solar:file-text-bold-duotone" class="h-4 w-4" />
                        PDF
                      </button>
                      <button type="button" class="toolbar-btn" @click="openMediaModal('map')">
                        <Icon icon="solar:map-point-bold-duotone" class="h-4 w-4" />
                        Maps
                      </button>
                      <span class="mx-1 h-6 w-px bg-neutral-200"></span>
                      <button type="button" class="toolbar-btn" @click="insertTable">
                        <Icon icon="solar:widget-bold-duotone" class="h-4 w-4" />
                        Tabel
                      </button>
                      <button v-if="editor?.isActive('table')" type="button" class="toolbar-btn" @click="editor?.chain().focus().addRowAfter().run()">+ Baris</button>
                      <button v-if="editor?.isActive('table')" type="button" class="toolbar-btn" @click="editor?.chain().focus().addColumnAfter().run()">+ Kolom</button>
                      <button v-if="editor?.isActive('table')" type="button" class="toolbar-btn text-red-600" @click="editor?.chain().focus().deleteTable().run()">Hapus Tabel</button>
                    </div>

                    <EditorContent :editor="editor" class="editor-surface" />
                  </div>

                  <input ref="editorImageInput" type="file" accept="image/*" class="hidden" @change="onPickEditorImage">
                </section>
              </div>

              <!-- Step 3 -->
              <div v-if="formStep === 3" class="grid gap-4 lg:grid-cols-2">
                <section class="rounded-[2rem] border border-neutral-200 bg-white p-4 shadow-sm">
                  <h3 class="text-lg font-black text-neutral-950">Kontak & Alamat</h3>
                  <p class="mt-1 text-sm font-medium text-neutral-500">Informasi yang membantu warga menghubungi organisasi.</p>

                  <div class="mt-4 grid gap-4 sm:grid-cols-2">
                    <div>
                      <label class="label">Telepon</label>
                      <input v-model.trim="form.phone" type="text" class="field" placeholder="0343..." />
                    </div>
                    <div>
                      <label class="label">WhatsApp</label>
                      <input v-model.trim="form.whatsapp" type="text" class="field" placeholder="628..." />
                    </div>
                    <div>
                      <label class="label">Email</label>
                      <input v-model.trim="form.email" type="email" class="field" placeholder="nama@email.com" />
                    </div>
                    <div>
                      <label class="label">Website</label>
                      <input v-model.trim="form.websiteUrl" type="url" class="field" placeholder="https://..." />
                    </div>
                    <div class="sm:col-span-2">
                      <label class="label">Alamat</label>
                      <textarea v-model.trim="form.address" rows="4" class="textarea-field" placeholder="Tulis alamat organisasi..."></textarea>
                    </div>
                  </div>
                </section>

                <section class="rounded-[2rem] border border-neutral-200 bg-white p-4 shadow-sm">
                  <h3 class="text-lg font-black text-neutral-950">Kanal Sosial & Status</h3>
                  <p class="mt-1 text-sm font-medium text-neutral-500">Tambahkan kanal yang aktif agar mudah dikunjungi.</p>

                  <div class="mt-4 grid gap-4 sm:grid-cols-2">
                    <div>
                      <label class="label">Instagram</label>
                      <input v-model.trim="form.instagram" type="text" class="field" placeholder="@username atau https://..." />
                    </div>
                    <div>
                      <label class="label">Facebook</label>
                      <input v-model.trim="form.facebook" type="text" class="field" placeholder="username atau https://..." />
                    </div>
                    <div>
                      <label class="label">YouTube</label>
                      <input v-model.trim="form.youtube" type="text" class="field" placeholder="channel atau https://..." />
                    </div>
                    <div>
                      <label class="label">TikTok</label>
                      <input v-model.trim="form.tiktok" type="text" class="field" placeholder="@username atau https://..." />
                    </div>
                    <div>
                      <label class="label">Status</label>
                      <select v-model="form.status" class="field">
                        <option value="active">Aktif</option>
                        <option value="inactive">Nonaktif</option>
                      </select>
                    </div>
                    <div>
                      <label class="label">Urutan tampil</label>
                      <input v-model.number="form.sortOrder" type="number" class="field" placeholder="0" />
                    </div>
                    <div class="sm:col-span-2">
                      <button
                        type="button"
                        class="flex w-full items-center justify-between rounded-2xl border border-neutral-200 bg-white p-4 text-left transition hover:border-blue-200 hover:bg-blue-50"
                        @click="form.isFeatured = !form.isFeatured"
                      >
                        <span>
                          <span class="block text-sm font-black text-neutral-950">Tampilkan sebagai unggulan</span>
                          <span class="block text-xs font-semibold text-neutral-500">Data unggulan dapat tampil di hero atau section public.</span>
                        </span>
                        <span
                          class="relative h-7 w-12 rounded-full transition"
                          :class="form.isFeatured ? 'bg-blue-600' : 'bg-neutral-200'"
                        >
                          <span
                            class="absolute top-1 h-5 w-5 rounded-full bg-white shadow-sm transition"
                            :class="form.isFeatured ? 'left-6' : 'left-1'"
                          ></span>
                        </span>
                      </button>
                    </div>
                  </div>
                </section>
              </div>

              <!-- Step 4 -->
              <div v-if="formStep === 4" class="grid gap-4 lg:grid-cols-[1fr_320px]">
                <section class="overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-sm">
                  <div class="relative h-56 bg-neutral-100">
                    <img
                      v-if="form.coverUrl"
                      :src="form.coverUrl"
                      alt="Preview"
                      class="h-full w-full object-cover"
                    >
                    <div v-else class="flex h-full w-full items-center justify-center bg-gradient-to-br from-blue-50 via-white to-sky-50 text-blue-600">
                      <Icon icon="solar:gallery-wide-bold-duotone" class="h-14 w-14" />
                    </div>
                    <div class="absolute inset-0 bg-gradient-to-t from-neutral-950/65 via-neutral-950/20 to-transparent"></div>
                    <div class="absolute bottom-5 left-5 right-5">
                      <div class="mb-3 grid h-14 w-14 place-items-center overflow-hidden rounded-2xl border border-white/20 bg-white/15 p-2 backdrop-blur">
                        <img v-if="form.logoUrl" :src="form.logoUrl" alt="Logo" class="h-full w-full object-contain">
                        <Icon v-else :icon="form.icon || defaultIconByType(form.organizationType)" class="h-7 w-7 text-white" />
                      </div>
                      <h3 class="line-clamp-2 text-2xl font-black tracking-tight text-white">{{ form.displayName || form.name || 'Nama Organisasi' }}</h3>
                      <p class="mt-2 line-clamp-2 max-w-2xl text-sm font-medium leading-6 text-white/80">
                        {{ form.shortDescription || 'Ringkasan organisasi akan tampil di sini.' }}
                      </p>
                    </div>
                  </div>

                  <div class="p-5">
                    <div class="prose prose-neutral max-w-none" v-html="reviewHtml"></div>
                  </div>
                </section>

                <aside class="space-y-4">
                  <section class="rounded-[2rem] border border-neutral-200 bg-white p-4 shadow-sm">
                    <h3 class="text-sm font-black text-neutral-950">Ringkasan</h3>
                    <div class="mt-4 space-y-3">
                      <ReviewRow label="Nama" :value="form.displayName || form.name || '-'" />
                      <ReviewRow label="Tipe" :value="organizationTypeLabel(form.organizationType)" />
                      <ReviewRow label="Status" :value="form.status === 'active' ? 'Aktif' : 'Nonaktif'" />
                      <ReviewRow label="Public" :value="formPublicUrl" />
                    </div>
                  </section>

                  <section class="rounded-[2rem] border border-blue-100 bg-blue-50 p-4">
                    <p class="text-sm font-black text-blue-900">Siap disimpan?</p>
                    <p class="mt-2 text-sm font-semibold leading-6 text-blue-700">
                      Pastikan judul, ringkasan, gambar, dan kontak sudah sesuai sebelum dipublikasikan.
                    </p>
                  </section>
                </aside>
              </div>
            </div>

            <footer class="flex flex-col gap-3 border-t border-neutral-200 bg-white px-4 py-4 sm:flex-row sm:items-center sm:justify-between sm:px-5">
              <p class="text-xs font-bold text-neutral-500">
                Langkah {{ formStep }} dari {{ formSteps.length }}
              </p>

              <div class="flex flex-col-reverse gap-2 sm:flex-row">
                <button type="button" class="btn-secondary" @click="requestCloseForm">
                  Batal
                </button>
                <button v-if="formStep > 1" type="button" class="btn-secondary" @click="formStep -= 1">
                  Sebelumnya
                </button>
                <button v-if="formStep < formSteps.length" type="button" class="btn-primary" @click="nextStep">
                  Lanjut
                  <Icon icon="solar:arrow-right-linear" class="h-4 w-4" />
                </button>
                <button v-else type="button" class="btn-primary" :disabled="saving || imageUploading" @click="submitForm">
                  <Icon icon="solar:diskette-bold-duotone" class="h-4 w-4" :class="saving ? 'animate-spin' : ''" />
                  {{ saving ? 'Menyimpan...' : 'Simpan' }}
                </button>
              </div>
            </footer>
          </div>
        </div>
      </Transition>
    </Teleport>

    <!-- Media Modal -->
    <Teleport to="body">
      <Transition
        enter-active-class="transition duration-200 ease-out"
        enter-from-class="opacity-0"
        enter-to-class="opacity-100"
        leave-active-class="transition duration-150 ease-in"
        leave-from-class="opacity-100"
        leave-to-class="opacity-0"
      >
        <div v-if="showMediaModal" class="fixed inset-0 z-[9992] flex items-center justify-center bg-neutral-950/50 p-4 backdrop-blur-sm">
          <div class="w-full max-w-xl rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-2xl">
            <div class="flex items-start justify-between gap-4">
              <div>
                <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">Tambah Media</p>
                <h2 class="mt-1 text-xl font-black text-neutral-950">{{ mediaTitle }}</h2>
                <p class="mt-1 text-sm font-semibold leading-6 text-neutral-500">{{ mediaHelp }}</p>
              </div>
              <button type="button" class="grid h-10 w-10 place-items-center rounded-2xl text-neutral-500 transition hover:bg-neutral-100 hover:text-neutral-950" @click="closeMediaModal">
                <Icon icon="solar:close-circle-bold-duotone" class="h-6 w-6" />
              </button>
            </div>

            <div class="mt-5 space-y-4">
              <div>
                <label class="label">Link atau kode semat</label>
                <textarea v-model.trim="mediaForm.url" rows="4" :placeholder="mediaPlaceholder" class="textarea-field"></textarea>
              </div>

              <div>
                <label class="label">Judul singkat</label>
                <input v-model.trim="mediaForm.title" type="text" placeholder="Opsional" class="field">
              </div>

              <div v-if="mediaError" class="rounded-2xl border border-red-200 bg-red-50 px-4 py-3 text-sm font-bold text-red-700">
                {{ mediaError }}
              </div>
            </div>

            <div class="mt-6 flex flex-col-reverse gap-3 sm:flex-row sm:justify-end">
              <button type="button" class="btn-secondary" @click="closeMediaModal">Batal</button>
              <button type="button" class="btn-primary" @click="insertMedia">Tambahkan</button>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>

    <!-- Link Modal -->
    <Teleport to="body">
      <Transition
        enter-active-class="transition duration-200 ease-out"
        enter-from-class="opacity-0"
        enter-to-class="opacity-100"
        leave-active-class="transition duration-150 ease-in"
        leave-from-class="opacity-100"
        leave-to-class="opacity-0"
      >
        <div v-if="showLinkModal" class="fixed inset-0 z-[9993] flex items-center justify-center bg-neutral-950/50 p-4 backdrop-blur-sm">
          <div class="w-full max-w-lg rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-2xl">
            <div class="flex items-start justify-between gap-4">
              <div>
                <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">Tambah Link</p>
                <h2 class="mt-1 text-xl font-black text-neutral-950">Sisipkan tautan</h2>
                <p class="mt-1 text-sm font-semibold leading-6 text-neutral-500">Gunakan untuk mengarahkan pembaca ke halaman pendukung.</p>
              </div>
              <button type="button" class="grid h-10 w-10 place-items-center rounded-2xl text-neutral-500 transition hover:bg-neutral-100 hover:text-neutral-950" @click="closeLinkModal">
                <Icon icon="solar:close-circle-bold-duotone" class="h-6 w-6" />
              </button>
            </div>

            <div class="mt-5 space-y-4">
              <div>
                <label class="label">Teks link</label>
                <input v-model.trim="linkForm.text" type="text" class="field" placeholder="Contoh: Buka informasi lengkap">
              </div>
              <div>
                <label class="label">Alamat link</label>
                <input v-model.trim="linkForm.url" type="url" class="field" placeholder="https://...">
              </div>
              <div v-if="linkError" class="rounded-2xl border border-red-200 bg-red-50 px-4 py-3 text-sm font-bold text-red-700">
                {{ linkError }}
              </div>
            </div>

            <div class="mt-6 flex flex-col-reverse gap-3 sm:flex-row sm:justify-end">
              <button type="button" class="btn-secondary" @click="closeLinkModal">Batal</button>
              <button v-if="editor?.isActive('link')" type="button" class="btn-secondary text-red-600" @click="removeLink">Hapus Link</button>
              <button type="button" class="btn-primary" @click="applyLink">Sisipkan</button>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>

    <!-- Icon Picker -->
    <Teleport to="body">
      <Transition
        enter-active-class="transition duration-200 ease-out"
        enter-from-class="opacity-0"
        enter-to-class="opacity-100"
        leave-active-class="transition duration-150 ease-in"
        leave-from-class="opacity-100"
        leave-to-class="opacity-0"
      >
        <div v-if="showIconPicker" class="fixed inset-0 z-[9994] flex items-center justify-center bg-neutral-950/50 p-4 backdrop-blur-sm">
          <div class="flex max-h-[88vh] w-full max-w-3xl flex-col overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-2xl">
            <header class="border-b border-neutral-200 p-5">
              <div class="flex items-start justify-between gap-4">
                <div>
                  <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">Pilih Ikon</p>
                  <h2 class="mt-1 text-xl font-black text-neutral-950">Ikon organisasi</h2>
                </div>
                <button type="button" class="grid h-10 w-10 place-items-center rounded-2xl text-neutral-500 transition hover:bg-neutral-100 hover:text-neutral-950" @click="showIconPicker = false">
                  <Icon icon="solar:close-circle-bold-duotone" class="h-6 w-6" />
                </button>
              </div>

              <div class="mt-4 grid gap-3 sm:grid-cols-[1fr_160px]">
                <input v-model.trim="iconQuery" type="text" class="field" placeholder="Cari ikon: user, building, mosque..." @input="scheduleIconSearch">
                <select v-model="iconPrefix" class="field" @change="searchIcons">
                  <option v-for="item in iconPrefixes" :key="item" :value="item">{{ item }}</option>
                </select>
              </div>
            </header>

            <div class="flex-1 overflow-y-auto p-5">
              <div v-if="iconLoading" class="grid grid-cols-6 gap-2 sm:grid-cols-10">
                <div v-for="item in 40" :key="item" class="h-12 animate-pulse rounded-2xl bg-neutral-100"></div>
              </div>

              <div v-else class="grid grid-cols-6 gap-2 sm:grid-cols-10">
                <button
                  v-for="icon in displayedIcons"
                  :key="icon"
                  type="button"
                  class="grid h-12 place-items-center rounded-2xl border transition"
                  :class="form.icon === icon ? 'border-blue-200 bg-blue-50 text-blue-600 ring-4 ring-blue-50' : 'border-neutral-200 bg-white text-neutral-700 hover:border-blue-200 hover:bg-blue-50 hover:text-blue-600'"
                  @click="selectIcon(icon)"
                >
                  <Icon :icon="icon" class="h-6 w-6" />
                </button>
              </div>

              <div v-if="iconError" class="mt-4 rounded-2xl border border-yellow-200 bg-yellow-50 p-4 text-sm font-bold text-yellow-800">
                {{ iconError }}
              </div>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>

    <!-- Delete Modal -->
    <Teleport to="body">
      <Transition
        enter-active-class="transition duration-200 ease-out"
        enter-from-class="opacity-0"
        enter-to-class="opacity-100"
        leave-active-class="transition duration-150 ease-in"
        leave-from-class="opacity-100"
        leave-to-class="opacity-0"
      >
        <div v-if="showDelete" class="fixed inset-0 z-[9995] flex items-center justify-center bg-neutral-950/50 p-4 backdrop-blur-sm">
          <div class="w-full max-w-md rounded-[2rem] border border-red-100 bg-white p-5 shadow-2xl">
            <div class="grid h-14 w-14 place-items-center rounded-3xl bg-red-50 text-red-600">
              <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-7 w-7" />
            </div>
            <h2 class="mt-4 text-xl font-black text-neutral-950">Hapus organisasi?</h2>
            <p class="mt-2 text-sm font-semibold leading-6 text-neutral-500">
              Data <b>{{ selectedOrganization?.displayName || selectedOrganization?.name }}</b> akan dipindahkan dari daftar. Tindakan ini sebaiknya dilakukan hanya jika data sudah tidak digunakan.
            </p>
            <div class="mt-6 flex flex-col-reverse gap-3 sm:flex-row sm:justify-end">
              <button type="button" class="btn-secondary" @click="showDelete = false">Batal</button>
              <button type="button" class="inline-flex items-center justify-center gap-2 rounded-2xl bg-red-600 px-5 py-3 text-sm font-black text-white transition hover:bg-red-700 disabled:cursor-not-allowed disabled:opacity-60" :disabled="deleting" @click="confirmDelete">
                <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-4 w-4" :class="deleting ? 'animate-spin' : ''" />
                Hapus
              </button>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>

    <!-- Discard Modal -->
    <Teleport to="body">
      <Transition
        enter-active-class="transition duration-200 ease-out"
        enter-from-class="opacity-0"
        enter-to-class="opacity-100"
        leave-active-class="transition duration-150 ease-in"
        leave-from-class="opacity-100"
        leave-to-class="opacity-0"
      >
        <div v-if="showDiscard" class="fixed inset-0 z-[9996] flex items-center justify-center bg-neutral-950/50 p-4 backdrop-blur-sm">
          <div class="w-full max-w-md rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-2xl">
            <div class="grid h-14 w-14 place-items-center rounded-3xl bg-blue-50 text-blue-600">
              <Icon icon="solar:shield-warning-bold-duotone" class="h-7 w-7" />
            </div>
            <h2 class="mt-4 text-xl font-black text-neutral-950">Tutup form?</h2>
            <p class="mt-2 text-sm font-semibold leading-6 text-neutral-500">
              Ada perubahan yang belum disimpan. Kamu bisa kembali mengedit atau menutup form ini.
            </p>
            <div class="mt-6 flex flex-col-reverse gap-3 sm:flex-row sm:justify-end">
              <button type="button" class="btn-secondary" @click="showDiscard = false">Kembali</button>
              <button type="button" class="btn-primary" @click="forceCloseForm">Tutup</button>
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
import Placeholder from '@tiptap/extension-placeholder'
import { Table } from '@tiptap/extension-table'
import { TableRow } from '@tiptap/extension-table-row'
import { TableCell } from '@tiptap/extension-table-cell'
import { TableHeader } from '@tiptap/extension-table-header'
import { Node, mergeAttributes } from '@tiptap/core'
import { computed, defineComponent, h, nextTick, onBeforeUnmount, onMounted, reactive, ref, shallowRef, watch } from 'vue'
import { useRuntimeConfig } from 'nuxt/app'
import type {
  CreateOrganizationPayload,
  OrganizationItem,
  OrganizationStatus,
  OrganizationType,
  UpdateOrganizationPayload
} from '~/types/organization'
import { useOrganizationsSQL } from '../../composables/data/useOrganizations'
import { useCloudinaryUpload as useMediaUpload } from '~/composables/useCloudinaryUpload'

definePageMeta({
  layout: 'app',
  layoutProps: {
    title: 'Organisasi'
  }
})

type ToastType = 'success' | 'error'
type MediaType = 'image-url' | 'youtube' | 'pdf' | 'map'

type OrganizationForm = {
  name: string
  displayName: string
  slug: string
  organizationType: OrganizationType
  shortDescription: string
  logoUrl: string
  coverUrl: string
  email: string
  phone: string
  whatsapp: string
  websiteUrl: string
  instagram: string
  facebook: string
  youtube: string
  tiktok: string
  address: string
  status: OrganizationStatus
  isFeatured: boolean
  sortOrder: number
  icon: string
  images: string[]
}

const runtime = useRuntimeConfig()

const {
  tenantSlug,
  q,
  selectedType,
  selectedStatus,
  featuredOnly,
  page,
  limit,
  sort,
  organizations,
  pending,
  error,
  refresh,
  createOrganization,
  updateOrganization,
  deleteOrganization,
  resetFilters: resetApiFilters
} = useOrganizationsSQL()

const {
  uploading: imageUploading,
  uploadImage
} = useMediaUpload()

const editor = shallowRef<Editor | null>(null)

const logoFailed = ref(false)
const failedImages = ref<Record<string, boolean>>({})
const failedLogos = ref<Record<string, boolean>>({})

const showForm = ref(false)
const showDelete = ref(false)
const showDiscard = ref(false)
const showMediaModal = ref(false)
const showLinkModal = ref(false)
const showIconPicker = ref(false)

const formMode = ref<'create' | 'edit'>('create')
const formStep = ref(1)
const formTouched = ref(false)
const formDirty = ref(false)
const saving = ref(false)
const deleting = ref(false)
const formError = ref('')
const selectedOrganization = ref<OrganizationItem | null>(null)
const manualSlugEdited = ref(false)

const logoInput = ref<HTMLInputElement | null>(null)
const coverInput = ref<HTMLInputElement | null>(null)
const galleryInput = ref<HTMLInputElement | null>(null)
const editorImageInput = ref<HTMLInputElement | null>(null)
const galleryUrlDraft = ref('')

const mediaType = ref<MediaType>('image-url')
const mediaError = ref('')
const mediaForm = reactive({
  url: '',
  title: ''
})

const linkError = ref('')
const linkForm = reactive({
  text: '',
  url: ''
})

const iconQuery = ref('building')
const iconPrefix = ref('solar')
const iconLoading = ref(false)
const iconError = ref('')
const iconResults = ref<string[]>([])

let iconSearchTimer: ReturnType<typeof setTimeout> | null = null
let toastTimer: ReturnType<typeof setTimeout> | null = null

const toast = reactive({
  show: false,
  type: 'success' as ToastType,
  title: '',
  message: ''
})

const form = reactive<OrganizationForm>({
  name: '',
  displayName: '',
  slug: '',
  organizationType: 'custom',
  shortDescription: '',
  logoUrl: '',
  coverUrl: '',
  email: '',
  phone: '',
  whatsapp: '',
  websiteUrl: '',
  instagram: '',
  facebook: '',
  youtube: '',
  tiktok: '',
  address: '',
  status: 'active',
  isFeatured: true,
  sortOrder: 0,
  icon: 'solar:buildings-3-bold-duotone',
  images: []
})

const formSteps = [
  {
    value: 1,
    title: 'Identitas',
    subtitle: 'Nama & tipe'
  },
  {
    value: 2,
    title: 'Konten',
    subtitle: 'Gambar & cerita'
  },
  {
    value: 3,
    title: 'Kontak',
    subtitle: 'Kanal & status'
  },
  {
    value: 4,
    title: 'Review',
    subtitle: 'Cek akhir'
  }
]

const typeOptions: Array<{ value: OrganizationType; label: string; icon: string }> = [
  { value: 'village_government', label: 'Pemerintah Desa', icon: 'solar:buildings-3-bold-duotone' },
  { value: 'government', label: 'Pemerintahan', icon: 'solar:banknote-2-bold-duotone' },
  { value: 'bumdes', label: 'BUMDes', icon: 'solar:case-round-bold-duotone' },
  { value: 'youth', label: 'Karang Taruna', icon: 'solar:users-group-rounded-bold-duotone' },
  { value: 'women', label: 'PKK / Perempuan', icon: 'solar:heart-bold-duotone' },
  { value: 'community', label: 'Komunitas', icon: 'solar:people-nearby-bold-duotone' },
  { value: 'religious', label: 'Keagamaan', icon: 'solar:stars-bold-duotone' },
  { value: 'education', label: 'Pendidikan', icon: 'solar:square-academic-cap-2-bold-duotone' },
  { value: 'health', label: 'Kesehatan', icon: 'solar:heart-pulse-bold-duotone' },
  { value: 'umkm', label: 'UMKM', icon: 'solar:shop-bold-duotone' },
  { value: 'tourism', label: 'Wisata', icon: 'solar:map-point-wave-bold-duotone' },
  { value: 'culture', label: 'Budaya', icon: 'solar:star-shine-bold-duotone' },
  { value: 'security', label: 'Keamanan', icon: 'solar:shield-check-bold-duotone' },
  { value: 'custom', label: 'Lainnya', icon: 'solar:widget-5-bold-duotone' }
]

const iconPrefixes = ['solar', 'lucide', 'mdi', 'tabler', 'material-symbols', 'heroicons', 'ph']

const fallbackIcons = [
  'solar:buildings-3-bold-duotone',
  'solar:users-group-rounded-bold-duotone',
  'solar:case-round-bold-duotone',
  'solar:shop-bold-duotone',
  'solar:heart-pulse-bold-duotone',
  'solar:shield-check-bold-duotone',
  'solar:map-point-wave-bold-duotone',
  'solar:star-shine-bold-duotone',
  'lucide:building-2',
  'lucide:users-round',
  'lucide:landmark',
  'lucide:heart-handshake',
  'lucide:store',
  'lucide:shield-check',
  'mdi:account-group',
  'mdi:office-building'
]

const appName = computed(() => {
  return String(
    runtime.public.appName ||
    runtime.public.clientDisplayName ||
    runtime.public.siteName ||
    tenantSlug.value ||
    'Arsades'
  )
})

const appLogo = computed(() => {
  if (logoFailed.value) return ''
  return String(
    runtime.public.appLogo ||
    runtime.public.logoUrl ||
    runtime.public.siteLogo ||
    runtime.public.favicon ||
    ''
  )
})

const visibleError = computed(() => {
  if (!error.value) return ''
  return error.value?.message || 'Data organisasi belum berhasil dimuat.'
})

const displayedIcons = computed(() => {
  return iconResults.value.length ? iconResults.value : fallbackIcons
})

const formPublicUrl = computed(() => {
  const slug = slugify(form.slug || form.name || '')
  return `/organizations${slug ? `?detail=${encodeURIComponent(slug)}` : ''}`
})

const reviewHtml = computed(() => {
  const html = editor.value?.getHTML() || '<p>Konten detail belum diisi.</p>'
  return sanitizeHtml(html)
})

const mediaTitle = computed(() => {
  if (mediaType.value === 'youtube') return 'Sematkan YouTube'
  if (mediaType.value === 'pdf') return 'Sematkan PDF'
  if (mediaType.value === 'map') return 'Sematkan Maps'
  return 'Tambahkan gambar dari link'
})

const mediaHelp = computed(() => {
  if (mediaType.value === 'youtube') return 'Tempel link video YouTube agar tampil langsung di artikel.'
  if (mediaType.value === 'pdf') return 'Tempel link dokumen yang bisa dibuka publik.'
  if (mediaType.value === 'map') return 'Tempel link atau kode semat lokasi dari Google Maps.'
  return 'Tempel link gambar yang bisa diakses publik.'
})

const mediaPlaceholder = computed(() => {
  if (mediaType.value === 'youtube') return 'https://www.youtube.com/watch?v=...'
  if (mediaType.value === 'pdf') return 'https://.../dokumen.pdf atau link Google Drive'
  if (mediaType.value === 'map') return '<iframe src="https://www.google.com/maps/embed?..."></iframe>'
  return 'https://.../gambar.jpg'
})

const PdfEmbed = Node.create({
  name: 'pdfEmbed',
  group: 'block',
  atom: true,

  addAttributes() {
    return {
      src: { default: null },
      title: { default: 'PDF' }
    }
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
        title: HTMLAttributes.title || 'PDF',
        class: 'tiptap-embed tiptap-pdf',
        loading: 'lazy'
      })
    ]
  },

  addCommands() {
    return {
      setPdfEmbed:
        (attrs: any) =>
        ({ commands }: any) => {
          return commands.insertContent({
            type: this.name,
            attrs
          })
        }
    } as any
  }
})

const MapEmbed = Node.create({
  name: 'mapEmbed',
  group: 'block',
  atom: true,

  addAttributes() {
    return {
      src: { default: null },
      title: { default: 'Maps' }
    }
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
        title: HTMLAttributes.title || 'Maps',
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
        ({ commands }: any) => {
          return commands.insertContent({
            type: this.name,
            attrs
          })
        }
    } as any
  }
})

onMounted(() => {
  limit.value = 120
  page.value = 1
  ensureEditor()
  searchIcons()
})

onBeforeUnmount(() => {
  if (toastTimer) clearTimeout(toastTimer)
  if (iconSearchTimer) clearTimeout(iconSearchTimer)
  editor.value?.destroy()
})

watch(
  () => form.name,
  () => {
    formDirty.value = true
    syncSlugFromName()
  }
)

watch(
  form,
  () => {
    formDirty.value = true
  },
  { deep: true }
)

function ensureEditor() {
  if (editor.value) return

  editor.value = new Editor({
    content: '<p></p>',
    extensions: [
      StarterKit.configure({
        heading: {
          levels: [1, 2, 3]
        },
        bulletList: {
          keepMarks: true
        },
        orderedList: {
          keepMarks: true
        }
      }),
      Underline,
      Link.configure({
        openOnClick: false,
        autolink: true,
        HTMLAttributes: {
          class: 'text-blue-600 underline underline-offset-4'
        }
      }),
      Image.configure({
        inline: false,
        allowBase64: false,
        HTMLAttributes: {
          class: 'rounded-2xl border border-neutral-200'
        }
      }),
      Youtube.configure({
        controls: true,
        nocookie: true,
        HTMLAttributes: {
          class: 'rounded-2xl overflow-hidden'
        }
      }),
      Table.configure({
        resizable: true,
        HTMLAttributes: {
          class: 'tiptap-table'
        }
      }),
      TableRow,
      TableHeader,
      TableCell,
      Placeholder.configure({
        placeholder: 'Tulis informasi lengkap organisasi di sini...'
      }),
      PdfEmbed,
      MapEmbed
    ],
    editorProps: {
      attributes: {
        class: 'outline-none min-h-[340px] px-4 py-4 prose prose-neutral max-w-none'
      }
    },
    onUpdate() {
      formDirty.value = true
    }
  })
}

async function reloadOrganizations() {
  try {
    await refresh()
    showToast('success', 'Data diperbarui', 'Daftar organisasi berhasil dimuat ulang.')
  } catch (err: any) {
    showToast('error', 'Gagal memuat data', err?.message || 'Coba beberapa saat lagi.')
  }
}

function resetFilters() {
  resetApiFilters()
  selectedStatus.value = 'active'
  selectedType.value = 'all'
  sort.value = 'sort_order'
}

function resetForm() {
  formStep.value = 1
  formTouched.value = false
  formDirty.value = false
  formError.value = ''
  selectedOrganization.value = null
  manualSlugEdited.value = false
  galleryUrlDraft.value = ''

  form.name = ''
  form.displayName = ''
  form.slug = ''
  form.organizationType = 'custom'
  form.shortDescription = ''
  form.logoUrl = ''
  form.coverUrl = ''
  form.email = ''
  form.phone = ''
  form.whatsapp = ''
  form.websiteUrl = ''
  form.instagram = ''
  form.facebook = ''
  form.youtube = ''
  form.tiktok = ''
  form.address = ''
  form.status = 'active'
  form.isFeatured = true
  form.sortOrder = 0
  form.icon = defaultIconByType('custom')
  form.images = []

  ensureEditor()
  editor.value?.commands.setContent('<p></p>')

  nextTick(() => {
    formDirty.value = false
  })
}

function openCreate() {
  formMode.value = 'create'
  resetForm()
  showForm.value = true

  nextTick(() => {
    ensureEditor()
    editor.value?.commands.focus()
    formDirty.value = false
  })
}

function openEdit(item: OrganizationItem) {
  formMode.value = 'edit'
  resetForm()
  selectedOrganization.value = item

  form.name = item.name || ''
  form.displayName = item.displayName || item.name || ''
  form.slug = item.slug || ''
  form.organizationType = item.organizationType || 'custom'
  form.shortDescription = item.shortDescription || ''
  form.logoUrl = item.logoUrl || ''
  form.coverUrl = item.coverUrl || getOrganizationImages(item)[0] || ''
  form.email = item.email || item.contact?.email || ''
  form.phone = item.phone || item.contact?.phone || ''
  form.whatsapp = item.whatsapp || item.contact?.whatsapp || ''
  form.websiteUrl = item.websiteUrl || ''
  form.instagram = item.social?.instagram || item.metadata?.instagram || ''
  form.facebook = item.social?.facebook || item.metadata?.facebook || ''
  form.youtube = item.social?.youtube || item.metadata?.youtube || ''
  form.tiktok = item.social?.tiktok || item.metadata?.tiktok || ''
  form.address = item.address || ''
  form.status = item.status || 'active'
  form.isFeatured = Boolean(item.isFeatured)
  form.sortOrder = Number(item.sortOrder || 0)
  form.icon = item.metadata?.icon || defaultIconByType(item.organizationType || 'custom')
  form.images = getOrganizationImages(item)
  manualSlugEdited.value = true

  ensureEditor()

  const metadata = item.metadata || {}
  if (metadata.descriptionJson) {
    editor.value?.commands.setContent(metadata.descriptionJson)
  } else if (metadata.descriptionHtml) {
    editor.value?.commands.setContent(metadata.descriptionHtml)
  } else if (item.description) {
    editor.value?.commands.setContent(item.description)
  } else {
    editor.value?.commands.setContent('<p></p>')
  }

  showForm.value = true

  nextTick(() => {
    formDirty.value = false
  })
}

function requestCloseForm() {
  if (formDirty.value) {
    showDiscard.value = true
    return
  }

  forceCloseForm()
}

function forceCloseForm() {
  showDiscard.value = false
  showForm.value = false
  formError.value = ''
  formDirty.value = false
}

function validateCurrentStep() {
  formTouched.value = true
  formError.value = ''

  if (formStep.value === 1) {
    if (!form.name.trim()) {
      formError.value = 'Nama organisasi wajib diisi.'
      return false
    }

    if (!form.slug.trim()) {
      form.slug = slugify(form.name)
    }

    if (!form.organizationType) {
      formError.value = 'Tipe organisasi wajib dipilih.'
      return false
    }
  }

  if (formStep.value === 2) {
    if (form.logoUrl && !isValidUrl(form.logoUrl)) {
      formError.value = 'Link logo belum valid.'
      return false
    }

    if (form.coverUrl && !isValidUrl(form.coverUrl)) {
      formError.value = 'Link gambar utama belum valid.'
      return false
    }
  }

  if (formStep.value === 3) {
    if (form.websiteUrl && !isValidUrl(form.websiteUrl)) {
      formError.value = 'Link website belum valid.'
      return false
    }

    if (form.email && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(form.email)) {
      formError.value = 'Format email belum valid.'
      return false
    }
  }

  return true
}

function validateAllSteps() {
  const current = formStep.value

  for (const step of formSteps) {
    formStep.value = step.value
    if (!validateCurrentStep()) {
      return false
    }
  }

  formStep.value = current
  return true
}

function nextStep() {
  if (!validateCurrentStep()) return
  formStep.value = Math.min(formStep.value + 1, formSteps.length)
}

function goToStep(step: number) {
  if (step <= formStep.value) {
    formStep.value = step
    return
  }

  if (!validateCurrentStep()) return
  formStep.value = step
}

async function submitForm() {
  formError.value = ''
  if (!validateAllSteps()) return

  saving.value = true

  try {
    ensureEditor()

    const html = editor.value?.getHTML() || '<p></p>'
    const json = editor.value?.getJSON() || {}
    const previousMetadata = selectedOrganization.value?.metadata || {}

    const images = Array.from(new Set([form.coverUrl, ...form.images].map((item) => String(item || '').trim()).filter(Boolean)))
    const cleanSlug = slugify(form.slug || form.name)

    const payload: CreateOrganizationPayload | UpdateOrganizationPayload = {
      organizationType: form.organizationType,
      name: form.name.trim(),
      displayName: form.displayName.trim() || form.name.trim(),
      slug: cleanSlug,
      shortDescription: form.shortDescription.trim(),
      description: html,
      logoUrl: form.logoUrl.trim() || null,
      coverUrl: images[0] || null,
      email: form.email.trim() || null,
      phone: form.phone.trim() || null,
      whatsapp: form.whatsapp.trim() || null,
      websiteUrl: form.websiteUrl.trim() || null,
      address: form.address.trim() || null,
      contact: {
        email: form.email.trim() || null,
        phone: form.phone.trim() || null,
        whatsapp: form.whatsapp.trim() || null
      },
      social: {
        instagram: normalizeSocialValue(form.instagram),
        facebook: normalizeSocialValue(form.facebook),
        youtube: normalizeSocialValue(form.youtube),
        tiktok: normalizeSocialValue(form.tiktok)
      },
      metadata: {
        ...previousMetadata,
        icon: form.icon || defaultIconByType(form.organizationType),
        images,
        descriptionHtml: html,
        descriptionJson: json,
        instagram: normalizeSocialValue(form.instagram),
        facebook: normalizeSocialValue(form.facebook),
        youtube: normalizeSocialValue(form.youtube),
        tiktok: normalizeSocialValue(form.tiktok),
        updatedFrom: 'app-organizations'
      },
      status: form.status,
      isFeatured: Boolean(form.isFeatured),
      sortOrder: Number(form.sortOrder || 0)
    }

    if (formMode.value === 'create') {
      await createOrganization(payload as CreateOrganizationPayload)
      showToast('success', 'Berhasil disimpan', 'Organisasi baru sudah ditambahkan.')
    } else if (selectedOrganization.value) {
      await updateOrganization(selectedOrganization.value.id, payload as UpdateOrganizationPayload)
      showToast('success', 'Perubahan tersimpan', 'Data organisasi berhasil diperbarui.')
    }

    formDirty.value = false
    showForm.value = false
    await refresh()
  } catch (err: any) {
    formError.value =
      err?.data?.statusMessage ||
      err?.data?.message ||
      err?.statusMessage ||
      err?.message ||
      'Data belum berhasil disimpan.'
  } finally {
    saving.value = false
  }
}

function openDelete(item: OrganizationItem) {
  selectedOrganization.value = item
  showDelete.value = true
}

async function confirmDelete() {
  if (!selectedOrganization.value) return

  deleting.value = true

  try {
    await deleteOrganization(selectedOrganization.value.id)
    showToast('success', 'Data dihapus', 'Organisasi berhasil dihapus dari daftar.')
    showDelete.value = false
    selectedOrganization.value = null
    await refresh()
  } catch (err: any) {
    showToast('error', 'Gagal menghapus', err?.message || 'Coba beberapa saat lagi.')
  } finally {
    deleting.value = false
  }
}

function syncSlugFromName() {
  if (manualSlugEdited.value && form.slug) return
  form.slug = slugify(form.name)
}

function syncIconFromType() {
  if (form.icon && form.icon !== defaultIconByType('custom')) return
  form.icon = defaultIconByType(form.organizationType)
}

async function onPickLogo(event: Event) {
  const url = await uploadPickedImage(event, `${tenantSlug.value}/organizations/logo`)
  if (url) form.logoUrl = url
}

async function onPickCover(event: Event) {
  const url = await uploadPickedImage(event, `${tenantSlug.value}/organizations/cover`)
  if (url) form.coverUrl = url
}

async function onPickGallery(event: Event) {
  const input = event.target as HTMLInputElement
  const files = Array.from(input.files || [])

  if (!files.length) return

  try {
    const uploaded: string[] = []
    for (const file of files) {
      const url = await uploadFileImage(file, `${tenantSlug.value}/organizations/gallery`)
      uploaded.push(url)
    }

    form.images = Array.from(new Set([...form.images, ...uploaded]))
    showToast('success', 'Gambar ditambahkan', 'Galeri berhasil diperbarui.')
  } catch (err: any) {
    showToast('error', 'Gambar belum berhasil ditambahkan', err?.message || 'Coba pilih gambar lain.')
  } finally {
    input.value = ''
  }
}

async function onPickEditorImage(event: Event) {
  const url = await uploadPickedImage(event, `${tenantSlug.value}/organizations/content`)
  if (!url) return

  editor.value
    ?.chain()
    .focus()
    .setImage({
      src: url,
      alt: 'Gambar konten'
    })
    .run()

  showToast('success', 'Gambar masuk ke konten', 'Gambar berhasil ditambahkan ke area tulisan.')
}

async function uploadPickedImage(event: Event, folder: string) {
  const input = event.target as HTMLInputElement
  const file = input.files?.[0] || null

  if (!file) return ''

  try {
    return await uploadFileImage(file, folder)
  } catch (err: any) {
    showToast('error', 'Gambar belum berhasil ditambahkan', err?.message || 'Coba pilih gambar lain.')
    return ''
  } finally {
    input.value = ''
  }
}

async function uploadFileImage(file: File, folder: string) {
  const result = await uploadImage(file, {
    folder,
    maxWidth: 1800,
    maxHeight: 1800,
    quality: 0.82,
    maxBytes: 5 * 1024 * 1024
  })

  return (result as any).secure_url || (result as any).url || ''
}

function addGalleryUrl() {
  const url = galleryUrlDraft.value.trim()
  if (!url) return

  if (!isValidUrl(url)) {
    showToast('error', 'Link belum valid', 'Pastikan link gambar diawali dengan http atau https.')
    return
  }

  form.images = Array.from(new Set([...form.images, url]))
  galleryUrlDraft.value = ''
}

function removeGalleryImage(index: number) {
  form.images = form.images.filter((_, itemIndex) => itemIndex !== index)
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

function insertMedia() {
  mediaError.value = ''

  const rawUrl = mediaForm.url.trim()
  const url = extractIframeSrc(rawUrl)

  if (!url || !isValidUrl(url)) {
    mediaError.value = 'Link atau kode semat belum valid.'
    return
  }

  ensureEditor()

  if (mediaType.value === 'image-url') {
    editor.value
      ?.chain()
      .focus()
      .setImage({
        src: url,
        alt: mediaForm.title || 'Gambar'
      })
      .run()
  }

  if (mediaType.value === 'youtube') {
    editor.value
      ?.chain()
      .focus()
      .setYoutubeVideo({
        src: url,
        width: 720,
        height: 405
      })
      .run()
  }

  if (mediaType.value === 'pdf') {
    ;(editor.value?.commands as any).setPdfEmbed({
      src: embedPdfUrl(url),
      title: mediaForm.title || 'PDF'
    })
  }

  if (mediaType.value === 'map') {
    ;(editor.value?.commands as any).setMapEmbed({
      src: url,
      title: mediaForm.title || 'Maps'
    })
  }

  closeMediaModal()
}

function openLinkModal() {
  ensureEditor()
  const previousUrl = editor.value?.getAttributes('link')?.href || ''
  const selectedText = getSelectedText()

  linkForm.url = previousUrl
  linkForm.text = selectedText
  linkError.value = ''
  showLinkModal.value = true
}

function closeLinkModal() {
  showLinkModal.value = false
  linkError.value = ''
}

function applyLink() {
  linkError.value = ''
  const url = linkForm.url.trim()

  if (!url || !isValidUrl(url)) {
    linkError.value = 'Alamat link belum valid.'
    return
  }

  ensureEditor()

  if (getSelectedText()) {
    editor.value
      ?.chain()
      .focus()
      .extendMarkRange('link')
      .setLink({ href: url })
      .run()
  } else {
    editor.value
      ?.chain()
      .focus()
      .insertContent({
        type: 'text',
        text: linkForm.text || url,
        marks: [
          {
            type: 'link',
            attrs: {
              href: url
            }
          }
        ]
      })
      .run()
  }

  closeLinkModal()
}

function removeLink() {
  editor.value?.chain().focus().extendMarkRange('link').unsetLink().run()
  closeLinkModal()
}

function insertTable() {
  ensureEditor()
  editor.value?.chain().focus().insertTable({ rows: 3, cols: 3, withHeaderRow: true }).run()
}

function getSelectedText() {
  const view = editor.value?.view
  const state = editor.value?.state

  if (!view || !state) return ''

  const { from, to } = state.selection
  return state.doc.textBetween(from, to, ' ').trim()
}

function extractIframeSrc(value: string) {
  const source = String(value || '').trim()
  const match = source.match(/src=["']([^"']+)["']/i)
  return match?.[1] || source
}

function embedPdfUrl(url: string) {
  const driveMatch = url.match(/drive\.google\.com\/file\/d\/([^/]+)/)
  if (driveMatch?.[1]) {
    return `https://drive.google.com/file/d/${driveMatch[1]}/preview`
  }

  return url
}

function getOrganizationImages(item: OrganizationItem) {
  const metadataImages = Array.isArray(item.metadata?.images)
    ? item.metadata.images
    : []

  const images = [
    item.coverUrl,
    ...metadataImages
  ]
    .map((value) => String(value || '').trim())
    .filter(Boolean)

  return Array.from(new Set(images))
}

function getOrganizationCover(item: OrganizationItem) {
  return getOrganizationImages(item)[0] || item.logoUrl || ''
}

function getOrganizationIcon(item: OrganizationItem) {
  return item.metadata?.icon || defaultIconByType(item.organizationType || 'custom')
}

function defaultIconByType(type: OrganizationType) {
  return typeOptions.find((item) => item.value === type)?.icon || 'solar:widget-5-bold-duotone'
}

function organizationTypeLabel(type: OrganizationType) {
  return typeOptions.find((item) => item.value === type)?.label || 'Organisasi'
}

function organizationPublicTo(item: OrganizationItem) {
  const slug = String(item.slug || '').trim()
  if (!slug) return '/organizations'
  return `/organizations?detail=${encodeURIComponent(slug)}`
}

async function copyPublicLink(item: OrganizationItem) {
  const path = organizationPublicTo(item)
  const origin = typeof window !== 'undefined' ? window.location.origin : ''
  await navigator.clipboard?.writeText(`${origin}${path}`)
  showToast('success', 'Link disalin', 'Link public organisasi siap dibagikan.')
}

function markImageFailed(id: string) {
  failedImages.value = {
    ...failedImages.value,
    [id]: true
  }
}

function markLogoFailed(id: string) {
  failedLogos.value = {
    ...failedLogos.value,
    [id]: true
  }
}

function plainDescription(item: OrganizationItem) {
  return stripHtml(item.description || item.metadata?.descriptionHtml || '')
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

function sanitizeHtml(value: string) {
  return String(value || '')
    .replace(/<script[\s\S]*?>[\s\S]*?<\/script>/gi, '')
    .replace(/<style[\s\S]*?>[\s\S]*?<\/style>/gi, '')
    .replace(/\son\w+="[^"]*"/gi, '')
    .replace(/\son\w+='[^']*'/gi, '')
    .replace(/javascript:/gi, '')
}

function normalizeSocialValue(value: string) {
  return String(value || '').trim() || null
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

function scheduleIconSearch() {
  if (iconSearchTimer) clearTimeout(iconSearchTimer)
  iconSearchTimer = setTimeout(() => {
    searchIcons()
  }, 350)
}

async function searchIcons() {
  iconLoading.value = true
  iconError.value = ''

  try {
    const response = await $fetch<{ icons?: string[] }>('https://api.iconify.design/search', {
      query: {
        query: iconQuery.value || 'building',
        prefix: iconPrefix.value,
        limit: 80
      }
    })

    iconResults.value = (response.icons || []).map((name) => `${iconPrefix.value}:${name}`)
  } catch {
    iconError.value = 'Pencarian ikon online belum tersedia. Pilih ikon bawaan yang tersedia.'
    iconResults.value = fallbackIcons
  } finally {
    iconLoading.value = false
  }
}

function selectIcon(icon: string) {
  form.icon = icon
  showIconPicker.value = false
}

const ReviewRow = defineComponent({
  props: {
    label: {
      type: String,
      required: true
    },
    value: {
      type: String,
      required: true
    }
  },
  setup(props) {
    return () =>
      h(
        'div',
        {
          class:
            'rounded-2xl border border-neutral-200 bg-neutral-50 px-4 py-3'
        },
        [
          h(
            'p',
            {
              class:
                'text-[10px] font-black uppercase tracking-[0.14em] text-neutral-400'
            },
            props.label
          ),
          h(
            'p',
            {
              class:
                'mt-1 break-words text-sm font-black leading-6 text-neutral-800'
            },
            props.value
          )
        ]
      )
  }
})
</script>

<style scoped>
.field {
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

.field:focus {
  border-color: rgb(37 99 235);
  background: white;
  box-shadow: 0 0 0 4px rgb(219 234 254);
}

.textarea-field {
  width: 100%;
  border-radius: 1rem;
  border: 1px solid rgb(229 229 229);
  background: rgb(250 250 250);
  padding: 0.85rem 1rem;
  font-size: 0.875rem;
  font-weight: 700;
  line-height: 1.65;
  color: rgb(38 38 38);
  outline: none;
  transition: 160ms ease;
  resize: vertical;
}

.textarea-field:focus {
  border-color: rgb(37 99 235);
  background: white;
  box-shadow: 0 0 0 4px rgb(219 234 254);
}

.label {
  margin-bottom: 0.5rem;
  display: block;
  font-size: 0.8125rem;
  font-weight: 900;
  color: rgb(64 64 64);
}

.btn-primary {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  border-radius: 1rem;
  background: rgb(37 99 235);
  padding: 0.75rem 1.25rem;
  font-size: 0.875rem;
  font-weight: 900;
  color: white;
  transition: 160ms ease;
  box-shadow: 0 12px 30px rgba(37, 99, 235, 0.18);
}

.btn-primary:hover {
  background: rgb(29 78 216);
}

.btn-primary:disabled {
  cursor: not-allowed;
  opacity: 0.6;
}

.btn-secondary {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  border-radius: 1rem;
  border: 1px solid rgb(229 229 229);
  background: white;
  padding: 0.75rem 1.25rem;
  font-size: 0.875rem;
  font-weight: 900;
  color: rgb(64 64 64);
  transition: 160ms ease;
}

.btn-secondary:hover {
  background: rgb(250 250 250);
  border-color: rgb(212 212 212);
}

.editor-btn,
.toolbar-btn {
  display: inline-flex;
  min-height: 2.25rem;
  align-items: center;
  justify-content: center;
  gap: 0.375rem;
  border-radius: 0.875rem;
  border: 1px solid rgb(229 229 229);
  background: white;
  padding: 0.45rem 0.75rem;
  font-size: 0.75rem;
  font-weight: 900;
  color: rgb(82 82 82);
  transition: 140ms ease;
}

.editor-btn:hover,
.toolbar-btn:hover,
.editor-btn.active,
.toolbar-btn.active {
  border-color: rgb(191 219 254);
  background: rgb(239 246 255);
  color: rgb(37 99 235);
}

.editor-surface :deep(.ProseMirror) {
  min-height: 340px;
}

.editor-surface :deep(.ProseMirror:focus) {
  outline: none;
}

.editor-surface :deep(h1) {
  margin-top: 1.25rem;
  margin-bottom: 0.75rem;
  font-size: 2rem;
  line-height: 1.15;
  font-weight: 950;
  letter-spacing: -0.04em;
  color: #171717;
}

.editor-surface :deep(h2) {
  margin-top: 1.25rem;
  margin-bottom: 0.65rem;
  font-size: 1.55rem;
  line-height: 1.2;
  font-weight: 950;
  letter-spacing: -0.03em;
  color: #171717;
}

.editor-surface :deep(h3) {
  margin-top: 1.1rem;
  margin-bottom: 0.55rem;
  font-size: 1.25rem;
  line-height: 1.3;
  font-weight: 900;
  color: #171717;
}

.editor-surface :deep(p) {
  margin: 0.75rem 0;
  line-height: 1.8;
}

.editor-surface :deep(ul),
.editor-surface :deep(ol) {
  margin: 0.85rem 0;
  padding-left: 1.25rem;
}

.editor-surface :deep(blockquote) {
  margin: 1rem 0;
  border-left: 4px solid #2563eb;
  border-radius: 0.85rem;
  background: #f8fafc;
  padding: 0.85rem 1rem;
  color: #525252;
}

.editor-surface :deep(img) {
  margin: 1rem 0;
  max-width: 100%;
  border-radius: 1rem;
}

.editor-surface :deep(.tiptap-embed) {
  margin: 1rem 0;
  min-height: 360px;
  width: 100%;
  border: 0;
  border-radius: 1rem;
  background: #f5f5f5;
}

.editor-surface :deep(.tiptap-table) {
  margin: 1rem 0;
  width: 100%;
  border-collapse: collapse;
  overflow: hidden;
  border-radius: 1rem;
}

.editor-surface :deep(.tiptap-table td),
.editor-surface :deep(.tiptap-table th) {
  min-width: 90px;
  border: 1px solid #e5e5e5;
  padding: 0.65rem 0.75rem;
  vertical-align: top;
}

.editor-surface :deep(.tiptap-table th) {
  background: #eff6ff;
  color: #1d4ed8;
  font-weight: 900;
}

.line-clamp-1,
.line-clamp-2 {
  display: -webkit-box;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.line-clamp-1 {
  -webkit-line-clamp: 1;
  line-clamp: 1;
}

.line-clamp-2 {
  -webkit-line-clamp: 2;
  line-clamp: 2;
}
</style>
