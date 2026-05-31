<!-- /pages/app/news.vue -->
<template>
  <section class="min-h-full bg-neutral-50 text-neutral-950" @click="closeEllipsisMenu">
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
            class="rounded-3xl border bg-white/95 p-4 shadow-[0_24px_80px_rgba(15,23,42,0.16)] backdrop-blur-xl"
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
                @click.stop="closeToast"
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
              :disabled="isLoading"
              @click.stop="reloadNews"
            >
              <Icon icon="solar:refresh-bold-duotone" class="h-5 w-5" :class="isLoading ? 'animate-spin' : ''" />
              Refresh
            </button>

            <button
              type="button"
              class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700"
              @click.stop="openCreateNewsModal"
            >
              <Icon icon="lucide:plus" class="h-5 w-5" />
              Tambah
            </button>
          </div>
        </div>
      </section>

      <section class="grid gap-3 sm:grid-cols-2 xl:grid-cols-4">
        <div class="rounded-3xl border border-neutral-200 bg-white p-4 shadow-sm">
          <div class="flex items-center justify-between gap-3">
            <div>
              <p class="text-[11px] font-black uppercase tracking-[0.14em] text-neutral-400">Total Berita</p>
              <p class="mt-2 text-2xl font-black text-neutral-950">{{ normalizedNews.length }}</p>
            </div>
            <div class="grid h-11 w-11 place-items-center rounded-2xl bg-blue-50 text-blue-600">
              <Icon icon="solar:documents-bold-duotone" class="h-6 w-6" />
            </div>
          </div>
        </div>

        <div class="rounded-3xl border border-neutral-200 bg-white p-4 shadow-sm">
          <div class="flex items-center justify-between gap-3">
            <div>
              <p class="text-[11px] font-black uppercase tracking-[0.14em] text-neutral-400">Terbit</p>
              <p class="mt-2 text-2xl font-black text-neutral-950">{{ publishedCount }}</p>
            </div>
            <div class="grid h-11 w-11 place-items-center rounded-2xl bg-emerald-50 text-emerald-600">
              <Icon icon="solar:check-circle-bold-duotone" class="h-6 w-6" />
            </div>
          </div>
        </div>

        <div class="rounded-3xl border border-neutral-200 bg-white p-4 shadow-sm">
          <div class="flex items-center justify-between gap-3">
            <div>
              <p class="text-[11px] font-black uppercase tracking-[0.14em] text-neutral-400">Draft</p>
              <p class="mt-2 text-2xl font-black text-neutral-950">{{ draftCount }}</p>
            </div>
            <div class="grid h-11 w-11 place-items-center rounded-2xl bg-amber-50 text-amber-600">
              <Icon icon="solar:document-add-bold-duotone" class="h-6 w-6" />
            </div>
          </div>
        </div>

        <div class="rounded-3xl border border-neutral-200 bg-white p-4 shadow-sm">
          <div class="flex items-center justify-between gap-3">
            <div>
              <p class="text-[11px] font-black uppercase tracking-[0.14em] text-neutral-400">Draft Lokal</p>
              <p class="mt-2 text-2xl font-black text-neutral-950">{{ localDraftExists ? 'Ada' : '-' }}</p>
            </div>
            <div class="grid h-11 w-11 place-items-center rounded-2xl bg-purple-50 text-purple-600">
              <Icon icon="solar:database-bold-duotone" class="h-6 w-6" />
            </div>
          </div>
        </div>
      </section>

      <section class="rounded-3xl border border-neutral-200 bg-white p-3 shadow-sm sm:p-4">
        <div class="flex flex-col gap-3 lg:flex-row lg:items-center lg:justify-between">
          <div class="relative min-w-0 flex-1">
            <Icon icon="solar:magnifer-linear" class="pointer-events-none absolute left-4 top-1/2 h-5 w-5 -translate-y-1/2 text-neutral-400" />
            <input
              v-model.trim="search"
              type="text"
              :placeholder="profile.searchPlaceholder"
              class="h-12 w-full rounded-2xl border border-neutral-200 bg-neutral-50 pl-12 pr-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:bg-white focus:ring-4 focus:ring-blue-600/10"
            >
          </div>

          <div class="flex gap-2 overflow-x-auto pb-1 lg:max-w-xl">
            <button
              type="button"
              class="shrink-0 rounded-2xl px-4 py-2.5 text-xs font-black transition"
              :class="selectedCategory === 'all' ? 'bg-blue-600 text-white shadow-lg shadow-blue-600/20' : 'border border-neutral-200 bg-white text-neutral-600 hover:bg-neutral-50'"
              @click.stop="selectedCategory = 'all'"
            >
              Semua
            </button>

            <button
              v-for="category in categoryOptions"
              :key="category"
              type="button"
              class="shrink-0 rounded-2xl px-4 py-2.5 text-xs font-black transition"
              :class="selectedCategory === category ? 'bg-blue-600 text-white shadow-lg shadow-blue-600/20' : 'border border-neutral-200 bg-white text-neutral-600 hover:bg-neutral-50'"
              @click.stop="selectedCategory = category"
            >
              {{ category }}
            </button>
          </div>
        </div>
      </section>

      <div class="mt-3 flex gap-2 overflow-x-auto pb-1 pb-5">
        <button
          v-for="option in statusFilterOptions"
          :key="option.value"
          type="button"
          class="inline-flex shrink-0 items-center gap-2 rounded-2xl px-4 py-2.5 text-xs font-black transition"
          :class="selectedStatus === option.value
            ? 'bg-neutral-950 text-white shadow-lg shadow-neutral-950/15'
            : 'border border-neutral-200 bg-white text-neutral-600 hover:bg-neutral-50'"
          @click.stop="selectedStatus = option.value"
        >
          <Icon :icon="option.icon" class="h-4 w-4" />
          {{ option.label }}
          <span
            class="rounded-full px-2 py-0.5 text-[10px] font-black"
            :class="selectedStatus === option.value ? 'bg-white/15 text-white' : 'bg-neutral-100 text-neutral-500'"
          >
            {{ option.count }}
          </span>
        </button>
      </div>

      <div v-if="visibleError" class="rounded-3xl border border-red-200 bg-red-50 p-4 text-sm font-bold leading-6 text-red-700">
        {{ visibleError }}
      </div>

      <section v-if="isLoading" class="grid gap-3 sm:grid-cols-2 xl:grid-cols-3">
        <div v-for="item in 6" :key="item" class="h-80 animate-pulse rounded-[1.75rem] border border-neutral-200 bg-white p-3">
          <div class="h-40 rounded-[1.35rem] bg-neutral-100"></div>
          <div class="mt-4 h-4 w-2/3 rounded-full bg-neutral-100"></div>
          <div class="mt-3 h-3 w-full rounded-full bg-neutral-100"></div>
          <div class="mt-2 h-3 w-4/5 rounded-full bg-neutral-100"></div>
        </div>
      </section>

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
          @click.stop="openCreateNewsModal"
        >
          <Icon icon="lucide:plus" class="h-5 w-5" />
          Tambah Berita Desa
        </button>
      </section>

      <section v-else class="grid gap-3 sm:grid-cols-2 xl:grid-cols-3">
        <article
          v-for="item in pagedNews"
          :key="item.id"
          class="group relative overflow-hidden rounded-[1.75rem] border border-neutral-200 bg-white shadow-sm transition hover:-translate-y-0.5 hover:border-blue-200 hover:shadow-xl hover:shadow-blue-900/5"
        >
          <div class="relative h-44 overflow-hidden bg-neutral-100">
            <img
              v-if="item.cover"
              :src="item.cover"
              :alt="item.title"
              class="h-full w-full object-cover transition duration-500 group-hover:scale-105"
              loading="lazy"
            >

            <div v-else class="flex h-full w-full items-center justify-center bg-gradient-to-br from-blue-50 via-white to-sky-50 text-blue-600">
              <Icon icon="solar:gallery-wide-bold-duotone" class="h-10 w-10" />
            </div>

            <div class="absolute inset-0 bg-gradient-to-t from-neutral-950/60 via-neutral-950/10 to-transparent"></div>

            <div class="absolute left-3 top-3 flex flex-wrap gap-2">
              <span class="rounded-full bg-white/90 px-3 py-1 text-[11px] font-black text-neutral-900 shadow-sm backdrop-blur">
                {{ item.category || profile.defaultCategory }}
              </span>

              <span class="rounded-full px-3 py-1 text-[11px] font-black shadow-sm backdrop-blur" :class="statusClass(item.status)">
                {{ statusLabel(item.status) }}
              </span>
            </div>

            <button
              type="button"
              class="absolute right-3 top-3 grid h-10 w-10 place-items-center rounded-2xl border border-white/70 bg-white/95 text-neutral-700 shadow-lg shadow-neutral-950/10 backdrop-blur transition hover:bg-neutral-950 hover:text-white"
              aria-label="Buka menu berita"
              @click.stop="openEllipsisMenu(item, $event)"
            >
              <Icon icon="lucide:ellipsis" class="h-5 w-5" />
            </button>
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

            <p class="mt-2 line-clamp-3 text-sm font-medium leading-6 text-neutral-500">
              {{ item.excerpt || plainTextFromContent(item.content).slice(0, 130) || 'Belum ada ringkasan.' }}
            </p>

            <div v-if="item.tags.length" class="mt-3 flex flex-wrap gap-1.5">
              <span v-for="tag in item.tags.slice(0, 3)" :key="tag" class="rounded-full bg-neutral-100 px-2.5 py-1 text-[11px] font-bold text-neutral-500">
                #{{ tag }}
              </span>
            </div>
          </div>
        </article>
      </section>

      <div v-if="hasMore && !isLoading" class="flex justify-center">
        <button
          type="button"
          class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-5 text-sm font-black text-neutral-700 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
          @click.stop="page += 1"
        >
          <Icon icon="solar:alt-arrow-down-bold-duotone" class="h-5 w-5" />
          Muat Lainnya
        </button>
      </div>
    </div>

    <Teleport to="body">
      <Transition
        enter-active-class="transition duration-150 ease-out"
        enter-from-class="translate-y-1 scale-95 opacity-0"
        enter-to-class="translate-y-0 scale-100 opacity-100"
        leave-active-class="transition duration-100 ease-in"
        leave-from-class="translate-y-0 scale-100 opacity-100"
        leave-to-class="translate-y-1 scale-95 opacity-0"
      >
        <div
          v-if="activeMenuNews"
          class="fixed z-[9999] w-56 overflow-hidden rounded-3xl border border-neutral-200 bg-white p-2 shadow-[0_24px_90px_rgba(15,23,42,0.22)]"
          :style="{ top: `${ellipsisMenuPosition.top}px`, left: `${ellipsisMenuPosition.left}px` }"
          @click.stop
        >
          <button
            type="button"
            class="flex w-full items-center gap-3 rounded-2xl px-3 py-2.5 text-left text-sm font-black text-neutral-700 transition hover:bg-blue-50 hover:text-blue-700"
            @click="openView(activeMenuNews)"
          >
            <Icon icon="solar:eye-bold-duotone" class="h-5 w-5 text-blue-600" />
            Lihat
          </button>

          <button
            type="button"
            class="flex w-full items-center gap-3 rounded-2xl px-3 py-2.5 text-left text-sm font-black text-neutral-700 transition disabled:cursor-not-allowed disabled:opacity-50"
            :class="activeMenuNews.status === 'draft'
              ? 'hover:bg-emerald-50 hover:text-emerald-700'
              : 'hover:bg-amber-50 hover:text-amber-700'"
            :disabled="isMutating"
            @click="toggleNewsPublishState(activeMenuNews)"
          >
            <Icon
              :icon="activeMenuNews.status === 'draft' ? 'solar:check-circle-bold-duotone' : 'solar:document-add-bold-duotone'"
              class="h-5 w-5"
              :class="activeMenuNews.status === 'draft' ? 'text-emerald-600' : 'text-amber-600'"
            />
            {{ activeMenuNews.status === 'draft' ? 'Publish' : 'Draft' }}
          </button>

          <button
            type="button"
            class="flex w-full items-center gap-3 rounded-2xl px-3 py-2.5 text-left text-sm font-black text-neutral-700 transition hover:bg-neutral-100 hover:text-neutral-950"
            @click="openEditNewsModal(activeMenuNews)"
          >
            <Icon icon="solar:pen-2-bold-duotone" class="h-5 w-5 text-neutral-600" />
            Edit
          </button>

          <div class="my-1 border-t border-neutral-100"></div>

          <button
            type="button"
            class="flex w-full items-center gap-3 rounded-2xl px-3 py-2.5 text-left text-sm font-black text-red-600 transition hover:bg-red-50"
            @click="openDelete(activeMenuNews)"
          >
            <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-5 w-5" />
            Delete
          </button>
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
          v-if="newsModalOpen"
          class="fixed inset-0 z-[120] grid place-items-center bg-neutral-950/60 p-4 backdrop-blur-sm"
          role="dialog"
          aria-modal="true"
          @click.self="closeNewsModal"
        >
          <section class="flex max-h-[92dvh] w-full max-w-5xl flex-col overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-[0_32px_110px_rgba(15,23,42,0.28)]">
            <div class="border-b border-neutral-200 bg-gradient-to-br from-blue-50 via-white to-white p-5">
              <div class="flex items-start justify-between gap-4">
                <div>
                  <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">Berita Desa</p>
                  <h2 class="mt-1 text-2xl font-black tracking-tight text-neutral-950">
                    {{ editingNews ? 'Edit Berita Desa' : 'Tambah Berita Desa' }}
                  </h2>
                  <p class="mt-1 text-sm font-semibold leading-6 text-neutral-500">
                    Form dibuat sederhana: slug tersembunyi otomatis, status default otomatis, dan draft lokal tersimpan setelah mulai mengetik.
                  </p>
                </div>

                <button
                  type="button"
                  class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl border border-neutral-200 bg-white text-neutral-500 transition hover:bg-neutral-50 hover:text-neutral-950"
                  aria-label="Tutup modal berita"
                  @click="closeNewsModal"
                >
                  <Icon icon="lucide:x" class="h-5 w-5" />
                </button>
              </div>

              <div class="mt-6 grid gap-3 lg:grid-cols-3">
                <button
                  v-for="step in formSteps"
                  :key="step.value"
                  type="button"
                  class="flex items-center gap-3 rounded-2xl border p-3 text-left transition"
                  :class="formStep === step.value
                    ? 'border-blue-200 bg-blue-600 text-white shadow-lg shadow-blue-600/20'
                    : formStep > step.value
                      ? 'border-emerald-200 bg-emerald-50 text-emerald-700'
                      : 'border-neutral-200 bg-white text-neutral-500 hover:bg-neutral-50'"
                  @click="goToFormStep(step.value)"
                >
                  <span
                    class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl"
                    :class="formStep === step.value
                      ? 'bg-white/15 text-white'
                      : formStep > step.value
                        ? 'bg-emerald-600 text-white'
                        : 'bg-neutral-100 text-neutral-500'"
                  >
                    <Icon :icon="formStep > step.value ? 'solar:check-circle-bold-duotone' : step.icon" class="h-5 w-5" />
                  </span>

                  <span class="min-w-0">
                    <span class="block truncate text-sm font-black">{{ step.title }}</span>
                    <span
                      class="mt-0.5 block truncate text-xs font-semibold"
                      :class="formStep === step.value ? 'text-white/65' : 'text-current/60'"
                    >
                      {{ step.description }}
                    </span>
                  </span>
                </button>
              </div>
            </div>

            <form
              class="min-h-0 flex-1 overflow-y-auto p-5"
              @submit.prevent="submitNewsForm"
              @keyup.capture="handleDraftKeyup"
              @input.capture="queueNewsDraftSave"
              @change.capture="queueNewsDraftSave"
            >
              <div
                v-if="draftLoaded"
                class="mb-4 flex items-start gap-3 rounded-2xl border border-amber-200 bg-amber-50 p-4 text-sm font-bold leading-6 text-amber-700"
              >
                <Icon icon="solar:info-circle-bold-duotone" class="mt-0.5 h-5 w-5 shrink-0" />
                <span>Draft lokal terakhir berhasil dimuat otomatis.</span>
              </div>

              <div
                v-if="formError"
                class="mb-4 flex items-start gap-3 rounded-2xl border border-red-200 bg-red-50 p-4 text-sm font-bold leading-6 text-red-700"
              >
                <Icon icon="solar:danger-circle-bold-duotone" class="mt-0.5 h-5 w-5 shrink-0" />
                <span>{{ formError }}</span>
              </div>

              <div v-show="formStep === 1" class="space-y-4">
                <div class="rounded-[1.5rem] border border-neutral-200 bg-neutral-50 p-4">
                  <div class="flex items-start gap-3">
                    <div class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl bg-white text-blue-600 shadow-sm">
                      <Icon icon="solar:document-add-bold-duotone" class="h-5 w-5" />
                    </div>
                    <div>
                      <h3 class="text-base font-black text-neutral-950">Informasi Utama</h3>
                      <p class="mt-1 text-sm font-medium leading-6 text-neutral-500">Isi judul, kategori, dan ringkasan singkat. Slug akan dibuat otomatis saat disimpan.</p>
                    </div>
                  </div>
                </div>

                <div class="grid gap-4 md:grid-cols-2">
                  <label class="block md:col-span-2">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Judul Berita</span>
                    <input
                      v-model="newsForm.title"
                      type="text"
                      class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10"
                      :placeholder="profile.titlePlaceholder"
                      required
                    >
                  </label>

                  <label class="block">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Kategori</span>
                    <input
                      v-model="newsForm.category"
                      type="text"
                      class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10"
                      :placeholder="profile.defaultCategory"
                      list="news-category-options"
                    >
                    <datalist id="news-category-options">
                      <option v-for="category in categoryOptions" :key="category" :value="category"></option>
                    </datalist>
                  </label>

                  <label class="block">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Tag</span>
                    <input
                      v-model="newsForm.tagInput"
                      type="text"
                      class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10"
                      placeholder="Pisahkan dengan koma, contoh: desa, agenda"
                      @keydown.enter.prevent="addTagsFromInput"
                      @keydown.comma.prevent="addTagsFromInput"
                    >
                  </label>

                  <div v-if="newsForm.tags.length" class="md:col-span-2 flex flex-wrap gap-2">
                    <button
                      v-for="tag in newsForm.tags"
                      :key="tag"
                      type="button"
                      class="inline-flex items-center gap-2 rounded-full bg-blue-50 px-3 py-1.5 text-xs font-black text-blue-700 transition hover:bg-red-50 hover:text-red-600"
                      @click="removeTag(tag)"
                    >
                      #{{ tag }}
                      <Icon icon="lucide:x" class="h-3.5 w-3.5" />
                    </button>
                  </div>

                  <label class="block md:col-span-2">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Ringkasan Singkat</span>
                    <textarea
                      v-model="newsForm.excerpt"
                      rows="4"
                      class="w-full resize-none rounded-2xl border border-neutral-200 bg-white px-4 py-3 text-sm font-bold leading-7 text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10"
                      :placeholder="profile.excerptPlaceholder"
                    ></textarea>
                  </label>
                </div>
              </div>

              <div v-show="formStep === 2" class="space-y-4">
                <div class="rounded-[1.5rem] border border-neutral-200 bg-neutral-50 p-4">
                  <div class="flex items-start gap-3">
                    <div class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl bg-white text-blue-600 shadow-sm">
                      <Icon icon="solar:gallery-wide-bold-duotone" class="h-5 w-5" />
                    </div>
                    <div>
                      <h3 class="text-base font-black text-neutral-950">Media Berita</h3>
                      <p class="mt-1 text-sm font-medium leading-6 text-neutral-500">
                        Pilih upload file ke Cloudinary atau gunakan link gambar yang sudah ada. Preview cukup gambar saja.
                      </p>
                    </div>
                  </div>
                </div>

                <div class="grid gap-4 lg:grid-cols-[1fr_22rem]">
                  <div class="space-y-4">
                    <div class="grid gap-2 rounded-[1.5rem] border border-neutral-200 bg-white p-2 sm:grid-cols-2">
                      <button
                        type="button"
                        class="inline-flex h-12 items-center justify-center gap-2 rounded-2xl text-sm font-black transition"
                        :class="coverInputMode === 'upload'
                          ? 'bg-blue-600 text-white shadow-lg shadow-blue-600/20'
                          : 'bg-neutral-50 text-neutral-600 hover:bg-neutral-100'"
                        @click.stop="setCoverInputMode('upload')"
                      >
                        <Icon icon="solar:upload-square-bold-duotone" class="h-5 w-5" />
                        File
                      </button>

                      <button
                        type="button"
                        class="inline-flex h-12 items-center justify-center gap-2 rounded-2xl text-sm font-black transition"
                        :class="coverInputMode === 'link'
                          ? 'bg-blue-600 text-white shadow-lg shadow-blue-600/20'
                          : 'bg-neutral-50 text-neutral-600 hover:bg-neutral-100'"
                        @click.stop="setCoverInputMode('link')"
                      >
                        <Icon icon="solar:link-bold-duotone" class="h-5 w-5" />
                        Link
                      </button>
                    </div>

                    <div v-if="coverInputMode === 'upload'" class="space-y-3">
                      <input
                        ref="coverInputRef"
                        type="file"
                        accept="image/jpeg,image/jpg,image/png,image/webp"
                        class="hidden"
                        @change="onPickCoverFile"
                      >

                      <button
                        type="button"
                        class="flex w-full items-center justify-center gap-3 rounded-[1.5rem] border-2 border-dashed border-blue-200 bg-blue-50 px-4 py-8 text-center text-blue-700 transition hover:border-blue-400 hover:bg-blue-100 disabled:cursor-not-allowed disabled:opacity-60"
                        :disabled="coverUploadDisabled"
                        @click.stop="pickCoverFile"
                      >
                        <Icon icon="solar:cloud-upload-bold-duotone" class="h-7 w-7 shrink-0" />
                        <span class="min-w-0 truncate text-sm font-black">
                          {{ coverFile ? coverFile.name : 'Klik untuk pilih gambar JPG, PNG, atau WebP' }}
                        </span>
                      </button>

                      <div
                        v-if="coverFile"
                        class="flex flex-wrap items-center justify-between gap-3 rounded-2xl border border-neutral-200 bg-white px-4 py-3"
                      >
                        <div class="min-w-0">
                          <p class="truncate text-sm font-black text-neutral-800">{{ coverFile.name }}</p>
                          <p class="text-xs font-semibold text-neutral-400">{{ formatFileSize(coverFile.size) }}</p>
                        </div>

                        <button
                          type="button"
                          class="inline-flex h-10 items-center justify-center gap-2 rounded-2xl border border-red-200 bg-red-50 px-3 text-xs font-black text-red-600 transition hover:bg-red-100"
                          :disabled="coverUploadDisabled"
                          @click.stop="clearCoverFile"
                        >
                          <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-4 w-4" />
                          Hapus
                        </button>
                      </div>

                    </div>

                    <label v-else class="block">
                      <span class="mb-2 block text-sm font-black text-neutral-800">Link Gambar Utama</span>
                      <input
                        v-model="newsForm.coverImage"
                        type="url"
                        class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10"
                        placeholder="https://domain.com/gambar.jpg"
                        @input="clearCoverFile(false)"
                      >
                      <span class="mt-2 block text-xs font-semibold leading-5 text-neutral-400">
                        Opsional. Jika kosong, card akan menampilkan placeholder gambar.
                      </span>
                    </label>
                  </div>

                  <div class="overflow-hidden rounded-[1.5rem] border border-neutral-200 bg-neutral-50 p-3">
                    <div class="overflow-hidden rounded-[1.2rem] bg-white">
                      <img
                        v-if="coverPreview"
                        :src="coverPreview"
                        alt="Preview gambar berita"
                        class="h-64 w-full object-cover"
                      >
                      <div v-else class="grid h-64 place-items-center bg-gradient-to-br from-blue-50 via-white to-sky-50 text-blue-600">
                        <div class="text-center">
                          <Icon icon="solar:gallery-wide-bold-duotone" class="mx-auto h-10 w-10" />
                          <p class="mt-2 text-xs font-black uppercase tracking-[0.14em] text-blue-500">Preview Gambar</p>
                        </div>
                      </div>
                    </div>

                    <div v-if="isCoverUploading" class="mt-3 flex items-center gap-2 rounded-2xl bg-blue-50 px-4 py-3 text-xs font-black text-blue-700">
                      <Icon icon="solar:refresh-bold-duotone" class="h-4 w-4 animate-spin" />
                      Mengupload gambar...
                    </div>
                  </div>
                </div>
              </div>

              <div v-show="formStep === 3" class="space-y-4">
                <div class="rounded-[1.5rem] border border-neutral-200 bg-neutral-50 p-4">
                  <div class="flex items-start gap-3">
                    <div class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl bg-white text-blue-600 shadow-sm">
                      <Icon icon="solar:pen-new-square-bold-duotone" class="h-5 w-5" />
                    </div>
                    <div>
                      <h3 class="text-base font-black text-neutral-950">Isi Berita</h3>
                      <p class="mt-1 text-sm font-medium leading-6 text-neutral-500">Gunakan komponen RichText reusable. Konten cukup dihubungkan dengan v-model.</p>
                    </div>
                  </div>
                </div>

                <div class="overflow-hidden rounded-[1.8rem] bg-white p-1">
                  <RichText
                    v-model="newsForm.content"
                    placeholder="Tulis isi lengkap berita desa di sini..."
                  />
                </div>
              </div>
            </form>

            <div class="flex flex-col-reverse gap-2 border-t border-neutral-200 bg-white p-5 sm:flex-row sm:items-center sm:justify-between">
              <div class="text-xs font-bold text-neutral-400">
                <span v-if="editingNews">Mode edit tidak menimpa draft lokal.</span>
                <span v-else-if="lastDraftSavedAt">Draft lokal tersimpan {{ lastDraftSavedAt }}.</span>
                <span v-else>Draft lokal akan tersimpan setelah kamu mulai mengetik.</span>
              </div>

              <div class="flex flex-col-reverse gap-2 sm:flex-row">
                <button
                  type="button"
                  class="inline-flex h-12 items-center justify-center rounded-2xl border border-neutral-200 bg-white px-5 text-sm font-black text-neutral-700 transition hover:bg-neutral-50"
                  @click="formStep === 1 ? closeNewsModal() : prevFormStep()"
                >
                  {{ formStep === 1 ? 'Batal' : 'Kembali' }}
                </button>

                <button
                  v-if="formStep < formSteps.length"
                  type="button"
                  class="inline-flex h-12 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-5 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700 disabled:cursor-not-allowed disabled:opacity-60"
                  :disabled="!canGoNext"
                  @click="nextFormStep"
                >
                  Lanjut
                  <Icon icon="solar:arrow-right-linear" class="h-5 w-5" />
                </button>

                <button
                  v-else
                  type="button"
                  class="inline-flex h-12 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-5 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700 disabled:cursor-wait disabled:opacity-60"
                  :disabled="isSubmittingNews || isCoverUploading || !canSubmit"
                  @click="submitNewsForm"
                >
                  <Icon
                    :icon="isSubmittingNews || isCoverUploading ? 'solar:refresh-bold-duotone' : 'solar:diskette-bold-duotone'"
                    class="h-5 w-5"
                    :class="isSubmittingNews || isCoverUploading ? 'animate-spin' : ''"
                  />
                  {{ isCoverUploading ? 'Upload Gambar...' : isSubmittingNews ? 'Menyimpan...' : editingNews ? 'Simpan Perubahan' : 'Tambah Berita' }}
                </button>
              </div>
            </div>
          </section>
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
          v-if="viewModalOpen && selectedNews"
          class="fixed inset-0 z-[130] grid place-items-center bg-neutral-950/60 p-4 backdrop-blur-sm"
          role="dialog"
          aria-modal="true"
          @click.self="closeView"
        >
          <section class="flex max-h-[92dvh] w-full max-w-4xl flex-col overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-[0_32px_110px_rgba(15,23,42,0.28)]">
            <div class="flex items-start justify-between gap-4 border-b border-neutral-200 p-5">
              <div>
                <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">Detail Berita</p>
                <h2 class="mt-1 text-2xl font-black tracking-tight text-neutral-950">{{ selectedNews.title }}</h2>
              </div>

              <button
                type="button"
                class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl border border-neutral-200 bg-white text-neutral-500 transition hover:bg-neutral-50 hover:text-neutral-950"
                aria-label="Tutup detail berita"
                @click="closeView"
              >
                <Icon icon="lucide:x" class="h-5 w-5" />
              </button>
            </div>

            <div class="min-h-0 flex-1 overflow-y-auto p-5">
              <img
                v-if="selectedNews.cover"
                :src="selectedNews.cover"
                :alt="selectedNews.title"
                class="mb-5 h-72 w-full rounded-[1.5rem] object-cover"
              >

              <div class="mb-5 flex flex-wrap items-center gap-2">
                <span class="rounded-full bg-blue-50 px-3 py-1 text-xs font-black text-blue-700">
                  {{ selectedNews.category || profile.defaultCategory }}
                </span>
                <span class="rounded-full px-3 py-1 text-xs font-black" :class="statusClass(selectedNews.status)">
                  {{ statusLabel(selectedNews.status) }}
                </span>
                <span class="rounded-full bg-neutral-100 px-3 py-1 text-xs font-black text-neutral-600">
                  {{ formatDate(selectedNews.publishedAt) }}
                </span>
              </div>

              <p class="mb-5 rounded-2xl bg-neutral-50 p-4 text-sm font-semibold leading-7 text-neutral-600">
                {{ selectedNews.excerpt || 'Belum ada ringkasan.' }}
              </p>

              <div class="news-content rounded-2xl border border-neutral-200 p-5" v-html="selectedNewsContent"></div>
            </div>
          </section>
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
          v-if="deleteModalOpen && selectedNews"
          class="fixed inset-0 z-[140] grid place-items-center bg-neutral-950/60 p-4 backdrop-blur-sm"
          role="dialog"
          aria-modal="true"
          @click.self="closeDelete"
        >
          <section class="w-full max-w-md rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-[0_32px_110px_rgba(15,23,42,0.28)]">
            <div class="grid h-14 w-14 place-items-center rounded-3xl bg-red-50 text-red-600">
              <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-7 w-7" />
            </div>

            <h2 class="mt-5 text-xl font-black tracking-tight text-neutral-950">Hapus Berita?</h2>
            <p class="mt-2 text-sm font-medium leading-6 text-neutral-500">
              Berita <strong class="text-neutral-900">{{ selectedNews.title }}</strong> akan dihapus dari daftar.
            </p>

            <div class="mt-6 flex flex-col-reverse gap-3 sm:flex-row sm:justify-end">
              <button
                type="button"
                class="inline-flex h-11 items-center justify-center rounded-2xl border border-neutral-200 bg-white px-5 text-sm font-black text-neutral-700 transition hover:bg-neutral-50"
                @click="closeDelete"
              >
                Batal
              </button>

              <button
                type="button"
                class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-red-600 px-5 text-sm font-black text-white transition hover:bg-red-700 disabled:cursor-not-allowed disabled:opacity-60"
                :disabled="isMutating"
                @click="confirmDelete"
              >
                <Icon
                  :icon="isMutating ? 'solar:refresh-bold-duotone' : 'solar:trash-bin-trash-bold-duotone'"
                  class="h-5 w-5"
                  :class="isMutating ? 'animate-spin' : ''"
                />
                {{ isMutating ? 'Menghapus...' : 'Hapus' }}
              </button>
            </div>
          </section>
        </div>
      </Transition>
    </Teleport>
  </section>
</template>

<script setup lang="ts">
import { Icon } from '@iconify/vue'
import { computed, nextTick, onBeforeUnmount, onMounted, reactive, ref, unref, watch } from 'vue'
import { useHead, useRuntimeConfig, useSeoMeta } from '#imports'
import RichText from '~/components/widget/RichText.vue'
import { useNews } from '~/composables/data/useNews'
import { useCloudinaryUpload } from '~/composables/useCloudinaryUpload'

definePageMeta({
  layout: 'app',
  layoutProps: {
    title: 'Berita Informasi'
  }
})

type ToastType = 'success' | 'error'
type CoverInputMode = 'upload' | 'link'
type NewsStatus = 'published' | 'draft' | 'scheduled' | 'archived'
type NewsContent = string | { kind?: string; json?: unknown; html?: string } | null | undefined

type NormalizedNewsItem = {
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
  raw: Record<string, unknown>
}

type NewsForm = {
  title: string
  excerpt: string
  category: string
  coverImage: string
  content: string
  tagInput: string
  tags: string[]
}

type NewsDraft = NewsForm & {
  updatedAt?: string
}

const config = useRuntimeConfig()
const news = useNews() as any
const { uploading: cloudinaryUploading, uploadImage } = useCloudinaryUpload()

const search = ref('')
const selectedCategory = ref('all')
const selectedStatus = ref<'all' | NewsStatus>('all')
const page = ref(1)
const pageSize = 12

const newsModalOpen = ref(false)
const viewModalOpen = ref(false)
const deleteModalOpen = ref(false)

const formStep = ref(1)
const editingNews = ref<NormalizedNewsItem | null>(null)
const selectedNews = ref<NormalizedNewsItem | null>(null)
const formError = ref('')

const draftLoaded = ref(false)
const draftReady = ref(false)
const draftStarted = ref(false)
const localDraftExists = ref(false)
const lastDraftSavedAt = ref('')

const activeMenuNews = ref<NormalizedNewsItem | null>(null)
const ellipsisMenuPosition = reactive({ top: 0, left: 0 })
const statusPatchedNews = ref<Record<string, NormalizedNewsItem>>({})

const coverInputMode = ref<CoverInputMode>('upload')
const coverInputRef = ref<HTMLInputElement | null>(null)
const coverFile = ref<File | null>(null)
const coverLocalPreview = ref('')

const isSubmittingNews = ref(false)
const localLoading = ref(false)
const localError = ref('')
let draftTimer: ReturnType<typeof setTimeout> | null = null
let toastTimer: ReturnType<typeof setTimeout> | null = null

const toast = reactive({
  show: false,
  type: 'success' as ToastType,
  title: '',
  message: ''
})

const newsForm = reactive<NewsForm>({
  title: '',
  excerpt: '',
  category: '',
  coverImage: '',
  content: '',
  tagInput: '',
  tags: []
})

const formSteps = [
  {
    value: 1,
    title: 'Informasi',
    description: 'Judul dan ringkasan',
    icon: 'solar:document-add-bold-duotone'
  },
  {
    value: 2,
    title: 'Media',
    description: 'Gambar utama',
    icon: 'solar:gallery-wide-bold-duotone'
  },
  {
    value: 3,
    title: 'Konten',
    description: 'Rich text editor',
    icon: 'solar:pen-new-square-bold-duotone'
  }
]

const profile = computed(() => {
  const clientName = String(config.public.clientName || 'martopuro').trim().toLowerCase()
  const isMartopuro = clientName.includes('martopuro')

  if (isMartopuro) {
    return {
      name: 'Desa Martopuro',
      title: 'Berita Informasi Desa',
      badge: 'Village News',
      icon: 'solar:buildings-3-bold-duotone',
      description: 'Kelola berita, agenda, pengumuman, layanan publik, dan informasi resmi desa dengan tampilan yang rapi.',
      searchPlaceholder: 'Cari berita desa, pengumuman, layanan...',
      emptyDescription: 'Belum ada berita desa. Mulai publikasikan informasi resmi, kegiatan, atau pengumuman untuk warga.',
      defaultCategory: 'Informasi Desa',
      titlePlaceholder: 'Contoh: Pemerintah Desa Martopuro Mengadakan Kegiatan Kerja Bakti',
      excerptPlaceholder: 'Tulis ringkasan singkat agar pembaca mudah memahami isi berita...',
      publicBase: '/news',
      categories: ['Informasi Desa', 'Pengumuman', 'Kegiatan Desa', 'Layanan Publik', 'Pembangunan', 'APBDes', 'UMKM', 'Kesehatan', 'Pendidikan']
    }
  }

  return {
    name: 'Obayan',
    title: 'Berita Informasi Obayan',
    badge: 'Platform News',
    icon: 'solar:widget-5-bold-duotone',
    description: 'Kelola berita, update produk, artikel edukasi, case study, dan informasi resmi platform dengan layout yang bersih.',
    searchPlaceholder: 'Cari artikel, update produk, tutorial...',
    emptyDescription: 'Belum ada artikel. Mulai publikasikan update produk, tutorial, atau informasi resmi Obayan.',
    defaultCategory: 'Update Produk',
    titlePlaceholder: 'Contoh: Obayan Merilis Modul Website Desa dan Pesantren',
    excerptPlaceholder: 'Tulis ringkasan artikel agar pembaca memahami poin utamanya...',
    publicBase: '/news',
    categories: ['Update Produk', 'Pengumuman', 'Tutorial', 'Case Study', 'Edukasi', 'Website', 'SIAKAD', 'CBT', 'Pembayaran']
  }
})

const tenantSlug = computed(() => {
  return String(unref(news.tenantSlug) || config.public.clientName || 'martopuro')
    .trim()
    .toLowerCase()
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

const rawNewsItems = computed(() => {
  const direct = unref(news.items)
  return Array.isArray(direct) ? direct : []
})

const isLoading = computed(() => Boolean(localLoading.value || unref(news.pending)))
const isMutating = computed(() => Boolean(unref(news.mutationPending)))

const visibleError = computed(() => {
  if (localError.value) return localError.value

  const fetchError = unref(news.error)
  const mutationError = unref(news.mutationError)

  return getErrorMessage(fetchError || mutationError, '')
})

const isCoverUploading = computed(() => Boolean(unref(cloudinaryUploading)))
const coverPreview = computed(() => coverLocalPreview.value || newsForm.coverImage.trim())
const coverUploadDisabled = computed(() => Boolean(isSubmittingNews.value || isCoverUploading.value))

const normalizedNews = computed<NormalizedNewsItem[]>(() => {
  const baseItems = rawNewsItems.value
    .map(normalizeNewsItem)
    .filter((item) => item.id)

  const merged = new Map<string, NormalizedNewsItem>()

  for (const item of baseItems) {
    merged.set(item.id, item)
  }

  for (const item of Object.values(statusPatchedNews.value)) {
    const existing = merged.get(item.id)
    merged.set(item.id, {
      ...existing,
      ...item,
      raw: {
        ...(existing?.raw || {}),
        ...(item.raw || {})
      }
    })
  }

  return Array.from(merged.values())
    .sort((a, b) => Number(b.publishedAt || 0) - Number(a.publishedAt || 0))
})
const categoryOptions = computed(() => {
  const fromData = normalizedNews.value
    .map((item) => item.category)
    .filter(Boolean)

  return Array.from(new Set([...profile.value.categories, ...fromData]))
})


const statusFilterOptions = computed<Array<{ value: 'all' | NewsStatus; label: string; icon: string; count: number }>>(() => {
  return [
    {
      value: 'all',
      label: 'Semua',
      icon: 'solar:layers-bold-duotone',
      count: normalizedNews.value.length
    },
    {
      value: 'published',
      label: 'Terbit',
      icon: 'solar:check-circle-bold-duotone',
      count: publishedCount.value
    },
    {
      value: 'draft',
      label: 'Draft',
      icon: 'solar:document-add-bold-duotone',
      count: draftCount.value
    },
    {
      value: 'scheduled',
      label: 'Terjadwal',
      icon: 'solar:calendar-mark-bold-duotone',
      count: scheduledCount.value
    },
    {
      value: 'archived',
      label: 'Arsip',
      icon: 'solar:archive-bold-duotone',
      count: archivedCount.value
    }
  ]
})
const filteredNews = computed(() => {
  const keyword = search.value.trim().toLowerCase()

  return normalizedNews.value.filter((item) => {
    const matchKeyword = !keyword || [
      item.title,
      item.slug,
      item.excerpt,
      item.category,
      item.status,
      ...item.tags
    ]
      .filter(Boolean)
      .join(' ')
      .toLowerCase()
      .includes(keyword)

    const matchCategory = selectedCategory.value === 'all' || item.category === selectedCategory.value
    const matchStatus = selectedStatus.value === 'all' || item.status === selectedStatus.value

    return matchKeyword && matchCategory && matchStatus
  })
})

const pagedNews = computed(() => filteredNews.value.slice(0, page.value * pageSize))
const hasMore = computed(() => pagedNews.value.length < filteredNews.value.length)

const publishedCount = computed(() => normalizedNews.value.filter((item) => item.status === 'published').length)
const draftCount = computed(() => normalizedNews.value.filter((item) => item.status === 'draft').length)
const scheduledCount = computed(() => normalizedNews.value.filter((item) => item.status === 'scheduled').length)
const archivedCount = computed(() => normalizedNews.value.filter((item) => item.status === 'archived').length)

const canGoNext = computed(() => {
  if (formStep.value === 1) return newsForm.title.trim().length >= 3
  if (formStep.value === 2) return true
  return newsForm.content.trim().length > 0
})

const canSubmit = computed(() => {
  return newsForm.title.trim().length >= 3 && newsForm.content.trim().length > 0
})

const newsDraftKey = computed(() => `news-form-draft:${tenantSlug.value}`)

const selectedNewsContent = computed(() => {
  if (!selectedNews.value) return ''
  return htmlFromContent(selectedNews.value.content)
})

useSeoMeta({
  title: () => `${profile.value.title} · ${profile.value.name}`,
  description: () => profile.value.description,
  ogTitle: () => `${profile.value.title} · ${profile.value.name}`,
  ogDescription: () => profile.value.description,
  robots: 'noindex, nofollow',
  themeColor: '#2563eb'
})

useHead({
  htmlAttrs: {
    lang: 'id'
  },
  meta: [
    {
      name: 'theme-color',
      content: '#2563eb'
    }
  ]
})

watch([search, selectedCategory, selectedStatus], () => {
  page.value = 1
})

watch(
  newsForm,
  () => {
    if (!draftStarted.value) return
    queueNewsDraftSave()
  },
  { deep: true }
)

onMounted(async () => {
  refreshLocalDraftState()
  await reloadNews(true)
  document.addEventListener('keydown', handleEscape)
  window.addEventListener('resize', closeEllipsisMenu)
  window.addEventListener('scroll', closeEllipsisMenu, true)
})

onBeforeUnmount(() => {
  if (draftTimer) clearTimeout(draftTimer)
  if (toastTimer) clearTimeout(toastTimer)
  clearCoverFile(false)
  document.removeEventListener('keydown', handleEscape)
  window.removeEventListener('resize', closeEllipsisMenu)
  window.removeEventListener('scroll', closeEllipsisMenu, true)
})

async function reloadNews(silent = false) {
  localLoading.value = true
  localError.value = ''

  try {
    if (typeof news.fetchNews === 'function') {
      await news.fetchNews({
        tenantSlug: tenantSlug.value,
        status: 'all',
        limit: 100,
        sort: 'newest'
      })
    } else if (typeof news.refresh === 'function') {
      await news.refresh()
    }
  } catch (error) {
    const message = getErrorMessage(error, 'Data berita gagal dimuat.')
    localError.value = message

    if (!silent) {
      showToast('error', 'Gagal Memuat Berita', message)
    }
  } finally {
    localLoading.value = false
  }
}

function createEmptyNewsForm(): NewsForm {
  return {
    title: '',
    excerpt: '',
    category: profile.value.defaultCategory,
    coverImage: '',
    content: '',
    tagInput: '',
    tags: []
  }
}

function resetNewsForm() {
  Object.assign(newsForm, createEmptyNewsForm())
  clearCoverFile(false)
  coverInputMode.value = 'upload'
}

async function openCreateNewsModal() {
  closeEllipsisMenu()
  editingNews.value = null
  formStep.value = 1
  formError.value = ''
  draftLoaded.value = false
  draftStarted.value = false
  draftReady.value = false
  resetNewsForm()

  const draft = readNewsDraft()

  if (draft) {
    Object.assign(newsForm, {
      ...createEmptyNewsForm(),
      ...draft
    })
    draftLoaded.value = true

    if (draft.coverImage) {
      coverInputMode.value = 'link'
    }
  }

  newsModalOpen.value = true

  await nextTick()

  draftReady.value = true
}

async function openEditNewsModal(item: NormalizedNewsItem) {
  closeEllipsisMenu()
  editingNews.value = item
  formStep.value = 1
  formError.value = ''
  draftLoaded.value = false
  draftStarted.value = false
  draftReady.value = false

  Object.assign(newsForm, {
    title: item.title,
    excerpt: item.excerpt,
    category: item.category || profile.value.defaultCategory,
    coverImage: item.cover,
    content: htmlFromContent(item.content),
    tagInput: '',
    tags: [...item.tags]
  })

  clearCoverFile(false)
  coverInputMode.value = item.cover ? 'link' : 'upload'

  newsModalOpen.value = true

  await nextTick()

  draftReady.value = true
}

function closeNewsModal() {
  newsModalOpen.value = false
  draftReady.value = false
  draftStarted.value = false
  formError.value = ''
}

function goToFormStep(targetStep: number) {
  if (targetStep <= formStep.value) {
    formStep.value = targetStep
    formError.value = ''
    return
  }

  if (!validateCurrentStep()) return

  formStep.value = targetStep
}

function nextFormStep() {
  if (!validateCurrentStep()) return
  formStep.value = Math.min(formStep.value + 1, formSteps.length)
}

function prevFormStep() {
  formError.value = ''
  formStep.value = Math.max(formStep.value - 1, 1)
}

function validateCurrentStep() {
  formError.value = ''

  if (formStep.value === 1 && newsForm.title.trim().length < 3) {
    formError.value = 'Judul berita minimal 3 karakter.'
    return false
  }

  if (formStep.value === 2 && coverInputMode.value === 'link' && newsForm.coverImage.trim() && !isValidUrl(newsForm.coverImage.trim())) {
    formError.value = 'Link gambar utama tidak valid.'
    return false
  }

  if (formStep.value === 3 && !newsForm.content.trim()) {
    formError.value = 'Isi berita wajib diisi.'
    return false
  }

  return true
}

async function submitNewsForm() {
  addTagsFromInput()

  if (!canSubmit.value || isSubmittingNews.value) return
  if (!validateAllSteps()) return

  isSubmittingNews.value = true
  formError.value = ''

  try {
    const coverUrl = await resolveCoverUrlBeforeSubmit()
    const payload = createNewsPayload(editingNews.value?.status || 'published', coverUrl)

    if (editingNews.value) {
      await news.updateNews(editingNews.value.id, payload)
      showToast('success', 'Berita Diupdate', 'Perubahan berita berhasil disimpan.')
    } else {
      await news.createNews(payload)
      clearNewsDraft()
      showToast('success', 'Berita Ditambahkan', 'Berita desa berhasil ditambahkan.')
    }

    closeNewsModal()
    await reloadNews(true)
  } catch (error) {
    const message = getErrorMessage(error, 'Gagal menyimpan berita.')
    formError.value = message
    showToast('error', 'Gagal Menyimpan', message)
  } finally {
    isSubmittingNews.value = false
  }
}


async function resolveCoverUrlBeforeSubmit() {
  if (coverInputMode.value === 'upload' && coverFile.value) {
    const result = await uploadImage(coverFile.value, {
      folder: `${tenantSlug.value}/news/covers`,
      maxWidth: 1600,
      maxHeight: 1600,
      quality: 0.82,
      maxBytes: 5 * 1024 * 1024
    })

    newsForm.coverImage = result.secure_url
    clearCoverFile(false)

    return result.secure_url
  }

  if (newsForm.coverImage.trim() && !isValidUrl(newsForm.coverImage.trim())) {
    throw new Error('Link gambar utama tidak valid.')
  }

  return newsForm.coverImage.trim()
}

function setCoverInputMode(mode: CoverInputMode) {
  coverInputMode.value = mode
  formError.value = ''

  if (mode === 'link') {
    clearCoverFile(false)
  }
}

function pickCoverFile() {
  if (coverUploadDisabled.value) return
  coverInputRef.value?.click()
}

function onPickCoverFile(event: Event) {
  const input = event.target as HTMLInputElement
  const file = input.files?.[0] || null

  if (!file) return

  if (!isAllowedCoverFile(file)) {
    if (coverInputRef.value) coverInputRef.value.value = ''
    return
  }

  clearCoverFile(false)
  coverFile.value = file
  coverLocalPreview.value = URL.createObjectURL(file)
  newsForm.coverImage = ''
  draftStarted.value = true
  queueNewsDraftSave()
}

function clearCoverFile(resetInput = true) {
  if (coverLocalPreview.value) {
    URL.revokeObjectURL(coverLocalPreview.value)
  }

  coverFile.value = null
  coverLocalPreview.value = ''

  if (resetInput && coverInputRef.value) {
    coverInputRef.value.value = ''
  }
}

function isAllowedCoverFile(file: File) {
  const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/webp']

  if (!allowedTypes.includes(file.type)) {
    showToast('error', 'Format Gambar Tidak Didukung', 'Gunakan gambar JPG, PNG, atau WebP.')
    return false
  }

  if (file.size > 5 * 1024 * 1024) {
    showToast('error', 'Ukuran Terlalu Besar', 'Ukuran gambar maksimal 5 MB.')
    return false
  }

  return true
}

function formatFileSize(bytes: number) {
  if (!bytes) return '0 KB'

  const kilobytes = bytes / 1024

  if (kilobytes < 1024) {
    return `${Math.round(kilobytes)} KB`
  }

  return `${(kilobytes / 1024).toFixed(1)} MB`
}

function validateAllSteps() {
  const currentStep = formStep.value

  for (const step of formSteps) {
    formStep.value = step.value
    if (!validateCurrentStep()) return false
  }

  formStep.value = currentStep
  formError.value = ''
  return true
}

function createNewsPayload(status: NewsStatus, coverUrl?: string) {
  const html = newsForm.content.trim()
  const title = newsForm.title.trim()
  const excerpt = newsForm.excerpt.trim() || plainTextFromContent(html).slice(0, 180)
  const cover = safeString(coverUrl || newsForm.coverImage)
  const slug = editingNews.value?.slug || createNewsSlug(title)

  return {
    tenantSlug: tenantSlug.value,
    title,
    slug,
    excerpt,
    cover,
    coverImage: cover,
    coverUrl: cover,
    image: cover,
    imageUrl: cover,
    category: newsForm.category.trim() || profile.value.defaultCategory,
    tags: [...newsForm.tags],
    status,
    publishedAt: status === 'published' ? Date.now() : editingNews.value?.publishedAt || Date.now(),
    readTime: estimateReadTime(plainTextFromContent(html)),
    content: {
      kind: 'html',
      html
    }
  }
}

async function toggleNewsPublishState(item: NormalizedNewsItem) {
  if (item.status === 'draft') {
    await publishNews(item)
    return
  }

  await markNewsAsDraft(item)
}

async function markNewsAsDraft(item: NormalizedNewsItem) {
  closeEllipsisMenu()

  try {
    const nextItem = patchNewsStatus(item, 'draft')

    await news.updateNews(item.id, createPayloadFromItem(nextItem, 'draft'))
    statusPatchedNews.value[item.id] = nextItem
    showToast('success', 'Berita Jadi Draft', 'Status berita berhasil diubah menjadi draft.')
    await reloadNews(true)
  } catch (error) {
    showToast('error', 'Gagal Mengubah Draft', getErrorMessage(error, 'Berita gagal diubah menjadi draft.'))
  }
}

async function publishNews(item: NormalizedNewsItem) {
  closeEllipsisMenu()

  try {
    const nextItem = patchNewsStatus(item, 'published')

    await news.updateNews(item.id, createPayloadFromItem(nextItem, 'published'))
    statusPatchedNews.value[item.id] = nextItem
    showToast('success', 'Berita Dipublish', 'Berita draft berhasil dipublish kembali.')
    await reloadNews(true)
  } catch (error) {
    showToast('error', 'Gagal Publish', getErrorMessage(error, 'Berita gagal dipublish.'))
  }
}

function patchNewsStatus(item: NormalizedNewsItem, status: NewsStatus): NormalizedNewsItem {
  const publishedAt = status === 'published' ? Date.now() : item.publishedAt || Date.now()

  return {
    ...item,
    status,
    publishedAt,
    raw: {
      ...item.raw,
      status,
      publishedAt,
      published_at: publishedAt
    }
  }
}

function createPayloadFromItem(item: NormalizedNewsItem, status: NewsStatus) {
  const html = htmlFromContent(item.content)
  const publishedAt = status === 'published' ? Date.now() : item.publishedAt || Date.now()

  return {
    tenantSlug: tenantSlug.value,
    title: item.title,
    slug: item.slug || createNewsSlug(item.title),
    excerpt: item.excerpt || plainTextFromContent(item.content).slice(0, 180),
    cover: item.cover,
    coverImage: item.cover,
    coverUrl: item.cover,
    image: item.cover,
    imageUrl: item.cover,
    category: item.category || profile.value.defaultCategory,
    tags: [...item.tags],
    status,
    publishedAt,
    readTime: item.readTime || estimateReadTime(plainTextFromContent(item.content)),
    content: {
      kind: 'html',
      html
    }
  }
}

function openView(item: NormalizedNewsItem) {
  selectedNews.value = item
  viewModalOpen.value = true
  closeEllipsisMenu()
}

function closeView() {
  viewModalOpen.value = false
  selectedNews.value = null
}

function openDelete(item: NormalizedNewsItem) {
  selectedNews.value = item
  deleteModalOpen.value = true
  closeEllipsisMenu()
}

function closeDelete() {
  deleteModalOpen.value = false
  selectedNews.value = null
}

async function confirmDelete() {
  if (!selectedNews.value || isMutating.value) return

  try {
    await news.deleteNews(selectedNews.value.id)
    delete statusPatchedNews.value[selectedNews.value.id]
    showToast('success', 'Berita Dihapus', 'Data berita berhasil dihapus.')
    closeDelete()
    await reloadNews(true)
  } catch (error) {
    showToast('error', 'Gagal Menghapus', getErrorMessage(error, 'Data berita gagal dihapus.'))
  }
}

function openEllipsisMenu(item: NormalizedNewsItem, event: MouseEvent) {
  const target = event.currentTarget as HTMLElement
  const rect = target.getBoundingClientRect()

  const menuWidth = 224
  const menuHeight = 220
  const gap = 8
  const padding = 12

  let left = rect.right - menuWidth
  let top = rect.bottom + gap

  if (left < padding) left = padding
  if (left + menuWidth > window.innerWidth - padding) left = window.innerWidth - menuWidth - padding
  if (top + menuHeight > window.innerHeight - padding) top = rect.top - menuHeight - gap
  if (top < padding) top = padding

  ellipsisMenuPosition.left = left
  ellipsisMenuPosition.top = top
  activeMenuNews.value = item
}

function closeEllipsisMenu() {
  activeMenuNews.value = null
}

function handleDraftKeyup() {
  if (editingNews.value) return
  draftStarted.value = true
  queueNewsDraftSave()
}

function queueNewsDraftSave() {
  if (editingNews.value) return
  if (!newsModalOpen.value || !draftReady.value || !draftStarted.value) return

  if (draftTimer) clearTimeout(draftTimer)

  draftTimer = setTimeout(() => {
    saveNewsDraft()
  }, 250)
}

function readNewsDraft(): NewsDraft | null {
  if (!import.meta.client) return null

  try {
    const raw = localStorage.getItem(newsDraftKey.value)
    if (!raw) return null
    return JSON.parse(raw) as NewsDraft
  } catch {
    return null
  }
}

function saveNewsDraft() {
  if (!import.meta.client) return

  const hasDraft = Boolean(
    newsForm.title.trim() ||
    newsForm.excerpt.trim() ||
    newsForm.category.trim() ||
    newsForm.coverImage.trim() ||
    newsForm.content.trim() ||
    newsForm.tags.length
  )

  if (!hasDraft) {
    localStorage.removeItem(newsDraftKey.value)
    refreshLocalDraftState()
    return
  }

  const payload: NewsDraft = {
    ...newsForm,
    updatedAt: new Date().toISOString()
  }

  localStorage.setItem(newsDraftKey.value, JSON.stringify(payload))
  lastDraftSavedAt.value = formatTimeOnly(Date.now())
  refreshLocalDraftState()
}

function clearNewsDraft() {
  if (!import.meta.client) return
  localStorage.removeItem(newsDraftKey.value)
  draftLoaded.value = false
  localDraftExists.value = false
  lastDraftSavedAt.value = ''
}

function refreshLocalDraftState() {
  if (!import.meta.client) return
  localDraftExists.value = Boolean(localStorage.getItem(newsDraftKey.value))
}

function addTagsFromInput() {
  const raw = newsForm.tagInput.trim()
  if (!raw) return

  const nextTags = raw
    .split(',')
    .map((tag) => normalizeTag(tag))
    .filter(Boolean)

  for (const tag of nextTags) {
    if (!newsForm.tags.includes(tag)) newsForm.tags.push(tag)
  }

  newsForm.tagInput = ''
}

function removeTag(tag: string) {
  newsForm.tags = newsForm.tags.filter((item) => item !== tag)
}

function normalizeNewsItem(rawValue: unknown): NormalizedNewsItem {
  const raw = isObjectRecord(rawValue) ? rawValue : {}
  const content = extractContent(raw)
  const title = safeString(raw.title || raw.name || 'Tanpa Judul')
  const slug = safeString(raw.slug || slugify(title))
  const excerpt = safeString(raw.excerpt || raw.descriptionCard || raw.description_card || raw.summary || raw.description || plainTextFromContent(content).slice(0, 160))
  const category = safeString(raw.category || raw.categoryName || raw.category_name || raw.type || profile.value.defaultCategory)
  const publishedAt = normalizeDate(raw.publishedAt || raw.published_at || raw.createdAt || raw.created_at || raw.updatedAt || raw.updated_at)

  return {
    id: safeString(raw.id || raw.uuid || raw._id || slug),
    title,
    slug,
    excerpt,
    cover: extractImageUrl(raw),
    category,
    tags: normalizeTags(raw.tags || raw.tagNames || raw.tag_names),
    status: normalizeStatus(raw.status),
    publishedAt,
    readTime: Number(raw.readTime || raw.read_time || estimateReadTime(plainTextFromContent(content))),
    tenantSlug: safeString(raw.tenantSlug || raw.tenant_slug || tenantSlug.value),
    content,
    raw
  }
}

function extractContent(raw: Record<string, unknown>): NewsContent {
  const content = raw.content

  if (isObjectRecord(content) || typeof content === 'string') return content as NewsContent

  return safeString(raw.descriptionContent || raw.description_content || raw.body || raw.contentHtml || raw.content_html || '')
}

function extractImageUrl(raw: Record<string, unknown>) {
  const candidates = [
    raw.cover,
    raw.coverUrl,
    raw.cover_url,
    raw.coverImage,
    raw.cover_image,
    raw.image,
    raw.imageUrl,
    raw.image_url,
    raw.thumbnail,
    raw.thumbnailUrl,
    raw.thumbnail_url,
    raw.banner,
    raw.bannerUrl,
    raw.banner_url,
    raw.photo,
    raw.photoUrl,
    raw.photo_url
  ]

  for (const value of candidates) {
    const result = imageCandidateToString(value)
    if (result) return result
  }

  const media = raw.media
  if (Array.isArray(media)) {
    for (const item of media) {
      const result = imageCandidateToString(item)
      if (result) return result
    }
  }

  const files = raw.files
  if (Array.isArray(files)) {
    for (const item of files) {
      const result = imageCandidateToString(item)
      if (result) return result
    }
  }

  return ''
}

function imageCandidateToString(value: unknown): string {
  if (!value) return ''
  if (typeof value === 'string') return value.trim()

  if (isObjectRecord(value)) {
    return safeString(
      value.secure_url ||
      value.secureUrl ||
      value.url ||
      value.path ||
      value.src ||
      value.href ||
      value.location
    )
  }

  return ''
}

function htmlFromContent(content?: NewsContent) {
  if (!content) return ''

  if (typeof content === 'string') {
    try {
      const parsed = JSON.parse(content)
      if (isObjectRecord(parsed) && typeof parsed.html === 'string') return parsed.html
    } catch {
      return content
    }

    return content
  }

  if (typeof content.html === 'string') return content.html

  return ''
}

function plainTextFromContent(content?: NewsContent) {
  return htmlFromContent(content)
    .replace(/<[^>]*>/g, ' ')
    .replace(/\s+/g, ' ')
    .trim()
}

function normalizeStatus(value: unknown): NewsStatus {
  const status = safeString(value || 'published').toLowerCase()

  if (status === 'draft') return 'draft'
  if (status === 'scheduled') return 'scheduled'
  if (status === 'archived') return 'archived'

  return 'published'
}

function normalizeDate(value: unknown) {
  if (!value) return Date.now()

  if (typeof value === 'number') {
    return value < 10_000_000_000 ? value * 1000 : value
  }

  const parsed = new Date(String(value)).getTime()
  return Number.isNaN(parsed) ? Date.now() : parsed
}

function normalizeTags(value: unknown): string[] {
  if (Array.isArray(value)) {
    return value.map((tag) => normalizeTag(tag)).filter(Boolean)
  }

  if (typeof value === 'string') {
    try {
      const parsed = JSON.parse(value)
      if (Array.isArray(parsed)) return normalizeTags(parsed)
    } catch {
      return value.split(',').map((tag) => normalizeTag(tag)).filter(Boolean)
    }
  }

  return []
}

function normalizeTag(value: unknown) {
  return safeString(value)
    .replace(/^#/, '')
    .trim()
    .replace(/\s+/g, '-')
    .replace(/[^a-zA-Z0-9-_]/g, '')
    .toLowerCase()
}

function createNewsSlug(title: string) {
  const baseSlug = slugify(title) || 'berita-desa'
  return `${baseSlug}-${createTimestampUuid()}`
}

function createTimestampUuid() {
  const timestamp = Date.now().toString(36)

  const random = typeof crypto !== 'undefined' && typeof crypto.randomUUID === 'function'
    ? crypto.randomUUID().slice(0, 8)
    : Math.random().toString(36).slice(2, 10)

  return `${timestamp}-${random}`
}

function slugify(value: string) {
  return safeString(value)
    .trim()
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9\s-]/g, '')
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-')
    .replace(/^-|-$/g, '')
}

function statusLabel(status: NewsStatus) {
  if (status === 'draft') return 'Draft'
  if (status === 'scheduled') return 'Terjadwal'
  if (status === 'archived') return 'Arsip'
  return 'Terbit'
}

function statusClass(status: NewsStatus) {
  if (status === 'draft') return 'bg-amber-100/90 text-amber-800'
  if (status === 'scheduled') return 'bg-blue-100/90 text-blue-800'
  if (status === 'archived') return 'bg-neutral-200/90 text-neutral-700'
  return 'bg-emerald-100/90 text-emerald-800'
}

function publicNewsUrl(item: NormalizedNewsItem) {
  const slug = safeString(item.slug)
  if (!slug) return profile.value.publicBase
  return `${profile.value.publicBase}?detail=${encodeURIComponent(slug)}`
}

function formatDate(value: number) {
  return new Intl.DateTimeFormat('id-ID', {
    day: '2-digit',
    month: 'short',
    year: 'numeric'
  }).format(new Date(value || Date.now()))
}

function formatTimeOnly(value: number) {
  return new Intl.DateTimeFormat('id-ID', {
    hour: '2-digit',
    minute: '2-digit'
  }).format(new Date(value))
}

function estimateReadTime(text: string) {
  const words = safeString(text)
    .trim()
    .split(/\s+/)
    .filter(Boolean)

  return Math.max(1, Math.ceil(words.length / 200))
}

function isValidUrl(value: string) {
  try {
    const url = new URL(value)
    return ['http:', 'https:'].includes(url.protocol)
  } catch {
    return false
  }
}

function isObjectRecord(value: unknown): value is Record<string, unknown> {
  return Boolean(value && typeof value === 'object' && !Array.isArray(value))
}

function safeString(value: unknown) {
  return String(value || '').trim()
}

function getErrorMessage(error: unknown, fallback: string) {
  if (!error) return fallback

  if (typeof error === 'string') return error

  if (isObjectRecord(error)) {
    const data = isObjectRecord(error.data) ? error.data : {}
    return safeString(data.statusMessage || data.message || error.statusMessage || error.message || fallback)
  }

  return fallback
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

function handleEscape(event: KeyboardEvent) {
  if (event.key !== 'Escape') return

  closeEllipsisMenu()
  closeView()
  closeDelete()
  closeNewsModal()
}
</script>

<style scoped>
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

.news-content :deep(h1) {
  margin: 1rem 0 0.75rem;
  font-size: 1.875rem;
  line-height: 2.25rem;
  font-weight: 900;
  color: rgb(23 23 23);
}

.news-content :deep(h2) {
  margin: 1rem 0 0.75rem;
  font-size: 1.5rem;
  line-height: 2rem;
  font-weight: 900;
  color: rgb(23 23 23);
}

.news-content :deep(h3) {
  margin: 0.875rem 0 0.5rem;
  font-size: 1.25rem;
  line-height: 1.75rem;
  font-weight: 900;
  color: rgb(23 23 23);
}

.news-content :deep(p) {
  margin: 0.75rem 0;
  font-size: 0.95rem;
  line-height: 1.85;
  font-weight: 500;
  color: rgb(64 64 64);
}

.news-content :deep(ul),
.news-content :deep(ol) {
  margin: 0.75rem 0;
  padding-left: 1.25rem;
  color: rgb(64 64 64);
}

.news-content :deep(ul) {
  list-style: disc;
}

.news-content :deep(ol) {
  list-style: decimal;
}

.news-content :deep(img) {
  max-width: 100%;
  height: auto;
  margin: 1rem 0;
  border-radius: 1rem;
}

.news-content :deep(iframe) {
  width: 100%;
  min-height: 320px;
  margin: 1rem 0;
  border-radius: 1rem;
}

.news-content :deep(table) {
  width: 100%;
  border-collapse: collapse;
  margin: 1rem 0;
}

.news-content :deep(th),
.news-content :deep(td) {
  border: 1px solid rgb(229 229 229);
  padding: 0.75rem;
  text-align: left;
}

.news-content :deep(th) {
  background: rgb(239 246 255);
  color: rgb(29 78 216);
  font-weight: 900;
}
</style>
