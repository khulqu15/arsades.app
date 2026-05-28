<template>
  <main class="min-h-screen overflow-hidden bg-neutral-50 text-neutral-950">
    <div class="pointer-events-none fixed inset-0 -z-10 overflow-hidden">
      <div class="absolute -left-40 top-0 h-[520px] w-[520px] rounded-full bg-blue-100 blur-3xl"></div>
      <div class="absolute -right-40 top-32 h-[520px] w-[520px] rounded-full bg-cyan-100 blur-3xl"></div>
      <div class="absolute bottom-0 left-1/3 h-[420px] w-[420px] rounded-full bg-emerald-100/60 blur-3xl"></div>
      <div class="absolute inset-0 bg-grid opacity-40"></div>
    </div>

    <template v-if="isDetailMode">
      <section v-if="pendingDetail" class="mx-auto max-w-7xl px-4 pb-16 pt-32 sm:px-6 lg:px-8">
        <div class="animate-pulse overflow-hidden rounded-[2.5rem] border border-neutral-200 bg-white shadow-sm">
          <div class="h-72 bg-neutral-100"></div>
          <div class="space-y-4 p-6">
            <div class="h-8 w-2/3 rounded-full bg-neutral-100"></div>
            <div class="h-4 w-full rounded-full bg-neutral-100"></div>
            <div class="h-4 w-4/5 rounded-full bg-neutral-100"></div>
          </div>
        </div>
      </section>

      <section
        v-else-if="!organization"
        class="mx-auto max-w-3xl px-4 pb-16 pt-32 text-center sm:px-6 lg:px-8"
      >
        <div class="rounded-[2rem] border border-neutral-200 bg-white p-10 shadow-sm">
          <div class="mx-auto grid h-16 w-16 place-items-center rounded-3xl bg-red-50 text-red-600">
            <Icon icon="solar:danger-triangle-bold-duotone" class="h-8 w-8" />
          </div>

          <h1 class="mt-5 text-3xl font-black tracking-tight text-neutral-950">
            Organisasi tidak ditemukan
          </h1>

          <p class="mx-auto mt-3 max-w-md text-sm font-semibold leading-6 text-neutral-500">
            Data organisasi dengan slug <span class="font-black text-neutral-800">{{ detailSlug }}</span> belum tersedia atau sudah tidak aktif.
          </p>

          <p
            v-if="visibleDetailError"
            class="mx-auto mt-4 max-w-md rounded-2xl bg-red-50 px-4 py-3 text-xs font-bold leading-5 text-red-700"
          >
            {{ visibleDetailError }}
          </p>

          <NuxtLink
            to="/organizations"
            class="mt-6 inline-flex items-center justify-center gap-2 rounded-2xl bg-neutral-900 px-5 py-3 text-sm font-black text-white transition hover:bg-neutral-800"
          >
            <Icon icon="solar:arrow-left-linear" class="h-5 w-5" />
            Kembali ke Organisasi
          </NuxtLink>
        </div>
      </section>

      <template v-else>
        <section class="relative overflow-hidden bg-neutral-950 pt-24 text-white">
          <div class="absolute inset-0">
            <img
              v-if="heroImage && !heroImageFailed"
              :src="heroImage"
              :alt="organization.title || organization.name || 'Organisasi'"
              class="h-full w-full object-cover opacity-60"
              @error="heroImageFailed = true"
            >

            <div
              v-else
              class="flex h-full w-full items-center justify-center bg-gradient-to-br from-blue-950 via-slate-950 to-cyan-950"
            >
              <Icon
                :icon="organization.icon || 'solar:users-group-rounded-bold-duotone'"
                class="h-32 w-32 text-white/15"
              />
            </div>

            <div class="absolute inset-0 bg-gradient-to-t from-neutral-950 via-neutral-950/70 to-neutral-950/25"></div>
            <div class="absolute inset-0 bg-gradient-to-r from-neutral-950 via-neutral-950/55 to-transparent"></div>
          </div>

          <div class="relative mx-auto max-w-7xl px-4 pb-12 pt-14 sm:px-6 lg:px-8">
            <nav class="mb-8 flex flex-wrap items-center gap-2 text-sm font-bold text-white/60">
              <NuxtLink to="/" class="transition hover:text-white">
                Beranda
              </NuxtLink>
              <Icon icon="solar:alt-arrow-right-linear" class="h-4 w-4" />
              <NuxtLink to="/organizations" class="transition hover:text-white">
                Organisasi
              </NuxtLink>
              <Icon icon="solar:alt-arrow-right-linear" class="h-4 w-4" />
              <span class="text-white">{{ organization.title || organization.name }}</span>
            </nav>

            <div class="grid gap-8 lg:grid-cols-[1fr_360px] lg:items-end">
              <div>
                <div class="mb-5 flex flex-wrap items-center gap-2">
                  <span class="inline-flex items-center gap-2 rounded-full border border-white/15 bg-white/10 px-3 py-1.5 text-xs font-black uppercase tracking-[0.14em] text-white backdrop-blur">
                    <Icon :icon="organization.icon || 'solar:users-group-rounded-bold-duotone'" class="h-4 w-4" />
                    Organisasi
                  </span>

                  <span
                    class="rounded-full px-3 py-1.5 text-xs font-black backdrop-blur"
                    :class="organization.status === 'active'
                      ? 'bg-emerald-400/15 text-emerald-200'
                      : 'bg-white/10 text-white/70'"
                  >
                    {{ organization.status }}
                  </span>

                  <span
                    v-if="organization.isFeatured"
                    class="rounded-full bg-blue-600 px-3 py-1.5 text-xs font-black text-white shadow-lg shadow-blue-900/20"
                  >
                    Featured
                  </span>
                </div>

                <h1 class="max-w-4xl text-4xl font-black leading-[1.05] tracking-tight text-white sm:text-5xl lg:text-6xl">
                  {{ organization.title || organization.name }}
                </h1>

                <p
                  v-if="organization.subtitle || organization.shortDescription"
                  class="mt-5 max-w-3xl text-base font-medium leading-8 text-white/75 sm:text-lg"
                >
                  {{ organization.subtitle || organization.shortDescription }}
                </p>

                <div class="mt-7 flex flex-wrap gap-3">
                  <a
                    v-if="whatsappUrl"
                    :href="whatsappUrl"
                    target="_blank"
                    rel="noopener"
                    class="inline-flex items-center justify-center gap-2 rounded-2xl bg-white px-5 py-3 text-sm font-black text-neutral-950 transition hover:-translate-y-0.5 hover:bg-blue-50"
                  >
                    <Icon icon="solar:chat-round-call-bold-duotone" class="h-5 w-5 text-blue-600" />
                    Hubungi WhatsApp
                  </a>

                  <a
                    v-if="organization.websiteUrl"
                    :href="organization.websiteUrl"
                    target="_blank"
                    rel="noopener"
                    class="inline-flex items-center justify-center gap-2 rounded-2xl border border-white/20 bg-white/10 px-5 py-3 text-sm font-black text-white backdrop-blur transition hover:-translate-y-0.5 hover:bg-white/15"
                  >
                    <Icon icon="solar:global-bold-duotone" class="h-5 w-5" />
                    Website
                  </a>

                  <NuxtLink
                    to="/organizations"
                    class="inline-flex items-center justify-center gap-2 rounded-2xl border border-white/20 bg-white/10 px-5 py-3 text-sm font-black text-white backdrop-blur transition hover:-translate-y-0.5 hover:bg-white/15"
                  >
                    <Icon icon="solar:arrow-left-linear" class="h-5 w-5" />
                    Semua Organisasi
                  </NuxtLink>
                </div>
              </div>

              <aside class="rounded-[2rem] border border-white/15 bg-white/10 p-5 shadow-2xl shadow-neutral-950/20 backdrop-blur-xl">
                <div class="flex items-start gap-4">
                  <div class="grid h-16 w-16 shrink-0 place-items-center overflow-hidden rounded-3xl bg-white/10 text-white">
                    <img
                      v-if="organization.logoUrl && !logoFailed"
                      :src="organization.logoUrl"
                      :alt="organization.title || organization.name || 'Organisasi'"
                      class="h-full w-full object-cover"
                      @error="logoFailed = true"
                    >
                    <Icon
                      v-else
                      :icon="organization.icon || 'solar:users-group-rounded-bold-duotone'"
                      class="h-8 w-8"
                    />
                  </div>

                  <div class="min-w-0">
                    <p class="text-xs font-black uppercase tracking-[0.14em] text-white/50">
                      Profil Organisasi
                    </p>
                    <p class="mt-1 truncate text-lg font-black text-white">
                      {{ organization.title || organization.name }}
                    </p>
                    <p class="mt-1 truncate text-xs font-bold text-white/50">
                      {{ organization.slug }}
                    </p>
                  </div>
                </div>

                <div class="mt-5 grid gap-2">
                  <InfoRow label="Status" :value="organization.status" />
                  <InfoRow label="Update" :value="formatDate(organization.updatedAt)" />
                  <InfoRow label="Urutan" :value="String(organization.sortOrder || 0)" />
                </div>
              </aside>
            </div>
          </div>
        </section>

        <section class="mx-auto grid max-w-7xl gap-6 px-4 py-10 sm:px-6 lg:grid-cols-[1fr_340px] lg:px-8">
          <article class="overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-sm">
            <div class="border-b border-neutral-200 px-5 py-4 sm:px-6">
              <div class="flex items-center gap-3">
                <div class="grid h-10 w-10 place-items-center rounded-2xl bg-blue-50 text-blue-700">
                  <Icon icon="solar:document-text-bold-duotone" class="h-5 w-5" />
                </div>

                <div>
                  <p class="text-sm font-black text-neutral-950">
                    Detail Organisasi
                  </p>
                  <p class="text-xs font-semibold text-neutral-500">
                    Informasi lengkap organisasi
                  </p>
                </div>
              </div>
            </div>

            <div class="px-5 py-6 sm:px-6">
              <div
                v-if="safeContentHtml"
                class="organization-content"
                v-html="safeContentHtml"
              ></div>

              <div v-else class="rounded-3xl border border-dashed border-neutral-300 bg-neutral-50 p-8 text-center">
                <Icon icon="solar:document-bold-duotone" class="mx-auto h-10 w-10 text-neutral-400" />
                <p class="mt-3 text-sm font-bold text-neutral-500">
                  Belum ada konten detail untuk organisasi ini.
                </p>
              </div>
            </div>
          </article>

          <aside class="space-y-4">
            <div class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm">
              <p class="text-sm font-black text-neutral-950">
                Informasi Kontak
              </p>

              <div class="mt-4 space-y-4">
                <ContactItem
                  v-if="organization.phone"
                  icon="solar:phone-bold-duotone"
                  label="Telepon"
                  :value="organization.phone"
                  :href="`tel:${organization.phone}`"
                />

                <ContactItem
                  v-if="organization.whatsapp"
                  icon="solar:chat-round-call-bold-duotone"
                  label="WhatsApp"
                  :value="organization.whatsapp"
                  :href="whatsappUrl"
                />

                <ContactItem
                  v-if="organization.email"
                  icon="solar:letter-bold-duotone"
                  label="Email"
                  :value="organization.email"
                  :href="`mailto:${organization.email}`"
                />

                <ContactItem
                  v-if="organization.websiteUrl"
                  icon="solar:global-bold-duotone"
                  label="Website"
                  :value="organization.websiteUrl"
                  :href="organization.websiteUrl"
                />

                <ContactItem
                  v-if="organization.address"
                  icon="solar:map-point-bold-duotone"
                  label="Alamat"
                  :value="organization.address"
                />

                <div
                  v-if="!organization.phone && !organization.whatsapp && !organization.email && !organization.websiteUrl && !organization.address"
                  class="rounded-3xl border border-dashed border-neutral-300 bg-neutral-50 p-5 text-sm font-bold leading-6 text-neutral-500"
                >
                  Informasi kontak belum tersedia.
                </div>
              </div>
            </div>

            <div
              v-if="galleryImages.length > 1"
              class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm"
            >
              <p class="text-sm font-black text-neutral-950">
                Galeri
              </p>

              <div class="mt-4 grid grid-cols-2 gap-2">
                <div
                  v-for="image in galleryImages.slice(0, 4)"
                  :key="image"
                  class="aspect-square overflow-hidden rounded-2xl bg-neutral-100"
                >
                  <img
                    :src="image"
                    :alt="organization.title || organization.name || 'Galeri organisasi'"
                    class="h-full w-full object-cover"
                  >
                </div>
              </div>
            </div>

            <div
              v-if="relatedOrganizations.length"
              class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm"
            >
              <div class="flex items-center justify-between gap-3">
                <p class="text-sm font-black text-neutral-950">
                  Organisasi Lainnya
                </p>
                <NuxtLink to="/organizations" class="text-xs font-black text-blue-700 hover:text-blue-800">
                  Lihat Semua
                </NuxtLink>
              </div>

              <div class="mt-4 space-y-3">
                <NuxtLink
                  v-for="item in relatedOrganizations"
                  :key="item.id"
                  :to="organizationDetailTo(item.slug)"
                  class="group flex items-center gap-3 rounded-2xl border border-neutral-200 bg-neutral-50 p-3 transition hover:bg-white"
                >
                  <div class="grid h-11 w-11 shrink-0 place-items-center overflow-hidden rounded-2xl bg-blue-50 text-blue-700">
                    <img
                      v-if="getOrganizationCover(item)"
                      :src="getOrganizationCover(item)"
                      :alt="item.title || item.name || 'Organisasi'"
                      class="h-full w-full object-cover"
                    >
                    <Icon v-else :icon="item.icon || 'solar:users-group-rounded-bold-duotone'" class="h-5 w-5" />
                  </div>

                  <div class="min-w-0 flex-1">
                    <p class="truncate text-sm font-black text-neutral-900 group-hover:text-blue-700">
                      {{ item.title || item.name }}
                    </p>
                    <p class="mt-0.5 truncate text-xs font-semibold text-neutral-500">
                      {{ item.subtitle || item.shortDescription || item.slug }}
                    </p>
                  </div>

                  <Icon icon="solar:alt-arrow-right-linear" class="h-4 w-4 text-neutral-400" />
                </NuxtLink>
              </div>
            </div>
          </aside>
        </section>
      </template>
    </template>

    <template v-else>
      <section class="relative border-b border-neutral-200 bg-white/80 pt-28 backdrop-blur-xl">
        <div class="mx-auto max-w-7xl px-4 pb-10 sm:px-6 lg:px-8">
          <nav class="mb-7 flex flex-wrap items-center gap-2 text-sm font-bold text-neutral-500">
            <NuxtLink to="/" class="transition hover:text-neutral-950">
              Beranda
            </NuxtLink>
            <Icon icon="solar:alt-arrow-right-linear" class="h-4 w-4" />
            <span class="text-neutral-950">Organisasi</span>
          </nav>

          <div class="grid gap-8 lg:grid-cols-[1fr_390px] lg:items-end">
            <div>
              <div class="mb-5 inline-flex items-center gap-2 rounded-full bg-blue-50 px-3 py-1.5 text-xs font-black uppercase tracking-[0.14em] text-blue-700">
                <Icon icon="solar:users-group-rounded-bold-duotone" class="h-4 w-4" />
                Organisasi Desa
              </div>

              <h1 class="max-w-4xl text-4xl font-black leading-[1.05] tracking-tight text-neutral-950 sm:text-5xl lg:text-6xl">
                Organisasi &
                <span class="block bg-gradient-to-r from-blue-600 via-cyan-500 to-emerald-500 bg-clip-text text-transparent">
                  Kelembagaan Aktif
                </span>
              </h1>

              <p class="mt-5 max-w-3xl text-base font-semibold leading-8 text-neutral-600 sm:text-lg">
                Jelajahi organisasi, kelompok masyarakat, unit kerja, komunitas, dan kelembagaan yang aktif mendukung pelayanan serta pembangunan {{ appName }}.
              </p>

              <div class="mt-8 flex flex-wrap gap-3">
                <NuxtLink
                  to="/profile"
                  class="inline-flex items-center justify-center gap-2 rounded-2xl bg-neutral-900 px-5 py-3 text-sm font-black text-white shadow-lg shadow-neutral-900/10 transition hover:-translate-y-0.5 hover:bg-neutral-800"
                >
                  Profil Desa
                  <Icon icon="solar:arrow-right-up-linear" class="h-5 w-5" />
                </NuxtLink>

                <button
                  type="button"
                  class="inline-flex items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-5 py-3 text-sm font-black text-neutral-700 shadow-sm transition hover:-translate-y-0.5 hover:bg-neutral-50"
                  @click="refreshList()"
                >
                  <Icon icon="solar:refresh-bold-duotone" class="h-5 w-5" :class="pendingList ? 'animate-spin' : ''" />
                  Refresh
                </button>
              </div>
            </div>

            <aside class="rounded-[2.25rem] border border-neutral-200 bg-white p-5 shadow-xl shadow-neutral-900/5">
              <div class="flex items-start gap-4">
                <div class="grid h-16 w-16 shrink-0 place-items-center rounded-3xl bg-blue-50 text-blue-700">
                  <Icon icon="solar:buildings-3-bold-duotone" class="h-8 w-8" />
                </div>

                <div class="min-w-0">
                  <p class="text-xs font-black uppercase tracking-[0.14em] text-neutral-400">
                    Total Organisasi
                  </p>
                  <h2 class="mt-1 text-3xl font-black text-neutral-950">
                    {{ organizations.length }}
                  </h2>
                  <p class="mt-1 text-sm font-bold text-neutral-500">
                    Tenant {{ tenantSlug }}
                  </p>
                </div>
              </div>

              <div class="mt-5 grid grid-cols-3 gap-2">
                <div class="rounded-2xl bg-neutral-50 p-3">
                  <p class="text-[10px] font-black uppercase tracking-[0.12em] text-neutral-400">
                    Active
                  </p>
                  <p class="mt-1 text-lg font-black text-neutral-950">
                    {{ activeCount }}
                  </p>
                </div>

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
                    Foto
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

      <section class="mx-auto max-w-7xl px-4 py-8 sm:px-6 lg:px-8">
        <div class="mb-5 rounded-[2rem] border border-neutral-200 bg-white p-4 shadow-sm">
          <div class="grid gap-3 lg:grid-cols-[1fr_180px_180px]">
            <div class="relative">
              <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-4 text-neutral-400">
                <Icon icon="solar:magnifer-linear" class="h-5 w-5" />
              </div>

              <input
                v-model.trim="q"
                type="text"
                placeholder="Cari organisasi, deskripsi, pengurus, atau kata kunci..."
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
            <p class="text-xs font-bold text-neutral-500">
              Menampilkan {{ filteredOrganizations.length }} dari {{ organizations.length }} organisasi.
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

        <div v-if="visibleListError" class="mb-5 rounded-3xl border border-red-200 bg-red-50 p-4 text-sm font-bold leading-6 text-red-700">
          {{ visibleListError }}
        </div>

        <section v-if="pendingList" class="grid gap-4 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
          <div
            v-for="item in 8"
            :key="item"
            class="h-[25rem] animate-pulse overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-sm"
          >
            <div class="h-44 bg-neutral-100"></div>
            <div class="p-5">
              <div class="h-5 w-2/3 rounded-full bg-neutral-100"></div>
              <div class="mt-3 h-3 w-full rounded-full bg-neutral-100"></div>
              <div class="mt-2 h-3 w-4/5 rounded-full bg-neutral-100"></div>
            </div>
          </div>
        </section>

        <section
          v-else-if="filteredOrganizations.length === 0"
          class="rounded-[2rem] border border-dashed border-neutral-300 bg-white p-10 text-center shadow-sm"
        >
          <div class="mx-auto grid h-16 w-16 place-items-center rounded-3xl bg-neutral-100 text-neutral-500">
            <Icon icon="solar:users-group-rounded-bold-duotone" class="h-8 w-8" />
          </div>

          <h2 class="mt-5 text-xl font-black text-neutral-950">
            Belum ada data organisasi
          </h2>

          <p class="mx-auto mt-2 max-w-md text-sm font-medium leading-6 text-neutral-500">
            Data organisasi akan tampil otomatis setelah ditambahkan dari dashboard organisasi.
          </p>
        </section>

        <section v-else class="grid gap-4 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
          <NuxtLink
            v-for="item in pagedOrganizations"
            :key="item.id"
            :to="organizationDetailTo(item.slug)"
            class="group overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-sm transition hover:-translate-y-1 hover:border-blue-200 hover:shadow-xl hover:shadow-blue-900/5"
          >
            <div class="relative h-48 overflow-hidden bg-neutral-100">
              <img
                v-if="getOrganizationCover(item) && !failedImages[item.id]"
                :src="getOrganizationCover(item)"
                :alt="item.title || item.name || 'Organisasi'"
                class="h-full w-full object-cover transition duration-500 group-hover:scale-105"
                @error="markImageFailed(item.id)"
              >

              <div
                v-else
                class="flex h-full w-full items-center justify-center bg-gradient-to-br from-blue-50 via-white to-cyan-50 text-blue-600"
              >
                <Icon :icon="item.icon || 'solar:users-group-rounded-bold-duotone'" class="h-14 w-14" />
              </div>

              <div class="absolute inset-0 bg-gradient-to-t from-neutral-950/65 via-transparent to-transparent"></div>

              <div class="absolute left-4 top-4 flex flex-wrap gap-2">
                <span
                  class="rounded-full px-3 py-1 text-[11px] font-black backdrop-blur"
                  :class="item.status === 'active'
                    ? 'bg-emerald-400/90 text-emerald-950'
                    : 'bg-white/80 text-neutral-600'"
                >
                  {{ item.status }}
                </span>

                <span
                  v-if="item.isFeatured"
                  class="rounded-full bg-blue-600 px-3 py-1 text-[11px] font-black text-white shadow-lg shadow-blue-900/20"
                >
                  Featured
                </span>
              </div>

              <div class="absolute bottom-4 left-4 right-4">
                <p class="line-clamp-2 text-lg font-black leading-tight text-white drop-shadow">
                  {{ item.title || item.name }}
                </p>
              </div>
            </div>

            <div class="p-5">
              <div class="mb-3 flex items-center gap-2 text-xs font-black uppercase tracking-[0.12em] text-blue-700">
                <Icon :icon="item.icon || 'solar:users-group-rounded-bold-duotone'" class="h-4 w-4" />
                Organisasi
              </div>

              <p class="line-clamp-2 text-sm font-semibold leading-6 text-neutral-600">
                {{ item.subtitle || item.shortDescription || plainText(item.contentHtml || '') || 'Informasi organisasi akan segera diperbarui.' }}
              </p>

              <div class="mt-5 flex items-center justify-between gap-3 border-t border-neutral-100 pt-4">
                <div class="min-w-0">
                  <p class="truncate text-xs font-bold text-neutral-400">
                    {{ item.slug }}
                  </p>
                  <p class="mt-0.5 text-xs font-black text-neutral-700">
                    {{ formatDate(item.updatedAt || item.createdAt) }}
                  </p>
                </div>

                <span class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl bg-neutral-950 text-white transition group-hover:bg-blue-600">
                  <Icon icon="solar:arrow-right-up-linear" class="h-5 w-5" />
                </span>
              </div>
            </div>
          </NuxtLink>
        </section>

        <div v-if="hasMore" class="mt-8 flex justify-center">
          <button
            type="button"
            class="inline-flex items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-5 py-3 text-sm font-black text-neutral-700 shadow-sm transition hover:-translate-y-0.5 hover:bg-neutral-50"
            @click="page += 1"
          >
            Muat Lebih Banyak
            <Icon icon="solar:alt-arrow-down-linear" class="h-5 w-5" />
          </button>
        </div>
      </section>
    </template>
  </main>
</template>

<script setup lang="ts">
import { Icon } from '@iconify/vue'
import { computed, defineComponent, h, ref, watch } from 'vue'

type OrganizationStatus = 'active' | 'inactive'

type OrganizationItem = {
  id: string
  tenantId?: string
  title?: string | null
  name?: string | null
  subtitle?: string | null
  slug: string
  icon?: string | null
  logoUrl?: string | null
  imageUrl?: string | null
  shortDescription?: string | null
  contentHtml?: string | null
  contentJson?: any | null
  phone?: string | null
  whatsapp?: string | null
  email?: string | null
  websiteUrl?: string | null
  address?: string | null
  status: OrganizationStatus
  isFeatured: boolean
  sortOrder: number
  metadata?: Record<string, any>
  createdAt?: number
  updatedAt?: number
}

type OrganizationDetailResponse = {
  data: OrganizationItem | null
}

type OrganizationListResponse = {
  data: OrganizationItem[]
  meta: {
    page: number
    limit: number
    total: number
    totalPages: number
  }
}

const route = useRoute()
const runtime = useRuntimeConfig()
const requestUrl = useRequestURL()
const { tenantApiUrl } = useAppApi()

const q = ref('')
const selectedStatus = ref<OrganizationStatus | 'all'>('active')
const sortBy = ref<'newest' | 'oldest' | 'title' | 'sort_order'>('sort_order')
const page = ref(1)
const pageSize = 12

const failedImages = ref<Record<string, boolean>>({})
const heroImageFailed = ref(false)
const logoFailed = ref(false)

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
  const rawValue = route.query.detail || route.query.detai || ''
  const value = Array.isArray(rawValue) ? rawValue[0] : rawValue

  return String(value || '')
    .trim()
    .toLowerCase()
})

const isDetailMode = computed(() => Boolean(detailSlug.value))
const listApiUrl = computed(() => tenantApiUrl(tenantSlug.value, '/organizations'))

const {
  data: listResponse,
  pending: pendingList,
  error: listError,
  refresh: refreshList
} = await useFetch<OrganizationListResponse>(listApiUrl, {
  key: computed(() => `organization-list-${tenantSlug.value}-${selectedStatus.value}-${sortBy.value}`),
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

const {
  data: detailResponse,
  pending: pendingDetail,
  error: detailError
} = await useAsyncData<OrganizationDetailResponse>(
  () => `organization-detail-query-${tenantSlug.value}-${detailSlug.value}`,
  async () => {
    if (!detailSlug.value) {
      return { data: null }
    }

    try {
      return await $fetch<OrganizationDetailResponse>(
        tenantApiUrl(tenantSlug.value, `/organizations/by-slug/${encodeURIComponent(detailSlug.value)}`)
      )
    } catch {
      const list = await $fetch<OrganizationListResponse>(tenantApiUrl(tenantSlug.value, '/organizations'), {
        query: {
          limit: 100,
          sort: 'sort_order'
        }
      })

      const found = (list.data || []).find((item) => item.slug === detailSlug.value) || null

      return { data: found }
    }
  },
  {
    watch: [tenantSlug, detailSlug],
    default: () => ({
      data: null
    })
  }
)

const organizations = computed<OrganizationItem[]>(() => listResponse.value?.data || [])

const organization = computed<OrganizationItem | null>(() => {
  if (!isDetailMode.value) return null

  return detailResponse.value?.data ||
    organizations.value.find((item) => item.slug === detailSlug.value) ||
    null
})

const visibleListError = computed(() => {
  if (!listError.value) return ''
  return listError.value?.message || 'Terjadi kesalahan saat memuat data organisasi.'
})

const visibleDetailError = computed(() => {
  if (!detailError.value) return ''
  return detailError.value?.message || 'Terjadi kesalahan saat memuat detail organisasi.'
})

const filteredOrganizations = computed(() => {
  const keyword = q.value.trim().toLowerCase()

  return organizations.value
    .filter((item) => {
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
        plainText(item.contentHtml || '')
      ]
        .filter(Boolean)
        .join(' ')
        .toLowerCase()
        .includes(keyword)
    })
    .sort((a, b) => {
      if (sortBy.value === 'title') {
        return String(a.title || a.name || '').localeCompare(String(b.title || b.name || ''))
      }

      if (sortBy.value === 'newest') {
        return Number(b.createdAt || 0) - Number(a.createdAt || 0)
      }

      if (sortBy.value === 'oldest') {
        return Number(a.createdAt || 0) - Number(b.createdAt || 0)
      }

      const sortA = Number(a.sortOrder || 0)
      const sortB = Number(b.sortOrder || 0)

      if (sortA !== sortB) return sortA - sortB

      return String(a.title || a.name || '').localeCompare(String(b.title || b.name || ''))
    })
})

const pagedOrganizations = computed(() => {
  return filteredOrganizations.value.slice(0, page.value * pageSize)
})

const hasMore = computed(() => {
  return pagedOrganizations.value.length < filteredOrganizations.value.length
})

const activeCount = computed(() => organizations.value.filter((item) => item.status === 'active').length)
const featuredCount = computed(() => organizations.value.filter((item) => item.isFeatured).length)
const withImageCount = computed(() => organizations.value.filter((item) => getOrganizationCover(item)).length)

const heroImage = computed(() => {
  if (!organization.value) return ''
  return getOrganizationCover(organization.value)
})

const galleryImages = computed(() => {
  if (!organization.value) return []
  return getOrganizationImages(organization.value)
})

const safeContentHtml = computed(() => {
  return sanitizeHtml(organization.value?.contentHtml || '')
})

const relatedOrganizations = computed(() => {
  const currentId = organization.value?.id
  const currentSlug = organization.value?.slug

  return organizations.value
    .filter((item) => item.id !== currentId && item.slug !== currentSlug)
    .slice(0, 3)
})

const whatsappUrl = computed(() => {
  const value = organization.value?.whatsapp || organization.value?.phone || ''
  const number = String(value).replace(/\D/g, '')

  if (!number) return ''

  return `https://wa.me/${number.startsWith('0') ? `62${number.slice(1)}` : number}`
})

const pageTitle = computed(() => {
  if (isDetailMode.value) {
    return organization.value
      ? `${organization.value.title || organization.value.name} · Organisasi`
      : 'Organisasi tidak ditemukan'
  }

  return `Organisasi · ${appName.value}`
})

const pageDescription = computed(() => {
  if (isDetailMode.value) {
    return organization.value?.subtitle ||
      organization.value?.shortDescription ||
      plainText(organization.value?.contentHtml || '').slice(0, 160) ||
      'Informasi organisasi desa.'
  }

  return `Daftar organisasi, kelembagaan, komunitas, dan unit kerja aktif di ${appName.value}.`
})

watch([q, selectedStatus, sortBy], () => {
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
  ogImage: () => heroImage.value || undefined,
  robots: 'index, follow'
})

useHead(() => ({
  htmlAttrs: {
    lang: 'id'
  },
  link: [
    {
      rel: 'canonical',
      href: `${requestUrl.origin}/organizations${detailSlug.value ? `?detail=${encodeURIComponent(detailSlug.value)}` : ''}`
    }
  ]
}))

function organizationDetailTo(slug: string) {
  return {
    path: '/organizations',
    query: {
      detail: slug
    }
  }
}

function resetFilters() {
  q.value = ''
  selectedStatus.value = 'active'
  sortBy.value = 'sort_order'
  page.value = 1
}

function getOrganizationImages(item: OrganizationItem) {
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

  return Array.from(new Set(images))
}

function getOrganizationCover(item: OrganizationItem) {
  return getOrganizationImages(item)[0] || ''
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

function formatDate(value?: number | null) {
  if (!value) return '-'

  const numericValue = Number(value)
  const date = new Date(numericValue < 10_000_000_000 ? numericValue * 1000 : numericValue)

  if (Number.isNaN(date.getTime())) return '-'

  return new Intl.DateTimeFormat('id-ID', {
    day: '2-digit',
    month: 'long',
    year: 'numeric'
  }).format(date)
}

const InfoRow = defineComponent({
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
            'flex items-center justify-between gap-3 rounded-2xl bg-white/10 px-4 py-3'
        },
        [
          h(
            'span',
            {
              class:
                'text-xs font-black uppercase tracking-[0.12em] text-white/50'
            },
            props.label
          ),
          h(
            'span',
            {
              class:
                'min-w-0 truncate text-right text-sm font-black text-white'
            },
            props.value
          )
        ]
      )
  }
})

const ContactItem = defineComponent({
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

.organization-content {
  color: #262626;
  font-size: 1rem;
  line-height: 1.8;
}

.organization-content :deep(h1) {
  margin-top: 2rem;
  margin-bottom: 0.75rem;
  font-size: 2rem;
  line-height: 1.15;
  font-weight: 900;
  letter-spacing: -0.04em;
  color: #171717;
}

.organization-content :deep(h2) {
  margin-top: 2rem;
  margin-bottom: 0.75rem;
  font-size: 1.75rem;
  line-height: 1.2;
  font-weight: 900;
  letter-spacing: -0.03em;
  color: #171717;
}

.organization-content :deep(h3) {
  margin-top: 1.5rem;
  margin-bottom: 0.65rem;
  font-size: 1.35rem;
  line-height: 1.3;
  font-weight: 900;
  color: #171717;
}

.organization-content :deep(p) {
  margin: 0.9rem 0;
}

.organization-content :deep(a) {
  color: #2563eb;
  font-weight: 800;
  text-decoration: underline;
  text-underline-offset: 4px;
}

.organization-content :deep(ul),
.organization-content :deep(ol) {
  margin: 1rem 0;
  padding-left: 1.35rem;
}

.organization-content :deep(li) {
  margin: 0.35rem 0;
}

.organization-content :deep(blockquote) {
  margin: 1.25rem 0;
  border-left: 4px solid #2563eb;
  border-radius: 0.75rem;
  background: #fafafa;
  padding: 1rem 1.25rem;
  color: #525252;
}

.organization-content :deep(img) {
  margin: 1.25rem 0;
  max-width: 100%;
  height: auto;
  border-radius: 1.25rem;
  border: 1px solid #e5e5e5;
}

.organization-content :deep(iframe) {
  margin: 1.25rem 0;
  min-height: 420px;
  width: 100%;
  border: 0;
  border-radius: 1.25rem;
  background: #f5f5f5;
}

.organization-content :deep(table) {
  margin: 1.25rem 0;
  width: 100%;
  border-collapse: collapse;
  overflow: hidden;
  border-radius: 1rem;
  border: 1px solid #e5e5e5;
}

.organization-content :deep(th),
.organization-content :deep(td) {
  border: 1px solid #e5e5e5;
  padding: 0.75rem;
  text-align: left;
}

.organization-content :deep(th) {
  background: #f5f5f5;
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
