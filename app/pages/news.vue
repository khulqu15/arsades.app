<!-- /pages/news.vue -->

<template>
  <main class="min-h-screen overflow-hidden bg-neutral-50 text-neutral-950">
    <div class="pointer-events-none fixed inset-0 -z-10 overflow-hidden">
      <div class="absolute -left-40 -top-32 h-[520px] w-[520px] rounded-full bg-blue-100 blur-3xl"></div>
      <div class="absolute -right-40 top-20 h-[520px] w-[520px] rounded-full bg-sky-100 blur-3xl"></div>
      <div class="absolute inset-0 bg-grid opacity-40"></div>
    </div>

    <section class="border-b border-neutral-200 bg-white/80 pt-24 backdrop-blur-xl">
      <div class="mx-auto max-w-7xl px-4 pb-8 sm:px-6 lg:px-8">
        <nav class="mb-6 flex flex-wrap items-center gap-2 text-xs font-black uppercase tracking-[0.14em] text-neutral-400">
          <NuxtLink to="/" class="transition hover:text-blue-600">
            Beranda
          </NuxtLink>
          <Icon icon="solar:alt-arrow-right-linear" class="h-4 w-4" />
          <span class="text-neutral-950">Berita</span>
        </nav>

        <div class="grid gap-6 lg:grid-cols-[1fr_360px] lg:items-end">
          <div>
            <div class="inline-flex items-center gap-3 rounded-[1.35rem] border border-neutral-200 bg-white px-3 py-2 shadow-sm shadow-neutral-900/5">
              <div class="grid h-11 w-11 place-items-center overflow-hidden rounded-2xl border border-neutral-200 bg-white shadow-sm">
                <img
                  v-if="profile.logo && !logoImageFailed"
                  :src="profile.logo"
                  :alt="profile.name"
                  class="h-8 w-8 object-contain"
                  @error="logoImageFailed = true"
                >
                <Icon
                  v-else
                  icon="solar:document-text-bold-duotone"
                  class="h-6 w-6 text-blue-600"
                />
              </div>

              <div class="min-w-0">
                <p class="text-[11px] font-black uppercase tracking-[0.14em] text-blue-600">
                  {{ profile.eyebrow }}
                </p>
                <p class="truncate text-sm font-black text-neutral-950">
                  {{ profile.name }}
                </p>
              </div>
            </div>

            <h1 class="mt-5 max-w-4xl text-4xl font-black leading-[1.04] tracking-tight text-neutral-950 sm:text-5xl lg:text-6xl">
              {{ profile.title }}
            </h1>

            <p class="mt-4 max-w-3xl text-sm font-semibold leading-7 text-neutral-600 sm:text-base">
              {{ profile.subtitle }}
            </p>

            <div class="mt-6 flex flex-wrap gap-3">
              <NuxtLink
                to="/news"
                class="inline-flex items-center justify-center gap-2 rounded-2xl bg-blue-600 px-5 py-3 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:-translate-y-0.5 hover:bg-blue-700"
              >
                Semua Berita
                <Icon icon="solar:document-text-bold-duotone" class="h-5 w-5" />
              </NuxtLink>

              <button
                type="button"
                class="inline-flex items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-5 py-3 text-sm font-black text-neutral-700 shadow-sm transition hover:-translate-y-0.5 hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
                @click="refreshPublicNews"
              >
                <Icon
                  icon="solar:refresh-bold-duotone"
                  class="h-5 w-5"
                  :class="pending ? 'animate-spin' : ''"
                />
                Refresh
              </button>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="mx-auto max-w-7xl px-4 py-7 sm:px-6 lg:px-8">
      <template v-if="isDetail">
        <div class="mb-5 flex flex-wrap items-center justify-between gap-3">
          <button
            type="button"
            class="inline-flex items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-4 py-2.5 text-sm font-black text-neutral-700 shadow-sm transition hover:-translate-y-0.5 hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
            @click="backToList"
          >
            <Icon icon="solar:arrow-left-linear" class="h-5 w-5" />
            Kembali
          </button>

          <div class="flex flex-wrap gap-2">
            <button
              type="button"
              class="inline-flex items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-4 py-2.5 text-sm font-black text-neutral-700 shadow-sm transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
              @click="copyLink"
            >
              <Icon :icon="copied ? 'solar:check-circle-bold-duotone' : 'solar:link-bold-duotone'" class="h-5 w-5" />
              {{ copied ? 'Link Tersalin' : 'Salin Link' }}
            </button>

            <button
              type="button"
              class="inline-flex items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 py-2.5 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700"
              @click="openShareModal"
            >
              <Icon icon="solar:share-bold-duotone" class="h-5 w-5" />
              Bagikan
            </button>
          </div>
        </div>

        <section
          v-if="pending"
          class="grid animate-pulse gap-5 lg:grid-cols-[1fr_320px]"
        >
          <div class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm">
            <div class="h-7 w-3/4 rounded-full bg-neutral-100"></div>
            <div class="mt-4 h-4 w-1/2 rounded-full bg-neutral-100"></div>
            <div class="mt-5 h-80 rounded-[1.5rem] bg-neutral-100"></div>
          </div>
          <div class="h-64 rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm"></div>
        </section>

        <section
          v-else-if="!current"
          class="mx-auto max-w-2xl rounded-[2rem] border border-dashed border-neutral-300 bg-white p-10 text-center shadow-sm"
        >
          <div class="mx-auto grid h-16 w-16 place-items-center rounded-3xl bg-blue-50 text-blue-600">
            <Icon icon="solar:document-text-bold-duotone" class="h-8 w-8" />
          </div>
          <h2 class="mt-5 text-xl font-black text-neutral-950">
            Berita tidak ditemukan
          </h2>
          <p class="mx-auto mt-2 max-w-md text-sm font-semibold leading-6 text-neutral-500">
            Data berita yang kamu buka belum tersedia, sudah tidak aktif, atau slug-nya tidak sesuai.
          </p>
          <button
            type="button"
            class="mt-6 inline-flex items-center justify-center gap-2 rounded-2xl bg-blue-600 px-5 py-3 text-sm font-black text-white transition hover:bg-blue-700"
            @click="backToList"
          >
            <Icon icon="solar:arrow-left-linear" class="h-5 w-5" />
            Kembali ke Daftar
          </button>
        </section>

        <template v-else>
          <div class="grid gap-5 lg:grid-cols-[minmax(0,1fr)_320px] lg:items-start">
            <article class="overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-sm shadow-neutral-900/5">
              <div class="relative overflow-hidden bg-gradient-to-br from-blue-50 via-white to-sky-50">
                <button
                  v-if="current.cover"
                  type="button"
                  class="group relative block w-full cursor-zoom-in overflow-hidden border-b border-neutral-200 bg-neutral-950/95"
                  @click="openImageModal(current.cover, current.title)"
                >
                  <div class="pointer-events-none absolute inset-0 bg-[radial-gradient(circle_at_top_left,rgba(37,99,235,0.30),transparent_30%),radial-gradient(circle_at_bottom_right,rgba(14,165,233,0.22),transparent_36%)]"></div>

                  <div class="relative mx-auto flex min-h-[260px] w-full items-center justify-center p-3 sm:min-h-[380px] sm:p-5 lg:min-h-[520px]">
                    <img
                      :src="current.cover"
                      :alt="current.title"
                      class="max-h-[72vh] w-full max-w-full object-contain transition duration-500 group-hover:scale-[1.015]"
                      @error="markCoverFailed(current.slug)"
                    >
                  </div>

                  <div class="absolute right-4 top-4 inline-flex items-center gap-2 rounded-2xl bg-white/90 px-3 py-2 text-xs font-black text-neutral-800 shadow-lg shadow-neutral-950/10 backdrop-blur">
                    <Icon icon="solar:magnifer-zoom-in-bold-duotone" class="h-4 w-4 text-blue-600" />
                    Klik untuk zoom
                  </div>
                </button>

                <div
                  v-else
                  class="flex min-h-[320px] items-center justify-center bg-gradient-to-br from-blue-50 via-white to-sky-50 text-blue-600 sm:min-h-[420px]"
                >
                  <Icon icon="solar:document-text-bold-duotone" class="h-16 w-16" />
                </div>

                <div class="border-b border-neutral-200 bg-white p-5 sm:p-7">
                  <div class="mb-4 flex flex-wrap items-center gap-2">
                    <span
                      v-if="current.category"
                      class="inline-flex items-center gap-1.5 rounded-full bg-blue-50 px-3 py-1.5 text-xs font-black text-blue-700 ring-1 ring-blue-100"
                    >
                      <Icon icon="solar:bookmark-bold-duotone" class="h-4 w-4" />
                      {{ current.category }}
                    </span>

                    <span class="inline-flex items-center gap-1.5 rounded-full bg-neutral-100 px-3 py-1.5 text-xs font-black text-neutral-600">
                      <Icon icon="solar:calendar-bold-duotone" class="h-4 w-4 text-blue-600" />
                      {{ formatDate(current.publishedAt) }}
                    </span>
                  </div>

                  <h1 class="max-w-4xl text-3xl font-black leading-tight tracking-tight text-neutral-950 sm:text-5xl">
                    {{ current.title }}
                  </h1>

                  <p
                    v-if="current.excerpt"
                    class="mt-3 max-w-3xl text-sm font-semibold leading-7 text-neutral-600 sm:text-base"
                  >
                    {{ current.excerpt }}
                  </p>
                </div>
              </div>

              <div class="p-5 sm:p-7">
                <div
                  v-if="renderedDetailHtml"
                  class="news-content text-[15px] leading-8 text-neutral-700 sm:text-base"
                  v-html="renderedDetailHtml"
                ></div>

                <p
                  v-else
                  class="rounded-2xl border border-dashed border-neutral-300 bg-neutral-50 p-5 text-sm font-semibold leading-7 text-neutral-500"
                >
                  Belum ada konten berita.
                </p>
              </div>

              <div class="border-t border-neutral-100 p-5 sm:p-7">
                <CommentsSection
                  :target-id="String(current.id || current.slug)"
                  :target-title="current.title"
                  :initial-comments="publicComments"
                  :storage-key-prefix="`news-comments:${tenantSlug}`"
                  @submit="handleNewsCommentSubmit"
                  @reply="handleNewsCommentReply"
                />
              </div>
            </article>

            <aside class="space-y-4 lg:sticky lg:top-24">
              <div class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm shadow-neutral-900/5">
                <div class="flex items-center gap-3">
                  <div class="grid h-12 w-12 place-items-center overflow-hidden rounded-2xl border border-neutral-200 bg-white shadow-sm">
                    <img
                      v-if="profile.logo && !logoImageFailed"
                      :src="profile.logo"
                      :alt="profile.name"
                      class="h-8 w-8 object-contain"
                    >
                    <Icon
                      v-else
                      icon="solar:document-text-bold-duotone"
                      class="h-6 w-6 text-blue-600"
                    />
                  </div>
                  <div class="min-w-0">
                    <p class="text-xs font-black uppercase tracking-[0.14em] text-neutral-400">
                      Dipublikasikan oleh
                    </p>
                    <p class="truncate text-sm font-black text-neutral-950">
                      {{ profile.authorName }}
                    </p>
                  </div>
                </div>

                <div class="mt-5 grid gap-2 text-sm">
                  <div class="flex items-center justify-between gap-3 rounded-2xl bg-neutral-50 px-4 py-3">
                    <span class="font-black text-neutral-400">Tanggal</span>
                    <span class="font-black text-neutral-800">{{ formatDate(current.publishedAt) }}</span>
                  </div>
                </div>
              </div>

              <div
                v-if="current.tags?.length"
                class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm shadow-neutral-900/5"
              >
                <p class="text-xs font-black uppercase tracking-[0.14em] text-neutral-400">
                  Tags
                </p>
                <div class="mt-3 flex flex-wrap gap-2">
                  <button
                    v-for="tag in current.tags"
                    :key="tag"
                    type="button"
                    class="rounded-full bg-blue-50 px-3 py-1.5 text-xs font-black text-blue-700 transition hover:bg-blue-600 hover:text-white"
                    @click="filterByTagAndBack(tag)"
                  >
                    #{{ tag }}
                  </button>
                </div>
              </div>

              <NuxtLink
                to="/news"
                class="flex items-center justify-between gap-3 rounded-[1.5rem] border border-neutral-200 bg-white p-4 text-sm font-black text-neutral-700 shadow-sm transition hover:-translate-y-0.5 hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
              >
                <span class="inline-flex items-center gap-2">
                  <Icon icon="solar:arrow-left-linear" class="h-5 w-5" />
                  Semua Berita
                </span>
                <Icon icon="solar:alt-arrow-right-linear" class="h-5 w-5" />
              </NuxtLink>
            </aside>
          </div>
        </template>
      </template>

      <template v-else>
        <section class="rounded-[2rem] border border-neutral-200 bg-white p-4 shadow-sm shadow-neutral-900/5">
          <div class="grid gap-3 lg:grid-cols-[1fr_190px_160px_auto] lg:items-center">
            <label class="relative block">
              <span class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-4 text-neutral-400">
                <Icon icon="solar:magnifer-linear" class="h-5 w-5" />
              </span>
              <input
                v-model.trim="q"
                type="text"
                placeholder="Cari berita, kategori, atau tag..."
                class="block w-full rounded-2xl border border-neutral-200 bg-neutral-50 py-3 pl-12 pr-4 text-sm font-bold text-neutral-800 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:bg-white focus:ring-4 focus:ring-blue-100"
              >
            </label>

            <select
              v-model="selectedCategory"
              class="block w-full rounded-2xl border border-neutral-200 bg-neutral-50 px-4 py-3 text-sm font-bold text-neutral-700 outline-none transition focus:border-blue-500 focus:bg-white focus:ring-4 focus:ring-blue-100"
            >
              <option value="">Semua Kategori</option>
              <option
                v-for="category in categories"
                :key="category"
                :value="category"
              >
                {{ category }}
              </option>
            </select>

            <select
              v-model="sortBy"
              class="block w-full rounded-2xl border border-neutral-200 bg-neutral-50 px-4 py-3 text-sm font-bold text-neutral-700 outline-none transition focus:border-blue-500 focus:bg-white focus:ring-4 focus:ring-blue-100"
            >
              <option value="newest">Terbaru</option>
              <option value="oldest">Terlama</option>
              <option value="title">Judul A-Z</option>
            </select>

            <button
              type="button"
              class="inline-flex items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-4 py-3 text-sm font-black text-neutral-600 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
              @click="resetFilters"
            >
              <Icon icon="solar:restart-bold-duotone" class="h-5 w-5" />
              Reset
            </button>
          </div>

          <div
            v-if="allTags.length"
            class="mt-4 flex gap-2 overflow-x-auto pb-1"
          >
            <button
              v-for="tag in allTags"
              :key="tag"
              type="button"
              class="shrink-0 rounded-full border px-3 py-1.5 text-xs font-black transition"
              :class="selectedTags.has(tag)
                ? 'border-blue-600 bg-blue-600 text-white shadow-lg shadow-blue-600/15'
                : 'border-neutral-200 bg-white text-neutral-600 hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700'"
              @click="toggleTag(tag)"
            >
              #{{ tag }}
            </button>
          </div>
        </section>

        <div
          v-if="visibleError"
          class="mt-5 rounded-3xl border border-red-200 bg-red-50 p-4 text-sm font-bold leading-6 text-red-700"
        >
          {{ visibleError }}
        </div>

        <section
          v-if="pending"
          class="mt-5 grid gap-4 sm:grid-cols-2 lg:grid-cols-3"
        >
          <div
            v-for="index in 6"
            :key="index"
            class="overflow-hidden rounded-[2rem] border border-neutral-200 bg-white p-3 shadow-sm"
          >
            <div class="h-44 animate-pulse rounded-[1.5rem] bg-neutral-100"></div>
            <div class="p-2 pt-4">
              <div class="h-4 w-32 animate-pulse rounded-full bg-neutral-100"></div>
              <div class="mt-3 h-6 w-4/5 animate-pulse rounded-full bg-neutral-100"></div>
              <div class="mt-3 h-3 w-full animate-pulse rounded-full bg-neutral-100"></div>
              <div class="mt-2 h-3 w-2/3 animate-pulse rounded-full bg-neutral-100"></div>
            </div>
          </div>
        </section>

        <section
          v-else-if="filtered.length === 0"
          class="mt-5 rounded-[2rem] border border-dashed border-neutral-300 bg-white p-10 text-center shadow-sm"
        >
          <div class="mx-auto grid h-16 w-16 place-items-center rounded-3xl bg-blue-50 text-blue-600">
            <Icon icon="solar:document-text-bold-duotone" class="h-8 w-8" />
          </div>
          <h2 class="mt-5 text-xl font-black text-neutral-950">
            Belum ada berita
          </h2>
          <p class="mx-auto mt-2 max-w-md text-sm font-semibold leading-6 text-neutral-500">
            Berita akan tampil otomatis setelah dipublikasikan dari dashboard.
          </p>
        </section>

        <section
          v-else
          class="mt-5 grid gap-4 sm:grid-cols-2 lg:grid-cols-3"
        >
          <article
            v-for="article in paged"
            :key="article.slug"
            class="group overflow-hidden rounded-[2rem] border border-neutral-200 bg-white p-3 shadow-sm shadow-neutral-900/5 transition hover:-translate-y-1 hover:border-blue-200 hover:shadow-xl hover:shadow-blue-900/5"
          >
            <button
              type="button"
              class="block w-full text-left"
              @click="openDetail(article.slug)"
            >
              <div class="relative h-48 overflow-hidden rounded-[1.5rem] bg-neutral-100">
                <img
                  v-if="article.cover && !failedCovers[article.slug]"
                  :src="article.cover"
                  :alt="article.title"
                  class="h-full w-full object-cover transition duration-500 group-hover:scale-105"
                  @error="markCoverFailed(article.slug)"
                >
                <div
                  v-else
                  class="flex h-full w-full items-center justify-center bg-gradient-to-br from-blue-50 via-white to-sky-50 text-blue-600"
                >
                  <Icon icon="solar:document-text-bold-duotone" class="h-12 w-12" />
                </div>

                <div class="absolute inset-0 bg-gradient-to-t from-neutral-950/60 via-neutral-950/5 to-transparent"></div>

                <div class="absolute left-3 top-3 flex flex-wrap gap-2">
                  <span
                    v-if="article.category"
                    class="inline-flex items-center gap-1.5 rounded-full bg-white/90 px-3 py-1 text-[11px] font-black text-neutral-800 backdrop-blur"
                  >
                    <Icon icon="solar:bookmark-bold-duotone" class="h-3.5 w-3.5 text-blue-600" />
                    {{ article.category }}
                  </span>
                </div>
              </div>

              <div class="px-2 pb-2 pt-4">
                <div class="mb-3 flex items-center gap-2 text-[11px] font-black uppercase tracking-[0.12em] text-neutral-400">
                  <span>{{ formatDate(article.publishedAt) }}</span>
                  <span class="h-1 w-1 rounded-full bg-neutral-300"></span>
                  <span>{{ article.readTime }} menit</span>
                </div>

                <h2 class="line-clamp-2 text-lg font-black leading-7 tracking-tight text-neutral-950 transition group-hover:text-blue-700">
                  {{ article.title }}
                </h2>

                <p class="mt-2 line-clamp-3 text-sm font-semibold leading-6 text-neutral-500">
                  {{ article.excerpt || 'Informasi terbaru.' }}
                </p>

                <div class="mt-5 flex items-center justify-between gap-3 border-t border-neutral-100 pt-4">
                  <div class="flex min-w-0 items-center gap-2">
                    <div class="grid h-8 w-8 shrink-0 place-items-center overflow-hidden rounded-xl border border-neutral-200 bg-white">
                      <img
                        v-if="profile.logo && !logoImageFailed"
                        :src="profile.logo"
                        :alt="profile.name"
                        class="h-5 w-5 object-contain"
                      >
                      <Icon
                        v-else
                        icon="solar:document-text-bold-duotone"
                        class="h-4 w-4 text-blue-600"
                      />
                    </div>
                    <span class="truncate text-xs font-black text-neutral-500">
                      {{ profile.name }}
                    </span>
                  </div>

                  <span class="grid h-9 w-9 shrink-0 place-items-center rounded-2xl bg-blue-50 text-blue-600 transition group-hover:bg-blue-600 group-hover:text-white">
                    <Icon icon="solar:arrow-right-up-linear" class="h-4 w-4" />
                  </span>
                </div>
              </div>
            </button>
          </article>
        </section>

        <div
          v-if="hasMore && !pending"
          class="mt-8 flex justify-center"
        >
          <button
            type="button"
            class="inline-flex items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-5 py-3 text-sm font-black text-neutral-700 shadow-sm transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
            @click="loadMore"
          >
            <Icon icon="solar:alt-arrow-down-bold-duotone" class="h-5 w-5" />
            Tampilkan Lagi
          </button>
        </div>
      </template>
    </section>

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
          v-if="imageModalOpen"
          class="fixed inset-0 z-[9999] bg-neutral-950/90 p-3 backdrop-blur-md sm:p-5"
          role="dialog"
          aria-modal="true"
          @click.self="closeImageModal"
        >
          <div class="flex h-full flex-col overflow-hidden rounded-[2rem] border border-white/10 bg-neutral-950 shadow-2xl shadow-neutral-950">
            <div class="flex shrink-0 items-center justify-between gap-3 border-b border-white/10 bg-white/5 px-3 py-3 backdrop-blur-xl sm:px-4">
              <div class="min-w-0">
                <p class="text-[11px] font-black uppercase tracking-[0.16em] text-blue-300">
                  Preview Gambar
                </p>
                <h3 class="mt-0.5 truncate text-sm font-black text-white sm:text-base">
                  {{ imageModalAlt }}
                </h3>
              </div>

              <div class="flex shrink-0 items-center gap-1 rounded-2xl border border-white/10 bg-white/5 p-1">
                <button
                  type="button"
                  class="image-toolbar-button"
                  aria-label="Zoom out"
                  @click="zoomOutImage"
                >
                  <Icon icon="solar:magnifer-zoom-out-bold-duotone" class="h-5 w-5" />
                </button>

                <button
                  type="button"
                  class="hidden h-10 min-w-16 items-center justify-center rounded-xl px-2 text-xs font-black text-white transition hover:bg-white/10 sm:inline-flex"
                  @click="resetImageZoom"
                >
                  {{ Math.round(imageZoom * 100) }}%
                </button>

                <button
                  type="button"
                  class="image-toolbar-button"
                  aria-label="Zoom in"
                  @click="zoomInImage"
                >
                  <Icon icon="solar:magnifer-zoom-in-bold-duotone" class="h-5 w-5" />
                </button>

                <div class="mx-1 h-5 w-px bg-white/10"></div>

                <button
                  type="button"
                  class="image-toolbar-button"
                  aria-label="Reset zoom"
                  @click="resetImageZoom"
                >
                  <Icon icon="solar:restart-bold-duotone" class="h-5 w-5" />
                </button>

                <button
                  type="button"
                  class="image-toolbar-button text-red-200 hover:bg-red-500/20 hover:text-white"
                  aria-label="Tutup"
                  @click="closeImageModal"
                >
                  <Icon icon="solar:close-circle-bold-duotone" class="h-5 w-5" />
                </button>
              </div>
            </div>

            <div
              ref="imageModalViewport"
              class="relative min-h-0 flex-1 overflow-auto bg-[radial-gradient(circle_at_center,rgba(37,99,235,0.18),transparent_34%),linear-gradient(45deg,rgba(255,255,255,0.04)_25%,transparent_25%,transparent_75%,rgba(255,255,255,0.04)_75%),linear-gradient(45deg,rgba(255,255,255,0.04)_25%,transparent_25%,transparent_75%,rgba(255,255,255,0.04)_75%)] bg-size-modal-preview p-4"
              @wheel.ctrl.prevent="handleImageWheelZoom"
              @wheel.meta.prevent="handleImageWheelZoom"
            >
              <div class="flex min-h-full min-w-full items-center justify-center">
                <img
                  v-if="imageModalSrc"
                  :src="imageModalSrc"
                  :alt="imageModalAlt"
                  class="max-w-none select-none rounded-2xl border border-white/10 bg-white shadow-2xl shadow-black/40"
                  :style="imageModalStyle"
                  draggable="false"
                >
              </div>
            </div>

            <div class="flex shrink-0 flex-col gap-2 border-t border-white/10 bg-white/5 px-4 py-3 text-xs font-semibold text-white/60 sm:flex-row sm:items-center sm:justify-between">
              <span>Gunakan tombol + / - untuk zoom. Ctrl/Cmd + scroll juga bisa.</span>
              <span>{{ Math.round(imageZoom * 100) }}%</span>
            </div>
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
        <div
          v-if="shareModalOpen"
          class="fixed inset-0 z-[9998] grid place-items-center bg-neutral-950/60 p-4 backdrop-blur-sm"
          role="dialog"
          aria-modal="true"
          @click.self="closeShareModal"
        >
          <section class="w-full max-w-md overflow-hidden rounded-[2rem] border border-neutral-200 bg-white p-2 shadow-2xl shadow-neutral-950/20">
            <div class="flex items-start justify-between gap-4 border-b border-neutral-100 px-4 py-4">
              <div class="min-w-0">
                <p class="text-[11px] font-black uppercase tracking-[0.16em] text-blue-600">
                  Bagikan Berita
                </p>
                <h3 class="mt-1 truncate text-lg font-black text-neutral-950">
                  {{ shareText }}
                </h3>
                <p class="mt-1 text-xs font-semibold leading-5 text-neutral-500">
                  Pilih kanal berbagi atau salin tautan berita.
                </p>
              </div>

              <button
                type="button"
                class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl text-neutral-500 transition hover:bg-neutral-100 hover:text-neutral-950"
                aria-label="Tutup"
                @click="closeShareModal"
              >
                <Icon icon="solar:close-circle-bold-duotone" class="h-6 w-6" />
              </button>
            </div>

            <div class="grid gap-2 p-3">
              <a
                :href="whatsappHref"
                target="_blank"
                rel="noopener"
                class="group flex items-center justify-between gap-3 rounded-2xl border border-neutral-200 bg-white px-4 py-3 text-sm font-black text-neutral-700 transition hover:border-green-200 hover:bg-green-50 hover:text-green-700"
                @click="closeShareModal"
              >
                <span class="inline-flex items-center gap-3">
                  <span class="grid h-10 w-10 place-items-center rounded-2xl bg-green-50 text-green-600 transition group-hover:bg-green-600 group-hover:text-white">
                    <Icon icon="mdi:whatsapp" class="h-6 w-6" />
                  </span>
                  WhatsApp
                </span>
                <Icon icon="solar:arrow-right-up-linear" class="h-5 w-5" />
              </a>

              <a
                :href="facebookHref"
                target="_blank"
                rel="noopener"
                class="group flex items-center justify-between gap-3 rounded-2xl border border-neutral-200 bg-white px-4 py-3 text-sm font-black text-neutral-700 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
                @click="closeShareModal"
              >
                <span class="inline-flex items-center gap-3">
                  <span class="grid h-10 w-10 place-items-center rounded-2xl bg-blue-50 text-blue-600 transition group-hover:bg-blue-600 group-hover:text-white">
                    <Icon icon="mdi:facebook" class="h-6 w-6" />
                  </span>
                  Facebook
                </span>
                <Icon icon="solar:arrow-right-up-linear" class="h-5 w-5" />
              </a>

              <a
                :href="twitterHref"
                target="_blank"
                rel="noopener"
                class="group flex items-center justify-between gap-3 rounded-2xl border border-neutral-200 bg-white px-4 py-3 text-sm font-black text-neutral-700 transition hover:border-neutral-300 hover:bg-neutral-950 hover:text-white"
                @click="closeShareModal"
              >
                <span class="inline-flex items-center gap-3">
                  <span class="grid h-10 w-10 place-items-center rounded-2xl bg-neutral-100 text-neutral-950 transition group-hover:bg-white group-hover:text-neutral-950">
                    <Icon icon="ri:twitter-x-line" class="h-5 w-5" />
                  </span>
                  X / Twitter
                </span>
                <Icon icon="solar:arrow-right-up-linear" class="h-5 w-5" />
              </a>

              <button
                type="button"
                class="group flex items-center justify-between gap-3 rounded-2xl border border-neutral-200 bg-white px-4 py-3 text-sm font-black text-neutral-700 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
                @click="copyShare"
              >
                <span class="inline-flex items-center gap-3">
                  <span
                    class="grid h-10 w-10 place-items-center rounded-2xl transition"
                    :class="copied ? 'bg-blue-600 text-white' : 'bg-blue-50 text-blue-600 group-hover:bg-blue-600 group-hover:text-white'"
                  >
                    <Icon :icon="copied ? 'solar:check-circle-bold-duotone' : 'solar:link-bold-duotone'" class="h-5 w-5" />
                  </span>
                  {{ copied ? 'Link Tersalin' : 'Salin Link' }}
                </span>
                <Icon icon="solar:copy-bold-duotone" class="h-5 w-5" />
              </button>

              <div class="mt-2 rounded-2xl border border-neutral-200 bg-neutral-50 p-3">
                <p class="text-[11px] font-black uppercase tracking-[0.14em] text-neutral-400">
                  Link Berita
                </p>
                <p class="mt-1 line-clamp-2 break-all text-xs font-semibold leading-5 text-neutral-600">
                  {{ shareUrl }}
                </p>
              </div>
            </div>
          </section>
        </div>
      </Transition>
    </Teleport>
  </main>
</template>

<script setup lang="ts">
import { computed, onBeforeUnmount, onMounted, ref, watch } from 'vue'
import { Icon } from '@iconify/vue'
import { useHead, useRequestURL, useRoute, useRuntimeConfig, useSeoMeta, useRouter } from 'nuxt/app'
import type { NewsItem, NewsListResponse } from '../../types/news'
import { useAppApi } from '../composables/useAppApi'
import { useNewsComments } from '../composables/data/useNewsComments'
import CommentsSection from '../components/widget/CommentNewsSection.vue'
import type { NewsCommentItem, NewsCommentListResponse } from '../../types/news-comment'

type NewsMode = 'martopuro' | 'obayan'
type NewsSort = 'newest' | 'oldest' | 'title'

type NewsCard = NewsItem & {
  excerpt: string
  cover: string
  readTime: number
}

const runtime = useRuntimeConfig()
const route = useRoute()
const router = useRouter()
const requestUrl = useRequestURL()

const q = ref('')
const selectedCategory = ref('')
const selectedTags = ref<Set<string>>(new Set())
const sortBy = ref<NewsSort>('newest')
const page = ref(1)
const pageSize = ref(9)
const copied = ref(false)
const heroImageFailed = ref(false)
const logoImageFailed = ref(false)
const failedCovers = ref<Record<string, boolean>>({})

const imageModalOpen = ref(false)
const imageModalSrc = ref('')
const imageModalAlt = ref('')
const imageZoom = ref(1)
const imageModalViewport = ref<HTMLElement | null>(null)

const shareModalOpen = ref(false)

let copiedTimer: ReturnType<typeof setTimeout> | null = null

const hostname = computed(() => {
  return String(requestUrl.hostname || '')
    .replace(/^www\./, '')
    .toLowerCase()
})

const envClientName = computed(() => {
  return String(runtime.public.clientName || 'obayan')
    .trim()
    .toLowerCase()
})

const isRailwayDomain = computed(() => {
  return (
    hostname.value === 'obayanweb-production.up.railway.app' ||
    hostname.value.endsWith('.railway.app') ||
    hostname.value.endsWith('.up.railway.app')
  )
})

const tenantSlug = computed(() => {
  if (isRailwayDomain.value) return 'martopuro'
  if (hostname.value.includes('martopuro')) return 'martopuro'
  if (hostname.value.includes('obayan')) return 'obayan'
  return envClientName.value || 'obayan'
})

const mode = computed<NewsMode>(() => {
  if (tenantSlug.value === 'martopuro') return 'martopuro'
  return 'obayan'
})

const profile = computed(() => {
  const clientDisplayName = String(
    runtime.public.clientDisplayName ||
    runtime.public.siteName ||
    runtime.public.appName ||
    (mode.value === 'martopuro' ? 'Desa Martopuro' : 'Obayan')
  )

  const titleFromEnv = String(runtime.public.newsTitle || '').trim()
  const subtitleFromEnv = String(runtime.public.newsSubtitle || '').trim()
  const eyebrowFromEnv = String(runtime.public.newsEyebrow || '').trim()
  const authorFromEnv = String(runtime.public.newsAuthor || '').trim()
  const logoFromEnv = String(runtime.public.appLogo || runtime.public.logo || '').trim()
  const heroFromEnv = String(runtime.public.newsHeroImage || runtime.public.heroImage || '').trim()

  if (mode.value === 'martopuro') {
    return {
      name: clientDisplayName,
      title: titleFromEnv || `Berita ${clientDisplayName}`,
      subtitle:
        subtitleFromEnv ||
        `Informasi resmi ${clientDisplayName}, mulai dari pelayanan publik, kegiatan warga, pengumuman desa, pembangunan, kesehatan, pendidikan, hingga potensi lokal.`,
      eyebrow: eyebrowFromEnv || 'Kabar Terbaru',
      baseTitle: titleFromEnv || `Berita | ${clientDisplayName}`,
      baseDesc: subtitleFromEnv || `Kumpulan berita dan informasi resmi ${clientDisplayName}.`,
      authorName: authorFromEnv || clientDisplayName,
      logo: logoFromEnv || '/assets/images/logo-martopuro.png',
      heroImage: heroImageFailed.value ? '/assets/images/profile.png' : heroFromEnv || '/assets/images/profile.png',
      themeColor: '#2563eb'
    }
  }

  return {
    name: clientDisplayName,
    title: titleFromEnv || `Berita ${clientDisplayName}`,
    subtitle:
      subtitleFromEnv ||
      `Informasi terbaru dari ${clientDisplayName}, mulai dari update produk, tutorial, artikel edukasi, case study, hingga pengumuman platform.`,
    eyebrow: eyebrowFromEnv || 'Kabar Terbaru',
    baseTitle: titleFromEnv || `Berita | ${clientDisplayName}`,
    baseDesc: subtitleFromEnv || `Kumpulan berita, artikel, dan informasi resmi ${clientDisplayName}.`,
    authorName: authorFromEnv || clientDisplayName,
    logo: logoFromEnv || '/logo.png',
    heroImage: heroImageFailed.value ? '/assets/images/profile.png' : heroFromEnv || '/assets/images/profile.png',
    themeColor: '#2563eb'
  }
})

const activeSlug = computed(() => {
  const detail = route.query.detail
  const legacyNews = route.query.news
  const value = typeof detail === 'string' ? detail : legacyNews

  return typeof value === 'string'
    ? value.trim().toLowerCase()
    : ''
})

const { tenantApiUrl } = useAppApi()
const newsComments = useNewsComments()
const apiUrl = computed(() => tenantApiUrl(tenantSlug.value, '/news'))

const buildNonce = Date.now()

const {
  data,
  pending,
  error,
  refresh
} = await useFetch<NewsListResponse>(apiUrl, {
  key: computed(() => `public-news-sql-${tenantSlug.value}-${buildNonce}`),
  server: true,
  immediate: true,
  query: computed(() => ({
    status: 'published',
    limit: 100,
    sort: 'newest',
    _t: buildNonce
  })),
  watch: [tenantSlug],
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

async function refreshPublicNews() {
  await refresh()
}

const items = computed<NewsCard[]>(() => {
  return (data.value?.data || []).map(normalizeNewsItem)
})

const isDetail = computed(() => Boolean(activeSlug.value))

const current = computed(() => {
  if (!activeSlug.value) return null
  return items.value.find((item) => String(item.slug || '').toLowerCase() === activeSlug.value) || null
})

const currentNewsId = computed(() => {
  return String(current.value?.id || '')
})

const commentsApiUrl = computed(() => tenantApiUrl(tenantSlug.value, '/news-comments'))

const {
  data: commentsResponse,
  refresh: refreshComments
} = await useFetch<NewsCommentListResponse>(commentsApiUrl, {
  key: computed(() => `public-news-comments-${tenantSlug.value}-${currentNewsId.value || 'none'}`),
  server: false,
  query: computed(() => ({
    newsId: currentNewsId.value || '__empty__',
    status: 'approved',
    limit: 100,
    sort: 'newest'
  })),
  watch: [tenantSlug, currentNewsId],
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

const publicComments = computed(() => {
  return (commentsResponse.value?.data || []).map(mapNewsCommentRecord)
})

const categories = computed(() => {
  return Array.from(
    new Set(
      items.value
        .map((item) => item.category)
        .filter(Boolean) as string[]
    )
  )
})

const allTags = computed(() => {
  return Array.from(new Set(items.value.flatMap((item) => item.tags || [])))
})

const filtered = computed(() => {
  let rows = [...items.value]

  const keyword = q.value.trim().toLowerCase()

  if (keyword) {
    rows = rows.filter((item) => {
      return [
        item.title,
        item.excerpt,
        item.descriptionCard,
        item.descriptionContent,
        item.category,
        ...(item.tags || [])
      ]
        .filter(Boolean)
        .join(' ')
        .toLowerCase()
        .includes(keyword)
    })
  }

  if (selectedCategory.value) {
    rows = rows.filter((item) => item.category === selectedCategory.value)
  }

  if (selectedTags.value.size) {
    rows = rows.filter((item) => item.tags?.some((tag: string) => selectedTags.value.has(tag)))
  }

  if (sortBy.value === 'newest') {
    rows.sort((a, b) => Number(b.publishedAt || 0) - Number(a.publishedAt || 0))
  }

  if (sortBy.value === 'oldest') {
    rows.sort((a, b) => Number(a.publishedAt || 0) - Number(b.publishedAt || 0))
  }

  if (sortBy.value === 'title') {
    rows.sort((a, b) => String(a.title || '').localeCompare(String(b.title || '')))
  }

  return rows
})

const paged = computed(() => filtered.value.slice(0, page.value * pageSize.value))
const hasMore = computed(() => paged.value.length < filtered.value.length)

const renderedDetailHtml = computed(() => {
  if (!current.value?.descriptionContent) return ''
  return sanitizeHtml(current.value.descriptionContent)
})

const visibleError = computed(() => {
  if (!error.value) return ''
  return error.value?.message || 'Terjadi kesalahan saat memuat berita.'
})

type NewsCommentPayload = {
  targetId: string
  parentId: string | null
  name: string
  email: string
  comment: string
  createdAt: string
  record?: {
    id: string
    targetId: string
    parentId: string | null
    name: string
    email: string
    comment: string
    createdAt: string
    likes: number
    dislikes: number
  }
}

async function handleNewsCommentSubmit(payload: NewsCommentPayload) {
  await submitNewsComment(payload)
}

async function handleNewsCommentReply(payload: NewsCommentPayload) {
  await submitNewsComment(payload)
}

function mapNewsCommentRecord(item: NewsCommentItem) {
  return {
    id: item.id,
    targetId: item.newsId || item.targetId,
    parentId: item.parentId,
    name: item.authorName || item.name,
    email: item.authorEmail || item.email,
    comment: item.content || item.comment,
    createdAt: new Date(item.createdAt || Date.now()).toISOString(),
    likes: Number(item.likesCount || item.likes || 0),
    dislikes: Number(item.dislikesCount || item.dislikes || 0)
  }
}

async function submitNewsComment(payload: NewsCommentPayload) {
  if (!currentNewsId.value) return

  try {
    const created = await newsComments.createComment(tenantSlug.value, {
      newsId: currentNewsId.value,
      parentId: payload.parentId,
      name: payload.name,
      email: payload.email,
      comment: payload.comment
    })

    if (payload.record && created?.id) {
      payload.record.id = created.id
      payload.record.targetId = created.newsId || currentNewsId.value
      payload.record.parentId = created.parentId
    }

    await refreshComments()
  } catch (error) {
    console.error('Komentar gagal dikirim ke API:', error)
  }
}

const imageModalStyle = computed(() => {
  return {
    width: `${Math.round(imageZoom.value * 100)}%`,
    maxWidth: imageZoom.value <= 1 ? '100%' : 'none',
    transformOrigin: 'center center'
  }
})

const safeSiteUrl = computed(() => {
  const value = String(runtime.public.siteUrl || '').trim()
  if (value) return value.replace(/\/$/, '')
  return `${requestUrl.protocol}//${requestUrl.host}`
})

const canonical = computed(() => new URL(route.fullPath || '/', safeSiteUrl.value).toString())
const shareUrl = computed(() => canonical.value)

const pageTitle = computed(() => {
  if (isDetail.value && current.value?.title) return `${current.value.title} | ${profile.value.name}`
  return profile.value.baseTitle
})

const pageDesc = computed(() => {
  if (isDetail.value && current.value?.excerpt) return current.value.excerpt
  return profile.value.baseDesc
})

const pageImage = computed(() => current.value?.cover || profile.value.logo || '/assets/logo.png')

const shareText = computed(() => {
  return current.value?.title && isDetail.value ? current.value.title : profile.value.baseTitle
})

const encodedUrl = computed(() => encodeURIComponent(shareUrl.value))
const encodedText = computed(() => encodeURIComponent(`${shareText.value} - ${shareUrl.value}`))

const facebookHref = computed(() => {
  return `https://www.facebook.com/sharer/sharer.php?u=${encodedUrl.value}`
})

const twitterHref = computed(() => {
  return `https://twitter.com/intent/tweet?url=${encodedUrl.value}&text=${encodeURIComponent(shareText.value)}`
})

const whatsappHref = computed(() => {
  return `https://wa.me/?text=${encodedText.value}`
})

watch([q, selectedCategory, sortBy], () => {
  page.value = 1
})

watch(tenantSlug, () => {
  refreshPublicNews()
})

onMounted(() => {
  document.addEventListener('keydown', handleGlobalKeydown)
  refreshPublicNews()
})

onBeforeUnmount(() => {
  document.removeEventListener('keydown', handleGlobalKeydown)

  if (copiedTimer) {
    clearTimeout(copiedTimer)
  }
})

function normalizeNewsItem(item: NewsItem): NewsCard {
  const raw = item as NewsItem & Record<string, any>

  const contentHtml = htmlFromNewsContent(
    raw.content ||
    raw.descriptionContent ||
    raw.description_content ||
    raw.body ||
    raw.contentHtml ||
    raw.content_html ||
    ''
  )

  const excerpt =
    raw.excerpt ||
    raw.descriptionCard ||
    raw.description_card ||
    raw.summary ||
    plainText(contentHtml).slice(0, 180)

  const contentText = plainText(contentHtml || excerpt)
  const estimatedReadTime = Math.max(
    1,
    Math.ceil(contentText.split(/\s+/).filter(Boolean).length / 220)
  )

  const cover =
    raw.cover ||
    raw.coverUrl ||
    raw.cover_url ||
    raw.coverImage ||
    raw.cover_image ||
    raw.image ||
    raw.imageUrl ||
    raw.image_url ||
    ''

  return {
    ...raw,
    id: raw.id || raw.uuid || raw._id || raw.slug,
    title: raw.title || raw.name || 'Tanpa Judul',
    slug: String(raw.slug || slugifyNews(raw.title || raw.name || 'berita')).toLowerCase(),
    cover,
    coverUrl: cover,
    excerpt,
    descriptionCard: excerpt,
    descriptionContent: contentHtml,
    category: raw.category || raw.categoryName || raw.category_name || '',
    tags: normalizeNewsTags(raw.tags || raw.tagNames || raw.tag_names),
    publishedAt: normalizeNewsDate(
      raw.publishedAt ||
      raw.published_at ||
      raw.createdAt ||
      raw.created_at ||
      raw.updatedAt ||
      raw.updated_at
    ),
    readTime: Number(raw.readTime || raw.read_time || estimatedReadTime || 1)
  } as NewsCard
}

function htmlFromNewsContent(value: unknown) {
  if (!value) return ''

  if (typeof value === 'string') {
    try {
      const parsed = JSON.parse(value)

      if (parsed && typeof parsed === 'object' && typeof parsed.html === 'string') {
        return parsed.html
      }
    } catch {
      return value
    }

    return value
  }

  if (typeof value === 'object' && value !== null && 'html' in value) {
    return String((value as { html?: unknown }).html || '')
  }

  return ''
}

function normalizeNewsDate(value: unknown) {
  if (!value) return Date.now()

  if (typeof value === 'number') {
    return value < 10_000_000_000 ? value * 1000 : value
  }

  const parsed = new Date(String(value)).getTime()
  return Number.isNaN(parsed) ? Date.now() : parsed
}

function normalizeNewsTags(value: unknown): string[] {
  if (Array.isArray(value)) {
    return value.map((tag) => String(tag || '').trim()).filter(Boolean)
  }

  if (typeof value === 'string') {
    try {
      const parsed = JSON.parse(value)
      if (Array.isArray(parsed)) return normalizeNewsTags(parsed)
    } catch {
      return value.split(',').map((tag) => tag.trim()).filter(Boolean)
    }
  }

  return []
}

function slugifyNews(value: string) {
  return String(value || '')
    .trim()
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9\s-]/g, '')
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-')
    .replace(/^-|-$/g, '')
}

function toggleTag(tag: string) {
  const next = new Set(selectedTags.value)

  if (next.has(tag)) next.delete(tag)
  else next.add(tag)

  selectedTags.value = next
  page.value = 1
}

async function filterByTagAndBack(tag: string) {
  selectedTags.value = new Set([tag])
  page.value = 1
  await backToList()
}

function resetFilters() {
  q.value = ''
  selectedCategory.value = ''
  selectedTags.value = new Set()
  sortBy.value = 'newest'
  page.value = 1
}

async function openDetail(slug: string) {
  await router.push({
    query: {
      ...route.query,
      detail: slug
    }
  })
}

async function backToList() {
  const query = { ...route.query }
  delete query.detail
  delete query.news
  await router.push({ query })
}

function loadMore() {
  page.value += 1
}

function markCoverFailed(slug: string) {
  failedCovers.value = {
    ...failedCovers.value,
    [slug]: true
  }
}

function formatDate(timestamp?: number) {
  if (!timestamp) return '-'

  return new Intl.DateTimeFormat('id-ID', {
    day: '2-digit',
    month: 'short',
    year: 'numeric'
  }).format(new Date(timestamp))
}

function openImageModal(src: string, alt: string) {
  imageModalSrc.value = src
  imageModalAlt.value = alt || 'Gambar berita'
  imageZoom.value = 1
  imageModalOpen.value = true
}

function closeImageModal() {
  imageModalOpen.value = false
  imageModalSrc.value = ''
  imageModalAlt.value = ''
  imageZoom.value = 1
}

function zoomInImage() {
  imageZoom.value = Math.min(4, Number((imageZoom.value + 0.25).toFixed(2)))
}

function zoomOutImage() {
  imageZoom.value = Math.max(0.5, Number((imageZoom.value - 0.25).toFixed(2)))
}

function resetImageZoom() {
  imageZoom.value = 1

  if (imageModalViewport.value) {
    imageModalViewport.value.scrollTop = 0
    imageModalViewport.value.scrollLeft = 0
  }
}

function handleImageWheelZoom(event: WheelEvent) {
  if (event.deltaY < 0) {
    zoomInImage()
    return
  }

  zoomOutImage()
}

function openShareModal() {
  shareModalOpen.value = true
}

function closeShareModal() {
  shareModalOpen.value = false
}

async function writeToClipboard(value: string) {
  if (typeof navigator !== 'undefined' && navigator.clipboard?.writeText) {
    await navigator.clipboard.writeText(value)
    return
  }

  if (typeof document === 'undefined') return

  const textarea = document.createElement('textarea')
  textarea.value = value
  textarea.setAttribute('readonly', '')
  textarea.style.position = 'fixed'
  textarea.style.left = '-9999px'
  textarea.style.top = '-9999px'

  document.body.appendChild(textarea)
  textarea.select()
  document.execCommand('copy')
  document.body.removeChild(textarea)
}

function showCopiedFeedback() {
  copied.value = true

  if (copiedTimer) {
    clearTimeout(copiedTimer)
  }

  copiedTimer = setTimeout(() => {
    copied.value = false
  }, 1400)
}

async function copyLink() {
  try {
    await writeToClipboard(canonical.value)
    showCopiedFeedback()
  } catch {}
}

async function copyShare() {
  try {
    await writeToClipboard(shareUrl.value)
    showCopiedFeedback()
  } catch {}
}

async function nativeShare() {
  try {
    if (typeof navigator !== 'undefined' && navigator.share) {
      await navigator.share({
        title: shareText.value,
        text: shareText.value,
        url: shareUrl.value
      })
    } else {
      openShareModal()
    }
  } catch {}
}

function handleGlobalKeydown(event: KeyboardEvent) {
  if (event.key !== 'Escape') return

  if (shareModalOpen.value) {
    closeShareModal()
  }

  if (imageModalOpen.value) {
    closeImageModal()
  }
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

function sanitizeHtml(value: string) {
  return String(value || '')
    .replace(/<script[\s\S]*?>[\s\S]*?<\/script>/gi, '')
    .replace(/<style[\s\S]*?>[\s\S]*?<\/style>/gi, '')
    .replace(/\son\w+="[^"]*"/gi, '')
    .replace(/\son\w+='[^']*'/gi, '')
    .replace(/javascript:/gi, '')
}

function onHeroImageError() {
  heroImageFailed.value = true
}

useSeoMeta({
  title: pageTitle,
  description: pageDesc,
  ogTitle: pageTitle,
  ogDescription: pageDesc,
  ogType: computed(() => (isDetail.value ? 'article' : 'website')),
  ogUrl: canonical,
  ogImage: pageImage,
  twitterCard: 'summary_large_image',
  twitterSite: runtime.public.twitterSite || undefined,
  themeColor: computed(() => profile.value.themeColor),
  robots: 'index, follow'
})

useHead(() => {
  return {
    htmlAttrs: {
      lang: 'id'
    },
    link: [
      {
        rel: 'canonical',
        href: canonical.value
      }
    ],
    meta: [
      {
        name: 'theme-color',
        content: profile.value.themeColor
      }
    ]
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

.bg-size-modal-preview {
  background-size:
    auto,
    32px 32px,
    32px 32px;
  background-position:
    center,
    0 0,
    16px 16px;
}

.image-toolbar-button {
  display: inline-flex;
  height: 2.5rem;
  width: 2.5rem;
  align-items: center;
  justify-content: center;
  border-radius: 0.75rem;
  color: rgba(255, 255, 255, 0.78);
  transition: 160ms ease;
}

.image-toolbar-button:hover {
  background: rgba(255, 255, 255, 0.1);
  color: white;
}

.news-content :deep(h2) {
  margin-top: 2rem;
  margin-bottom: 0.75rem;
  font-size: 1.75rem;
  line-height: 1.2;
  font-weight: 900;
  letter-spacing: -0.03em;
  color: #171717;
}

.news-content :deep(h3) {
  margin-top: 1.5rem;
  margin-bottom: 0.65rem;
  font-size: 1.35rem;
  line-height: 1.3;
  font-weight: 900;
  color: #171717;
}

.news-content :deep(p) {
  margin: 0.9rem 0;
}

.news-content :deep(a) {
  color: rgb(37 99 235);
  font-weight: 800;
  text-decoration: underline;
  text-underline-offset: 4px;
}

.news-content :deep(ul),
.news-content :deep(ol) {
  margin: 1rem 0;
  padding-left: 1.35rem;
}

.news-content :deep(li) {
  margin: 0.35rem 0;
}

.news-content :deep(blockquote) {
  margin: 1.25rem 0;
  border-left: 4px solid rgb(37 99 235);
  border-radius: 0.75rem;
  background: #fafafa;
  padding: 1rem 1.25rem;
  color: #525252;
}

.news-content :deep(img) {
  margin: 1.25rem 0;
  max-width: 100%;
  height: auto;
  border-radius: 1.25rem;
  border: 1px solid rgb(229 229 229);
}

.news-content :deep(iframe) {
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

.line-clamp-3 {
  display: -webkit-box;
  -webkit-line-clamp: 3;
  line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>
