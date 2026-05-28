<template>
  <main class="min-h-screen overflow-hidden bg-neutral-50 text-neutral-950">
    <div class="pointer-events-none fixed inset-0 -z-10 overflow-hidden">
      <div class="absolute -left-32 top-0 h-[420px] w-[420px] rounded-full bg-blue-100 blur-3xl"></div>
      <div class="absolute -right-32 top-40 h-[420px] w-[420px] rounded-full bg-cyan-100 blur-3xl"></div>
      <div class="absolute bottom-0 left-1/3 h-[360px] w-[360px] rounded-full bg-emerald-100/70 blur-3xl"></div>
      <div class="absolute inset-0 bg-grid opacity-40"></div>
    </div>

    <!-- DETAIL MODE: /facilities?detail=slug -->
    <template v-if="isDetailMode">
      <section
        v-if="detailLoading"
        class="mx-auto max-w-7xl px-4 pb-12 pt-28 sm:px-6 lg:px-8"
      >
        <div class="overflow-hidden rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm">
          <div class="grid animate-pulse gap-5 lg:grid-cols-[1fr_320px]">
            <div>
              <div class="h-5 w-40 rounded-full bg-neutral-100"></div>
              <div class="mt-5 h-12 w-2/3 rounded-2xl bg-neutral-100"></div>
              <div class="mt-5 h-4 w-full rounded-full bg-neutral-100"></div>
              <div class="mt-2 h-4 w-4/5 rounded-full bg-neutral-100"></div>
            </div>
            <div class="h-56 rounded-[1.75rem] bg-neutral-100"></div>
          </div>
        </div>
      </section>

      <section
        v-else-if="detailError || !activeFacility"
        class="mx-auto max-w-3xl px-4 pb-14 pt-28 text-center sm:px-6 lg:px-8"
      >
        <div class="rounded-[2rem] border border-red-200 bg-white p-8 shadow-sm">
          <div class="mx-auto grid h-14 w-14 place-items-center rounded-2xl bg-red-50 text-red-600">
            <Icon icon="solar:danger-circle-bold-duotone" class="h-7 w-7" />
          </div>

          <h1 class="mt-5 text-2xl font-black text-neutral-950">
            Fasilitas tidak ditemukan
          </h1>

          <p class="mx-auto mt-2 max-w-md text-sm font-medium leading-6 text-neutral-500">
            Data fasilitas belum tersedia, tidak aktif, atau slug pada URL tidak sesuai.
          </p>

          <NuxtLink
            to="/facilities"
            class="mt-6 inline-flex items-center justify-center gap-2 rounded-2xl bg-neutral-900 px-5 py-3 text-sm font-black text-white transition hover:bg-neutral-800"
          >
            <Icon icon="solar:arrow-left-linear" class="h-5 w-5" />
            Kembali ke Fasilitas
          </NuxtLink>
        </div>
      </section>

      <template v-else>
        <section class="relative border-b border-neutral-200 bg-white/80 pt-24 backdrop-blur-xl">
          <div class="mx-auto max-w-7xl px-4 py-8 sm:px-6 lg:px-8">
            <nav class="mb-6 flex flex-wrap items-center gap-2 text-sm font-bold text-neutral-500">
              <NuxtLink to="/" class="transition hover:text-neutral-950">
                Beranda
              </NuxtLink>
              <Icon icon="solar:alt-arrow-right-linear" class="h-4 w-4" />
              <NuxtLink to="/facilities" class="transition hover:text-neutral-950">
                Fasilitas
              </NuxtLink>
              <Icon icon="solar:alt-arrow-right-linear" class="h-4 w-4" />
              <span class="max-w-[220px] truncate text-neutral-950 sm:max-w-md">
                {{ activeFacility.title || activeFacility.name }}
              </span>
            </nav>

            <div class="grid gap-6 lg:grid-cols-[1fr_380px] lg:items-stretch">
              <div class="flex min-h-[320px] flex-col justify-end rounded-[2rem] border border-neutral-200 bg-neutral-950 p-5 text-white shadow-sm sm:p-7">
                <div class="relative -mx-5 -mt-5 mb-6 h-48 overflow-hidden rounded-t-[2rem] bg-neutral-900 sm:-mx-7 sm:-mt-7 sm:h-60">
                  <img
                    v-if="detailImage && !heroImageFailed"
                    :src="detailImage"
                    :alt="activeFacility.title || activeFacility.name || 'Fasilitas'"
                    class="h-full w-full object-cover opacity-80"
                    @error="heroImageFailed = true"
                  >

                  <div
                    v-else
                    class="flex h-full w-full items-center justify-center bg-gradient-to-br from-blue-950 via-slate-950 to-cyan-950"
                  >
                    <Icon
                      :icon="activeFacility.icon || getFacilityTypeIcon(activeFacility.facilityType)"
                      class="h-24 w-24 text-white/15"
                    />
                  </div>

                  <div class="absolute inset-0 bg-gradient-to-t from-neutral-950 via-neutral-950/35 to-transparent"></div>
                </div>

                <div class="flex flex-wrap items-center gap-2">
                  <span class="inline-flex items-center gap-2 rounded-full border border-white/15 bg-white/10 px-3 py-1.5 text-xs font-black uppercase tracking-[0.14em] text-white backdrop-blur">
                    <Icon :icon="getFacilityTypeIcon(activeFacility.facilityType)" class="h-4 w-4" />
                    {{ facilityTypeLabel(activeFacility.facilityType) }}
                  </span>

                  <span
                    class="rounded-full px-3 py-1.5 text-xs font-black backdrop-blur"
                    :class="activeFacility.status === 'active'
                      ? 'bg-emerald-400/15 text-emerald-200'
                      : 'bg-white/10 text-white/70'"
                  >
                    {{ activeFacility.status }}
                  </span>

                  <span
                    v-if="activeFacility.isFeatured"
                    class="rounded-full bg-blue-600 px-3 py-1.5 text-xs font-black text-white shadow-lg shadow-blue-900/20"
                  >
                    Featured
                  </span>
                </div>

                <h1 class="mt-4 max-w-4xl text-3xl font-black leading-tight tracking-tight text-white sm:text-5xl">
                  {{ activeFacility.title || activeFacility.name }}
                </h1>

                <p
                  v-if="activeFacility.subtitle || activeFacility.shortDescription"
                  class="mt-4 max-w-3xl text-sm font-medium leading-7 text-white/75 sm:text-base"
                >
                  {{ activeFacility.subtitle || activeFacility.shortDescription }}
                </p>

                <div class="mt-6 flex flex-wrap gap-3">
                  <a
                    v-if="whatsappUrl"
                    :href="whatsappUrl"
                    target="_blank"
                    rel="noopener"
                    class="inline-flex items-center justify-center gap-2 rounded-2xl bg-white px-5 py-3 text-sm font-black text-neutral-950 transition hover:-translate-y-0.5 hover:bg-blue-50"
                  >
                    <Icon icon="solar:chat-round-call-bold-duotone" class="h-5 w-5 text-blue-600" />
                    WhatsApp
                  </a>

                  <a
                    v-if="mapsUrl"
                    :href="mapsUrl"
                    target="_blank"
                    rel="noopener"
                    class="inline-flex items-center justify-center gap-2 rounded-2xl border border-white/20 bg-white/10 px-5 py-3 text-sm font-black text-white backdrop-blur transition hover:-translate-y-0.5 hover:bg-white/15"
                  >
                    <Icon icon="solar:map-point-bold-duotone" class="h-5 w-5" />
                    Maps
                  </a>

                  <a
                    v-if="activeFacility.websiteUrl"
                    :href="activeFacility.websiteUrl"
                    target="_blank"
                    rel="noopener"
                    class="inline-flex items-center justify-center gap-2 rounded-2xl border border-white/20 bg-white/10 px-5 py-3 text-sm font-black text-white backdrop-blur transition hover:-translate-y-0.5 hover:bg-white/15"
                  >
                    <Icon icon="solar:global-bold-duotone" class="h-5 w-5" />
                    Website
                  </a>

                  <NuxtLink
                    to="/facilities"
                    class="inline-flex items-center justify-center gap-2 rounded-2xl border border-white/20 bg-white/10 px-5 py-3 text-sm font-black text-white backdrop-blur transition hover:-translate-y-0.5 hover:bg-white/15"
                  >
                    <Icon icon="solar:arrow-left-linear" class="h-5 w-5" />
                    Semua Fasilitas
                  </NuxtLink>
                </div>
              </div>

              <aside class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm">
                <div class="flex items-start gap-4">
                  <div class="grid h-14 w-14 shrink-0 place-items-center overflow-hidden rounded-2xl bg-blue-50 text-blue-700">
                    <img
                      v-if="activeFacility.logoUrl && !logoFailed"
                      :src="activeFacility.logoUrl"
                      :alt="activeFacility.title || activeFacility.name || 'Fasilitas'"
                      class="h-full w-full object-cover"
                      @error="logoFailed = true"
                    >
                    <Icon
                      v-else
                      :icon="activeFacility.icon || getFacilityTypeIcon(activeFacility.facilityType)"
                      class="h-7 w-7"
                    />
                  </div>

                  <div class="min-w-0">
                    <p class="text-xs font-black uppercase tracking-[0.14em] text-neutral-400">
                      Ringkasan
                    </p>
                    <p class="mt-1 truncate text-base font-black text-neutral-950">
                      {{ activeFacility.slug }}
                    </p>
                    <p class="mt-1 text-xs font-bold text-neutral-500">
                      Update {{ formatDate(activeFacility.updatedAt) }}
                    </p>
                  </div>
                </div>

                <div class="mt-5 grid gap-2">
                  <div
                    v-for="item in detailFacts"
                    :key="item.label"
                    class="rounded-2xl bg-neutral-50 px-4 py-3"
                  >
                    <p class="text-[10px] font-black uppercase tracking-[0.12em] text-neutral-400">
                      {{ item.label }}
                    </p>
                    <p class="mt-1 text-sm font-black leading-6 text-neutral-800">
                      {{ item.value }}
                    </p>
                  </div>
                </div>
              </aside>
            </div>
          </div>
        </section>

        <section class="mx-auto grid max-w-7xl gap-6 px-4 py-8 sm:px-6 lg:grid-cols-[1fr_340px] lg:px-8">
          <article class="overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-sm">
            <div class="border-b border-neutral-200 px-5 py-4 sm:px-6">
              <div class="flex items-center justify-between gap-4">
                <div class="flex items-center gap-3">
                  <div class="grid h-10 w-10 place-items-center rounded-2xl bg-blue-50 text-blue-700">
                    <Icon icon="solar:document-text-bold-duotone" class="h-5 w-5" />
                  </div>
                  <div>
                    <p class="text-sm font-black text-neutral-950">
                      Detail Fasilitas
                    </p>
                    <p class="text-xs font-semibold text-neutral-500">
                      Informasi singkat dan konten utama
                    </p>
                  </div>
                </div>
              </div>
            </div>

            <div class="px-5 py-6 sm:px-6">
              <div
                v-if="safeContentHtml"
                class="facility-content"
                v-html="safeContentHtml"
              ></div>

              <div v-else class="rounded-3xl border border-dashed border-neutral-300 bg-neutral-50 p-8 text-center">
                <Icon icon="solar:document-bold-duotone" class="mx-auto h-10 w-10 text-neutral-400" />
                <p class="mt-3 text-sm font-bold text-neutral-500">
                  Belum ada konten detail untuk fasilitas ini.
                </p>
              </div>
            </div>
          </article>

          <aside class="space-y-4">
            <div class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm">
              <p class="text-sm font-black text-neutral-950">
                Kontak & Lokasi
              </p>

              <div class="mt-4 space-y-3">
                <CompactContact
                  v-if="activeFacility.phone"
                  icon="solar:phone-bold-duotone"
                  label="Telepon"
                  :value="activeFacility.phone"
                  :href="`tel:${activeFacility.phone}`"
                />

                <CompactContact
                  v-if="activeFacility.whatsapp"
                  icon="solar:chat-round-call-bold-duotone"
                  label="WhatsApp"
                  :value="activeFacility.whatsapp"
                  :href="whatsappUrl"
                />

                <CompactContact
                  v-if="activeFacility.email"
                  icon="solar:letter-bold-duotone"
                  label="Email"
                  :value="activeFacility.email"
                  :href="`mailto:${activeFacility.email}`"
                />

                <CompactContact
                  v-if="activeFacility.websiteUrl"
                  icon="solar:global-bold-duotone"
                  label="Website"
                  :value="activeFacility.websiteUrl"
                  :href="activeFacility.websiteUrl"
                />

                <div v-if="activeFacility.address" class="rounded-2xl border border-neutral-200 bg-neutral-50 p-4">
                  <p class="text-xs font-black uppercase tracking-[0.14em] text-neutral-400">
                    Alamat
                  </p>
                  <p class="mt-1 text-sm font-bold leading-6 text-neutral-700">
                    {{ activeFacility.address }}
                  </p>
                </div>

                <div
                  v-if="!activeFacility.phone && !activeFacility.whatsapp && !activeFacility.email && !activeFacility.websiteUrl && !activeFacility.address"
                  class="rounded-2xl border border-dashed border-neutral-300 bg-neutral-50 p-5 text-center"
                >
                  <Icon icon="solar:map-point-wave-bold-duotone" class="mx-auto h-8 w-8 text-neutral-400" />
                  <p class="mt-2 text-sm font-bold text-neutral-500">
                    Kontak dan lokasi belum tersedia.
                  </p>
                </div>
              </div>
            </div>

            <div v-if="galleryImages.length" class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm">
              <div class="flex items-center justify-between gap-3">
                <p class="text-sm font-black text-neutral-950">
                  Galeri
                </p>
                <p class="text-xs font-bold text-neutral-400">
                  {{ galleryImages.length }} foto
                </p>
              </div>

              <div class="mt-4 grid grid-cols-2 gap-2">
                <img
                  v-for="image in galleryImages.slice(0, 4)"
                  :key="image"
                  :src="image"
                  :alt="activeFacility.title || activeFacility.name || 'Galeri fasilitas'"
                  class="h-24 w-full rounded-2xl object-cover"
                >
              </div>
            </div>
          </aside>
        </section>

        <section v-if="relatedFacilities.length" class="mx-auto max-w-7xl px-4 pb-12 sm:px-6 lg:px-8">
          <div class="mb-4 flex items-end justify-between gap-4">
            <div>
              <p class="text-xs font-black uppercase tracking-[0.14em] text-blue-600">
                Fasilitas Terkait
              </p>
              <h2 class="mt-1 text-2xl font-black tracking-tight text-neutral-950">
                Lokasi lainnya
              </h2>
            </div>

            <NuxtLink
              to="/facilities"
              class="hidden rounded-2xl border border-neutral-200 bg-white px-4 py-2 text-xs font-black text-neutral-600 shadow-sm transition hover:bg-neutral-50 sm:inline-flex"
            >
              Lihat Semua
            </NuxtLink>
          </div>

          <div class="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
            <NuxtLink
              v-for="item in relatedFacilities"
              :key="item.id"
              :to="detailTo(item.slug)"
              class="group overflow-hidden rounded-[1.75rem] border border-neutral-200 bg-white shadow-sm transition hover:-translate-y-1 hover:border-blue-200 hover:shadow-xl hover:shadow-blue-900/5"
            >
              <div class="relative h-36 bg-neutral-100">
                <img
                  v-if="getFacilityCover(item) && !relatedFailedImages[item.id]"
                  :src="getFacilityCover(item)"
                  :alt="item.title || item.name || 'Fasilitas'"
                  class="h-full w-full object-cover transition duration-500 group-hover:scale-105"
                  @error="markRelatedImageFailed(item.id)"
                >
                <div v-else class="flex h-full w-full items-center justify-center bg-gradient-to-br from-blue-50 via-white to-cyan-50 text-blue-600">
                  <Icon :icon="item.icon || getFacilityTypeIcon(item.facilityType)" class="h-12 w-12" />
                </div>
              </div>

              <div class="p-4">
                <p class="text-[11px] font-black uppercase tracking-[0.12em] text-blue-600">
                  {{ facilityTypeLabel(item.facilityType) }}
                </p>
                <h3 class="mt-1 line-clamp-2 text-base font-black leading-6 text-neutral-950 group-hover:text-blue-700">
                  {{ item.title || item.name }}
                </h3>
                <p class="mt-1 line-clamp-2 text-xs font-semibold leading-5 text-neutral-500">
                  {{ item.subtitle || item.shortDescription || contentPreview(item) || 'Informasi fasilitas desa.' }}
                </p>
              </div>
            </NuxtLink>
          </div>
        </section>
      </template>
    </template>

    <!-- LIST MODE: /facilities -->
    <template v-else>
      <section class="relative overflow-hidden border-b border-neutral-200 bg-white/80 pt-28 backdrop-blur-xl">
        <div class="mx-auto max-w-7xl px-4 pb-8 sm:px-6 lg:px-8">
          <nav class="mb-6 flex flex-wrap items-center gap-2 text-sm font-bold text-neutral-500">
            <NuxtLink to="/" class="transition hover:text-neutral-950">
              Beranda
            </NuxtLink>
            <Icon icon="solar:alt-arrow-right-linear" class="h-4 w-4" />
            <span class="text-neutral-950">Fasilitas</span>
          </nav>

          <div class="grid gap-6 lg:grid-cols-[1fr_360px] lg:items-end">
            <div>
              <div class="mb-5 inline-flex items-center gap-2 rounded-full bg-blue-50 px-3 py-1.5 text-xs font-black uppercase tracking-[0.14em] text-blue-700">
                <Icon icon="solar:map-point-wave-bold-duotone" class="h-4 w-4" />
                Fasilitas Desa
              </div>

              <h1 class="max-w-4xl text-4xl font-black leading-tight tracking-tight text-neutral-950 sm:text-5xl lg:text-6xl">
                Fasilitas Publik
                <span class="bg-gradient-to-r from-blue-600 via-sky-500 to-cyan-500 bg-clip-text text-transparent">
                  {{ appName }}
                </span>
              </h1>

              <p class="mt-5 max-w-3xl text-base font-medium leading-8 text-neutral-600 sm:text-lg">
                Data fasilitas dibuat compact agar warga bisa cepat melihat kategori, lokasi, kontak, dan informasi penting tanpa membuka banyak halaman.
              </p>
            </div>

            <aside class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm">
              <div class="flex items-start gap-4">
                <div class="grid h-14 w-14 shrink-0 place-items-center overflow-hidden rounded-2xl bg-blue-50 text-blue-700">
                  <img
                    v-if="appLogo"
                    :src="appLogo"
                    :alt="appName"
                    class="h-10 w-10 object-contain"
                    @error="hideImage"
                  >
                  <Icon v-else icon="solar:map-point-wave-bold-duotone" class="h-7 w-7" />
                </div>

                <div class="min-w-0">
                  <p class="text-xs font-black uppercase tracking-[0.14em] text-neutral-400">
                    Total Fasilitas
                  </p>
                  <p class="mt-1 text-3xl font-black text-neutral-950">
                    {{ facilities.length }}
                  </p>
                  <p class="mt-1 text-sm font-bold text-neutral-500">
                    {{ activeCount }} aktif · {{ featuredCount }} unggulan
                  </p>
                </div>
              </div>
            </aside>
          </div>
        </div>
      </section>

      <section class="mx-auto max-w-7xl px-4 py-7 sm:px-6 lg:px-8">
        <div class="mb-5 rounded-[2rem] border border-neutral-200 bg-white p-4 shadow-sm">
          <div class="grid gap-3 lg:grid-cols-[1fr_180px_180px]">
            <div class="relative">
              <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-4 text-neutral-400">
                <Icon icon="solar:magnifer-linear" class="h-5 w-5" />
              </div>

              <input
                v-model.trim="q"
                type="text"
                placeholder="Cari fasilitas, alamat, kontak, atau konten..."
                class="input-field py-3 pl-12"
              >
            </div>

            <select v-model="selectedStatus" class="input-field">
              <option value="active">Active</option>
              <option value="all">Semua Status</option>
              <option value="inactive">Inactive</option>
            </select>

            <select v-model="sortBy" class="input-field">
              <option value="sort_order">Urutan</option>
              <option value="title">Title A-Z</option>
              <option value="newest">Terbaru</option>
              <option value="oldest">Terlama</option>
            </select>
          </div>

          <div class="mt-4 flex flex-wrap items-center justify-between gap-3">
            <div class="flex flex-wrap gap-2">
              <button
                v-for="type in quickTypes"
                :key="type.value"
                type="button"
                class="inline-flex items-center gap-2 rounded-2xl border px-3 py-2 text-xs font-black transition"
                :class="selectedType === type.value
                  ? 'border-blue-600 bg-blue-600 text-white shadow-lg shadow-blue-600/20'
                  : 'border-neutral-200 bg-white text-neutral-600 hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700'"
                @click="toggleType(type.value)"
              >
                <Icon :icon="type.icon" class="h-4 w-4" />
                {{ type.label }}
              </button>
            </div>

            <button
              type="button"
              class="inline-flex items-center gap-2 rounded-2xl border border-neutral-200 bg-white px-4 py-2 text-xs font-black text-neutral-600 transition hover:bg-neutral-50"
              @click="resetFilters"
            >
              <Icon icon="solar:restart-bold-duotone" class="h-4 w-4" />
              Reset
            </button>
          </div>

          <p class="mt-3 text-xs font-bold text-neutral-500">
            Menampilkan {{ filteredFacilities.length }} dari {{ facilities.length }} fasilitas.
          </p>
        </div>

        <div v-if="visibleError" class="mb-5 rounded-3xl border border-red-200 bg-red-50 p-4 text-sm font-bold leading-6 text-red-700">
          {{ visibleError }}
        </div>

        <section v-if="pending" class="grid gap-4 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
          <div
            v-for="item in 8"
            :key="item"
            class="h-[20rem] animate-pulse overflow-hidden rounded-[1.75rem] border border-neutral-200 bg-white shadow-sm"
          >
            <div class="h-36 bg-neutral-100"></div>
            <div class="p-4">
              <div class="h-5 w-2/3 rounded-full bg-neutral-100"></div>
              <div class="mt-3 h-3 w-full rounded-full bg-neutral-100"></div>
              <div class="mt-2 h-3 w-4/5 rounded-full bg-neutral-100"></div>
            </div>
          </div>
        </section>

        <section
          v-else-if="filteredFacilities.length === 0"
          class="rounded-[2rem] border border-dashed border-neutral-300 bg-white p-10 text-center shadow-sm"
        >
          <div class="mx-auto grid h-16 w-16 place-items-center rounded-3xl bg-neutral-100 text-neutral-500">
            <Icon icon="solar:map-point-wave-bold-duotone" class="h-8 w-8" />
          </div>

          <h2 class="mt-5 text-xl font-black text-neutral-950">
            Belum ada data fasilitas
          </h2>

          <p class="mx-auto mt-2 max-w-md text-sm font-medium leading-6 text-neutral-500">
            Data fasilitas akan tampil otomatis setelah ditambahkan dari dashboard.
          </p>
        </section>

        <section v-else class="grid gap-4 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
          <NuxtLink
            v-for="item in pagedFacilities"
            :key="item.id"
            :to="detailTo(item.slug)"
            class="group overflow-hidden rounded-[1.75rem] border border-neutral-200 bg-white shadow-sm transition hover:-translate-y-1 hover:border-blue-200 hover:shadow-xl hover:shadow-blue-900/5"
          >
            <div class="relative h-40 overflow-hidden bg-neutral-100">
              <img
                v-if="getFacilityCover(item) && !failedImages[item.id]"
                :src="getFacilityCover(item)"
                :alt="item.title || item.name || 'Fasilitas'"
                class="h-full w-full object-cover transition duration-500 group-hover:scale-105"
                @error="markImageFailed(item.id)"
              >

              <div
                v-else
                class="flex h-full w-full items-center justify-center bg-gradient-to-br from-blue-50 via-white to-cyan-50 text-blue-600"
              >
                <Icon :icon="item.icon || getFacilityTypeIcon(item.facilityType)" class="h-14 w-14" />
              </div>

              <div class="absolute inset-0 bg-gradient-to-t from-neutral-950/55 via-neutral-950/10 to-transparent"></div>

              <div class="absolute left-3 top-3 flex flex-wrap gap-2">
                <span class="inline-flex items-center gap-1.5 rounded-full bg-white/90 px-3 py-1 text-xs font-black text-neutral-800 backdrop-blur">
                  <Icon :icon="getFacilityTypeIcon(item.facilityType)" class="h-3.5 w-3.5 text-blue-600" />
                  {{ facilityTypeLabel(item.facilityType) }}
                </span>

                <span
                  v-if="item.isFeatured"
                  class="rounded-full bg-blue-600 px-3 py-1 text-xs font-black text-white shadow-lg shadow-blue-900/20"
                >
                  Featured
                </span>
              </div>
            </div>

            <div class="p-4">
              <h2 class="line-clamp-2 text-lg font-black leading-7 text-neutral-950 group-hover:text-blue-700">
                {{ item.title || item.name }}
              </h2>

              <p class="mt-2 line-clamp-2 text-sm font-medium leading-6 text-neutral-500">
                {{ item.subtitle || item.shortDescription || contentPreview(item) || 'Informasi fasilitas desa.' }}
              </p>

              <div class="mt-4 flex items-center justify-between gap-3 border-t border-neutral-100 pt-3">
                <span class="inline-flex min-w-0 items-center gap-2 truncate text-xs font-black text-neutral-500">
                  <Icon icon="solar:map-point-bold-duotone" class="h-4 w-4 shrink-0 text-blue-600" />
                  <span class="truncate">{{ item.address || item.slug }}</span>
                </span>

                <span class="grid h-9 w-9 shrink-0 place-items-center rounded-2xl bg-neutral-50 text-neutral-500 transition group-hover:bg-blue-600 group-hover:text-white">
                  <Icon icon="solar:arrow-right-up-linear" class="h-4 w-4" />
                </span>
              </div>
            </div>
          </NuxtLink>
        </section>

        <div v-if="hasMore && !pending" class="mt-8 flex justify-center">
          <button
            type="button"
            class="inline-flex items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-5 py-3 text-sm font-black text-neutral-700 shadow-sm transition hover:bg-neutral-50"
            @click="page += 1"
          >
            <Icon icon="solar:alt-arrow-down-bold-duotone" class="h-5 w-5" />
            Muat Lainnya
          </button>
        </div>
      </section>
    </template>
  </main>
</template>

<script setup lang="ts">
import { Icon } from '@iconify/vue'
import { computed, defineComponent, h, ref, watch } from 'vue'
import { useAppApi } from '~/composables/useAppApi'

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

type FacilityDetailResponse = {
  data: FacilityItem | null
}

const route = useRoute()
const requestUrl = useRequestURL()
const runtime = useRuntimeConfig()
const { tenantApiUrl } = useAppApi()

const q = ref('')
const selectedStatus = ref<FacilityStatus | 'all'>('active')
const selectedType = ref<FacilityType | 'all'>('all')
const sortBy = ref<'newest' | 'oldest' | 'title' | 'sort_order'>('sort_order')
const page = ref(1)
const pageSize = 12

const failedImages = ref<Record<string, boolean>>({})
const relatedFailedImages = ref<Record<string, boolean>>({})
const heroImageFailed = ref(false)
const logoFailed = ref(false)
const fallbackDetail = ref<FacilityItem | null>(null)
const detailPending = ref(false)
const detailFetchError = ref('')

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
    'Desa Martopuro'
  )
})

const appLogo = computed(() => {
  return String(
    runtime.public.appLogo ||
    runtime.public.logoUrl ||
    'https://martopuro.sencra.io/martopuro-logo.png'
  )
})

const detailSlug = computed(() => {
  const raw = route.query.detail || route.query.detai

  return String(Array.isArray(raw) ? raw[0] : raw || '')
    .trim()
    .toLowerCase()
})

const isDetailMode = computed(() => Boolean(detailSlug.value))

const apiUrl = computed(() => {
  return tenantApiUrl(tenantSlug.value, '/facilities')
})

const {
  data,
  pending,
  error,
  refresh
} = await useFetch<FacilityListResponse>(apiUrl, {
  key: computed(() => `facilities-page-${tenantSlug.value}-${selectedStatus.value}-${sortBy.value}`),
  query: computed(() => ({
    status: selectedStatus.value === 'all' ? undefined : selectedStatus.value,
    limit: 100,
    sort: sortBy.value
  })),
  watch: [tenantSlug, selectedStatus, sortBy],
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

const facilities = computed<FacilityItem[]>(() => {
  return data.value?.data || []
})

const activeFacilityFromList = computed(() => {
  if (!detailSlug.value) return null

  return facilities.value.find((item) => {
    return String(item.slug || '').toLowerCase() === detailSlug.value
  }) || null
})

const activeFacility = computed<FacilityItem | null>(() => {
  return activeFacilityFromList.value || fallbackDetail.value
})

const detailLoading = computed(() => {
  return pending.value || detailPending.value
})

const detailError = computed(() => {
  return Boolean(error.value || detailFetchError.value)
})

const visibleError = computed(() => {
  if (!error.value) return ''

  return error.value?.message || 'Terjadi kesalahan saat memuat data fasilitas.'
})

const filteredFacilities = computed(() => {
  const keyword = q.value.trim().toLowerCase()

  return facilities.value
    .filter((item) => {
      const matchType = selectedType.value === 'all' || item.facilityType === selectedType.value

      if (!matchType) return false
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
        facilityTypeLabel(item.facilityType),
        plainText(item.contentHtml || '')
      ]
        .filter(Boolean)
        .join(' ')
        .toLowerCase()
        .includes(keyword)
    })
    .sort((a, b) => sortFacility(a, b))
})

const pagedFacilities = computed(() => {
  return filteredFacilities.value.slice(0, page.value * pageSize)
})

const hasMore = computed(() => {
  return pagedFacilities.value.length < filteredFacilities.value.length
})

const activeCount = computed(() => facilities.value.filter((item) => item.status === 'active').length)
const featuredCount = computed(() => facilities.value.filter((item) => item.isFeatured).length)

const detailImage = computed(() => {
  if (!activeFacility.value) return ''

  return getFacilityCover(activeFacility.value)
})

const galleryImages = computed(() => {
  if (!activeFacility.value) return []

  return getFacilityImages(activeFacility.value)
})

const safeContentHtml = computed(() => {
  return sanitizeHtml(activeFacility.value?.contentHtml || '')
})

const detailFacts = computed(() => {
  if (!activeFacility.value) return []

  return [
    {
      label: 'Kategori',
      value: facilityTypeLabel(activeFacility.value.facilityType)
    },
    {
      label: 'Status',
      value: activeFacility.value.status || '-'
    },
    {
      label: 'Alamat',
      value: activeFacility.value.address || '-'
    },
    {
      label: 'Kontak',
      value: activeFacility.value.whatsapp || activeFacility.value.phone || activeFacility.value.email || '-'
    }
  ]
})

const relatedFacilities = computed(() => {
  const currentId = activeFacility.value?.id
  const currentType = activeFacility.value?.facilityType

  return facilities.value
    .filter((item) => item.id !== currentId)
    .sort((a, b) => {
      const aSameType = currentType && a.facilityType === currentType ? 0 : 1
      const bSameType = currentType && b.facilityType === currentType ? 0 : 1

      if (aSameType !== bSameType) return aSameType - bSameType

      return sortFacility(a, b)
    })
    .slice(0, 3)
})

const whatsappUrl = computed(() => {
  const value = activeFacility.value?.whatsapp || activeFacility.value?.phone || ''
  const number = String(value).replace(/\D/g, '')

  if (!number) return ''

  return `https://wa.me/${number.startsWith('0') ? `62${number.slice(1)}` : number}`
})

const mapsUrl = computed(() => {
  if (!activeFacility.value) return ''

  const lat = activeFacility.value.latitude
  const lng = activeFacility.value.longitude

  if (lat && lng) {
    return `https://www.google.com/maps?q=${encodeURIComponent(`${lat},${lng}`)}`
  }

  if (activeFacility.value.address) {
    return `https://www.google.com/maps/search/?api=1&query=${encodeURIComponent(activeFacility.value.address)}`
  }

  return ''
})

const pageTitle = computed(() => {
  if (isDetailMode.value && activeFacility.value) {
    return `${activeFacility.value.title || activeFacility.value.name} · Fasilitas`
  }

  if (isDetailMode.value) return 'Fasilitas tidak ditemukan'

  return `Fasilitas · ${appName.value}`
})

const pageDescription = computed(() => {
  if (activeFacility.value) {
    return activeFacility.value.subtitle ||
      activeFacility.value.shortDescription ||
      plainText(activeFacility.value.contentHtml || '').slice(0, 160) ||
      'Informasi fasilitas desa.'
  }

  return `Daftar fasilitas publik di ${appName.value}.`
})

const quickTypes = computed(() => {
  const usedTypes = Array.from(new Set(facilities.value.map((item) => item.facilityType).filter(Boolean)))

  const preferred = ['health', 'education', 'religious', 'sport', 'market', 'public_service']
  const ordered = [
    ...preferred.filter((type) => usedTypes.includes(type)),
    ...usedTypes.filter((type) => !preferred.includes(String(type)))
  ].slice(0, 6)

  return ordered.map((type) => ({
    value: type as FacilityType,
    label: facilityTypeLabel(type),
    icon: getFacilityTypeIcon(type)
  }))
})

watch([q, selectedStatus, selectedType, sortBy], () => {
  page.value = 1
})

watch(detailSlug, async () => {
  heroImageFailed.value = false
  logoFailed.value = false
  detailFetchError.value = ''
  fallbackDetail.value = null

  await fetchDetailFallback()
}, {
  immediate: true
})

watch(activeFacilityFromList, async (value) => {
  if (value || !detailSlug.value) return

  await fetchDetailFallback()
})

useSeoMeta({
  title: () => pageTitle.value,
  description: () => pageDescription.value,
  ogTitle: () => pageTitle.value,
  ogDescription: () => pageDescription.value,
  ogImage: () => detailImage.value || undefined,
  robots: 'index, follow'
})

useHead(() => ({
  htmlAttrs: {
    lang: 'id'
  },
  link: [
    {
      rel: 'canonical',
      href: isDetailMode.value
        ? `${requestUrl.origin}/facilities?detail=${encodeURIComponent(detailSlug.value)}`
        : `${requestUrl.origin}/facilities`
    }
  ]
}))

async function fetchDetailFallback() {
  if (!detailSlug.value || activeFacilityFromList.value) return

  detailPending.value = true
  detailFetchError.value = ''

  try {
    const response = await $fetch<FacilityDetailResponse>(
      tenantApiUrl(tenantSlug.value, `/facilities/by-slug/${encodeURIComponent(detailSlug.value)}`)
    )

    fallbackDetail.value = response.data || null
  } catch (err: any) {
    detailFetchError.value = err?.message || 'Gagal memuat detail fasilitas.'
    fallbackDetail.value = null
  } finally {
    detailPending.value = false
  }
}

function sortFacility(a: FacilityItem, b: FacilityItem) {
  if (sortBy.value === 'title') {
    return String(a.title || a.name || '').localeCompare(String(b.title || b.name || ''))
  }

  if (sortBy.value === 'newest') {
    return Number(new Date(b.createdAt || 0)) - Number(new Date(a.createdAt || 0))
  }

  if (sortBy.value === 'oldest') {
    return Number(new Date(a.createdAt || 0)) - Number(new Date(b.createdAt || 0))
  }

  const sortA = Number(a.sortOrder || 0)
  const sortB = Number(b.sortOrder || 0)

  if (sortA !== sortB) return sortA - sortB

  return String(a.title || a.name || '').localeCompare(String(b.title || b.name || ''))
}

function detailTo(slug?: string | null) {
  return `/facilities?detail=${encodeURIComponent(String(slug || '').trim())}`
}

function resetFilters() {
  q.value = ''
  selectedStatus.value = 'active'
  selectedType.value = 'all'
  sortBy.value = 'sort_order'
  page.value = 1
}

function toggleType(type: FacilityType) {
  selectedType.value = selectedType.value === type ? 'all' : type
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

function contentPreview(item: FacilityItem) {
  return plainText(item.contentHtml || '').slice(0, 120)
}

function markImageFailed(id: string) {
  failedImages.value = {
    ...failedImages.value,
    [id]: true
  }
}

function markRelatedImageFailed(id: string) {
  relatedFailedImages.value = {
    ...relatedFailedImages.value,
    [id]: true
  }
}

function hideImage(event: Event) {
  const target = event.target as HTMLImageElement
  target.style.display = 'none'
}

function facilityTypeLabel(type?: FacilityType | null) {
  const map: Record<string, string> = {
    health: 'Kesehatan',
    education: 'Pendidikan',
    religious: 'Keagamaan',
    sport: 'Olahraga',
    market: 'Pasar',
    public_service: 'Layanan Publik',
    transportation: 'Transportasi',
    security: 'Keamanan',
    water: 'Air Bersih',
    tourism: 'Wisata',
    government: 'Pemerintahan',
    community: 'Komunitas',
    custom: 'Fasilitas'
  }

  return map[String(type || 'custom')] || String(type || 'Fasilitas')
}

function getFacilityTypeIcon(type?: FacilityType | null) {
  const map: Record<string, string> = {
    health: 'solar:heart-pulse-bold-duotone',
    education: 'solar:square-academic-cap-2-bold-duotone',
    religious: 'solar:stars-bold-duotone',
    sport: 'solar:football-bold-duotone',
    market: 'solar:shop-bold-duotone',
    public_service: 'solar:buildings-3-bold-duotone',
    transportation: 'solar:bus-bold-duotone',
    security: 'solar:shield-check-bold-duotone',
    water: 'solar:waterdrops-bold-duotone',
    tourism: 'solar:map-point-wave-bold-duotone',
    government: 'solar:buildings-2-bold-duotone',
    community: 'solar:users-group-rounded-bold-duotone',
    custom: 'solar:map-point-wave-bold-duotone'
  }

  return map[String(type || 'custom')] || 'solar:map-point-wave-bold-duotone'
}

function sanitizeHtml(value: string) {
  const html = String(value || '').trim()

  if (!html) return ''

  if (typeof window !== 'undefined') {
    const doc = new DOMParser().parseFromString(html, 'text/html')

    doc.querySelectorAll('script, style, object, embed').forEach((element) => {
      element.remove()
    })

    doc.querySelectorAll('*').forEach((element) => {
      Array.from(element.attributes).forEach((attribute) => {
        const name = attribute.name.toLowerCase()
        const val = attribute.value || ''

        if (name.startsWith('on')) element.removeAttribute(attribute.name)

        if (['href', 'src'].includes(name) && /^javascript:/i.test(val)) {
          element.removeAttribute(attribute.name)
        }
      })
    })

    return doc.body.innerHTML
  }

  return html
    .replace(/<script[\s\S]*?>[\s\S]*?<\/script>/gi, '')
    .replace(/<style[\s\S]*?>[\s\S]*?<\/style>/gi, '')
    .replace(/\son\w+="[^"]*"/gi, '')
    .replace(/\son\w+='[^']*'/gi, '')
    .replace(/javascript:/gi, '')
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

function formatDate(value?: number | string | null) {
  if (!value) return '-'

  const date = new Date(value)

  if (Number.isNaN(date.getTime())) return '-'

  return new Intl.DateTimeFormat('id-ID', {
    day: '2-digit',
    month: 'long',
    year: 'numeric'
  }).format(date)
}

const CompactContact = defineComponent({
  props: {
    icon: {
      type: String,
      required: true
    },
    label: {
      type: String,
      required: true
    },
    value: {
      type: String,
      required: true
    },
    href: {
      type: String,
      default: ''
    }
  },
  setup(props) {
    return () => {
      const children = [
        h(
          'div',
          {
            class:
              'grid h-10 w-10 shrink-0 place-items-center rounded-2xl bg-blue-50 text-blue-700'
          },
          [h(Icon, { icon: props.icon, class: 'h-5 w-5' })]
        ),
        h('div', { class: 'min-w-0 flex-1' }, [
          h(
            'p',
            {
              class:
                'text-xs font-black uppercase tracking-[0.14em] text-neutral-400'
            },
            props.label
          ),
          h(
            'p',
            {
              class:
                'mt-1 truncate text-sm font-bold text-neutral-800'
            },
            props.value
          )
        ])
      ]

      const className =
        'flex items-center gap-3 rounded-2xl border border-neutral-200 bg-neutral-50 p-4 transition hover:bg-white'

      if (props.href) {
        return h(
          'a',
          {
            href: props.href,
            target: props.href.startsWith('http') ? '_blank' : undefined,
            rel: props.href.startsWith('http') ? 'noopener' : undefined,
            class: className
          },
          children
        )
      }

      return h('div', { class: className }, children)
    }
  }
})
</script>

<style scoped>
.bg-grid {
  background-size: 44px 44px;
  background-image:
    linear-gradient(to right, #e5e7eb 1px, transparent 1px),
    linear-gradient(to bottom, #e5e7eb 1px, transparent 1px);
}

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

.facility-content {
  color: #262626;
  font-size: 1rem;
  line-height: 1.8;
}

.facility-content :deep(h2) {
  margin-top: 2rem;
  margin-bottom: 0.75rem;
  font-size: 1.75rem;
  line-height: 1.2;
  font-weight: 900;
  letter-spacing: -0.03em;
  color: #171717;
}

.facility-content :deep(h3) {
  margin-top: 1.5rem;
  margin-bottom: 0.65rem;
  font-size: 1.35rem;
  line-height: 1.3;
  font-weight: 900;
  color: #171717;
}

.facility-content :deep(p) {
  margin: 0.9rem 0;
}

.facility-content :deep(a) {
  color: #2563eb;
  font-weight: 800;
  text-decoration: underline;
  text-underline-offset: 4px;
}

.facility-content :deep(ul),
.facility-content :deep(ol) {
  margin: 1rem 0;
  padding-left: 1.35rem;
}

.facility-content :deep(li) {
  margin: 0.35rem 0;
}

.facility-content :deep(blockquote) {
  margin: 1.25rem 0;
  border-left: 4px solid #2563eb;
  border-radius: 0.75rem;
  background: #fafafa;
  padding: 1rem 1.25rem;
  color: #525252;
}

.facility-content :deep(img) {
  margin: 1.25rem 0;
  max-width: 100%;
  height: auto;
  border-radius: 1.25rem;
  border: 1px solid #e5e5e5;
}

.facility-content :deep(iframe) {
  margin: 1.25rem 0;
  min-height: 420px;
  width: 100%;
  border: 0;
  border-radius: 1.25rem;
  background: #f5f5f5;
}

.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>
