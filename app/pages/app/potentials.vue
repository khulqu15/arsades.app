<template>
  <section class="min-h-screen bg-neutral-50 text-neutral-950" :style="themeVars">
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
        <div v-if="toast.show" class="fixed right-4 top-4 z-[10050] w-[calc(100%-2rem)] max-w-sm">
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

    <div class="space-y-4 p-4 sm:p-5">
      <!-- Header -->
      <section class="relative overflow-hidden rounded-[2rem] border border-neutral-200 bg-white p-4 shadow-sm sm:p-5">
        <div class="pointer-events-none absolute -right-24 -top-24 h-72 w-72 rounded-full bg-blue-100 blur-3xl"></div>
        <div class="pointer-events-none absolute -left-20 bottom-0 h-56 w-56 rounded-full bg-sky-50 blur-3xl"></div>

        <div class="relative flex flex-col gap-4 lg:flex-row lg:items-center lg:justify-between">
          <div class="flex min-w-0 items-start gap-3">
            <div class="grid h-14 w-14 shrink-0 place-items-center overflow-hidden rounded-3xl border border-blue-100 bg-white p-2 shadow-sm shadow-blue-900/5">
              <img
                v-if="appLogo"
                :src="appLogo"
                :alt="appName"
                class="h-full w-full object-contain"
                @error="appLogoFailed = true"
              >
              <Icon v-else icon="solar:leaf-bold-duotone" class="h-7 w-7 text-blue-600" />
            </div>

            <div class="min-w-0">
              <div class="mb-2 flex flex-wrap items-center gap-2">
                <span class="rounded-full bg-blue-50 px-3 py-1 text-[11px] font-black uppercase tracking-[0.14em] text-blue-700">
                  Potensi
                </span>
                <span class="rounded-full border border-neutral-200 bg-neutral-50 px-3 py-1 text-[11px] font-bold text-neutral-500">
                  {{ tenantSlug }}
                </span>
              </div>

              <h1 class="text-2xl font-black tracking-tight text-neutral-950 sm:text-3xl">
                Kelola Potensi
              </h1>
              <p class="mt-1 max-w-2xl text-sm font-semibold leading-6 text-neutral-500">
                Atur potensi desa, UMKM, wisata, budaya, dan sumber daya lokal dengan tampilan publik yang rapi.
              </p>
            </div>
          </div>

          <div class="flex flex-wrap gap-2">
            <button
              type="button"
              class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-black text-neutral-700 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
              @click="refresh"
            >
              <Icon icon="solar:refresh-bold-duotone" class="h-5 w-5" :class="pending ? 'animate-spin' : ''" />
              Refresh
            </button>

            <button
              type="button"
              class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700"
              @click="openCreate"
            >
              <Icon icon="solar:add-circle-bold-duotone" class="h-5 w-5" />
              Tambah Potensi
            </button>
          </div>
        </div>
      </section>

      <!-- Toolbar -->
      <section class="rounded-[2rem] border border-neutral-200 bg-white p-3 shadow-sm sm:p-4">
        <div class="grid gap-3 lg:grid-cols-[1fr_190px_170px_170px]">
          <div class="relative">
            <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-4 text-neutral-400">
              <Icon icon="solar:magnifer-linear" class="h-5 w-5" />
            </div>

            <input
              v-model.trim="q"
              type="text"
              placeholder="Cari potensi, lokasi, pengelola, pasar, atau kata kunci..."
              class="input-field py-3 pl-12"
            >
          </div>

          <select v-model="selectedType" class="input-field">
            <option value="all">Semua Tipe</option>
            <option v-for="item in potentialTypeOptions" :key="item.value" :value="item.value">
              {{ item.label }}
            </option>
          </select>

          <select v-model="selectedStatus" class="input-field">
            <option value="active">Active</option>
            <option value="all">Semua Status</option>
            <option value="inactive">Inactive</option>
          </select>

          <select v-model="sortBy" class="input-field">
            <option value="sort_order">Urutan</option>
            <option value="name">Nama A-Z</option>
            <option value="newest">Terbaru</option>
            <option value="oldest">Terlama</option>
          </select>
        </div>

        <div class="mt-3 flex flex-wrap items-center justify-between gap-3">
          <p class="text-xs font-bold text-neutral-500">
            {{ filteredPotentials.length }} potensi tampil dari {{ potentials.length }} data.
          </p>

          <button
            type="button"
            class="inline-flex items-center gap-2 rounded-2xl border border-neutral-200 bg-white px-4 py-2 text-xs font-black text-neutral-600 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
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
      <section v-if="pending" class="grid gap-4 sm:grid-cols-2 xl:grid-cols-3">
        <div v-for="item in 6" :key="item" class="h-80 animate-pulse rounded-[2rem] border border-neutral-200 bg-white p-3">
          <div class="h-40 rounded-3xl bg-neutral-100"></div>
          <div class="mt-4 h-4 w-2/3 rounded-full bg-neutral-100"></div>
          <div class="mt-3 h-3 w-full rounded-full bg-neutral-100"></div>
          <div class="mt-2 h-3 w-4/5 rounded-full bg-neutral-100"></div>
        </div>
      </section>

      <!-- Empty -->
      <section
        v-else-if="filteredPotentials.length === 0"
        class="rounded-[2rem] border border-dashed border-neutral-300 bg-white p-10 text-center shadow-sm"
      >
        <div class="mx-auto grid h-16 w-16 place-items-center rounded-3xl bg-blue-50 text-blue-600">
          <Icon icon="solar:leaf-bold-duotone" class="h-8 w-8" />
        </div>

        <h2 class="mt-5 text-xl font-black text-neutral-950">Belum ada potensi</h2>
        <p class="mx-auto mt-2 max-w-md text-sm font-medium leading-6 text-neutral-500">
          Tambahkan potensi desa agar bisa tampil di website publik.
        </p>

        <button
          type="button"
          class="mt-5 inline-flex items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 py-3 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700"
          @click="openCreate"
        >
          <Icon icon="solar:add-circle-bold-duotone" class="h-5 w-5" />
          Tambah Potensi
        </button>
      </section>

      <!-- Grid -->
      <section v-else class="grid gap-4 sm:grid-cols-2 xl:grid-cols-3">
        <article
          v-for="item in pagedPotentials"
          :key="item.id"
          class="group overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-sm transition hover:-translate-y-1 hover:border-blue-200 hover:shadow-xl hover:shadow-blue-900/5"
        >
          <div class="relative h-44 overflow-hidden bg-neutral-100">
            <img
              v-if="getPotentialCover(item) && !failedImages[item.id]"
              :src="getPotentialCover(item)"
              :alt="getPotentialTitle(item)"
              class="h-full w-full object-cover transition duration-500 group-hover:scale-105"
              @error="markImageFailed(item.id)"
            >

            <div
              v-else
              class="flex h-full w-full items-center justify-center bg-gradient-to-br from-blue-50 via-white to-sky-50 text-blue-600"
            >
              <Icon :icon="item.icon || getPotentialTypeIcon(item.potentialType)" class="h-14 w-14" />
            </div>

            <div class="absolute inset-0 bg-gradient-to-t from-neutral-950/65 via-neutral-950/10 to-transparent"></div>

            <div class="absolute left-3 top-3 flex flex-wrap gap-2">
              <span class="inline-flex items-center gap-1.5 rounded-full bg-white/90 px-3 py-1 text-[11px] font-black text-neutral-800 backdrop-blur">
                <Icon :icon="item.icon || getPotentialTypeIcon(item.potentialType)" class="h-3.5 w-3.5 text-blue-600" />
                {{ potentialTypeLabel(item.potentialType) }}
              </span>

              <span v-if="item.isFeatured" class="rounded-full bg-blue-600 px-3 py-1 text-[11px] font-black text-white shadow-lg shadow-blue-900/20">
                Featured
              </span>
            </div>

            <div class="absolute bottom-3 left-3 right-3 flex items-center gap-3">
              <div class="grid h-12 w-12 shrink-0 place-items-center overflow-hidden rounded-2xl border border-white/20 bg-white/90 p-1.5 shadow-sm backdrop-blur">
                <img
                  v-if="item.logoUrl && !failedLogos[item.id]"
                  :src="item.logoUrl"
                  :alt="getPotentialTitle(item)"
                  class="h-full w-full object-contain"
                  @error="failedLogos[item.id] = true"
                >
                <Icon v-else :icon="item.icon || getPotentialTypeIcon(item.potentialType)" class="h-6 w-6 text-blue-600" />
              </div>

              <div class="min-w-0">
                <h2 class="truncate text-base font-black text-white">
                  {{ getPotentialTitle(item) }}
                </h2>
                <p class="truncate text-xs font-semibold text-white/70">
                  {{ item.slug }}
                </p>
              </div>
            </div>
          </div>

          <div class="p-4">
            <p class="line-clamp-2 min-h-11 text-sm font-semibold leading-6 text-neutral-500">
              {{ item.subtitle || item.shortDescription || plainText(item.contentHtml || '').slice(0, 120) || 'Informasi potensi desa.' }}
            </p>

            <div class="mt-4 grid grid-cols-2 gap-2 text-xs">
              <div class="rounded-2xl bg-neutral-50 p-3">
                <p class="font-black uppercase tracking-[0.12em] text-neutral-400">Pasar</p>
                <p class="mt-1 truncate font-black text-neutral-800">{{ item.marketReach || '-' }}</p>
              </div>
              <div class="rounded-2xl bg-neutral-50 p-3">
                <p class="font-black uppercase tracking-[0.12em] text-neutral-400">Status</p>
                <p class="mt-1 truncate font-black text-neutral-800">{{ item.status }}</p>
              </div>
            </div>

            <div class="mt-4 flex flex-wrap items-center gap-2 border-t border-neutral-100 pt-4">
              <button
                type="button"
                class="inline-flex items-center justify-center gap-1.5 rounded-xl bg-blue-600 px-3 py-2 text-xs font-black text-white shadow-sm shadow-blue-600/20 transition hover:bg-blue-700"
                @click="openEdit(item)"
              >
                <Icon icon="solar:pen-new-square-bold-duotone" class="h-4 w-4" />
                Edit
              </button>

              <button
                type="button"
                class="inline-flex items-center justify-center gap-1.5 rounded-xl border border-red-200 bg-red-50 px-3 py-2 text-xs font-black text-red-600 transition hover:bg-red-100"
                @click="openDelete(item)"
              >
                <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-4 w-4" />
                Hapus
              </button>

              <NuxtLink
                :to="potentialPublicUrl(item.slug)"
                target="_blank"
                class="ms-auto inline-flex items-center justify-center gap-1.5 rounded-xl border border-neutral-200 bg-white px-3 py-2 text-xs font-black text-neutral-600 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
              >
                Buka
                <Icon icon="solar:arrow-right-linear" class="h-4 w-4" />
              </NuxtLink>
            </div>
          </div>
        </article>
      </section>

      <div v-if="hasMore && !pending" class="flex justify-center">
        <button
          type="button"
          class="inline-flex items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-5 py-3 text-sm font-black text-neutral-700 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
          @click="page += 1"
        >
          <Icon icon="solar:alt-arrow-down-bold-duotone" class="h-5 w-5" />
          Muat lainnya
        </button>
      </div>
    </div>

    <!-- Editor Modal -->
    <Teleport to="body">
      <Transition enter-active-class="transition duration-200 ease-out" enter-from-class="opacity-0" enter-to-class="opacity-100" leave-active-class="transition duration-150 ease-in" leave-from-class="opacity-100" leave-to-class="opacity-0">
        <div v-if="isEditorOpen" class="fixed inset-0 z-[9990] overflow-y-auto bg-neutral-950/50 p-3 backdrop-blur-sm sm:p-5">
          <div class="mx-auto flex min-h-full max-w-6xl items-center py-4">
            <div class="w-full overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-[0_32px_110px_rgba(15,23,42,0.24)]">
              <header class="border-b border-neutral-200 bg-white/95 p-4 backdrop-blur-xl sm:p-5">
                <div class="flex flex-col gap-4 lg:flex-row lg:items-start lg:justify-between">
                  <div class="min-w-0">
                    <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">
                      {{ form.id ? 'Edit Potensi' : 'Tambah Potensi' }}
                    </p>
                    <h2 class="mt-1 text-2xl font-black tracking-tight text-neutral-950">
                      {{ form.title || 'Data Potensi Baru' }}
                    </h2>
                    <p class="mt-1 text-sm font-semibold leading-6 text-neutral-500">
                      Lengkapi data secara bertahap agar informasi publik lebih rapi dan mudah dipahami.
                    </p>
                  </div>

                  <button
                    type="button"
                    class="grid h-10 w-10 place-items-center rounded-2xl text-neutral-500 transition hover:bg-neutral-100 hover:text-neutral-950"
                    @click="requestCloseEditor"
                  >
                    <Icon icon="solar:close-circle-bold-duotone" class="h-6 w-6" />
                  </button>
                </div>

                <div class="mt-5 grid gap-2 sm:grid-cols-4">
                  <button
                    v-for="(step, index) in steps"
                    :key="step.key"
                    type="button"
                    class="rounded-2xl border p-3 text-left transition"
                    :class="modalStep === index
                      ? 'border-blue-200 bg-blue-50 text-blue-700 ring-4 ring-blue-100'
                      : 'border-neutral-200 bg-white text-neutral-500 hover:border-blue-200 hover:bg-blue-50/50'"
                    @click="modalStep = index"
                  >
                    <div class="flex items-center gap-2">
                      <span class="grid h-8 w-8 place-items-center rounded-xl bg-white text-sm font-black shadow-sm">
                        {{ index + 1 }}
                      </span>
                      <div class="min-w-0">
                        <p class="truncate text-sm font-black">{{ step.title }}</p>
                        <p class="truncate text-[11px] font-bold opacity-70">{{ step.subtitle }}</p>
                      </div>
                    </div>
                  </button>
                </div>
              </header>

              <main class="max-h-[calc(100vh-230px)] overflow-y-auto p-4 sm:p-5">
                <!-- Step 1 -->
                <section v-if="modalStep === 0" class="grid gap-4 lg:grid-cols-2">
                  <div>
                    <label class="mb-2 block text-sm font-black text-neutral-700">Nama Potensi</label>
                    <input v-model.trim="form.title" type="text" placeholder="Contoh: Sentra Padi Organik" class="input-field" @input="handleTitleInput">
                  </div>

                  <div>
                    <label class="mb-2 block text-sm font-black text-neutral-700">Slug</label>
                    <input v-model.trim="form.slug" type="text" placeholder="sentra-padi-organik" class="input-field" @input="manualSlugEdited = true">
                  </div>

                  <div>
                    <label class="mb-2 block text-sm font-black text-neutral-700">Tipe Potensi</label>
                    <select v-model="form.potentialType" class="input-field">
                      <option v-for="item in potentialTypeOptions" :key="item.value" :value="item.value">
                        {{ item.label }}
                      </option>
                    </select>
                  </div>

                  <div>
                    <label class="mb-2 block text-sm font-black text-neutral-700">Ikon</label>
                    <button
                      type="button"
                      class="flex w-full items-center justify-between gap-3 rounded-2xl border border-neutral-200 bg-neutral-50 px-4 py-3 text-left transition hover:border-blue-200 hover:bg-white focus:border-blue-300 focus:bg-white focus:ring-4 focus:ring-blue-100"
                      @click="openIconPicker"
                    >
                      <span class="flex min-w-0 items-center gap-3">
                        <span class="grid h-11 w-11 shrink-0 place-items-center rounded-2xl bg-white text-blue-600 shadow-sm">
                          <Icon :icon="form.icon || getPotentialTypeIcon(form.potentialType)" class="h-6 w-6" />
                        </span>

                        <span class="min-w-0">
                          <span class="block truncate text-sm font-black text-neutral-900">{{ form.icon || 'Pilih ikon' }}</span>
                          <span class="block truncate text-xs font-semibold text-neutral-500">Cari berdasarkan kata kunci</span>
                        </span>
                      </span>

                      <Icon icon="solar:magnifer-linear" class="h-5 w-5 shrink-0 text-neutral-400" />
                    </button>
                  </div>

                  <div class="lg:col-span-2">
                    <label class="mb-2 block text-sm font-black text-neutral-700">Ringkasan Pendek</label>
                    <textarea v-model.trim="form.subtitle" rows="3" placeholder="Ringkasan singkat untuk kartu dan halaman publik." class="textarea-field"></textarea>
                  </div>

                  <div class="grid gap-4 sm:grid-cols-3 lg:col-span-2">
                    <div>
                      <label class="mb-2 block text-sm font-black text-neutral-700">Status</label>
                      <select v-model="form.status" class="input-field">
                        <option value="active">Active</option>
                        <option value="inactive">Inactive</option>
                      </select>
                    </div>

                    <div>
                      <label class="mb-2 block text-sm font-black text-neutral-700">Urutan</label>
                      <input v-model.number="form.sortOrder" type="number" min="0" class="input-field">
                    </div>

                    <label class="flex cursor-pointer items-center gap-3 rounded-2xl border border-neutral-200 bg-neutral-50 px-4 py-3">
                      <input v-model="form.isFeatured" type="checkbox" class="h-4 w-4 rounded border-neutral-300 text-blue-600 focus:ring-blue-600">
                      <span>
                        <span class="block text-sm font-black text-neutral-800">Featured</span>
                        <span class="block text-xs font-semibold text-neutral-500">Tampilkan sebagai prioritas</span>
                      </span>
                    </label>
                  </div>
                </section>

                <!-- Step 2 -->
                <section v-else-if="modalStep === 1" class="grid gap-4 lg:grid-cols-2">
                  <MediaCard
                    title="Gambar Utama"
                    description="Gambar yang tampil di kartu dan halaman detail."
                    :image="form.imageUrl"
                    icon="solar:gallery-wide-bold-duotone"
                    @open="openMediaModal('cover')"
                    @clear="form.imageUrl = ''"
                  />

                  <MediaCard
                    title="Logo / Ikon Brand"
                    description="Logo kecil agar identitas lebih jelas."
                    :image="form.logoUrl"
                    icon="solar:sticker-smile-circle-2-bold-duotone"
                    object-fit="contain"
                    @open="openMediaModal('logo')"
                    @clear="form.logoUrl = ''"
                  />

                  <div class="lg:col-span-2 rounded-[1.75rem] border border-neutral-200 bg-white p-4">
                    <div class="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
                      <div>
                        <h3 class="text-sm font-black text-neutral-950">Galeri</h3>
                        <p class="mt-1 text-sm font-semibold leading-6 text-neutral-500">Tambahkan beberapa gambar pendukung.</p>
                      </div>

                      <button type="button" class="inline-flex h-10 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 text-sm font-black text-white shadow-sm shadow-blue-600/20 transition hover:bg-blue-700" @click="openMediaModal('gallery')">
                        <Icon icon="solar:add-circle-bold-duotone" class="h-5 w-5" />
                        Tambah Gambar
                      </button>
                    </div>

                    <div v-if="form.images.length" class="mt-4 grid gap-3 sm:grid-cols-3 lg:grid-cols-5">
                      <div v-for="(image, index) in form.images" :key="`${image}-${index}`" class="group relative overflow-hidden rounded-2xl border border-neutral-200 bg-neutral-100">
                        <img :src="image" alt="Galeri" class="h-32 w-full object-cover">
                        <button
                          type="button"
                          class="absolute right-2 top-2 grid h-8 w-8 place-items-center rounded-xl bg-white/90 text-red-600 opacity-0 shadow-sm backdrop-blur transition group-hover:opacity-100"
                          @click="removeGalleryImage(index)"
                        >
                          <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-4 w-4" />
                        </button>
                      </div>
                    </div>

                    <div v-else class="mt-4 rounded-2xl border border-dashed border-neutral-300 bg-neutral-50 p-6 text-center text-sm font-semibold text-neutral-500">
                      Belum ada gambar galeri.
                    </div>
                  </div>
                </section>

                <!-- Step 3 -->
                <section v-else-if="modalStep === 2" class="space-y-4">
                  <div>
                    <div class="mb-2 flex flex-wrap items-center justify-between gap-2">
                      <label class="block text-sm font-black text-neutral-700">Deskripsi Lengkap</label>
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
                            :class="button.active() ? 'bg-blue-600 text-white shadow-sm shadow-blue-600/20' : 'text-neutral-600 hover:bg-white hover:text-blue-700'"
                            @click="button.action"
                          >
                            <Icon :icon="button.icon" class="h-4 w-4" />
                            <span class="editor-tooltip">{{ button.label }}</span>
                          </button>

                          <div class="ms-auto flex flex-wrap items-center gap-1">
                            <button type="button" class="editor-btn group relative text-neutral-600 hover:bg-white hover:text-blue-700" @click="triggerEditorImageUpload">
                              <Icon icon="solar:cloud-upload-bold-duotone" class="h-4 w-4" />
                              <span class="editor-tooltip">Unggah Gambar</span>
                            </button>

                            <button type="button" class="editor-btn group relative text-neutral-600 hover:bg-white hover:text-blue-700" @click="openLinkModal">
                              <Icon icon="solar:link-circle-bold-duotone" class="h-4 w-4" />
                              <span class="editor-tooltip">Link</span>
                            </button>

                            <button type="button" class="editor-btn group relative text-neutral-600 hover:bg-white hover:text-blue-700" @click="openEmbedModal('youtube')">
                              <Icon icon="solar:video-frame-play-horizontal-bold-duotone" class="h-4 w-4" />
                              <span class="editor-tooltip">YouTube</span>
                            </button>

                            <button type="button" class="editor-btn group relative text-neutral-600 hover:bg-white hover:text-blue-700" @click="openEmbedModal('pdf')">
                              <Icon icon="solar:file-text-bold-duotone" class="h-4 w-4" />
                              <span class="editor-tooltip">PDF</span>
                            </button>

                            <button type="button" class="editor-btn group relative text-neutral-600 hover:bg-white hover:text-blue-700" @click="openEmbedModal('maps')">
                              <Icon icon="solar:map-point-bold-duotone" class="h-4 w-4" />
                              <span class="editor-tooltip">Maps</span>
                            </button>

                            <button
                              v-for="button in secondaryEditorButtons"
                              :key="button.label"
                              type="button"
                              class="editor-btn group relative text-neutral-600 hover:bg-white hover:text-blue-700"
                              @click="button.action"
                            >
                              <Icon :icon="button.icon" class="h-4 w-4" />
                              <span class="editor-tooltip">{{ button.label }}</span>
                            </button>
                          </div>
                        </div>

                        <EditorContent
                          v-if="editor"
                          :editor="editor"
                          class="editor-content min-h-[420px] bg-white px-5 py-4 text-neutral-800"
                          @contextmenu.prevent="openContextMenu"
                        />

                        <div class="flex flex-col gap-2 border-t border-neutral-200 bg-neutral-50 px-4 py-3 text-xs font-semibold text-neutral-500 sm:flex-row sm:items-center sm:justify-between">
                          <span>Gunakan toolbar untuk heading, list, tabel, tautan, gambar, dokumen, video, dan peta.</span>
                          <span>Klik kanan di area tulisan untuk menu cepat.</span>
                        </div>
                      </div>
                    </ClientOnly>
                  </div>
                </section>

                <!-- Step 4 -->
                <section v-else class="grid gap-4 lg:grid-cols-[1fr_360px]">
                  <div class="grid gap-4 lg:grid-cols-2">
                    <div>
                      <label class="mb-2 block text-sm font-black text-neutral-700">Pengelola / Pemilik</label>
                      <input v-model.trim="form.ownerName" type="text" placeholder="Nama pemilik atau kelompok" class="input-field">
                    </div>

                    <div>
                      <label class="mb-2 block text-sm font-black text-neutral-700">Penanggung Jawab</label>
                      <input v-model.trim="form.managerName" type="text" placeholder="Nama pengelola" class="input-field">
                    </div>

                    <div>
                      <label class="mb-2 block text-sm font-black text-neutral-700">Kapasitas Produksi</label>
                      <input v-model.trim="form.productionCapacity" type="text" placeholder="Contoh: 2 ton / bulan" class="input-field">
                    </div>

                    <div>
                      <label class="mb-2 block text-sm font-black text-neutral-700">Jangkauan Pasar</label>
                      <input v-model.trim="form.marketReach" type="text" placeholder="Lokal, kabupaten, nasional..." class="input-field">
                    </div>

                    <div>
                      <label class="mb-2 block text-sm font-black text-neutral-700">Nilai Estimasi</label>
                      <input v-model.trim="form.estimatedValue" type="text" placeholder="Contoh: 50000000" class="input-field">
                    </div>

                    <div>
                      <label class="mb-2 block text-sm font-black text-neutral-700">Website / Sosial Media</label>
                      <input v-model.trim="form.websiteUrl" type="url" placeholder="https://..." class="input-field">
                    </div>

                    <div>
                      <label class="mb-2 block text-sm font-black text-neutral-700">WhatsApp</label>
                      <input v-model.trim="form.whatsapp" type="text" placeholder="08..." class="input-field">
                    </div>

                    <div>
                      <label class="mb-2 block text-sm font-black text-neutral-700">Email</label>
                      <input v-model.trim="form.email" type="email" placeholder="nama@email.com" class="input-field">
                    </div>

                    <div class="lg:col-span-2">
                      <label class="mb-2 block text-sm font-black text-neutral-700">Alamat</label>
                      <textarea v-model.trim="form.address" rows="3" placeholder="Alamat atau lokasi potensi" class="textarea-field"></textarea>
                    </div>

                    <div>
                      <label class="mb-2 block text-sm font-black text-neutral-700">Latitude</label>
                      <input v-model.trim="form.latitude" type="text" placeholder="-7.655..." class="input-field">
                    </div>

                    <div>
                      <label class="mb-2 block text-sm font-black text-neutral-700">Longitude</label>
                      <input v-model.trim="form.longitude" type="text" placeholder="112.789..." class="input-field">
                    </div>
                  </div>

                  <aside class="rounded-[2rem] border border-neutral-200 bg-white p-4 shadow-sm">
                    <div class="overflow-hidden rounded-[1.5rem] border border-neutral-200 bg-neutral-50">
                      <div class="h-44 bg-neutral-100">
                        <img v-if="form.imageUrl" :src="form.imageUrl" alt="Preview" class="h-full w-full object-cover">
                        <div v-else class="flex h-full w-full items-center justify-center text-blue-600">
                          <Icon :icon="form.icon || getPotentialTypeIcon(form.potentialType)" class="h-12 w-12" />
                        </div>
                      </div>

                      <div class="p-4">
                        <div class="mb-3 flex items-center gap-3">
                          <div class="grid h-12 w-12 place-items-center overflow-hidden rounded-2xl border border-blue-100 bg-white p-1.5 text-blue-600">
                            <img v-if="form.logoUrl" :src="form.logoUrl" alt="Logo" class="h-full w-full object-contain">
                            <Icon v-else :icon="form.icon || getPotentialTypeIcon(form.potentialType)" class="h-6 w-6" />
                          </div>
                          <div class="min-w-0">
                            <p class="truncate text-sm font-black text-neutral-950">{{ form.title || 'Nama potensi' }}</p>
                            <p class="truncate text-xs font-semibold text-neutral-500">{{ potentialTypeLabel(form.potentialType) }}</p>
                          </div>
                        </div>

                        <p class="line-clamp-3 text-sm font-semibold leading-6 text-neutral-500">
                          {{ form.subtitle || 'Ringkasan singkat akan tampil di sini.' }}
                        </p>

                        <NuxtLink
                          v-if="form.slug"
                          :to="potentialPublicUrl(form.slug)"
                          target="_blank"
                          class="mt-4 inline-flex w-full items-center justify-center gap-2 rounded-2xl border border-blue-200 bg-blue-50 px-4 py-3 text-sm font-black text-blue-700 transition hover:bg-blue-100"
                        >
                          Lihat halaman publik
                          <Icon icon="solar:arrow-right-up-linear" class="h-5 w-5" />
                        </NuxtLink>
                      </div>
                    </div>
                  </aside>
                </section>
              </main>

              <footer class="border-t border-neutral-200 bg-white p-4 sm:p-5">
                <div class="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
                  <button type="button" class="inline-flex h-11 items-center justify-center rounded-2xl border border-neutral-200 bg-white px-5 text-sm font-black text-neutral-700 transition hover:bg-neutral-50" @click="requestCloseEditor">
                    Tutup
                  </button>

                  <div class="flex flex-col-reverse gap-2 sm:flex-row">
                    <button
                      v-if="modalStep > 0"
                      type="button"
                      class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-5 text-sm font-black text-neutral-700 transition hover:bg-neutral-50"
                      @click="modalStep -= 1"
                    >
                      <Icon icon="solar:arrow-left-linear" class="h-5 w-5" />
                      Kembali
                    </button>

                    <button
                      v-if="modalStep < steps.length - 1"
                      type="button"
                      class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-5 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700"
                      @click="goNextStep"
                    >
                      Lanjut
                      <Icon icon="solar:arrow-right-linear" class="h-5 w-5" />
                    </button>

                    <button
                      v-else
                      type="button"
                      class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-5 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700 disabled:cursor-not-allowed disabled:opacity-60"
                      :disabled="isSaving"
                      @click="savePotential"
                    >
                      <Icon :icon="isSaving ? 'solar:refresh-bold-duotone' : 'solar:diskette-bold-duotone'" class="h-5 w-5" :class="isSaving ? 'animate-spin' : ''" />
                      {{ isSaving ? 'Menyimpan...' : 'Simpan Potensi' }}
                    </button>
                  </div>
                </div>
              </footer>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>

    <!-- Media Picker Modal -->
    <Teleport to="body">
      <Transition enter-active-class="transition duration-200 ease-out" enter-from-class="opacity-0" enter-to-class="opacity-100" leave-active-class="transition duration-150 ease-in" leave-from-class="opacity-100" leave-to-class="opacity-0">
        <div v-if="mediaModal.open" class="fixed inset-0 z-[10000] grid place-items-center bg-neutral-950/45 p-4 backdrop-blur-sm">
          <div class="w-full max-w-lg rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-[0_32px_110px_rgba(15,23,42,0.24)]">
            <div class="flex items-start justify-between gap-4">
              <div>
                <p class="text-xs font-black uppercase tracking-[0.14em] text-blue-600">Media</p>
                <h3 class="mt-1 text-xl font-black text-neutral-950">{{ mediaModal.title }}</h3>
                <p class="mt-1 text-sm font-semibold leading-6 text-neutral-500">Pilih file dari perangkat atau tempel tautan yang sudah tersedia.</p>
              </div>

              <button type="button" class="grid h-10 w-10 place-items-center rounded-2xl text-neutral-500 transition hover:bg-neutral-100 hover:text-neutral-950" @click="closeMediaModal">
                <Icon icon="solar:close-circle-bold-duotone" class="h-6 w-6" />
              </button>
            </div>

            <div class="mt-5 space-y-4">
              <div class="grid gap-3 sm:grid-cols-2">
                <button
                  type="button"
                  class="flex min-h-32 flex-col items-center justify-center gap-3 rounded-3xl border border-dashed border-blue-200 bg-blue-50 p-5 text-center transition hover:bg-blue-100"
                  @click="triggerMediaFile"
                >
                  <Icon icon="solar:cloud-upload-bold-duotone" class="h-9 w-9 text-blue-600" />
                  <span>
                    <span class="block text-sm font-black text-blue-700">Unggah dari perangkat</span>
                    <span class="mt-1 block text-xs font-semibold text-blue-600/80">JPG, PNG, atau WebP</span>
                  </span>
                </button>

                <div class="rounded-3xl border border-neutral-200 bg-neutral-50 p-4">
                  <label class="mb-2 block text-sm font-black text-neutral-700">Atau tempel tautan gambar</label>
                  <input v-model.trim="mediaModal.url" type="url" placeholder="https://..." class="input-field bg-white">
                  <button
                    type="button"
                    class="mt-3 inline-flex w-full items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 py-3 text-sm font-black text-white shadow-sm shadow-blue-600/20 transition hover:bg-blue-700"
                    @click="applyMediaUrl"
                  >
                    Gunakan Tautan
                    <Icon icon="solar:arrow-right-linear" class="h-5 w-5" />
                  </button>
                </div>
              </div>

              <div v-if="mediaModal.preview" class="overflow-hidden rounded-3xl border border-neutral-200 bg-neutral-50">
                <img :src="mediaModal.preview" alt="Preview" class="h-56 w-full object-cover">
              </div>

              <div v-if="mediaModal.error" class="rounded-2xl border border-red-200 bg-red-50 px-4 py-3 text-sm font-bold text-red-700">
                {{ mediaModal.error }}
              </div>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>

    <!-- Embed Modal -->
    <Teleport to="body">
      <Transition enter-active-class="transition duration-200 ease-out" enter-from-class="opacity-0" enter-to-class="opacity-100" leave-active-class="transition duration-150 ease-in" leave-from-class="opacity-100" leave-to-class="opacity-0">
        <div v-if="embedModal.open" class="fixed inset-0 z-[10001] grid place-items-center bg-neutral-950/45 p-4 backdrop-blur-sm">
          <div class="w-full max-w-xl rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-[0_32px_110px_rgba(15,23,42,0.24)]">
            <div class="flex items-start justify-between gap-4">
              <div>
                <p class="text-xs font-black uppercase tracking-[0.14em] text-blue-600">Sisipkan</p>
                <h3 class="mt-1 text-xl font-black text-neutral-950">{{ embedTitle }}</h3>
                <p class="mt-1 text-sm font-semibold leading-6 text-neutral-500">Tempel alamat atau kode semat yang ingin ditampilkan di konten.</p>
              </div>

              <button type="button" class="grid h-10 w-10 place-items-center rounded-2xl text-neutral-500 transition hover:bg-neutral-100 hover:text-neutral-950" @click="closeEmbedModal">
                <Icon icon="solar:close-circle-bold-duotone" class="h-6 w-6" />
              </button>
            </div>

            <div class="mt-5 space-y-4">
              <textarea v-model.trim="embedModal.url" rows="4" :placeholder="embedPlaceholder" class="textarea-field"></textarea>

              <div v-if="embedModal.error" class="rounded-2xl border border-red-200 bg-red-50 px-4 py-3 text-sm font-bold text-red-700">
                {{ embedModal.error }}
              </div>
            </div>

            <div class="mt-6 flex flex-col-reverse gap-3 sm:flex-row sm:justify-end">
              <button type="button" class="inline-flex items-center justify-center rounded-2xl border border-neutral-200 bg-white px-5 py-3 text-sm font-black text-neutral-700 transition hover:bg-neutral-50" @click="closeEmbedModal">
                Batal
              </button>
              <button type="button" class="inline-flex items-center justify-center gap-2 rounded-2xl bg-blue-600 px-5 py-3 text-sm font-black text-white shadow-sm shadow-blue-600/20 transition hover:bg-blue-700" @click="insertEmbed">
                <Icon icon="solar:add-circle-bold-duotone" class="h-5 w-5" />
                Sisipkan
              </button>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>

    <!-- Link Modal -->
    <Teleport to="body">
      <Transition enter-active-class="transition duration-200 ease-out" enter-from-class="opacity-0" enter-to-class="opacity-100" leave-active-class="transition duration-150 ease-in" leave-from-class="opacity-100" leave-to-class="opacity-0">
        <div v-if="linkModal.open" class="fixed inset-0 z-[10002] grid place-items-center bg-neutral-950/45 p-4 backdrop-blur-sm">
          <div class="w-full max-w-xl rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-[0_32px_110px_rgba(15,23,42,0.24)]">
            <div class="flex items-start justify-between gap-4">
              <div>
                <p class="text-xs font-black uppercase tracking-[0.14em] text-blue-600">Tautan</p>
                <h3 class="mt-1 text-xl font-black text-neutral-950">Tambahkan Tautan</h3>
                <p class="mt-1 text-sm font-semibold leading-6 text-neutral-500">Masukkan alamat halaman dan teks yang ingin ditampilkan.</p>
              </div>

              <button type="button" class="grid h-10 w-10 place-items-center rounded-2xl text-neutral-500 transition hover:bg-neutral-100 hover:text-neutral-950" @click="closeLinkModal">
                <Icon icon="solar:close-circle-bold-duotone" class="h-6 w-6" />
              </button>
            </div>

            <div class="mt-5 space-y-4">
              <div>
                <label class="mb-2 block text-sm font-black text-neutral-700">Alamat tautan</label>
                <input v-model.trim="linkModal.url" type="url" placeholder="https://contoh.com/halaman" class="input-field">
              </div>

              <div>
                <label class="mb-2 block text-sm font-black text-neutral-700">Teks tautan</label>
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
                Tambahkan
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
                    <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">Ikon</p>
                    <h2 class="mt-1 text-xl font-black text-neutral-950">Pilih Ikon Potensi</h2>
                    <p class="mt-1 text-sm font-medium leading-6 text-neutral-500">Cari ikon berdasarkan kata kunci, lalu pilih yang paling sesuai.</p>
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

                    <input
                      v-model.trim="iconQuery"
                      type="text"
                      placeholder="Cari: padi, toko, ikan, wisata, industri..."
                      class="input-field py-3 pl-12"
                      @keydown.enter.prevent="searchIconifyIcons"
                    >
                  </div>

                  <button
                    type="button"
                    :disabled="iconLoading"
                    class="inline-flex items-center justify-center gap-2 rounded-2xl bg-blue-600 px-5 py-3 text-sm font-black text-white shadow-sm shadow-blue-600/20 transition hover:bg-blue-700 disabled:cursor-not-allowed disabled:opacity-60"
                    @click="searchIconifyIcons"
                  >
                    <Icon :icon="iconLoading ? 'solar:refresh-bold-duotone' : 'solar:magnifer-bold-duotone'" class="h-5 w-5" :class="iconLoading ? 'animate-spin' : ''" />
                    Cari
                  </button>
                </div>

                <div class="mt-3 flex flex-wrap gap-2">
                  <button
                    v-for="keyword in iconKeywordSuggestions"
                    :key="keyword"
                    type="button"
                    class="rounded-full border border-neutral-200 bg-white px-3 py-1.5 text-xs font-black text-neutral-600 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
                    :class="iconQuery === keyword ? 'border-blue-200 bg-blue-50 text-blue-700' : ''"
                    @click="setIconKeyword(keyword)"
                  >
                    {{ keyword }}
                  </button>
                </div>

                <div class="mt-4 flex flex-wrap items-center gap-2">
                  <span class="rounded-full border border-neutral-200 bg-neutral-50 px-3 py-1 text-xs font-black text-neutral-500">Terpilih:</span>
                  <span class="inline-flex items-center gap-2 rounded-full bg-blue-50 px-3 py-1 text-xs font-black text-blue-700">
                    <Icon :icon="form.icon || getPotentialTypeIcon(form.potentialType)" class="h-4 w-4" />
                    {{ form.icon || '-' }}
                  </span>
                  <span v-if="iconTotal" class="rounded-full border border-neutral-200 bg-neutral-50 px-3 py-1 text-xs font-black text-neutral-500">
                    {{ iconTotal }} hasil
                  </span>
                </div>
              </div>

              <div class="max-h-[62vh] overflow-y-auto p-5">
                <div v-if="iconError" class="mb-4 rounded-2xl border border-red-200 bg-red-50 px-4 py-3 text-sm font-bold text-red-700">
                  {{ iconError }}
                </div>

                <div v-if="iconLoading" class="grid grid-cols-3 gap-3 sm:grid-cols-5 md:grid-cols-7 lg:grid-cols-9">
                  <div v-for="item in 45" :key="item" class="h-24 animate-pulse rounded-3xl border border-neutral-200 bg-neutral-100"></div>
                </div>

                <div v-else-if="iconResults.length === 0" class="rounded-[2rem] border border-dashed border-neutral-300 bg-neutral-50 p-10 text-center">
                  <div class="mx-auto grid h-16 w-16 place-items-center rounded-3xl bg-white text-neutral-400">
                    <Icon icon="solar:gallery-minimalistic-bold-duotone" class="h-8 w-8" />
                  </div>

                  <h3 class="mt-4 text-lg font-black text-neutral-950">Belum ada ikon</h3>
                  <p class="mx-auto mt-2 max-w-md text-sm font-medium leading-6 text-neutral-500">
                    Coba kata kunci lain seperti <b>padi</b>, <b>toko</b>, <b>ikan</b>, <b>wisata</b>, atau <b>industri</b>.
                  </p>
                </div>

                <div v-else class="grid grid-cols-3 gap-3 sm:grid-cols-5 md:grid-cols-7 lg:grid-cols-9">
                  <button
                    v-for="iconName in iconResults"
                    :key="iconName"
                    type="button"
                    class="group relative flex h-24 flex-col items-center justify-center gap-2 rounded-3xl border p-2 text-center transition hover:-translate-y-0.5 hover:shadow-md"
                    :class="form.icon === normalizeIconName(iconName)
                      ? 'border-blue-300 bg-blue-50 ring-4 ring-blue-100'
                      : 'border-neutral-200 bg-white hover:border-blue-200 hover:bg-blue-50'"
                    @click="selectIcon(iconName)"
                  >
                    <Icon :icon="normalizeIconName(iconName)" class="h-7 w-7" :class="form.icon === normalizeIconName(iconName) ? 'text-blue-600' : 'text-neutral-700'" />
                    <span class="max-w-full truncate text-[10px] font-black text-neutral-500">{{ normalizeIconName(iconName) }}</span>

                    <span v-if="form.icon === normalizeIconName(iconName)" class="absolute right-2 top-2 grid h-5 w-5 place-items-center rounded-full bg-blue-600 text-white">
                      <Icon icon="solar:check-circle-bold" class="h-4 w-4" />
                    </span>
                  </button>
                </div>
              </div>

              <div class="flex flex-col-reverse gap-3 border-t border-neutral-200 bg-neutral-50 p-5 sm:flex-row sm:items-center sm:justify-between">
                <p class="text-xs font-semibold leading-5 text-neutral-500">
                  Tips: pakai kata kunci sederhana seperti <b>padi</b>, <b>toko</b>, <b>ikan</b>, <b>wisata</b>, atau <b>industri</b>.
                </p>

                <div class="flex gap-2">
                  <button type="button" class="inline-flex items-center justify-center rounded-2xl border border-neutral-200 bg-white px-5 py-3 text-sm font-black text-neutral-700 transition hover:bg-neutral-50" @click="closeIconPicker">
                    Batal
                  </button>

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

    <!-- Context Toolbar -->
    <Teleport to="body">
      <Transition enter-active-class="transition duration-150 ease-out" enter-from-class="scale-95 opacity-0" enter-to-class="scale-100 opacity-100" leave-active-class="transition duration-100 ease-in" leave-from-class="scale-100 opacity-100" leave-to-class="scale-95 opacity-0">
        <div
          v-if="contextToolbar.open"
          class="fixed z-[10004] w-60 rounded-3xl border border-neutral-200 bg-white p-2 shadow-[0_24px_80px_rgba(15,23,42,0.18)]"
          :style="{ left: `${contextToolbar.x}px`, top: `${contextToolbar.y}px` }"
        >
          <button
            v-for="button in contextEditorButtons"
            :key="button.label"
            type="button"
            class="flex w-full items-center gap-3 rounded-2xl px-3 py-2.5 text-sm font-bold text-neutral-600 transition hover:bg-blue-50 hover:text-blue-700"
            @click="runContextAction(button.action)"
          >
            <Icon :icon="button.icon" class="h-5 w-5 text-blue-500" />
            {{ button.label }}
          </button>
        </div>
      </Transition>
    </Teleport>

    <!-- Delete Modal -->
    <Teleport to="body">
      <Transition enter-active-class="transition duration-200 ease-out" enter-from-class="opacity-0" enter-to-class="opacity-100" leave-active-class="transition duration-150 ease-in" leave-from-class="opacity-100" leave-to-class="opacity-0">
        <div v-if="deleteModal.open" class="fixed inset-0 z-[10005] grid place-items-center bg-neutral-950/45 p-4 backdrop-blur-sm">
          <div class="w-full max-w-md rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-[0_32px_110px_rgba(15,23,42,0.24)]">
            <div class="grid h-14 w-14 place-items-center rounded-3xl bg-red-50 text-red-600">
              <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-8 w-8" />
            </div>

            <h3 class="mt-4 text-xl font-black text-neutral-950">Hapus Potensi?</h3>
            <p class="mt-2 text-sm font-semibold leading-6 text-neutral-500">
              Data <b>{{ deleteModal.item ? getPotentialTitle(deleteModal.item) : '' }}</b> akan dipindahkan dari daftar.
            </p>

            <div class="mt-6 flex flex-col-reverse gap-2 sm:flex-row sm:justify-end">
              <button type="button" class="inline-flex justify-center rounded-2xl border border-neutral-200 bg-white px-5 py-3 text-sm font-black text-neutral-700 transition hover:bg-neutral-50" @click="closeDelete">
                Batal
              </button>
              <button
                type="button"
                class="inline-flex items-center justify-center gap-2 rounded-2xl bg-red-600 px-5 py-3 text-sm font-black text-white transition hover:bg-red-700 disabled:opacity-60"
                :disabled="isDeleting"
                @click="deletePotentialNow"
              >
                <Icon :icon="isDeleting ? 'solar:refresh-bold-duotone' : 'solar:trash-bin-trash-bold-duotone'" class="h-5 w-5" :class="isDeleting ? 'animate-spin' : ''" />
                {{ isDeleting ? 'Menghapus...' : 'Hapus' }}
              </button>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>

    <!-- Close Modal -->
    <Teleport to="body">
      <Transition enter-active-class="transition duration-200 ease-out" enter-from-class="opacity-0" enter-to-class="opacity-100" leave-active-class="transition duration-150 ease-in" leave-from-class="opacity-100" leave-to-class="opacity-0">
        <div v-if="closeModalOpen" class="fixed inset-0 z-[10006] grid place-items-center bg-neutral-950/45 p-4 backdrop-blur-sm">
          <div class="w-full max-w-md rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-[0_32px_110px_rgba(15,23,42,0.24)]">
            <div class="grid h-14 w-14 place-items-center rounded-3xl bg-blue-50 text-blue-600">
              <Icon icon="solar:question-circle-bold-duotone" class="h-8 w-8" />
            </div>

            <h3 class="mt-4 text-xl font-black text-neutral-950">Tutup Form?</h3>
            <p class="mt-2 text-sm font-semibold leading-6 text-neutral-500">
              Perubahan yang belum disimpan akan hilang.
            </p>

            <div class="mt-6 flex flex-col-reverse gap-2 sm:flex-row sm:justify-end">
              <button type="button" class="inline-flex justify-center rounded-2xl border border-neutral-200 bg-white px-5 py-3 text-sm font-black text-neutral-700 transition hover:bg-neutral-50" @click="closeModalOpen = false">
                Lanjut Edit
              </button>
              <button type="button" class="inline-flex justify-center rounded-2xl bg-blue-600 px-5 py-3 text-sm font-black text-white shadow-sm shadow-blue-600/20 transition hover:bg-blue-700" @click="forceCloseEditor">
                Tutup Form
              </button>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>

    <input ref="mediaFileInput" type="file" accept="image/*" class="hidden" @change="onPickMediaFile">
    <input ref="editorImageInput" type="file" accept="image/*" class="hidden" @change="onPickEditorImage">
  </section>
</template>

<script setup lang="ts">
import { Node, mergeAttributes } from '@tiptap/core'
import { Editor, EditorContent } from '@tiptap/vue-3'
import StarterKit from '@tiptap/starter-kit'
import Image from '@tiptap/extension-image'
import Link from '@tiptap/extension-link'
import Placeholder from '@tiptap/extension-placeholder'
import Underline from '@tiptap/extension-underline'
import Youtube from '@tiptap/extension-youtube'
import { Table } from '@tiptap/extension-table'
import { TableRow } from '@tiptap/extension-table-row'
import { TableCell } from '@tiptap/extension-table-cell'
import { TableHeader } from '@tiptap/extension-table-header'
import { Icon } from '@iconify/vue'
import { computed, defineComponent, h, nextTick, onBeforeUnmount, onMounted, reactive, ref, shallowRef, watch } from 'vue'
import { useRequestURL, useRuntimeConfig } from 'nuxt/app'
import { useAppApi } from '../../composables/useAppApi'
import { useCloudinaryUpload as useMediaUpload } from '~/composables/useCloudinaryUpload'

definePageMeta({
  layout: 'app',
  layoutProps: {
    title: 'Potensi'
  }
})

type PotentialStatus = 'active' | 'inactive'
type SortOption = 'newest' | 'oldest' | 'name' | 'sort_order'
type ToastType = 'success' | 'error'
type MediaTarget = 'cover' | 'logo' | 'gallery' | 'editorImage'
type EmbedKind = 'youtube' | 'pdf' | 'maps'

type PotentialType =
  | 'agriculture'
  | 'livestock'
  | 'fishery'
  | 'umkm'
  | 'tourism'
  | 'culture'
  | 'natural_resource'
  | 'human_resource'
  | 'industry'
  | 'creative_economy'
  | 'food'
  | 'craft'
  | 'custom'

type PotentialItem = {
  id: string
  tenantId?: string
  title?: string | null
  name?: string | null
  subtitle?: string | null
  shortDescription?: string | null
  slug: string
  potentialType?: PotentialType | null
  icon?: string | null
  logoUrl?: string | null
  imageUrl?: string | null
  coverUrl?: string | null
  contentHtml?: string | null
  phone?: string | null
  whatsapp?: string | null
  email?: string | null
  websiteUrl?: string | null
  address?: string | null
  latitude?: string | number | null
  longitude?: string | number | null
  ownerName?: string | null
  managerName?: string | null
  productionCapacity?: string | null
  productionUnit?: string | null
  marketReach?: string | null
  estimatedValue?: string | number | null
  status: PotentialStatus
  isFeatured?: boolean
  sortOrder?: number
  metadata?: Record<string, any>
  createdAt?: number
  updatedAt?: number
}

type PotentialListResponse = {
  data: PotentialItem[]
  meta?: {
    page: number
    limit: number
    total: number
    totalPages: number
  }
}

type PotentialForm = {
  id: string
  title: string
  slug: string
  subtitle: string
  shortDescription: string
  contentHtml: string
  potentialType: PotentialType
  icon: string
  logoUrl: string
  imageUrl: string
  phone: string
  whatsapp: string
  email: string
  websiteUrl: string
  address: string
  latitude: string
  longitude: string
  ownerName: string
  managerName: string
  productionCapacity: string
  productionUnit: string
  marketReach: string
  estimatedValue: string
  status: PotentialStatus
  isFeatured: boolean
  sortOrder: number
  images: string[]
}

const EmbedFrame = Node.create({
  name: 'embedFrame',
  group: 'block',
  atom: true,
  draggable: true,
  addAttributes() {
    return {
      src: { default: null },
      title: { default: 'Konten' },
      embedType: { default: 'custom' }
    }
  },
  parseHTML() {
    return [{ tag: 'iframe[data-embed-frame]' }]
  },
  renderHTML({ HTMLAttributes }) {
    return [
      'iframe',
      mergeAttributes(HTMLAttributes, {
        'data-embed-frame': 'true',
        class: `potential-embed potential-embed-${HTMLAttributes.embedType || 'custom'}`,
        loading: 'lazy',
        allowfullscreen: 'true',
        referrerpolicy: 'no-referrer-when-downgrade'
      })
    ]
  }
})

const runtime = useRuntimeConfig()
const requestUrl = useRequestURL()
const { tenantApiUrl } = useAppApi()

const {
  uploading: imageUploading,
  uploadImage
} = useMediaUpload()

const q = ref('')
const selectedType = ref<PotentialType | 'all'>('all')
const selectedStatus = ref<PotentialStatus | 'all'>('active')
const sortBy = ref<SortOption>('sort_order')
const page = ref(1)
const pageSize = 12

const editor = shallowRef<Editor | null>(null)
const appLogoFailed = ref(false)
const failedImages = ref<Record<string, boolean>>({})
const failedLogos = ref<Record<string, boolean>>({})

const isEditorOpen = ref(false)
const closeModalOpen = ref(false)
const modalStep = ref(0)
const editingPotential = ref<PotentialItem | null>(null)
const isSaving = ref(false)
const isDeleting = ref(false)
const manualSlugEdited = ref(false)

const mediaFileInput = ref<HTMLInputElement | null>(null)
const editorImageInput = ref<HTMLInputElement | null>(null)

const toast = reactive({
  show: false,
  title: '',
  message: '',
  type: 'success' as ToastType
})

let toastTimer: ReturnType<typeof setTimeout> | null = null
let iconSearchTimer: ReturnType<typeof setTimeout> | null = null

const deleteModal = reactive<{ open: boolean; item: PotentialItem | null }>({
  open: false,
  item: null
})

const mediaModal = reactive({
  open: false,
  title: '',
  target: 'cover' as MediaTarget,
  url: '',
  preview: '',
  error: '',
  uploading: false
})

const embedModal = reactive({
  open: false,
  kind: 'youtube' as EmbedKind,
  url: '',
  error: ''
})

const linkModal = reactive({
  open: false,
  text: '',
  url: '',
  error: ''
})

const showIconPicker = ref(false)
const iconQuery = ref('padi')
const iconLoading = ref(false)
const iconError = ref('')
const iconResults = ref<string[]>([])
const iconTotal = ref(0)
const preferredIconPrefixes = ['solar', 'lucide', 'mdi', 'tabler', 'material-symbols', 'heroicons', 'ph', 'fluent']

const iconKeywordSuggestions = [
  'padi',
  'pertanian',
  'toko',
  'umkm',
  'ikan',
  'wisata',
  'budaya',
  'industri',
  'kuliner',
  'kerajinan',
  'peternakan',
  'ekonomi',
  'desa',
  'gunung',
  'pasar',
  'kopi',
  'air',
  'komunitas'
]

const form = reactive<PotentialForm>(createEmptyForm())

const steps = [
  { key: 'identity', title: 'Identitas', subtitle: 'Nama & tipe' },
  { key: 'media', title: 'Media', subtitle: 'Logo & gambar' },
  { key: 'content', title: 'Konten', subtitle: 'Tulisan lengkap' },
  { key: 'contact', title: 'Kontak', subtitle: 'Info & lokasi' }
]

const potentialTypeOptions: { value: PotentialType; label: string; icon: string }[] = [
  { value: 'agriculture', label: 'Pertanian', icon: 'lucide:wheat' },
  { value: 'livestock', label: 'Peternakan', icon: 'lucide:cow' },
  { value: 'fishery', label: 'Perikanan', icon: 'lucide:fish' },
  { value: 'umkm', label: 'UMKM', icon: 'lucide:store' },
  { value: 'tourism', label: 'Wisata', icon: 'lucide:map-pin' },
  { value: 'culture', label: 'Budaya', icon: 'lucide:landmark' },
  { value: 'natural_resource', label: 'Sumber Daya Alam', icon: 'lucide:mountain' },
  { value: 'human_resource', label: 'Sumber Daya Manusia', icon: 'lucide:users' },
  { value: 'industry', label: 'Industri', icon: 'lucide:factory' },
  { value: 'creative_economy', label: 'Ekonomi Kreatif', icon: 'lucide:palette' },
  { value: 'food', label: 'Kuliner', icon: 'lucide:utensils' },
  { value: 'craft', label: 'Kerajinan', icon: 'lucide:gem' },
  { value: 'custom', label: 'Custom', icon: 'lucide:layers' }
]

const hostname = computed(() => String(requestUrl.hostname || '').replace(/^www\./, '').toLowerCase())
const tenantSlug = computed(() => {
  const envClient = String(runtime.public.clientName || 'martopuro').trim().toLowerCase()
  if (hostname.value.includes('martopuro')) return 'martopuro'
  if (hostname.value.includes('obayan')) return 'obayan'
  return envClient || 'martopuro'
})

const appName = computed(() => String(runtime.public.appName || runtime.public.clientDisplayName || runtime.public.siteName || 'Arsades'))
const appLogo = computed(() => {
  if (appLogoFailed.value) return ''
  return String(runtime.public.appLogo || runtime.public.logoUrl || runtime.public.siteLogo || '').trim()
})

const themeVars = computed(() => ({
  '--brand': '#2563eb',
  '--brand-soft': '#dbeafe',
  '--brand-ring': '#dbeafe'
}))

const apiUrl = computed(() => tenantApiUrl(tenantSlug.value, '/potentials'))

const { data, pending, error, refresh } = await useFetch<PotentialListResponse>(apiUrl, {
  key: computed(() => `app-potentials-${tenantSlug.value}-${selectedType.value}-${selectedStatus.value}-${sortBy.value}`),
  query: computed(() => ({
    type: selectedType.value === 'all' ? undefined : selectedType.value,
    status: selectedStatus.value === 'all' ? undefined : selectedStatus.value,
    limit: 100,
    sort: sortBy.value
  })),
  watch: [tenantSlug, selectedType, selectedStatus, sortBy],
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

const potentials = computed<PotentialItem[]>(() => data.value?.data || [])

const visibleError = computed(() => {
  if (!error.value) return ''
  return error.value?.message || 'Terjadi kesalahan saat memuat data potensi.'
})

const filteredPotentials = computed(() => {
  const keyword = q.value.trim().toLowerCase()

  return potentials.value
    .filter((item) => {
      if (!keyword) return true

      return [
        item.title,
        item.name,
        item.subtitle,
        item.shortDescription,
        item.slug,
        item.potentialType,
        item.address,
        item.email,
        item.phone,
        item.whatsapp,
        item.ownerName,
        item.managerName,
        item.marketReach,
        plainText(item.contentHtml || '')
      ]
        .filter(Boolean)
        .join(' ')
        .toLowerCase()
        .includes(keyword)
    })
    .sort((a, b) => {
      if (sortBy.value === 'name') return getPotentialTitle(a).localeCompare(getPotentialTitle(b))
      if (sortBy.value === 'newest') return Number(b.createdAt || 0) - Number(a.createdAt || 0)
      if (sortBy.value === 'oldest') return Number(a.createdAt || 0) - Number(b.createdAt || 0)

      const sortA = Number(a.sortOrder || 0)
      const sortB = Number(b.sortOrder || 0)
      if (sortA !== sortB) return sortA - sortB
      return getPotentialTitle(a).localeCompare(getPotentialTitle(b))
    })
})

const pagedPotentials = computed(() => filteredPotentials.value.slice(0, page.value * pageSize))
const hasMore = computed(() => pagedPotentials.value.length < filteredPotentials.value.length)
const readTime = computed(() => estimateReadTime(editor.value?.getText() || ''))

const embedTitle = computed(() => {
  if (embedModal.kind === 'youtube') return 'Sisipkan YouTube'
  if (embedModal.kind === 'pdf') return 'Sisipkan PDF'
  return 'Sisipkan Peta'
})

const embedPlaceholder = computed(() => {
  if (embedModal.kind === 'youtube') return 'https://www.youtube.com/watch?v=...'
  if (embedModal.kind === 'pdf') return 'https://contoh.com/file.pdf atau kode semat'
  return 'Tempel URL atau kode semat Google Maps'
})

const primaryEditorButtons = computed(() => {
  const ed = editor.value
  if (!ed) return []

  return [
    { label: 'Paragraf', icon: 'solar:text-bold-duotone', active: () => ed.isActive('paragraph'), action: () => ed.chain().focus().setParagraph().run() },
    { label: 'Judul 1', icon: 'solar:text-square-bold-duotone', active: () => ed.isActive('heading', { level: 1 }), action: () => ed.chain().focus().toggleHeading({ level: 1 }).run() },
    { label: 'Judul 2', icon: 'solar:text-square-2-bold-duotone', active: () => ed.isActive('heading', { level: 2 }), action: () => ed.chain().focus().toggleHeading({ level: 2 }).run() },
    { label: 'Judul 3', icon: 'solar:text-square-2-bold', active: () => ed.isActive('heading', { level: 3 }), action: () => ed.chain().focus().toggleHeading({ level: 3 }).run() },
    { label: 'Tebal', icon: 'solar:text-bold-bold-duotone', active: () => ed.isActive('bold'), action: () => ed.chain().focus().toggleBold().run() },
    { label: 'Miring', icon: 'solar:text-italic-bold-duotone', active: () => ed.isActive('italic'), action: () => ed.chain().focus().toggleItalic().run() },
    { label: 'Garis', icon: 'solar:text-underline-bold-duotone', active: () => ed.isActive('underline'), action: () => ed.chain().focus().toggleUnderline().run() },
    { label: 'Poin', icon: 'solar:list-bold-duotone', active: () => ed.isActive('bulletList'), action: () => ed.chain().focus().toggleBulletList().run() },
    { label: 'Nomor', icon: 'solar:list-down-bold-duotone', active: () => ed.isActive('orderedList'), action: () => ed.chain().focus().toggleOrderedList().run() }
  ]
})

const secondaryEditorButtons = computed(() => {
  const ed = editor.value
  if (!ed) return []

  return [
    { label: 'Kutipan', icon: 'solar:quote-up-bold-duotone', action: () => ed.chain().focus().toggleBlockquote().run() },
    { label: 'Tabel', icon: 'solar:table-2-bold-duotone', action: () => ed.chain().focus().insertTable({ rows: 3, cols: 3, withHeaderRow: true }).run() },
    { label: 'Batal', icon: 'solar:undo-left-bold-duotone', action: () => ed.chain().focus().undo().run() },
    { label: 'Ulangi', icon: 'solar:undo-right-bold-duotone', action: () => ed.chain().focus().redo().run() }
  ]
})

const contextEditorButtons = computed(() => {
  const ed = editor.value
  if (!ed) return []

  return [
    { label: 'Tebal', icon: 'solar:text-bold-bold-duotone', action: () => ed.chain().focus().toggleBold().run() },
    { label: 'Miring', icon: 'solar:text-italic-bold-duotone', action: () => ed.chain().focus().toggleItalic().run() },
    { label: 'Link', icon: 'solar:link-circle-bold-duotone', action: () => openLinkModal() },
    { label: 'Kutipan', icon: 'solar:quote-up-bold-duotone', action: () => ed.chain().focus().toggleBlockquote().run() },
    { label: 'Tabel', icon: 'solar:table-2-bold-duotone', action: () => ed.chain().focus().insertTable({ rows: 3, cols: 3, withHeaderRow: true }).run() }
  ]
})

const contextToolbar = reactive({
  open: false,
  x: 0,
  y: 0
})

watch([q, selectedType, selectedStatus, sortBy], () => {
  page.value = 1
})

watch(() => form.potentialType, (type) => {
  if (!form.icon || !iconManuallySelected.value) form.icon = getPotentialTypeIcon(type)
})

const iconManuallySelected = ref(false)

watch(iconQuery, () => {
  if (!showIconPicker.value) return
  if (iconSearchTimer) clearTimeout(iconSearchTimer)
  iconSearchTimer = setTimeout(() => searchIconifyIcons(), 400)
})

onMounted(() => {
  ensureEditor()
})

onBeforeUnmount(() => {
  editor.value?.destroy()
  if (toastTimer) clearTimeout(toastTimer)
  if (iconSearchTimer) clearTimeout(iconSearchTimer)
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
        HTMLAttributes: {
          class: 'text-blue-600 underline underline-offset-4',
          target: '_blank',
          rel: 'noopener'
        }
      }),
      Placeholder.configure({
        placeholder: 'Tulis deskripsi lengkap potensi di sini...'
      }),
      Table.configure({
        resizable: true,
        HTMLAttributes: { class: 'tiptap-table' }
      }),
      TableRow,
      TableHeader,
      TableCell,
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
      EmbedFrame
    ],
    editorProps: {
      attributes: {
        class: 'outline-none min-h-[360px] prose prose-neutral max-w-none'
      }
    },
    onUpdate: () => {
      form.contentHtml = editor.value?.getHTML() || ''
    }
  })
}

function createEmptyForm(): PotentialForm {
  return {
    id: '',
    title: '',
    slug: '',
    subtitle: '',
    shortDescription: '',
    contentHtml: '',
    potentialType: 'custom',
    icon: 'lucide:layers',
    logoUrl: '',
    imageUrl: '',
    phone: '',
    whatsapp: '',
    email: '',
    websiteUrl: '',
    address: '',
    latitude: '',
    longitude: '',
    ownerName: '',
    managerName: '',
    productionCapacity: '',
    productionUnit: '',
    marketReach: '',
    estimatedValue: '',
    status: 'active',
    isFeatured: true,
    sortOrder: 0,
    images: []
  }
}

function resetFilters() {
  q.value = ''
  selectedType.value = 'all'
  selectedStatus.value = 'active'
  sortBy.value = 'sort_order'
  page.value = 1
}

function openCreate() {
  Object.assign(form, createEmptyForm())
  form.icon = getPotentialTypeIcon(form.potentialType)
  editingPotential.value = null
  manualSlugEdited.value = false
  iconManuallySelected.value = false
  modalStep.value = 0
  isEditorOpen.value = true

  nextTick(() => {
    ensureEditor()
    editor.value?.commands.setContent('<p></p>')
  })
}

function openEdit(item: PotentialItem) {
  editingPotential.value = item
  Object.assign(form, createEmptyForm(), {
    id: item.id,
    title: getPotentialTitle(item),
    slug: item.slug || '',
    subtitle: item.subtitle || item.shortDescription || '',
    shortDescription: item.shortDescription || item.subtitle || '',
    contentHtml: item.contentHtml || '',
    potentialType: item.potentialType || 'custom',
    icon: item.icon || getPotentialTypeIcon(item.potentialType || 'custom'),
    logoUrl: item.logoUrl || '',
    imageUrl: getPotentialCover(item),
    phone: item.phone || '',
    whatsapp: item.whatsapp || '',
    email: item.email || '',
    websiteUrl: item.websiteUrl || '',
    address: item.address || '',
    latitude: item.latitude ? String(item.latitude) : '',
    longitude: item.longitude ? String(item.longitude) : '',
    ownerName: item.ownerName || '',
    managerName: item.managerName || '',
    productionCapacity: item.productionCapacity || '',
    productionUnit: item.productionUnit || '',
    marketReach: item.marketReach || '',
    estimatedValue: item.estimatedValue ? String(item.estimatedValue) : '',
    status: item.status || 'active',
    isFeatured: Boolean(item.isFeatured),
    sortOrder: Number(item.sortOrder || 0),
    images: getPotentialImages(item)
  })

  manualSlugEdited.value = Boolean(form.slug)
  iconManuallySelected.value = Boolean(item.icon)
  modalStep.value = 0
  isEditorOpen.value = true

  nextTick(() => {
    ensureEditor()
    editor.value?.commands.setContent(form.contentHtml || '<p></p>')
  })
}

function requestCloseEditor() {
  closeModalOpen.value = true
}

function forceCloseEditor() {
  isEditorOpen.value = false
  closeModalOpen.value = false
  contextToolbar.open = false
}

function goNextStep() {
  if (modalStep.value === 0 && !validateIdentity()) return
  modalStep.value = Math.min(modalStep.value + 1, steps.length - 1)
}

function validateIdentity() {
  if (!form.title.trim()) {
    showToast('error', 'Nama belum diisi', 'Isi nama potensi terlebih dahulu.')
    return false
  }

  if (!form.slug.trim()) {
    form.slug = slugify(form.title)
  }

  return true
}

async function savePotential() {
  if (!validateIdentity()) return

  isSaving.value = true

  try {
    ensureEditor()
    form.contentHtml = editor.value?.getHTML() || ''

    const payload = buildPayload()

    if (form.id) {
      await $fetch(`${apiUrl.value}/${form.id}`, {
        method: 'PUT',
        body: payload
      })
    } else {
      await $fetch(apiUrl.value, {
        method: 'POST',
        body: payload
      })
    }

    await refresh()
    showToast('success', 'Potensi disimpan', 'Data potensi berhasil diperbarui.')
    forceCloseEditor()
  } catch (err: any) {
    showToast('error', 'Gagal menyimpan', err?.data?.message || err?.message || 'Data belum berhasil disimpan.')
  } finally {
    isSaving.value = false
  }
}

function buildPayload() {
  return {
    title: form.title.trim(),
    name: form.title.trim(),
    slug: slugify(form.slug || form.title),
    subtitle: form.subtitle.trim(),
    shortDescription: form.subtitle.trim(),
    contentHtml: form.contentHtml,
    potentialType: form.potentialType,
    icon: form.icon || getPotentialTypeIcon(form.potentialType),
    logoUrl: form.logoUrl.trim() || null,
    imageUrl: form.imageUrl.trim() || null,
    coverUrl: form.imageUrl.trim() || null,
    phone: form.phone.trim() || null,
    whatsapp: form.whatsapp.trim() || null,
    email: form.email.trim() || null,
    websiteUrl: form.websiteUrl.trim() || null,
    address: form.address.trim() || null,
    latitude: parseNullableNumber(form.latitude),
    longitude: parseNullableNumber(form.longitude),
    ownerName: form.ownerName.trim() || null,
    managerName: form.managerName.trim() || null,
    productionCapacity: form.productionCapacity.trim() || null,
    productionUnit: form.productionUnit.trim() || null,
    marketReach: form.marketReach.trim() || null,
    estimatedValue: parseNullableNumber(form.estimatedValue),
    status: form.status,
    isFeatured: form.isFeatured,
    sortOrder: Number(form.sortOrder || 0),
    metadata: {
      images: form.images.filter(Boolean)
    }
  }
}

function openDelete(item: PotentialItem) {
  deleteModal.open = true
  deleteModal.item = item
}

function closeDelete() {
  deleteModal.open = false
  deleteModal.item = null
}

async function deletePotentialNow() {
  if (!deleteModal.item) return

  isDeleting.value = true

  try {
    await $fetch(`${apiUrl.value}/${deleteModal.item.id}`, {
      method: 'DELETE'
    })

    await refresh()
    showToast('success', 'Potensi dihapus', 'Data potensi berhasil dihapus.')
    closeDelete()
  } catch (err: any) {
    showToast('error', 'Gagal menghapus', err?.data?.message || err?.message || 'Data belum berhasil dihapus.')
  } finally {
    isDeleting.value = false
  }
}

function openMediaModal(target: MediaTarget) {
  mediaModal.open = true
  mediaModal.target = target
  mediaModal.url = ''
  mediaModal.preview = ''
  mediaModal.error = ''

  const titleMap: Record<MediaTarget, string> = {
    cover: 'Gambar Utama',
    logo: 'Logo Potensi',
    gallery: 'Gambar Galeri',
    editorImage: 'Gambar Konten'
  }

  mediaModal.title = titleMap[target]
}

function closeMediaModal() {
  mediaModal.open = false
  mediaModal.error = ''
}

function triggerMediaFile() {
  mediaModal.error = ''
  mediaFileInput.value?.click()
}

function triggerEditorImageUpload() {
  openMediaModal('editorImage')
}

async function onPickMediaFile(event: Event) {
  const input = event.target as HTMLInputElement
  const file = input.files?.[0] || null

  if (!file) return

  if (!validateImageFile(file)) {
    input.value = ''
    return
  }

  mediaModal.uploading = true

  try {
    const url = await uploadFileImage(file, `${tenantSlug.value}/potentials`)
    applyMedia(url)
    showToast('success', 'Gambar ditambahkan', 'Gambar berhasil ditambahkan.')
  } catch (err: any) {
    mediaModal.error = err?.message || 'Gambar belum berhasil ditambahkan.'
  } finally {
    mediaModal.uploading = false
    input.value = ''
  }
}

async function onPickEditorImage(event: Event) {
  await onPickMediaFile(event)
}

function applyMediaUrl() {
  const url = mediaModal.url.trim()

  if (!isValidUrl(url)) {
    mediaModal.error = 'Tautan gambar belum valid.'
    return
  }

  applyMedia(url)
}

function applyMedia(url: string) {
  if (mediaModal.target === 'cover') form.imageUrl = url
  if (mediaModal.target === 'logo') form.logoUrl = url
  if (mediaModal.target === 'gallery') form.images = Array.from(new Set([...form.images, url]))
  if (mediaModal.target === 'editorImage') editor.value?.chain().focus().setImage({ src: url, alt: 'Gambar' }).run()

  closeMediaModal()
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

function removeGalleryImage(index: number) {
  form.images = form.images.filter((_, itemIndex) => itemIndex !== index)
}

function openEmbedModal(kind: EmbedKind) {
  embedModal.open = true
  embedModal.kind = kind
  embedModal.url = ''
  embedModal.error = ''
}

function closeEmbedModal() {
  embedModal.open = false
  embedModal.error = ''
}

function insertEmbed() {
  const raw = embedModal.url.trim()
  const url = extractIframeSrc(raw)

  if (!isValidUrl(url)) {
    embedModal.error = 'Alamat belum valid.'
    return
  }

  ensureEditor()

  if (embedModal.kind === 'youtube') {
    editor.value?.chain().focus().setYoutubeVideo({ src: url, width: 720, height: 405 }).run()
  } else {
    editor.value?.chain().focus().insertContent({
      type: 'embedFrame',
      attrs: {
        src: embedModal.kind === 'pdf' ? embedPdfUrl(url) : url,
        title: embedModal.kind === 'pdf' ? 'PDF' : 'Peta',
        embedType: embedModal.kind
      }
    }).run()
  }

  closeEmbedModal()
}

function openLinkModal() {
  ensureEditor()
  const selectedText = editor.value?.state.doc.textBetween(
    editor.value.state.selection.from,
    editor.value.state.selection.to,
    ' '
  ) || ''

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

function openContextMenu(event: MouseEvent) {
  contextToolbar.open = true
  contextToolbar.x = Math.min(event.clientX, window.innerWidth - 260)
  contextToolbar.y = Math.min(event.clientY, window.innerHeight - 260)
}

function runContextAction(action: () => void) {
  action()
  contextToolbar.open = false
}

async function openIconPicker() {
  showIconPicker.value = true
  iconError.value = ''
  await searchIconifyIcons()
}

function closeIconPicker() {
  showIconPicker.value = false
  iconError.value = ''
}

function setIconKeyword(keyword: string) {
  iconQuery.value = keyword
  searchIconifyIcons()
}

async function searchIconifyIcons() {
  const query = iconQuery.value.trim() || 'padi'

  iconLoading.value = true
  iconError.value = ''

  try {
    const params = new URLSearchParams()
    params.set('query', query)
    params.set('limit', '108')
    params.set('prefixes', preferredIconPrefixes.join(','))

    const response = await $fetch<{ icons?: string[]; total?: number }>(`https://api.iconify.design/search?${params.toString()}`)
    iconResults.value = Array.from(new Set((response.icons || []).map((icon) => normalizeIconName(icon))))
    iconTotal.value = Number(response.total || iconResults.value.length)
  } catch (err: any) {
    iconResults.value = fallbackIconResults(query)
    iconTotal.value = iconResults.value.length
    iconError.value = err?.message ? 'Ikon online belum berhasil dimuat. Pilihan awal tetap bisa digunakan.' : ''
  } finally {
    iconLoading.value = false
  }
}

function normalizeIconName(iconName: string) {
  const cleanIcon = String(iconName || '').trim()
  if (!cleanIcon) return getPotentialTypeIcon(form.potentialType)
  if (cleanIcon.includes(':')) return cleanIcon
  return `lucide:${cleanIcon}`
}

function selectIcon(iconName: string) {
  form.icon = normalizeIconName(iconName)
  iconManuallySelected.value = true
}

function fallbackIconResults(query: string) {
  const base = [
    'lucide:wheat',
    'lucide:store',
    'lucide:fish',
    'lucide:map-pin',
    'lucide:landmark',
    'lucide:factory',
    'lucide:palette',
    'lucide:utensils',
    'lucide:gem',
    'lucide:cow',
    'lucide:leaf',
    'lucide:mountain',
    'lucide:users',
    'lucide:tree-pine',
    'lucide:shopping-bag',
    'lucide:coffee',
    'lucide:waves',
    'lucide:tractor',
    'lucide:warehouse',
    'lucide:hand-coins',
    'lucide:building-2',
    'lucide:sprout',
    'lucide:badge-check',
    'lucide:route',
    'lucide:camera',
    'lucide:package',
    'lucide:box',
    'lucide:chart-no-axes-column-increasing',
    'lucide:handshake',
    'lucide:map'
  ]

  const lower = query.toLowerCase()
  if (lower.includes('padi') || lower.includes('pertanian')) return ['lucide:wheat', 'lucide:tractor', 'lucide:sprout', ...base]
  if (lower.includes('ikan')) return ['lucide:fish', 'lucide:waves', ...base]
  if (lower.includes('toko') || lower.includes('umkm')) return ['lucide:store', 'lucide:shopping-bag', 'lucide:package', ...base]
  if (lower.includes('wisata')) return ['lucide:map-pin', 'lucide:camera', 'lucide:route', ...base]
  return base
}

function handleTitleInput() {
  if (!manualSlugEdited.value) form.slug = slugify(form.title)
}

function getPotentialTitle(item: PotentialItem) {
  return String(item.title || item.name || 'Potensi').trim()
}

function getPotentialImages(item: PotentialItem) {
  const metadataImages = Array.isArray(item.metadata?.images)
    ? item.metadata.images
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

function getPotentialCover(item: PotentialItem) {
  return getPotentialImages(item)[0] || ''
}

function markImageFailed(id: string) {
  failedImages.value = {
    ...failedImages.value,
    [id]: true
  }
}

function potentialPublicUrl(slug?: string | null) {
  const cleanSlug = String(slug || '').trim()
  if (!cleanSlug) return '/potentials'
  return `/potentials?detail=${encodeURIComponent(cleanSlug)}`
}

function potentialTypeLabel(type?: PotentialType | null) {
  return potentialTypeOptions.find((item) => item.value === type)?.label || 'Potensi'
}

function getPotentialTypeIcon(type?: PotentialType | null) {
  return potentialTypeOptions.find((item) => item.value === type)?.icon || 'lucide:layers'
}

function validateImageFile(file: File) {
  const allowed = ['image/jpeg', 'image/png', 'image/webp', 'image/gif']

  if (!allowed.includes(file.type)) {
    showToast('error', 'Format gambar belum sesuai', 'Gunakan gambar JPG, PNG, WebP, atau GIF.')
    return false
  }

  if (file.size > 5 * 1024 * 1024) {
    showToast('error', 'Ukuran gambar terlalu besar', 'Gunakan gambar maksimal 5 MB.')
    return false
  }

  return true
}

function extractIframeSrc(value: string) {
  const match = value.match(/src=["']([^"']+)["']/i)
  return match?.[1] || value
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

function parseNullableNumber(value: string) {
  const trimmed = String(value || '').trim()
  if (!trimmed) return null

  const number = Number(trimmed)
  return Number.isNaN(number) ? null : number
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

function plainText(value: string) {
  return String(value || '')
    .replace(/<script[\s\S]*?>[\s\S]*?<\/script>/gi, ' ')
    .replace(/<style[\s\S]*?>[\s\S]*?<\/style>/gi, ' ')
    .replace(/<iframe[\s\S]*?>[\s\S]*?<\/iframe>/gi, ' ')
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
    .replace(/'/g, '&#39;')
}

function showToast(type: ToastType, title: string, message: string) {
  toast.show = true
  toast.type = type
  toast.title = title
  toast.message = message

  if (toastTimer) clearTimeout(toastTimer)

  toastTimer = setTimeout(() => {
    closeToast()
  }, 2800)
}

function closeToast() {
  toast.show = false
}

const MediaCard = defineComponent({
  props: {
    title: { type: String, required: true },
    description: { type: String, required: true },
    image: { type: String, default: '' },
    icon: { type: String, default: 'solar:gallery-wide-bold-duotone' },
    objectFit: { type: String, default: 'cover' }
  },
  emits: ['open', 'clear'],
  setup(props, { emit }) {
    return () =>
      h(
        'div',
        {
          class: 'overflow-hidden rounded-[1.75rem] border border-neutral-200 bg-white shadow-sm'
        },
        [
          h(
            'div',
            {
              class: 'relative h-48 bg-neutral-100'
            },
            props.image
              ? [
                  h('img', {
                    src: props.image,
                    alt: props.title,
                    class: `h-full w-full ${props.objectFit === 'contain' ? 'object-contain p-5' : 'object-cover'}`
                  })
                ]
              : [
                  h(
                    'div',
                    {
                      class: 'flex h-full w-full items-center justify-center bg-gradient-to-br from-blue-50 via-white to-sky-50 text-blue-600'
                    },
                    [h(Icon, { icon: props.icon, class: 'h-12 w-12' })]
                  )
                ]
          ),
          h('div', { class: 'p-4' }, [
            h('h3', { class: 'text-sm font-black text-neutral-950' }, props.title),
            h('p', { class: 'mt-1 text-sm font-semibold leading-6 text-neutral-500' }, props.description),
            h('div', { class: 'mt-4 flex gap-2' }, [
              h(
                'button',
                {
                  type: 'button',
                  class:
                    'inline-flex h-10 flex-1 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 text-sm font-black text-white shadow-sm shadow-blue-600/20 transition hover:bg-blue-700',
                  onClick: () => emit('open')
                },
                [h(Icon, { icon: 'solar:upload-bold-duotone', class: 'h-5 w-5' }), 'Pilih Gambar']
              ),
              props.image
                ? h(
                    'button',
                    {
                      type: 'button',
                      class:
                        'grid h-10 w-10 place-items-center rounded-2xl border border-red-200 bg-red-50 text-red-600 transition hover:bg-red-100',
                      onClick: () => emit('clear')
                    },
                    [h(Icon, { icon: 'solar:trash-bin-trash-bold-duotone', class: 'h-5 w-5' })]
                  )
                : null
            ])
          ])
        ]
      )
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

.textarea-field {
  display: block;
  width: 100%;
  border-radius: 1rem;
  border: 1px solid rgb(229 229 229);
  background: rgb(250 250 250);
  padding: 0.75rem 1rem;
  font-size: 0.875rem;
  font-weight: 700;
  line-height: 1.6;
  color: rgb(38 38 38);
  outline: none;
  transition: 160ms ease;
}

.textarea-field:focus {
  border-color: rgb(37 99 235);
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
  padding: 0.4rem 0.6rem;
  font-size: 0.7rem;
  font-weight: 800;
  color: white;
  opacity: 0;
  transition: 120ms ease;
  box-shadow: 0 12px 30px rgba(15, 23, 42, 0.18);
}

.editor-btn:hover .editor-tooltip {
  opacity: 1;
  transform: translateX(-50%) translateY(0);
}

.editor-content :deep(.ProseMirror) {
  min-height: 360px;
  outline: none;
}

.editor-content :deep(.ProseMirror p) {
  margin: 0.75rem 0;
}

.editor-content :deep(.ProseMirror h1) {
  margin: 1.5rem 0 0.85rem;
  font-size: 2rem;
  font-weight: 950;
  line-height: 1.15;
  letter-spacing: -0.04em;
}

.editor-content :deep(.ProseMirror h2) {
  margin: 1.25rem 0 0.75rem;
  font-size: 1.5rem;
  font-weight: 900;
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
  padding: 0.85rem 1rem;
  color: #334155;
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

.editor-content :deep(.ProseMirror table),
.editor-content :deep(.ProseMirror .tiptap-table) {
  width: 100%;
  border-collapse: collapse;
  margin: 1rem 0;
  overflow: hidden;
  border-radius: 1rem;
}

.editor-content :deep(.ProseMirror th),
.editor-content :deep(.ProseMirror td) {
  border: 1px solid #e5e7eb;
  padding: 0.75rem;
  vertical-align: top;
}

.editor-content :deep(.ProseMirror th) {
  background: #eff6ff;
  color: #1e3a8a;
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
