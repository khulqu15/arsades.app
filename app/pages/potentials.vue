<template>
  <main class="min-h-screen overflow-hidden bg-neutral-50 text-neutral-950">
    <div class="pointer-events-none fixed inset-0 -z-10 overflow-hidden">
      <div class="absolute -left-32 top-0 h-[420px] w-[420px] rounded-full bg-emerald-100 blur-3xl"></div>
      <div class="absolute -right-32 top-40 h-[420px] w-[420px] rounded-full bg-lime-100 blur-3xl"></div>
      <div class="absolute bottom-0 left-1/3 h-[360px] w-[360px] rounded-full bg-yellow-100/70 blur-3xl"></div>
      <div class="absolute inset-0 bg-grid opacity-40"></div>
    </div>

    <!-- DETAIL MODE: /potentials?detail=slug -->
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
        v-else-if="detailError || !activePotential"
        class="mx-auto max-w-3xl px-4 pb-14 pt-28 text-center sm:px-6 lg:px-8"
      >
        <div class="rounded-[2rem] border border-red-200 bg-white p-8 shadow-sm">
          <div class="mx-auto grid h-14 w-14 place-items-center rounded-2xl bg-red-50 text-red-600">
            <Icon icon="solar:danger-circle-bold-duotone" class="h-7 w-7" />
          </div>

          <h1 class="mt-5 text-2xl font-black text-neutral-950">
            Potensi tidak ditemukan
          </h1>

          <p class="mx-auto mt-2 max-w-md text-sm font-medium leading-6 text-neutral-500">
            Data potensi belum tersedia, tidak aktif, atau slug pada URL tidak sesuai.
          </p>

          <NuxtLink
            to="/potentials"
            class="mt-6 inline-flex items-center justify-center gap-2 rounded-2xl bg-neutral-900 px-5 py-3 text-sm font-black text-white transition hover:bg-neutral-800"
          >
            <Icon icon="solar:arrow-left-linear" class="h-5 w-5" />
            Kembali ke Potensi
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
              <NuxtLink to="/potentials" class="transition hover:text-neutral-950">
                Potensi
              </NuxtLink>
              <Icon icon="solar:alt-arrow-right-linear" class="h-4 w-4" />
              <span class="max-w-[220px] truncate text-neutral-950 sm:max-w-md">
                {{ activePotential.title }}
              </span>
            </nav>

            <div class="grid gap-6 lg:grid-cols-[1fr_380px] lg:items-stretch">
              <div class="flex min-h-[320px] flex-col justify-end rounded-[2rem] border border-neutral-200 bg-neutral-950 p-5 text-white shadow-sm sm:p-7">
                <div class="absolute inset-0 -z-10"></div>

                <div class="pointer-events-none absolute inset-0 hidden"></div>

                <div class="relative -mx-5 -mt-5 mb-6 h-48 overflow-hidden rounded-t-[2rem] bg-neutral-900 sm:-mx-7 sm:-mt-7 sm:h-60">
                  <img
                    v-if="detailImage && !heroImageFailed"
                    :src="detailImage"
                    :alt="activePotential.title"
                    class="h-full w-full object-cover opacity-80"
                    @error="heroImageFailed = true"
                  >

                  <div
                    v-else
                    class="flex h-full w-full items-center justify-center bg-gradient-to-br from-emerald-950 via-slate-950 to-lime-950"
                  >
                    <Icon
                      :icon="activePotential.icon || getPotentialTypeIcon(activePotential.potentialType)"
                      class="h-24 w-24 text-white/15"
                    />
                  </div>

                  <div class="absolute inset-0 bg-gradient-to-t from-neutral-950 via-neutral-950/35 to-transparent"></div>
                </div>

                <div class="flex flex-wrap items-center gap-2">
                  <span class="inline-flex items-center gap-2 rounded-full border border-white/15 bg-white/10 px-3 py-1.5 text-xs font-black uppercase tracking-[0.14em] text-white backdrop-blur">
                    <Icon :icon="getPotentialTypeIcon(activePotential.potentialType)" class="h-4 w-4" />
                    {{ potentialTypeLabel(activePotential.potentialType) }}
                  </span>

                  <span
                    class="rounded-full px-3 py-1.5 text-xs font-black backdrop-blur"
                    :class="activePotential.status === 'active'
                      ? 'bg-emerald-400/15 text-emerald-200'
                      : 'bg-white/10 text-white/70'"
                  >
                    {{ activePotential.status }}
                  </span>

                  <span
                    v-if="activePotential.isFeatured"
                    class="rounded-full bg-emerald-600 px-3 py-1.5 text-xs font-black text-white shadow-lg shadow-emerald-900/20"
                  >
                    Featured
                  </span>
                </div>

                <h1 class="mt-4 max-w-4xl text-3xl font-black leading-tight tracking-tight text-white sm:text-5xl">
                  {{ activePotential.title }}
                </h1>

                <p
                  v-if="activePotential.subtitle"
                  class="mt-4 max-w-3xl text-sm font-medium leading-7 text-white/75 sm:text-base"
                >
                  {{ activePotential.subtitle }}
                </p>

                <div class="mt-6 flex flex-wrap gap-3">
                  <a
                    v-if="whatsappUrl"
                    :href="whatsappUrl"
                    target="_blank"
                    rel="noopener"
                    class="inline-flex items-center justify-center gap-2 rounded-2xl bg-white px-5 py-3 text-sm font-black text-neutral-950 transition hover:-translate-y-0.5 hover:bg-emerald-50"
                  >
                    <Icon icon="solar:chat-round-call-bold-duotone" class="h-5 w-5 text-emerald-600" />
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
                    v-if="activePotential.websiteUrl"
                    :href="activePotential.websiteUrl"
                    target="_blank"
                    rel="noopener"
                    class="inline-flex items-center justify-center gap-2 rounded-2xl border border-white/20 bg-white/10 px-5 py-3 text-sm font-black text-white backdrop-blur transition hover:-translate-y-0.5 hover:bg-white/15"
                  >
                    <Icon icon="solar:global-bold-duotone" class="h-5 w-5" />
                    Website
                  </a>

                  <NuxtLink
                    to="/potentials"
                    class="inline-flex items-center justify-center gap-2 rounded-2xl border border-white/20 bg-white/10 px-5 py-3 text-sm font-black text-white backdrop-blur transition hover:-translate-y-0.5 hover:bg-white/15"
                  >
                    <Icon icon="solar:arrow-left-linear" class="h-5 w-5" />
                    Semua Potensi
                  </NuxtLink>
                </div>
              </div>

              <aside class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm">
                <div class="flex items-start gap-4">
                  <div class="grid h-14 w-14 shrink-0 place-items-center overflow-hidden rounded-2xl bg-emerald-50 text-emerald-700">
                    <img
                      v-if="activePotential.logoUrl && !logoFailed"
                      :src="activePotential.logoUrl"
                      :alt="activePotential.title"
                      class="h-full w-full object-cover"
                      @error="logoFailed = true"
                    >
                    <Icon
                      v-else
                      :icon="activePotential.icon || getPotentialTypeIcon(activePotential.potentialType)"
                      class="h-7 w-7"
                    />
                  </div>

                  <div class="min-w-0">
                    <p class="text-xs font-black uppercase tracking-[0.14em] text-neutral-400">
                      Ringkasan
                    </p>
                    <p class="mt-1 truncate text-base font-black text-neutral-950">
                      {{ activePotential.slug }}
                    </p>
                    <p class="mt-1 text-xs font-bold text-neutral-500">
                      Update {{ formatDate(activePotential.updatedAt) }}
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

        <section class="mx-auto grid max-w-7xl gap-5 px-4 py-8 sm:px-6 lg:grid-cols-[1fr_320px] lg:px-8">
          <article class="overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-sm">
            <div class="border-b border-neutral-200 px-5 py-4 sm:px-6">
              <div class="flex items-center gap-3">
                <div class="grid h-10 w-10 place-items-center rounded-2xl bg-emerald-50 text-emerald-700">
                  <Icon icon="solar:document-text-bold-duotone" class="h-5 w-5" />
                </div>

                <div>
                  <p class="text-sm font-black text-neutral-950">
                    Detail Potensi
                  </p>
                  <p class="text-xs font-semibold text-neutral-500">
                    Informasi utama tanpa duplikasi tampilan
                  </p>
                </div>
              </div>
            </div>

            <div class="px-5 py-6 sm:px-6">
              <div
                v-if="safeContentHtml"
                class="potential-content"
                v-html="safeContentHtml"
              ></div>

              <div
                v-else
                class="rounded-3xl border border-dashed border-neutral-300 bg-neutral-50 p-8 text-center"
              >
                <Icon icon="solar:document-bold-duotone" class="mx-auto h-10 w-10 text-neutral-400" />
                <p class="mt-3 text-sm font-bold text-neutral-500">
                  Belum ada konten detail untuk potensi ini.
                </p>
              </div>
            </div>
          </article>

          <aside class="space-y-4">
            <section class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm">
              <p class="text-sm font-black text-neutral-950">
                Kontak & Lokasi
              </p>

              <div class="mt-4 space-y-3">
                <a
                  v-if="activePotential.phone"
                  :href="`tel:${activePotential.phone}`"
                  class="contact-row"
                >
                  <Icon icon="solar:phone-bold-duotone" class="h-5 w-5 text-emerald-600" />
                  <span class="truncate">{{ activePotential.phone }}</span>
                </a>

                <a
                  v-if="activePotential.email"
                  :href="`mailto:${activePotential.email}`"
                  class="contact-row"
                >
                  <Icon icon="solar:letter-bold-duotone" class="h-5 w-5 text-emerald-600" />
                  <span class="truncate">{{ activePotential.email }}</span>
                </a>

                <a
                  v-if="activePotential.websiteUrl"
                  :href="activePotential.websiteUrl"
                  target="_blank"
                  rel="noopener"
                  class="contact-row"
                >
                  <Icon icon="solar:global-bold-duotone" class="h-5 w-5 text-emerald-600" />
                  <span class="truncate">{{ activePotential.websiteUrl }}</span>
                </a>

                <div
                  v-if="activePotential.address"
                  class="rounded-2xl bg-neutral-50 p-4"
                >
                  <p class="text-xs font-black uppercase tracking-[0.14em] text-neutral-400">
                    Alamat
                  </p>
                  <p class="mt-1 text-sm font-bold leading-6 text-neutral-700">
                    {{ activePotential.address }}
                  </p>
                </div>

                <div
                  v-if="!activePotential.phone && !activePotential.email && !activePotential.websiteUrl && !activePotential.address"
                  class="rounded-2xl border border-dashed border-neutral-300 bg-neutral-50 p-5 text-center"
                >
                  <Icon icon="solar:phone-bold-duotone" class="mx-auto h-8 w-8 text-neutral-400" />
                  <p class="mt-2 text-sm font-bold text-neutral-500">
                    Kontak belum tersedia.
                  </p>
                </div>
              </div>
            </section>

            <section
              v-if="relatedPotentials.length"
              class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm"
            >
              <div class="flex items-center justify-between gap-3">
                <p class="text-sm font-black text-neutral-950">
                  Terkait
                </p>
                <NuxtLink to="/potentials" class="text-xs font-black text-emerald-700 hover:underline">
                  Semua
                </NuxtLink>
              </div>

              <div class="mt-4 space-y-3">
                <NuxtLink
                  v-for="item in relatedPotentials"
                  :key="item.id"
                  :to="potentialDetailTo(item.slug)"
                  class="flex items-center gap-3 rounded-2xl border border-neutral-200 bg-neutral-50 p-3 transition hover:border-emerald-200 hover:bg-emerald-50"
                >
                  <div class="grid h-11 w-11 shrink-0 place-items-center overflow-hidden rounded-xl bg-white text-emerald-700">
                    <img
                      v-if="getPotentialImage(item) && !failedImages[item.id]"
                      :src="getPotentialImage(item)"
                      :alt="item.title"
                      class="h-full w-full object-cover"
                      @error="markImageFailed(item.id)"
                    >
                    <Icon v-else :icon="item.icon || getPotentialTypeIcon(item.potentialType)" class="h-5 w-5" />
                  </div>

                  <div class="min-w-0">
                    <p class="truncate text-sm font-black text-neutral-950">
                      {{ item.title }}
                    </p>
                    <p class="truncate text-xs font-bold text-neutral-500">
                      {{ potentialTypeLabel(item.potentialType) }}
                    </p>
                  </div>
                </NuxtLink>
              </div>
            </section>
          </aside>
        </section>
      </template>
    </template>

    <!-- LIST MODE: /potentials -->
    <template v-else>
      <section class="border-b border-neutral-200 bg-white/80 pt-28 backdrop-blur-xl">
        <div class="mx-auto max-w-7xl px-4 pb-8 sm:px-6 lg:px-8">
          <nav class="mb-6 flex flex-wrap items-center gap-2 text-sm font-bold text-neutral-500">
            <NuxtLink to="/" class="transition hover:text-neutral-950">
              Beranda
            </NuxtLink>
            <Icon icon="solar:alt-arrow-right-linear" class="h-4 w-4" />
            <span class="text-neutral-950">Potensi</span>
          </nav>

          <div class="grid gap-6 lg:grid-cols-[1fr_360px] lg:items-end">
            <div>
              <div class="mb-4 inline-flex items-center gap-2 rounded-full bg-emerald-50 px-3 py-1.5 text-xs font-black uppercase tracking-[0.14em] text-emerald-700">
                <Icon icon="solar:leaf-bold-duotone" class="h-4 w-4" />
                Potensi Desa
              </div>

              <h1 class="max-w-4xl text-4xl font-black leading-[1.05] tracking-tight text-neutral-950 sm:text-5xl lg:text-6xl">
                Potensi Unggulan
                <span class="block bg-gradient-to-r from-emerald-600 via-lime-500 to-yellow-500 bg-clip-text text-transparent sm:inline">
                  {{ appName }}
                </span>
              </h1>

              <p class="mt-5 max-w-3xl text-base font-semibold leading-8 text-neutral-600">
                Ringkasan potensi lokal desa dalam tampilan compact: kategori, lokasi, nilai, kontak, dan detail utama.
              </p>
            </div>

            <aside class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm">
              <div class="flex items-start gap-4">
                <div class="grid h-14 w-14 shrink-0 place-items-center rounded-2xl bg-emerald-50 text-emerald-700">
                  <Icon icon="solar:leaf-bold-duotone" class="h-7 w-7" />
                </div>

                <div class="min-w-0">
                  <p class="text-xs font-black uppercase tracking-[0.14em] text-neutral-400">
                    Total Potensi
                  </p>
                  <p class="mt-1 text-3xl font-black text-neutral-950">
                    {{ potentials.length }}
                  </p>
                  <p class="mt-1 text-xs font-bold text-neutral-500">
                    Tenant {{ tenantSlug }}
                  </p>
                </div>
              </div>

              <div class="mt-5 grid grid-cols-3 gap-2">
                <div class="rounded-2xl bg-neutral-50 p-3">
                  <p class="text-[10px] font-black uppercase tracking-[0.12em] text-neutral-400">
                    Featured
                  </p>
                  <p class="mt-1 text-lg font-black text-neutral-950">
                    {{ featuredCount }}
                  </p>
                </div>

                <div class="rounded-2xl bg-neutral-50 p-3">
                  <p class="text-[10px] font-black uppercase tracking-[0.12em] text-neutral-400">
                    Kategori
                  </p>
                  <p class="mt-1 text-lg font-black text-neutral-950">
                    {{ categoryCount }}
                  </p>
                </div>

                <div class="rounded-2xl bg-neutral-50 p-3">
                  <p class="text-[10px] font-black uppercase tracking-[0.12em] text-neutral-400">
                    Gambar
                  </p>
                  <p class="mt-1 text-lg font-black text-neutral-950">
                    {{ withImageCount }}
                  </p>
                </div>
              </div>
            </aside>
          </div>
        </div>
      </section>

      <section class="mx-auto max-w-7xl px-4 py-7 sm:px-6 lg:px-8">
        <div class="mb-5 rounded-[2rem] border border-neutral-200 bg-white p-4 shadow-sm">
          <div class="grid gap-3 lg:grid-cols-[1fr_210px_170px_170px]">
            <div class="relative">
              <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-4 text-neutral-400">
                <Icon icon="solar:magnifer-linear" class="h-5 w-5" />
              </div>

              <input
                v-model.trim="q"
                type="text"
                placeholder="Cari potensi, owner, lokasi, pasar, atau deskripsi..."
                class="input-field py-3 pl-12"
              >
            </div>

            <select v-model="selectedType" class="input-field">
              <option value="all">Semua Tipe</option>
              <option
                v-for="type in potentialTypeOptions"
                :key="type.value"
                :value="type.value"
              >
                {{ type.label }}
              </option>
            </select>

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
            <p class="text-xs font-bold text-neutral-500">
              Menampilkan {{ filteredPotentials.length }} dari {{ potentials.length }} potensi.
            </p>

            <button
              type="button"
              class="inline-flex items-center gap-2 rounded-2xl border border-neutral-200 bg-white px-4 py-2 text-xs font-black text-neutral-600 transition hover:bg-neutral-50"
              @click="resetFilters"
            >
              <Icon icon="solar:restart-bold-duotone" class="h-4 w-4" />
              Reset Filter
            </button>
          </div>
        </div>

        <div
          v-if="visibleError"
          class="mb-5 rounded-3xl border border-red-200 bg-red-50 p-4 text-sm font-bold leading-6 text-red-700"
        >
          {{ visibleError }}
        </div>

        <section
          v-if="listPending"
          class="grid gap-4 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4"
        >
          <div
            v-for="item in 8"
            :key="item"
            class="h-[22rem] animate-pulse overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-sm"
          >
            <div class="h-40 bg-neutral-100"></div>
            <div class="p-5">
              <div class="h-5 w-2/3 rounded-full bg-neutral-100"></div>
              <div class="mt-3 h-3 w-full rounded-full bg-neutral-100"></div>
              <div class="mt-2 h-3 w-4/5 rounded-full bg-neutral-100"></div>
            </div>
          </div>
        </section>

        <section
          v-else-if="filteredPotentials.length === 0"
          class="rounded-[2rem] border border-dashed border-neutral-300 bg-white p-10 text-center shadow-sm"
        >
          <div class="mx-auto grid h-16 w-16 place-items-center rounded-3xl bg-neutral-100 text-neutral-500">
            <Icon icon="solar:leaf-bold-duotone" class="h-8 w-8" />
          </div>

          <h2 class="mt-5 text-xl font-black text-neutral-950">
            Belum ada data potensi
          </h2>

          <p class="mx-auto mt-2 max-w-md text-sm font-medium leading-6 text-neutral-500">
            Data potensi akan tampil otomatis setelah ditambahkan dari dashboard potensi.
          </p>
        </section>

        <section
          v-else
          class="grid gap-4 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4"
        >
          <NuxtLink
            v-for="item in pagedPotentials"
            :key="item.id"
            :to="potentialDetailTo(item.slug)"
            class="group overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-sm transition hover:-translate-y-1 hover:border-emerald-200 hover:shadow-xl hover:shadow-emerald-900/5"
          >
            <div class="relative h-40 overflow-hidden bg-neutral-100">
              <img
                v-if="getPotentialImage(item) && !failedImages[item.id]"
                :src="getPotentialImage(item)"
                :alt="item.title"
                class="h-full w-full object-cover transition duration-500 group-hover:scale-105"
                @error="markImageFailed(item.id)"
              >

              <div
                v-else
                class="flex h-full w-full items-center justify-center bg-gradient-to-br from-emerald-50 via-white to-lime-50 text-emerald-600"
              >
                <Icon :icon="item.icon || getPotentialTypeIcon(item.potentialType)" class="h-14 w-14" />
              </div>

              <div class="absolute inset-0 bg-gradient-to-t from-neutral-950/50 via-neutral-950/10 to-transparent"></div>

              <div class="absolute left-3 top-3 flex flex-wrap gap-2">
                <span class="inline-flex items-center gap-1.5 rounded-full bg-white/90 px-3 py-1 text-xs font-black text-neutral-800 backdrop-blur">
                  <Icon :icon="getPotentialTypeIcon(item.potentialType)" class="h-3.5 w-3.5 text-emerald-600" />
                  {{ potentialTypeLabel(item.potentialType) }}
                </span>

                <span
                  v-if="item.isFeatured"
                  class="rounded-full bg-emerald-600 px-3 py-1 text-xs font-black text-white shadow-lg shadow-emerald-900/20"
                >
                  Featured
                </span>
              </div>
            </div>

            <div class="p-5">
              <h2 class="line-clamp-2 text-lg font-black leading-7 text-neutral-950 group-hover:text-emerald-700">
                {{ item.title }}
              </h2>

              <p class="mt-2 line-clamp-2 text-sm font-medium leading-6 text-neutral-500">
                {{ item.subtitle || plainText(item.contentHtml || '').slice(0, 110) || 'Informasi potensi desa.' }}
              </p>

              <div class="mt-4 grid gap-2 border-t border-neutral-100 pt-4 text-xs font-bold text-neutral-500">
                <div v-if="item.ownerName" class="flex items-center gap-2 truncate">
                  <Icon icon="solar:user-rounded-bold-duotone" class="h-4 w-4 shrink-0 text-emerald-600" />
                  <span class="truncate">{{ item.ownerName }}</span>
                </div>

                <div v-if="item.marketReach" class="flex items-center gap-2 truncate">
                  <Icon icon="solar:shop-bold-duotone" class="h-4 w-4 shrink-0 text-emerald-600" />
                  <span class="truncate">{{ item.marketReach }}</span>
                </div>

                <div class="flex items-center justify-between gap-3 pt-1">
                  <span class="truncate">{{ item.slug }}</span>
                  <span class="grid h-9 w-9 shrink-0 place-items-center rounded-2xl bg-neutral-50 text-neutral-500 transition group-hover:bg-emerald-600 group-hover:text-white">
                    <Icon icon="solar:arrow-right-up-linear" class="h-4 w-4" />
                  </span>
                </div>
              </div>
            </div>
          </NuxtLink>
        </section>

        <div v-if="hasMore && !listPending" class="mt-8 flex justify-center">
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
import { computed, ref, watch } from 'vue'
import { useAppApi } from '~/composables/useAppApi'
import type {
  PotentialDetailResponse,
  PotentialItem,
  PotentialListResponse,
  PotentialType
} from '~/types/potential'

type PotentialStatus = 'active' | 'inactive'
type SortBy = 'newest' | 'oldest' | 'title' | 'sort_order'
type SelectStatus = PotentialStatus | 'all'
type SelectType = PotentialType | 'all'

const route = useRoute()
const requestUrl = useRequestURL()
const runtime = useRuntimeConfig()
const { tenantApiUrl } = useAppApi()

const q = ref('')
const selectedType = ref<SelectType>('all')
const selectedStatus = ref<SelectStatus>('active')
const sortBy = ref<SortBy>('sort_order')
const page = ref(1)
const pageSize = 12

const heroImageFailed = ref(false)
const logoFailed = ref(false)
const failedImages = ref<Record<string, boolean>>({})

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

const detailSlug = computed(() => {
  const value = route.query.detail || route.query.detai
  const raw = Array.isArray(value) ? value[0] : value

  return String(raw || '')
    .trim()
    .toLowerCase()
})

const isDetailMode = computed(() => Boolean(detailSlug.value))

const listApiUrl = computed(() => {
  return tenantApiUrl(tenantSlug.value, '/potentials')
})

const {
  data: listResponse,
  pending: listPending,
  error: listError,
  refresh
} = await useFetch<PotentialListResponse>(listApiUrl, {
  key: computed(() => `tenant-potentials-${tenantSlug.value}-${isDetailMode.value ? 'detail' : 'list'}`),
  query: computed(() => ({
    q: !isDetailMode.value && q.value ? q.value : undefined,
    type: !isDetailMode.value && selectedType.value !== 'all' ? selectedType.value : undefined,
    status: isDetailMode.value
      ? 'active'
      : selectedStatus.value === 'all'
        ? undefined
        : selectedStatus.value,
    limit: 100,
    sort: isDetailMode.value ? 'sort_order' : sortBy.value
  })),
  watch: [tenantSlug, isDetailMode, q, selectedType, selectedStatus, sortBy],
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

const potentials = computed<PotentialItem[]>(() => {
  return listResponse.value?.data || []
})

const potentialFromList = computed(() => {
  if (!detailSlug.value) return null

  return potentials.value.find((item) => {
    return String(item.slug || '').toLowerCase() === detailSlug.value
  }) || null
})

const detailApiUrl = computed(() => {
  return tenantApiUrl(tenantSlug.value, `/potentials/by-slug/${encodeURIComponent(detailSlug.value)}`)
})

const {
  data: detailResponse,
  pending: remoteDetailPending,
  error: remoteDetailError
} = await useAsyncData<PotentialDetailResponse>(
  'potential-detail-by-query',
  async () => {
    if (!detailSlug.value) {
      return { data: null as any }
    }

    if (potentialFromList.value?.contentHtml) {
      return { data: potentialFromList.value }
    }

    try {
      return await $fetch<PotentialDetailResponse>(detailApiUrl.value)
    } catch {
      return {
        data: (potentialFromList.value || null) as any
      }
    }
  },
  {
    watch: [tenantSlug, detailSlug, potentialFromList],
    default: () => ({
      data: null as any
    })
  }
)

const activePotential = computed<PotentialItem | null>(() => {
  return detailResponse.value?.data || potentialFromList.value || null
})

const detailLoading = computed(() => {
  return isDetailMode.value && (listPending.value || remoteDetailPending.value)
})

const detailError = computed(() => {
  if (!isDetailMode.value) return null
  if (remoteDetailError.value && !activePotential.value) return remoteDetailError.value
  return null
})

const visibleError = computed(() => {
  if (!listError.value) return ''
  return listError.value?.message || 'Terjadi kesalahan saat memuat data potensi.'
})

const filteredPotentials = computed(() => {
  const keyword = q.value.trim().toLowerCase()

  return potentials.value
    .filter((item) => {
      if (selectedStatus.value !== 'all' && item.status !== selectedStatus.value) return false
      if (selectedType.value !== 'all' && item.potentialType !== selectedType.value) return false

      if (!keyword) return true

      return [
        item.title,
        item.subtitle,
        item.slug,
        item.ownerName,
        item.managerName,
        item.marketReach,
        item.productionUnit,
        item.address,
        item.phone,
        item.whatsapp,
        item.email,
        plainText(item.contentHtml || '')
      ]
        .filter(Boolean)
        .join(' ')
        .toLowerCase()
        .includes(keyword)
    })
    .sort((a, b) => sortPotentials(a, b))
})

const pagedPotentials = computed(() => {
  return filteredPotentials.value.slice(0, page.value * pageSize)
})

const hasMore = computed(() => {
  return pagedPotentials.value.length < filteredPotentials.value.length
})

const featuredCount = computed(() => {
  return potentials.value.filter((item) => item.isFeatured).length
})

const categoryCount = computed(() => {
  return new Set(potentials.value.map((item) => item.potentialType)).size
})

const withImageCount = computed(() => {
  return potentials.value.filter((item) => getPotentialImage(item)).length
})

const detailImage = computed(() => {
  if (!activePotential.value) return ''
  return getPotentialImage(activePotential.value)
})

const safeContentHtml = computed(() => {
  return sanitizeHtml(activePotential.value?.contentHtml || '')
})

const whatsappUrl = computed(() => {
  const value = activePotential.value?.whatsapp || activePotential.value?.phone || ''
  const number = String(value).replace(/\D/g, '')

  if (!number) return ''

  return `https://wa.me/${number.startsWith('0') ? `62${number.slice(1)}` : number}`
})

const mapsUrl = computed(() => {
  if (!activePotential.value) return ''

  if (activePotential.value.latitude && activePotential.value.longitude) {
    return `https://www.google.com/maps/search/?api=1&query=${activePotential.value.latitude},${activePotential.value.longitude}`
  }

  if (activePotential.value.address) {
    return `https://www.google.com/maps/search/?api=1&query=${encodeURIComponent(activePotential.value.address)}`
  }

  return ''
})

const detailFacts = computed(() => {
  if (!activePotential.value) return []

  const item = activePotential.value

  return [
    {
      label: 'Kategori',
      value: potentialTypeLabel(item.potentialType)
    },
    {
      label: 'Pemilik',
      value: item.ownerName || item.managerName || '-'
    },
    {
      label: 'Kapasitas',
      value: item.productionCapacity || item.productionUnit
        ? `${item.productionCapacity || '-'} ${item.productionUnit || ''}`.trim()
        : '-'
    },
    {
      label: 'Pasar',
      value: item.marketReach || '-'
    },
    {
      label: 'Estimasi Nilai',
      value: formatCurrency(item.estimatedValue)
    }
  ].filter((row) => row.value && row.value !== '-')
})

const relatedPotentials = computed(() => {
  if (!activePotential.value) return []

  return potentials.value
    .filter((item) => item.id !== activePotential.value?.id)
    .filter((item) => item.status === 'active')
    .sort((a, b) => {
      if (a.potentialType === activePotential.value?.potentialType && b.potentialType !== activePotential.value?.potentialType) return -1
      if (a.potentialType !== activePotential.value?.potentialType && b.potentialType === activePotential.value?.potentialType) return 1
      return sortPotentials(a, b)
    })
    .slice(0, 4)
})

const pageTitle = computed(() => {
  if (isDetailMode.value) {
    return activePotential.value
      ? `${activePotential.value.title} · Potensi Desa`
      : 'Potensi tidak ditemukan'
  }

  return `Potensi · ${appName.value}`
})

const pageDescription = computed(() => {
  if (isDetailMode.value && activePotential.value) {
    return activePotential.value.subtitle ||
      plainText(activePotential.value.contentHtml || '').slice(0, 160) ||
      'Informasi potensi desa.'
  }

  return `Daftar potensi unggulan, UMKM, wisata, budaya, pertanian, dan ekonomi lokal di ${appName.value}.`
})

watch([q, selectedType, selectedStatus, sortBy], () => {
  page.value = 1
})

watch(detailSlug, () => {
  heroImageFailed.value = false
  logoFailed.value = false
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
      href: detailSlug.value
        ? `${requestUrl.origin}/potentials?detail=${encodeURIComponent(detailSlug.value)}`
        : `${requestUrl.origin}/potentials`
    }
  ]
}))

const potentialTypeOptions: {
  value: PotentialType
  label: string
  icon: string
}[] = [
  { value: 'agriculture', label: 'Pertanian', icon: 'lucide:wheat' },
  { value: 'livestock', label: 'Peternakan', icon: 'lucide:cow' },
  { value: 'fishery', label: 'Perikanan', icon: 'lucide:fish' },
  { value: 'umkm', label: 'UMKM', icon: 'lucide:store' },
  { value: 'tourism', label: 'Wisata', icon: 'lucide:map-pin' },
  { value: 'culture', label: 'Budaya', icon: 'lucide:landmark' },
  { value: 'natural_resource', label: 'SDA', icon: 'lucide:mountain' },
  { value: 'human_resource', label: 'SDM', icon: 'lucide:users' },
  { value: 'industry', label: 'Industri', icon: 'lucide:factory' },
  { value: 'creative_economy', label: 'Ekonomi Kreatif', icon: 'lucide:palette' },
  { value: 'food', label: 'Kuliner', icon: 'lucide:utensils' },
  { value: 'craft', label: 'Kerajinan', icon: 'lucide:gem' },
  { value: 'custom', label: 'Potensi', icon: 'lucide:layers' }
]

function potentialDetailTo(slug: string) {
  return {
    path: '/potentials',
    query: {
      detail: slug
    }
  }
}

function resetFilters() {
  q.value = ''
  selectedType.value = 'all'
  selectedStatus.value = 'active'
  sortBy.value = 'sort_order'
  page.value = 1
  refresh()
}

function sortPotentials(a: PotentialItem, b: PotentialItem) {
  if (sortBy.value === 'title') {
    return String(a.title || '').localeCompare(String(b.title || ''))
  }

  if (sortBy.value === 'newest') {
    return normalizeDateNumber(b.createdAt) - normalizeDateNumber(a.createdAt)
  }

  if (sortBy.value === 'oldest') {
    return normalizeDateNumber(a.createdAt) - normalizeDateNumber(b.createdAt)
  }

  const sortA = Number(a.sortOrder || 0)
  const sortB = Number(b.sortOrder || 0)

  if (sortA !== sortB) return sortA - sortB

  return String(a.title || '').localeCompare(String(b.title || ''))
}

function getPotentialTypeIcon(type: PotentialType) {
  const match = potentialTypeOptions.find((item) => item.value === type)
  return match?.icon || 'lucide:layers'
}

function potentialTypeLabel(type: PotentialType) {
  const match = potentialTypeOptions.find((item) => item.value === type)
  return match?.label || 'Potensi'
}

function getPotentialImage(item: PotentialItem) {
  const metadataImages = Array.isArray(item.metadata?.images)
    ? item.metadata.images
    : []

  const images = [
    item.imageUrl,
    ...metadataImages,
    item.logoUrl
  ]
    .map((value) => String(value || '').trim())
    .filter(Boolean)

  return Array.from(new Set(images))[0] || ''
}

function markImageFailed(id: string) {
  failedImages.value = {
    ...failedImages.value,
    [id]: true
  }
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
        if (['href', 'src'].includes(name) && /^javascript:/i.test(val)) element.removeAttribute(attribute.name)
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

function normalizeDateNumber(value?: number | string | null) {
  const parsed = Number(value || 0)

  if (!parsed) return 0
  if (parsed < 10000000000) return parsed * 1000

  return parsed
}

function formatDate(value?: number | string | null) {
  const timestamp = normalizeDateNumber(value)

  if (!timestamp) return '-'

  return new Intl.DateTimeFormat('id-ID', {
    day: '2-digit',
    month: 'long',
    year: 'numeric'
  }).format(new Date(timestamp))
}

function formatCurrency(value?: number | null) {
  if (value === null || typeof value === 'undefined') return '-'

  return new Intl.NumberFormat('id-ID', {
    style: 'currency',
    currency: 'IDR',
    maximumFractionDigits: 0
  }).format(value)
}
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
  border-color: rgb(5 150 105);
  background: white;
  box-shadow: 0 0 0 4px rgb(209 250 229);
}

.contact-row {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  border-radius: 1rem;
  border: 1px solid rgb(229 229 229);
  background: rgb(250 250 250);
  padding: 0.875rem 1rem;
  font-size: 0.875rem;
  font-weight: 800;
  color: rgb(64 64 64);
  transition: 160ms ease;
}

.contact-row:hover {
  border-color: rgb(167 243 208);
  background: rgb(236 253 245);
  color: rgb(4 120 87);
}

.potential-content {
  color: #262626;
  font-size: 1rem;
  line-height: 1.8;
}

.potential-content :deep(h2) {
  margin-top: 2rem;
  margin-bottom: 0.75rem;
  font-size: 1.75rem;
  line-height: 1.2;
  font-weight: 900;
  letter-spacing: -0.03em;
  color: #171717;
}

.potential-content :deep(h3) {
  margin-top: 1.5rem;
  margin-bottom: 0.65rem;
  font-size: 1.35rem;
  line-height: 1.3;
  font-weight: 900;
  color: #171717;
}

.potential-content :deep(p) {
  margin: 0.9rem 0;
}

.potential-content :deep(a) {
  color: #059669;
  font-weight: 800;
  text-decoration: underline;
  text-underline-offset: 4px;
}

.potential-content :deep(ul),
.potential-content :deep(ol) {
  margin: 1rem 0;
  padding-left: 1.35rem;
}

.potential-content :deep(li) {
  margin: 0.35rem 0;
}

.potential-content :deep(blockquote) {
  margin: 1.25rem 0;
  border-left: 4px solid #059669;
  border-radius: 0.75rem;
  background: #fafafa;
  padding: 1rem 1.25rem;
  color: #525252;
}

.potential-content :deep(img) {
  margin: 1.25rem 0;
  max-width: 100%;
  height: auto;
  border-radius: 1.25rem;
  border: 1px solid #e5e5e5;
}

.potential-content :deep(iframe) {
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
