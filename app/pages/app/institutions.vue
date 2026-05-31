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
                :alt="appName"
                class="h-full w-full object-contain"
                @error="appLogoFailed = true"
              >
              <div v-else class="grid h-full w-full place-items-center rounded-2xl bg-blue-600 text-white">
                <Icon icon="solar:buildings-2-bold-duotone" class="h-7 w-7" />
              </div>
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
                Atur data lembaga, logo, profil, dan tautan publik dengan tampilan yang seragam dengan modul konten lainnya.
              </p>
            </div>
          </div>

          <div class="flex flex-wrap gap-2">
            <button
              type="button"
              class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-black text-neutral-700 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700 disabled:cursor-wait disabled:opacity-60"
              :disabled="isLoading"
              @click.stop="reloadInstitutions"
            >
              <Icon icon="solar:refresh-bold-duotone" class="h-5 w-5" :class="isLoading ? 'animate-spin' : ''" />
              Refresh
            </button>

            <button
              type="button"
              class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700"
              @click.stop="openCreate"
            >
              <Icon icon="lucide:plus" class="h-5 w-5" />
              Tambah Lembaga
            </button>
          </div>
        </div>
      </section>

      <section class="grid gap-3 sm:grid-cols-2 xl:grid-cols-4">
        <div class="rounded-3xl border border-neutral-200 bg-white p-4 shadow-sm">
          <div class="flex items-center justify-between gap-3">
            <div>
              <p class="text-[11px] font-black uppercase tracking-[0.14em] text-neutral-400">Total Lembaga</p>
              <p class="mt-2 text-2xl font-black text-neutral-950">{{ normalizedInstitutions.length }}</p>
            </div>
            <div class="grid h-11 w-11 place-items-center rounded-2xl bg-blue-50 text-blue-600">
              <Icon icon="solar:buildings-2-bold-duotone" class="h-6 w-6" />
            </div>
          </div>
        </div>

        <div class="rounded-3xl border border-neutral-200 bg-white p-4 shadow-sm">
          <div class="flex items-center justify-between gap-3">
            <div>
              <p class="text-[11px] font-black uppercase tracking-[0.14em] text-neutral-400">Aktif</p>
              <p class="mt-2 text-2xl font-black text-neutral-950">{{ activeCount }}</p>
            </div>
            <div class="grid h-11 w-11 place-items-center rounded-2xl bg-emerald-50 text-emerald-600">
              <Icon icon="solar:check-circle-bold-duotone" class="h-6 w-6" />
            </div>
          </div>
        </div>

        <div class="rounded-3xl border border-neutral-200 bg-white p-4 shadow-sm">
          <div class="flex items-center justify-between gap-3">
            <div>
              <p class="text-[11px] font-black uppercase tracking-[0.14em] text-neutral-400">Nonaktif</p>
              <p class="mt-2 text-2xl font-black text-neutral-950">{{ inactiveCount }}</p>
            </div>
            <div class="grid h-11 w-11 place-items-center rounded-2xl bg-neutral-100 text-neutral-600">
              <Icon icon="solar:archive-bold-duotone" class="h-6 w-6" />
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
              placeholder="Cari nama lembaga, slug, atau deskripsi..."
              class="h-12 w-full rounded-2xl border border-neutral-200 bg-neutral-50 pl-12 pr-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:bg-white focus:ring-4 focus:ring-blue-600/10"
            >
          </div>

          <div class="grid gap-2 sm:grid-cols-[180px_auto] lg:w-auto">
            <select
              v-model="sortBy"
              class="h-12 rounded-2xl border border-neutral-200 bg-neutral-50 px-4 text-sm font-black text-neutral-700 outline-none transition focus:border-blue-500 focus:bg-white focus:ring-4 focus:ring-blue-600/10"
            >
              <option value="sort_order">Urutan</option>
              <option value="title">Nama A-Z</option>
              <option value="newest">Terbaru</option>
              <option value="oldest">Terlama</option>
            </select>

            <button
              type="button"
              class="inline-flex h-12 items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-black text-neutral-700 transition hover:bg-neutral-50"
              @click.stop="resetFilters"
            >
              <Icon icon="solar:restart-bold-duotone" class="h-5 w-5" />
              Reset
            </button>
          </div>
        </div>
      </section>

      <div class="flex gap-2 overflow-x-auto pb-1">
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
        <article v-for="item in 6" :key="item" class="h-80 animate-pulse rounded-[1.75rem] border border-neutral-200 bg-white p-3 shadow-sm">
          <div class="h-44 rounded-[1.35rem] bg-neutral-100"></div>
          <div class="mt-4 h-4 w-2/3 rounded-full bg-neutral-100"></div>
          <div class="mt-3 h-3 w-full rounded-full bg-neutral-100"></div>
          <div class="mt-2 h-3 w-4/5 rounded-full bg-neutral-100"></div>
        </article>
      </section>

      <section
        v-else-if="filteredInstitutions.length === 0"
        class="rounded-[1.75rem] border border-dashed border-neutral-300 bg-white p-8 text-center shadow-sm"
      >
        <div class="mx-auto grid h-14 w-14 place-items-center rounded-3xl bg-blue-50 text-blue-600">
          <Icon icon="solar:buildings-2-bold-duotone" class="h-7 w-7" />
        </div>

        <h2 class="mt-4 text-xl font-black text-neutral-950">Belum ada lembaga</h2>
        <p class="mx-auto mt-2 max-w-md text-sm font-medium leading-6 text-neutral-500">
          Tambahkan data lembaga agar dapat tampil pada halaman publik.
        </p>

        <button
          type="button"
          class="mt-5 inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700"
          @click.stop="openCreate"
        >
          <Icon icon="lucide:plus" class="h-5 w-5" />
          Tambah Lembaga
        </button>
      </section>

      <section v-else class="grid gap-3 sm:grid-cols-2 xl:grid-cols-3">
        <article
          v-for="item in pagedInstitutions"
          :key="item.id"
          class="group relative overflow-hidden rounded-[1.75rem] border border-neutral-200 bg-white shadow-sm transition hover:-translate-y-0.5 hover:border-blue-200 hover:shadow-xl hover:shadow-blue-900/5"
        >
          <div class="relative h-44 overflow-hidden bg-neutral-100">
            <img
              v-if="getInstitutionCover(item) && !failedImages[item.id]"
              :src="getInstitutionCover(item)"
              :alt="item.title || 'Lembaga'"
              class="h-full w-full object-cover transition duration-500 group-hover:scale-105"
              loading="lazy"
              @error="markImageFailed(item.id)"
            >

            <div v-else class="flex h-full w-full items-center justify-center bg-gradient-to-br from-blue-50 via-white to-sky-50 text-blue-600">
              <Icon :icon="item.icon || defaultInstitutionIcon" class="h-14 w-14" />
            </div>

            <div class="absolute inset-0 bg-gradient-to-t from-neutral-950/65 via-neutral-950/10 to-transparent"></div>

            <div class="absolute left-3 top-3 flex flex-wrap gap-2">
              <span class="rounded-full px-3 py-1 text-[11px] font-black shadow-sm backdrop-blur" :class="statusClass(item.status)">
                {{ statusLabel(item.status) }}
              </span>

              <span v-if="item.isFeatured" class="rounded-full bg-blue-600 px-3 py-1 text-[11px] font-black text-white shadow-lg shadow-blue-900/20">
                Unggulan
              </span>
            </div>

            <button
              type="button"
              class="absolute right-3 top-3 grid h-10 w-10 place-items-center rounded-2xl border border-white/70 bg-white/95 text-neutral-700 shadow-lg shadow-neutral-950/10 backdrop-blur transition hover:bg-neutral-950 hover:text-white"
              aria-label="Buka menu lembaga"
              @click.stop="openEllipsisMenu(item, $event)"
            >
              <Icon icon="lucide:ellipsis" class="h-5 w-5" />
            </button>

            <div class="absolute bottom-3 left-3 right-3 flex items-center gap-3">
              <div class="grid h-12 w-12 shrink-0 place-items-center overflow-hidden rounded-2xl border border-white/20 bg-white/90 p-1.5 shadow-sm backdrop-blur">
                <img
                  v-if="item.logoUrl && !failedLogos[item.id]"
                  :src="item.logoUrl"
                  :alt="item.title || 'Logo lembaga'"
                  class="h-full w-full object-contain"
                  @error="markLogoFailed(item.id)"
                >
                <Icon v-else :icon="item.icon || defaultInstitutionIcon" class="h-6 w-6 text-blue-600" />
              </div>

              <div class="min-w-0">
                <h2 class="truncate text-base font-black text-white">
                  {{ item.title || 'Tanpa Nama' }}
                </h2>
                <p class="truncate text-xs font-semibold text-white/70">
                  {{ item.slug || '-' }}
                </p>
              </div>
            </div>
          </div>

          <div class="p-4">
            <p class="line-clamp-3 min-h-[4.5rem] text-sm font-medium leading-6 text-neutral-500">
              {{ item.subtitle || contentPreview(item) || 'Belum ada ringkasan lembaga.' }}
            </p>
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
          v-if="activeMenuInstitution"
          class="fixed z-[9999] w-56 overflow-hidden rounded-3xl border border-neutral-200 bg-white p-2 shadow-[0_24px_90px_rgba(15,23,42,0.22)]"
          :style="{ top: `${ellipsisMenuPosition.top}px`, left: `${ellipsisMenuPosition.left}px` }"
          @click.stop
        >
          <button
            type="button"
            class="flex w-full items-center gap-3 rounded-2xl px-3 py-2.5 text-left text-sm font-black text-neutral-700 transition hover:bg-blue-50 hover:text-blue-700"
            @click="openView(activeMenuInstitution)"
          >
            <Icon icon="solar:eye-bold-duotone" class="h-5 w-5 text-blue-600" />
            Lihat
          </button>

          <button
            type="button"
            class="flex w-full items-center gap-3 rounded-2xl px-3 py-2.5 text-left text-sm font-black text-neutral-700 transition disabled:cursor-not-allowed disabled:opacity-50"
            :class="activeMenuInstitution.status === 'inactive'
              ? 'hover:bg-emerald-50 hover:text-emerald-700'
              : 'hover:bg-amber-50 hover:text-amber-700'"
            :disabled="isMutatingStatus"
            @click="toggleInstitutionStatus(activeMenuInstitution)"
          >
            <Icon
              :icon="activeMenuInstitution.status === 'inactive' ? 'solar:check-circle-bold-duotone' : 'solar:archive-bold-duotone'"
              class="h-5 w-5"
              :class="activeMenuInstitution.status === 'inactive' ? 'text-emerald-600' : 'text-amber-600'"
            />
            {{ activeMenuInstitution.status === 'inactive' ? 'Aktifkan' : 'Nonaktifkan' }}
          </button>

          <button
            type="button"
            class="flex w-full items-center gap-3 rounded-2xl px-3 py-2.5 text-left text-sm font-black text-neutral-700 transition hover:bg-neutral-100 hover:text-neutral-950"
            @click="openEdit(activeMenuInstitution)"
          >
            <Icon icon="solar:pen-2-bold-duotone" class="h-5 w-5 text-neutral-600" />
            Edit
          </button>

          <div class="my-1 border-t border-neutral-100"></div>

          <button
            type="button"
            class="flex w-full items-center gap-3 rounded-2xl px-3 py-2.5 text-left text-sm font-black text-red-600 transition hover:bg-red-50"
            @click="openDelete(activeMenuInstitution)"
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
          v-if="showForm"
          class="fixed inset-0 z-[120] grid place-items-center bg-neutral-950/60 p-4 backdrop-blur-sm"
          role="dialog"
          aria-modal="true"
          @click.self="requestCloseForm"
        >
          <section class="flex max-h-[92dvh] w-full max-w-5xl flex-col overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-[0_32px_110px_rgba(15,23,42,0.28)]">
            <div class="border-b border-neutral-200 bg-gradient-to-br from-blue-50 via-white to-white p-5">
              <div class="flex items-start justify-between gap-4">
                <div>
                  <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">Lembaga</p>
                  <h2 class="mt-1 text-2xl font-black tracking-tight text-neutral-950">
                    {{ formMode === 'create' ? 'Tambah Lembaga' : 'Edit Lembaga' }}
                  </h2>
                  <p class="mt-1 text-sm font-semibold leading-6 text-neutral-500">
                    Form dibuat sederhana: slug tersembunyi otomatis, status default aktif, dan draft lokal tersimpan setelah mulai mengetik.
                  </p>
                </div>

                <button
                  type="button"
                  class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl border border-neutral-200 bg-white text-neutral-500 transition hover:bg-neutral-50 hover:text-neutral-950"
                  aria-label="Tutup modal lembaga"
                  @click="requestCloseForm"
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
              @submit.prevent="submitForm"
              @keyup.capture="handleDraftKeyup"
              @input.capture="queueInstitutionDraftSave"
              @change.capture="queueInstitutionDraftSave"
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
                      <Icon icon="solar:buildings-2-bold-duotone" class="h-5 w-5" />
                    </div>
                    <div>
                      <h3 class="text-base font-black text-neutral-950">Informasi Utama</h3>
                      <p class="mt-1 text-sm font-medium leading-6 text-neutral-500">Isi nama dan ringkasan singkat. Slug dibuat otomatis saat disimpan.</p>
                    </div>
                  </div>
                </div>

                <div class="grid gap-4 md:grid-cols-2">
                  <label class="block md:col-span-2">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Nama Lembaga</span>
                    <input
                      v-model="form.title"
                      type="text"
                      class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10"
                      placeholder="Contoh: Badan Permusyawaratan Desa"
                      required
                    >
                  </label>

                  <label class="block md:col-span-2">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Ringkasan Singkat</span>
                    <textarea
                      v-model="form.subtitle"
                      rows="4"
                      class="w-full resize-none rounded-2xl border border-neutral-200 bg-white px-4 py-3 text-sm font-bold leading-7 text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10"
                      placeholder="Tulis ringkasan pendek agar pengunjung memahami fungsi lembaga."
                    ></textarea>
                  </label>

                  <label class="block">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Ikon</span>
                    <input
                      v-model="form.icon"
                      type="text"
                      class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10"
                      placeholder="solar:buildings-2-bold-duotone"
                      list="institution-icon-options"
                    >
                    <datalist id="institution-icon-options">
                      <option v-for="icon in iconOptions" :key="icon.name" :value="icon.name">{{ icon.label }}</option>
                    </datalist>
                  </label>

                  <label class="block">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Urutan Tampil</span>
                    <input
                      v-model.number="form.sortOrder"
                      type="number"
                      min="0"
                      class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10"
                      placeholder="0"
                    >
                  </label>

                  <label class="flex items-start gap-3 rounded-2xl border border-neutral-200 bg-neutral-50 p-4 md:col-span-2">
                    <input
                      v-model="form.isFeatured"
                      type="checkbox"
                      class="mt-1 h-4 w-4 rounded border-neutral-300 text-blue-600 focus:ring-blue-500"
                    >
                    <span>
                      <span class="block text-sm font-black text-neutral-800">Tampilkan sebagai unggulan</span>
                      <span class="mt-1 block text-sm font-semibold leading-6 text-neutral-500">Data unggulan dapat ditampilkan lebih menonjol di halaman publik.</span>
                    </span>
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
                      <h3 class="text-base font-black text-neutral-950">Media Lembaga</h3>
                      <p class="mt-1 text-sm font-medium leading-6 text-neutral-500">Gunakan upload Cloudinary atau tempel link gambar. Preview cukup gambar saja.</p>
                    </div>
                  </div>
                </div>

                <div class="grid gap-4 lg:grid-cols-2">
                  <div class="space-y-4 rounded-[1.5rem] border border-neutral-200 bg-white p-4">
                    <div class="flex items-start justify-between gap-3">
                      <div>
                        <h4 class="text-sm font-black text-neutral-950">Logo Lembaga</h4>
                        <p class="mt-1 text-xs font-semibold leading-5 text-neutral-500">Logo kecil untuk identitas lembaga.</p>
                      </div>
                      <button
                        v-if="form.logoUrl"
                        type="button"
                        class="grid h-8 w-8 place-items-center rounded-xl bg-red-50 text-red-600 transition hover:bg-red-100"
                        @click.stop="form.logoUrl = ''"
                      >
                        <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-4 w-4" />
                      </button>
                    </div>

                    <div class="overflow-hidden rounded-2xl bg-neutral-100">
                      <img v-if="form.logoUrl" :src="form.logoUrl" alt="Preview logo lembaga" class="h-40 w-full object-contain p-5">
                      <div v-else class="grid h-40 place-items-center bg-gradient-to-br from-blue-50 via-white to-sky-50 text-blue-600">
                        <Icon :icon="form.icon || defaultInstitutionIcon" class="h-10 w-10" />
                      </div>
                    </div>

                    <div class="grid gap-2 rounded-[1.25rem] border border-neutral-200 bg-neutral-50 p-2 sm:grid-cols-2">
                      <button
                        type="button"
                        class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl text-sm font-black transition"
                        :class="mediaMode.logo === 'upload' ? 'bg-blue-600 text-white shadow-lg shadow-blue-600/20' : 'bg-white text-neutral-600 hover:bg-neutral-100'"
                        @click.stop="mediaMode.logo = 'upload'"
                      >
                        <Icon icon="solar:upload-square-bold-duotone" class="h-5 w-5" />
                        File
                      </button>

                      <button
                        type="button"
                        class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl text-sm font-black transition"
                        :class="mediaMode.logo === 'link' ? 'bg-blue-600 text-white shadow-lg shadow-blue-600/20' : 'bg-white text-neutral-600 hover:bg-neutral-100'"
                        @click.stop="mediaMode.logo = 'link'"
                      >
                        <Icon icon="solar:link-bold-duotone" class="h-5 w-5" />
                        Link
                      </button>
                    </div>

                    <div v-if="mediaMode.logo === 'upload'">
                      <input ref="logoInput" type="file" accept="image/jpeg,image/jpg,image/png,image/webp" class="hidden" @change="onPickLogo">
                      <button
                        type="button"
                        class="flex w-full items-center justify-center gap-3 rounded-[1.5rem] border-2 border-dashed border-blue-200 bg-blue-50 px-4 py-6 text-center text-blue-700 transition hover:border-blue-400 hover:bg-blue-100 disabled:cursor-not-allowed disabled:opacity-60"
                        :disabled="imageUploading"
                        @click.stop="logoInput?.click()"
                      >
                        <Icon icon="solar:cloud-upload-bold-duotone" class="h-7 w-7 shrink-0" />
                        <span class="min-w-0 truncate text-sm font-black">Pilih gambar logo</span>
                      </button>
                    </div>

                    <label v-else class="block">
                      <input
                        v-model="form.logoUrl"
                        type="url"
                        class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10"
                        placeholder="https://domain.com/logo.png"
                      >
                    </label>
                  </div>

                  <div class="space-y-4 rounded-[1.5rem] border border-neutral-200 bg-white p-4">
                    <div class="flex items-start justify-between gap-3">
                      <div>
                        <h4 class="text-sm font-black text-neutral-950">Gambar Utama</h4>
                        <p class="mt-1 text-xs font-semibold leading-5 text-neutral-500">Opsional, dipakai untuk card full-cover.</p>
                      </div>
                      <button
                        v-if="form.coverUrl"
                        type="button"
                        class="grid h-8 w-8 place-items-center rounded-xl bg-red-50 text-red-600 transition hover:bg-red-100"
                        @click.stop="form.coverUrl = ''"
                      >
                        <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-4 w-4" />
                      </button>
                    </div>

                    <div class="overflow-hidden rounded-2xl bg-neutral-100">
                      <img v-if="form.coverUrl" :src="form.coverUrl" alt="Preview gambar lembaga" class="h-40 w-full object-cover">
                      <div v-else class="grid h-40 place-items-center bg-gradient-to-br from-blue-50 via-white to-sky-50 text-blue-600">
                        <Icon icon="solar:gallery-wide-bold-duotone" class="h-10 w-10" />
                      </div>
                    </div>

                    <div class="grid gap-2 rounded-[1.25rem] border border-neutral-200 bg-neutral-50 p-2 sm:grid-cols-2">
                      <button
                        type="button"
                        class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl text-sm font-black transition"
                        :class="mediaMode.cover === 'upload' ? 'bg-blue-600 text-white shadow-lg shadow-blue-600/20' : 'bg-white text-neutral-600 hover:bg-neutral-100'"
                        @click.stop="mediaMode.cover = 'upload'"
                      >
                        <Icon icon="solar:upload-square-bold-duotone" class="h-5 w-5" />
                        File
                      </button>

                      <button
                        type="button"
                        class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl text-sm font-black transition"
                        :class="mediaMode.cover === 'link' ? 'bg-blue-600 text-white shadow-lg shadow-blue-600/20' : 'bg-white text-neutral-600 hover:bg-neutral-100'"
                        @click.stop="mediaMode.cover = 'link'"
                      >
                        <Icon icon="solar:link-bold-duotone" class="h-5 w-5" />
                        Link
                      </button>
                    </div>

                    <div v-if="mediaMode.cover === 'upload'">
                      <input ref="coverInput" type="file" accept="image/jpeg,image/jpg,image/png,image/webp" class="hidden" @change="onPickCover">
                      <button
                        type="button"
                        class="flex w-full items-center justify-center gap-3 rounded-[1.5rem] border-2 border-dashed border-blue-200 bg-blue-50 px-4 py-6 text-center text-blue-700 transition hover:border-blue-400 hover:bg-blue-100 disabled:cursor-not-allowed disabled:opacity-60"
                        :disabled="imageUploading"
                        @click.stop="coverInput?.click()"
                      >
                        <Icon icon="solar:cloud-upload-bold-duotone" class="h-7 w-7 shrink-0" />
                        <span class="min-w-0 truncate text-sm font-black">Pilih gambar utama</span>
                      </button>
                    </div>

                    <label v-else class="block">
                      <input
                        v-model="form.coverUrl"
                        type="url"
                        class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10"
                        placeholder="https://domain.com/cover.jpg"
                      >
                    </label>
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
                      <h3 class="text-base font-black text-neutral-950">Profil Lembaga</h3>
                      <p class="mt-1 text-sm font-medium leading-6 text-neutral-500">Gunakan RichText reusable. Konten cukup dihubungkan dengan v-model.</p>
                    </div>
                  </div>
                </div>

                <div class="overflow-hidden rounded-[1.8rem] bg-white p-1">
                  <RichText
                    v-model="form.contentHtml"
                    placeholder="Tulis profil lengkap lembaga di sini..."
                  />
                </div>
              </div>
            </form>

            <div class="flex flex-col-reverse gap-2 border-t border-neutral-200 bg-white p-5 sm:flex-row sm:items-center sm:justify-between">
              <div class="text-xs font-bold text-neutral-400">
                <span v-if="formMode === 'edit'">Mode edit tidak menimpa draft lokal.</span>
                <span v-else-if="lastDraftSavedAt">Draft lokal tersimpan {{ lastDraftSavedAt }}.</span>
                <span v-else>Draft lokal akan tersimpan setelah kamu mulai mengetik.</span>
              </div>

              <div class="flex flex-col-reverse gap-2 sm:flex-row">
                <button
                  type="button"
                  class="inline-flex h-12 items-center justify-center rounded-2xl border border-neutral-200 bg-white px-5 text-sm font-black text-neutral-700 transition hover:bg-neutral-50"
                  @click="formStep === 1 ? requestCloseForm() : prevFormStep()"
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
                  :disabled="saving || imageUploading || !canSubmit"
                  @click="submitForm"
                >
                  <Icon
                    :icon="saving || imageUploading ? 'solar:refresh-bold-duotone' : 'solar:diskette-bold-duotone'"
                    class="h-5 w-5"
                    :class="saving || imageUploading ? 'animate-spin' : ''"
                  />
                  {{ imageUploading ? 'Mengunggah...' : saving ? 'Menyimpan...' : formMode === 'create' ? 'Tambah Lembaga' : 'Simpan Perubahan' }}
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
          v-if="viewModalOpen && selectedInstitution"
          class="fixed inset-0 z-[130] grid place-items-center bg-neutral-950/60 p-4 backdrop-blur-sm"
          role="dialog"
          aria-modal="true"
          @click.self="closeView"
        >
          <section class="flex max-h-[92dvh] w-full max-w-4xl flex-col overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-[0_32px_110px_rgba(15,23,42,0.28)]">
            <div class="flex items-start justify-between gap-4 border-b border-neutral-200 p-5">
              <div>
                <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">Detail Lembaga</p>
                <h2 class="mt-1 text-2xl font-black tracking-tight text-neutral-950">{{ selectedInstitution.title }}</h2>
              </div>

              <button
                type="button"
                class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl border border-neutral-200 bg-white text-neutral-500 transition hover:bg-neutral-50 hover:text-neutral-950"
                aria-label="Tutup detail lembaga"
                @click="closeView"
              >
                <Icon icon="lucide:x" class="h-5 w-5" />
              </button>
            </div>

            <div class="min-h-0 flex-1 overflow-y-auto p-5">
              <img
                v-if="getInstitutionCover(selectedInstitution)"
                :src="getInstitutionCover(selectedInstitution)"
                :alt="selectedInstitution.title"
                class="mb-5 h-72 w-full rounded-[1.5rem] object-cover"
              >

              <div class="mb-5 flex flex-wrap items-center gap-2">
                <span class="rounded-full px-3 py-1 text-xs font-black" :class="statusClass(selectedInstitution.status)">
                  {{ statusLabel(selectedInstitution.status) }}
                </span>
                <span v-if="selectedInstitution.isFeatured" class="rounded-full bg-blue-50 px-3 py-1 text-xs font-black text-blue-700">
                  Unggulan
                </span>
                <span class="rounded-full bg-neutral-100 px-3 py-1 text-xs font-black text-neutral-600">
                  {{ selectedInstitution.slug || '-' }}
                </span>
              </div>

              <p class="mb-5 rounded-2xl bg-neutral-50 p-4 text-sm font-semibold leading-7 text-neutral-600">
                {{ selectedInstitution.subtitle || contentPreview(selectedInstitution) || 'Belum ada ringkasan.' }}
              </p>

              <div class="institution-content rounded-2xl border border-neutral-200 p-5" v-html="selectedInstitution.contentHtml || '<p>Belum ada konten profil.</p>'"></div>
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
          v-if="showDelete && selectedInstitution"
          class="fixed inset-0 z-[140] grid place-items-center bg-neutral-950/60 p-4 backdrop-blur-sm"
          role="dialog"
          aria-modal="true"
          @click.self="showDelete = false"
        >
          <section class="w-full max-w-md rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-[0_32px_110px_rgba(15,23,42,0.28)]">
            <div class="grid h-14 w-14 place-items-center rounded-3xl bg-red-50 text-red-600">
              <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-7 w-7" />
            </div>

            <h2 class="mt-5 text-xl font-black tracking-tight text-neutral-950">Hapus lembaga?</h2>
            <p class="mt-2 text-sm font-medium leading-6 text-neutral-500">
              Data <strong class="text-neutral-900">{{ selectedInstitution.title }}</strong> akan dihapus dari daftar.
            </p>

            <div class="mt-6 flex flex-col-reverse gap-3 sm:flex-row sm:justify-end">
              <button
                type="button"
                class="inline-flex h-11 items-center justify-center rounded-2xl border border-neutral-200 bg-white px-5 text-sm font-black text-neutral-700 transition hover:bg-neutral-50"
                @click="showDelete = false"
              >
                Batal
              </button>

              <button
                type="button"
                class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-red-600 px-5 text-sm font-black text-white transition hover:bg-red-700 disabled:cursor-not-allowed disabled:opacity-60"
                :disabled="deleting"
                @click="confirmDelete"
              >
                <Icon
                  :icon="deleting ? 'solar:refresh-bold-duotone' : 'solar:trash-bin-trash-bold-duotone'"
                  class="h-5 w-5"
                  :class="deleting ? 'animate-spin' : ''"
                />
                {{ deleting ? 'Menghapus...' : 'Hapus' }}
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
import { useFetch, useHead, useRequestURL, useRuntimeConfig, useSeoMeta } from '#imports'
import RichText from '~/components/widget/RichText.vue'
import { useCloudinaryUpload } from '~/composables/useCloudinaryUpload'
import { useAppApi } from '../../composables/useAppApi'

definePageMeta({
  layout: 'app',
  layoutProps: {
    title: 'Lembaga'
  }
})

type ToastType = 'success' | 'error'
type InstitutionStatus = 'active' | 'inactive'
type StatusFilter = 'all' | InstitutionStatus | 'featured'
type SortOption = 'newest' | 'oldest' | 'title' | 'sort_order'
type MediaMode = 'upload' | 'link'
type MediaTarget = 'logo' | 'cover'

type InstitutionItem = {
  id: string
  title: string
  subtitle?: string | null
  slug: string
  icon?: string | null
  logoUrl?: string | null
  coverUrl?: string | null
  imageUrl?: string | null
  contentHtml?: string | null
  status: InstitutionStatus
  isFeatured?: boolean
  sortOrder?: number
  metadata?: Record<string, any> | null
  createdAt?: number | string | null
  updatedAt?: number | string | null
}

type InstitutionListResponse = {
  data: InstitutionItem[]
  meta?: {
    page: number
    limit: number
    total: number
    totalPages: number
  }
}

type InstitutionForm = {
  title: string
  subtitle: string
  icon: string
  logoUrl: string
  coverUrl: string
  contentHtml: string
  isFeatured: boolean
  sortOrder: number
}

type InstitutionDraft = InstitutionForm & {
  updatedAt?: string
}

const config = useRuntimeConfig()
const requestUrl = useRequestURL()
const { tenantApiUrl } = useAppApi()
const { uploading: imageUploading, uploadError: imageUploadError, uploadImage } = useCloudinaryUpload()

const search = ref('')
const selectedStatus = ref<StatusFilter>('all')
const sortBy = ref<SortOption>('sort_order')
const page = ref(1)
const pageSize = 12

const appLogoFailed = ref(false)
const failedImages = ref<Record<string, boolean>>({})
const failedLogos = ref<Record<string, boolean>>({})
const patchedInstitutions = ref<Record<string, InstitutionItem>>({})

const showForm = ref(false)
const viewModalOpen = ref(false)
const showDelete = ref(false)
const formMode = ref<'create' | 'edit'>('create')
const formStep = ref(1)
const formError = ref('')
const saving = ref(false)
const deleting = ref(false)
const selectedInstitution = ref<InstitutionItem | null>(null)

const draftLoaded = ref(false)
const draftReady = ref(false)
const draftStarted = ref(false)
const localDraftExists = ref(false)
const lastDraftSavedAt = ref('')

const activeMenuInstitution = ref<InstitutionItem | null>(null)
const ellipsisMenuPosition = reactive({ top: 0, left: 0 })
const isMutatingStatus = ref(false)

const logoInput = ref<HTMLInputElement | null>(null)
const coverInput = ref<HTMLInputElement | null>(null)
const mediaMode = reactive<Record<MediaTarget, MediaMode>>({
  logo: 'upload',
  cover: 'upload'
})

let toastTimer: ReturnType<typeof setTimeout> | null = null
let draftTimer: ReturnType<typeof setTimeout> | null = null

const toast = reactive({
  show: false,
  type: 'success' as ToastType,
  title: '',
  message: ''
})

const form = reactive<InstitutionForm>(createEmptyForm())

const formSteps = [
  {
    value: 1,
    title: 'Informasi',
    description: 'Nama dan ringkasan',
    icon: 'solar:buildings-2-bold-duotone'
  },
  {
    value: 2,
    title: 'Media',
    description: 'Logo dan cover',
    icon: 'solar:gallery-wide-bold-duotone'
  },
  {
    value: 3,
    title: 'Detail',
    description: 'Profil lengkap',
    icon: 'solar:pen-new-square-bold-duotone'
  }
]

const iconOptions = [
  { name: 'solar:buildings-2-bold-duotone', label: 'Gedung Lembaga' },
  { name: 'solar:buildings-3-bold-duotone', label: 'Kantor Desa' },
  { name: 'solar:users-group-rounded-bold-duotone', label: 'Kelompok Warga' },
  { name: 'solar:shield-check-bold-duotone', label: 'Keamanan' },
  { name: 'solar:hand-heart-bold-duotone', label: 'Sosial' },
  { name: 'solar:heart-pulse-bold-duotone', label: 'Kesehatan' },
  { name: 'solar:book-bookmark-bold-duotone', label: 'Pendidikan' },
  { name: 'solar:leaf-bold-duotone', label: 'Pertanian' },
  { name: 'solar:case-round-bold-duotone', label: 'BUMDes / Usaha' },
  { name: 'solar:stars-bold-duotone', label: 'Keagamaan' },
  { name: 'lucide:landmark', label: 'Pemerintahan' },
  { name: 'lucide:users-round', label: 'Masyarakat' },
  { name: 'lucide:graduation-cap', label: 'Pendidikan' },
  { name: 'lucide:shield-check', label: 'Aman' },
  { name: 'lucide:hand-heart', label: 'PKK / Sosial' }
]

const defaultInstitutionIcon = 'solar:buildings-2-bold-duotone'

const hostname = computed(() => String(requestUrl.hostname || '').replace(/^www\./, '').toLowerCase())

const tenantSlug = computed(() => {
  const envClient = String(config.public.clientName || '').trim().toLowerCase()
  if (hostname.value.includes('martopuro')) return 'martopuro'
  if (hostname.value.includes('obayan')) return 'obayan'
  return envClient || 'martopuro'
})

const appName = computed(() => String(config.public.appName || config.public.clientDisplayName || config.public.siteName || 'Arsades'))

const appLogo = computed(() => {
  if (appLogoFailed.value) return ''
  return String(config.public.appLogo || config.public.logoUrl || config.public.siteLogo || '').trim()
})

const apiUrl = computed(() => tenantApiUrl(tenantSlug.value, '/institutions'))

const queryParams = computed(() => ({
  status: selectedStatus.value === 'active' || selectedStatus.value === 'inactive' ? selectedStatus.value : undefined,
  limit: 100,
  sort: sortBy.value
}))

const { data, pending, error, refresh } = await useFetch<InstitutionListResponse>(apiUrl, {
  key: computed(() => `tenant-institutions-${tenantSlug.value}-${selectedStatus.value}-${sortBy.value}`),
  query: queryParams,
  watch: [tenantSlug, selectedStatus, sortBy],
  default: () => ({
    data: [],
    meta: { page: 1, limit: 100, total: 0, totalPages: 1 }
  })
})

const isLoading = computed(() => Boolean(unref(pending)))

const visibleError = computed(() => {
  const value = unref(error)
  if (!value) return ''
  if (typeof value === 'string') return value
  return value?.message || 'Data lembaga belum bisa dimuat.'
})

const rawInstitutions = computed(() => data.value?.data || [])

const normalizedInstitutions = computed(() => {
  const merged = new Map<string, InstitutionItem>()

  for (const item of rawInstitutions.value) {
    merged.set(item.id, normalizeInstitutionItem(item))
  }

  for (const item of Object.values(patchedInstitutions.value)) {
    const existing = merged.get(item.id)
    merged.set(item.id, {
      ...existing,
      ...item,
      metadata: {
        ...(existing?.metadata || {}),
        ...(item.metadata || {})
      }
    })
  }

  return Array.from(merged.values())
})

const filteredInstitutions = computed(() => {
  const keyword = search.value.trim().toLowerCase()

  return normalizedInstitutions.value
    .filter((item) => {
      const matchKeyword = !keyword || [
        item.title,
        item.subtitle,
        item.slug,
        item.status,
        item.icon,
        stripHtml(item.contentHtml || '')
      ]
        .filter(Boolean)
        .join(' ')
        .toLowerCase()
        .includes(keyword)

      const matchStatus =
        selectedStatus.value === 'all' ||
        selectedStatus.value === item.status ||
        (selectedStatus.value === 'featured' && Boolean(item.isFeatured))

      return matchKeyword && matchStatus
    })
    .sort((a, b) => {
      if (sortBy.value === 'title') return String(a.title || '').localeCompare(String(b.title || ''))
      if (sortBy.value === 'newest') return toTimestamp(b.createdAt || b.updatedAt) - toTimestamp(a.createdAt || a.updatedAt)
      if (sortBy.value === 'oldest') return toTimestamp(a.createdAt || a.updatedAt) - toTimestamp(b.createdAt || b.updatedAt)

      const sortA = Number(a.sortOrder || 0)
      const sortB = Number(b.sortOrder || 0)
      if (sortA !== sortB) return sortA - sortB
      return String(a.title || '').localeCompare(String(b.title || ''))
    })
})

const pagedInstitutions = computed(() => filteredInstitutions.value.slice(0, page.value * pageSize))
const hasMore = computed(() => pagedInstitutions.value.length < filteredInstitutions.value.length)

const activeCount = computed(() => normalizedInstitutions.value.filter((item) => item.status === 'active').length)
const inactiveCount = computed(() => normalizedInstitutions.value.filter((item) => item.status === 'inactive').length)
const featuredCount = computed(() => normalizedInstitutions.value.filter((item) => item.isFeatured).length)

const statusFilterOptions = computed<Array<{ value: StatusFilter; label: string; icon: string; count: number }>>(() => [
  { value: 'all', label: 'Semua', icon: 'solar:layers-bold-duotone', count: normalizedInstitutions.value.length },
  { value: 'active', label: 'Aktif', icon: 'solar:check-circle-bold-duotone', count: activeCount.value },
  { value: 'inactive', label: 'Nonaktif', icon: 'solar:archive-bold-duotone', count: inactiveCount.value },
  { value: 'featured', label: 'Unggulan', icon: 'solar:star-bold-duotone', count: featuredCount.value }
])

const canGoNext = computed(() => {
  if (formStep.value === 1) return form.title.trim().length >= 3
  if (formStep.value === 2) return validateMediaLinks(false)
  return true
})

const canSubmit = computed(() => form.title.trim().length >= 3)
const institutionDraftKey = computed(() => `institution-form-draft:${tenantSlug.value}`)

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

watch([search, selectedStatus, sortBy], () => {
  page.value = 1
})

watch(
  form,
  () => {
    if (!draftStarted.value) return
    queueInstitutionDraftSave()
  },
  { deep: true }
)

onMounted(() => {
  refreshLocalDraftState()
  document.addEventListener('keydown', handleEscape)
  window.addEventListener('resize', closeEllipsisMenu)
  window.addEventListener('scroll', closeEllipsisMenu, true)
})

onBeforeUnmount(() => {
  if (toastTimer) clearTimeout(toastTimer)
  if (draftTimer) clearTimeout(draftTimer)
  document.removeEventListener('keydown', handleEscape)
  window.removeEventListener('resize', closeEllipsisMenu)
  window.removeEventListener('scroll', closeEllipsisMenu, true)
})

async function reloadInstitutions() {
  try {
    await refresh()
    showToast('success', 'Data diperbarui', 'Daftar lembaga berhasil dimuat ulang.')
  } catch (fetchError: any) {
    showToast('error', 'Gagal Memuat Data', fetchError?.message || 'Data lembaga gagal dimuat.')
  }
}

function createEmptyForm(): InstitutionForm {
  return {
    title: '',
    subtitle: '',
    icon: defaultInstitutionIcon,
    logoUrl: '',
    coverUrl: '',
    contentHtml: '',
    isFeatured: true,
    sortOrder: 0
  }
}

function resetForm() {
  Object.assign(form, createEmptyForm())
  formError.value = ''
  mediaMode.logo = 'upload'
  mediaMode.cover = 'upload'

  if (logoInput.value) logoInput.value.value = ''
  if (coverInput.value) coverInput.value.value = ''
}

async function openCreate() {
  closeEllipsisMenu()
  formMode.value = 'create'
  selectedInstitution.value = null
  formStep.value = 1
  draftLoaded.value = false
  draftStarted.value = false
  draftReady.value = false
  resetForm()

  const draft = readInstitutionDraft()

  if (draft) {
    Object.assign(form, {
      ...createEmptyForm(),
      ...draft
    })

    if (draft.logoUrl) mediaMode.logo = 'link'
    if (draft.coverUrl) mediaMode.cover = 'link'

    draftLoaded.value = true
  }

  showForm.value = true

  await nextTick()

  draftReady.value = true
}

async function openEdit(item: InstitutionItem) {
  closeEllipsisMenu()
  formMode.value = 'edit'
  selectedInstitution.value = item
  formStep.value = 1
  draftLoaded.value = false
  draftStarted.value = false
  draftReady.value = false
  formError.value = ''

  Object.assign(form, {
    title: item.title || '',
    subtitle: item.subtitle || '',
    icon: item.icon || defaultInstitutionIcon,
    logoUrl: item.logoUrl || '',
    coverUrl: getInstitutionCoverWithoutLogo(item),
    contentHtml: item.contentHtml || '',
    isFeatured: Boolean(item.isFeatured),
    sortOrder: Number(item.sortOrder || 0)
  })

  mediaMode.logo = item.logoUrl ? 'link' : 'upload'
  mediaMode.cover = getInstitutionCoverWithoutLogo(item) ? 'link' : 'upload'
  showForm.value = true

  await nextTick()

  draftReady.value = true
}

function requestCloseForm() {
  closeForm()
}

function closeForm() {
  showForm.value = false
  formError.value = ''
  draftReady.value = false
  draftStarted.value = false
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

  if (formStep.value === 1 && form.title.trim().length < 3) {
    formError.value = 'Nama lembaga minimal 3 karakter.'
    return false
  }

  if (formStep.value === 2 && !validateMediaLinks(true)) {
    return false
  }

  return true
}

function validateMediaLinks(withMessage: boolean) {
  if (form.logoUrl.trim() && !isValidUrl(form.logoUrl.trim())) {
    if (withMessage) formError.value = 'Link logo belum valid.'
    return false
  }

  if (form.coverUrl.trim() && !isValidUrl(form.coverUrl.trim())) {
    if (withMessage) formError.value = 'Link gambar utama belum valid.'
    return false
  }

  return true
}

async function submitForm() {
  if (!canSubmit.value || saving.value) return

  for (const step of formSteps) {
    formStep.value = step.value
    if (!validateCurrentStep()) return
  }

  saving.value = true

  try {
    const payload = buildFormPayload(selectedInstitution.value?.status || 'active')

    if (formMode.value === 'create') {
      await $fetch(apiUrl.value, {
        method: 'POST',
        body: payload
      })

      clearInstitutionDraft()
      showToast('success', 'Berhasil Disimpan', 'Data lembaga berhasil ditambahkan.')
    } else if (selectedInstitution.value) {
      await $fetch(`${apiUrl.value}/${selectedInstitution.value.id}`, {
        method: 'PUT',
        body: payload
      })

      showToast('success', 'Berhasil Diupdate', 'Perubahan lembaga berhasil disimpan.')
    }

    closeForm()
    await refresh()
  } catch (submitError: any) {
    const message = submitError?.data?.statusMessage || submitError?.data?.message || submitError?.statusMessage || submitError?.message || 'Data lembaga gagal disimpan.'
    formError.value = message
    showToast('error', 'Gagal Menyimpan', message)
  } finally {
    saving.value = false
  }
}

function buildFormPayload(status: InstitutionStatus) {
  const title = form.title.trim()
  const slug = selectedInstitution.value?.slug || createInstitutionSlug(title)
  const previousMetadata = selectedInstitution.value?.metadata || {}
  const cover = form.coverUrl.trim()

  return {
    title,
    subtitle: form.subtitle.trim() || null,
    slug,
    icon: form.icon.trim() || defaultInstitutionIcon,
    logoUrl: form.logoUrl.trim() || null,
    coverUrl: cover || null,
    imageUrl: cover || null,
    contentHtml: form.contentHtml || '<p></p>',
    status,
    isFeatured: Boolean(form.isFeatured),
    sortOrder: Number(form.sortOrder || 0),
    metadata: {
      ...previousMetadata,
      coverUrl: cover || null,
      images: cover ? [cover] : Array.isArray(previousMetadata.images) ? previousMetadata.images : []
    }
  }
}

async function toggleInstitutionStatus(item: InstitutionItem) {
  closeEllipsisMenu()
  isMutatingStatus.value = true

  const nextStatus: InstitutionStatus = item.status === 'inactive' ? 'active' : 'inactive'
  const nextItem: InstitutionItem = {
    ...item,
    status: nextStatus,
    updatedAt: Date.now()
  }

  try {
    await $fetch(`${apiUrl.value}/${item.id}`, {
      method: 'PUT',
      body: createPayloadFromItem(nextItem)
    })

    patchedInstitutions.value[item.id] = nextItem
    showToast(
      'success',
      nextStatus === 'active' ? 'Lembaga Diaktifkan' : 'Lembaga Dinonaktifkan',
      nextStatus === 'active' ? 'Lembaga berhasil ditampilkan kembali.' : 'Lembaga berhasil disimpan sebagai nonaktif.'
    )

    await refresh()
  } catch (statusError: any) {
    showToast('error', 'Gagal Mengubah Status', statusError?.data?.message || statusError?.message || 'Status lembaga belum berhasil diubah.')
  } finally {
    isMutatingStatus.value = false
  }
}

function createPayloadFromItem(item: InstitutionItem) {
  const cover = getInstitutionCoverWithoutLogo(item)

  return {
    title: item.title,
    subtitle: item.subtitle || null,
    slug: item.slug || createInstitutionSlug(item.title),
    icon: item.icon || defaultInstitutionIcon,
    logoUrl: item.logoUrl || null,
    coverUrl: cover || null,
    imageUrl: cover || null,
    contentHtml: item.contentHtml || '<p></p>',
    status: item.status,
    isFeatured: Boolean(item.isFeatured),
    sortOrder: Number(item.sortOrder || 0),
    metadata: {
      ...(item.metadata || {}),
      coverUrl: cover || null,
      images: cover ? [cover] : Array.isArray(item.metadata?.images) ? item.metadata?.images : []
    }
  }
}

function openView(item: InstitutionItem) {
  selectedInstitution.value = item
  viewModalOpen.value = true
  closeEllipsisMenu()
}

function closeView() {
  viewModalOpen.value = false
  selectedInstitution.value = null
}

function openDelete(item: InstitutionItem) {
  selectedInstitution.value = item
  showDelete.value = true
  closeEllipsisMenu()
}

async function confirmDelete() {
  if (!selectedInstitution.value) return

  deleting.value = true

  try {
    await $fetch(`${apiUrl.value}/${selectedInstitution.value.id}`, {
      method: 'DELETE'
    })

    delete patchedInstitutions.value[selectedInstitution.value.id]
    showDelete.value = false
    showToast('success', 'Data Dihapus', 'Data lembaga berhasil dihapus.')
    await refresh()
  } catch (deleteError: any) {
    showToast('error', 'Gagal Menghapus', deleteError?.message || 'Data lembaga gagal dihapus.')
  } finally {
    deleting.value = false
  }
}

async function onPickLogo(event: Event) {
  await uploadPickedImage(event, 'logo')
}

async function onPickCover(event: Event) {
  await uploadPickedImage(event, 'cover')
}

async function uploadPickedImage(event: Event, target: MediaTarget) {
  const input = event.target as HTMLInputElement
  const file = input.files?.[0] || null

  if (!file) return

  if (!isAllowedImageFile(file)) {
    input.value = ''
    return
  }

  try {
    const result = await uploadImage(file, {
      folder: `${tenantSlug.value}/institutions/${target}`,
      maxWidth: target === 'logo' ? 900 : 1800,
      maxHeight: target === 'logo' ? 900 : 1800,
      quality: 0.85,
      maxBytes: 5 * 1024 * 1024
    })

    const url = result.secure_url || (result as any).url || ''

    if (target === 'logo') form.logoUrl = url
    if (target === 'cover') form.coverUrl = url

    draftStarted.value = true
    queueInstitutionDraftSave()
    showToast('success', 'Gambar Ditambahkan', 'Gambar berhasil dipasang.')
  } catch (uploadError: any) {
    showToast('error', 'Gagal Mengunggah', uploadError?.message || imageUploadError.value || 'Gambar belum bisa dipasang.')
  } finally {
    input.value = ''
  }
}

function isAllowedImageFile(file: File) {
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

function openEllipsisMenu(item: InstitutionItem, event: MouseEvent) {
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
  activeMenuInstitution.value = item
}

function closeEllipsisMenu() {
  activeMenuInstitution.value = null
}

function handleDraftKeyup() {
  if (formMode.value === 'edit') return
  draftStarted.value = true
  queueInstitutionDraftSave()
}

function queueInstitutionDraftSave() {
  if (formMode.value === 'edit') return
  if (!showForm.value || !draftReady.value || !draftStarted.value) return

  if (draftTimer) clearTimeout(draftTimer)

  draftTimer = setTimeout(() => {
    saveInstitutionDraft()
  }, 250)
}

function readInstitutionDraft(): InstitutionDraft | null {
  if (!import.meta.client) return null

  try {
    const raw = localStorage.getItem(institutionDraftKey.value)
    if (!raw) return null
    return JSON.parse(raw) as InstitutionDraft
  } catch {
    return null
  }
}

function saveInstitutionDraft() {
  if (!import.meta.client) return

  const hasDraft = Boolean(
    form.title.trim() ||
    form.subtitle.trim() ||
    form.logoUrl.trim() ||
    form.coverUrl.trim() ||
    form.contentHtml.trim()
  )

  if (!hasDraft) {
    localStorage.removeItem(institutionDraftKey.value)
    refreshLocalDraftState()
    return
  }

  const payload: InstitutionDraft = {
    ...form,
    updatedAt: new Date().toISOString()
  }

  localStorage.setItem(institutionDraftKey.value, JSON.stringify(payload))
  lastDraftSavedAt.value = formatTimeOnly(Date.now())
  refreshLocalDraftState()
}

function clearInstitutionDraft() {
  if (!import.meta.client) return
  localStorage.removeItem(institutionDraftKey.value)
  draftLoaded.value = false
  localDraftExists.value = false
  lastDraftSavedAt.value = ''
}

function refreshLocalDraftState() {
  if (!import.meta.client) return
  localDraftExists.value = Boolean(localStorage.getItem(institutionDraftKey.value))
}

function resetFilters() {
  search.value = ''
  selectedStatus.value = 'all'
  sortBy.value = 'sort_order'
  page.value = 1
}

function normalizeInstitutionItem(item: InstitutionItem): InstitutionItem {
  const status = item.status === 'inactive' ? 'inactive' : 'active'

  return {
    ...item,
    title: String(item.title || 'Tanpa Nama'),
    subtitle: item.subtitle || '',
    slug: item.slug || slugify(item.title || 'lembaga'),
    icon: item.icon || defaultInstitutionIcon,
    logoUrl: item.logoUrl || '',
    coverUrl: item.coverUrl || item.imageUrl || item.metadata?.coverUrl || '',
    imageUrl: item.imageUrl || item.coverUrl || item.metadata?.coverUrl || '',
    contentHtml: item.contentHtml || '',
    status,
    isFeatured: Boolean(item.isFeatured),
    sortOrder: Number(item.sortOrder || 0),
    metadata: item.metadata || {}
  }
}

function getInstitutionCover(item: InstitutionItem) {
  return getInstitutionCoverWithoutLogo(item) || String(item.logoUrl || '')
}

function getInstitutionCoverWithoutLogo(item: InstitutionItem) {
  const metadataImages = Array.isArray(item.metadata?.images) ? item.metadata?.images : []
  const candidates = [
    item.coverUrl,
    item.imageUrl,
    item.metadata?.coverUrl,
    item.metadata?.imageUrl,
    ...metadataImages
  ]

  for (const value of candidates) {
    const url = String(value || '').trim()
    if (url) return url
  }

  return ''
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

function statusClass(status: InstitutionStatus) {
  if (status === 'active') return 'bg-emerald-100/90 text-emerald-800'
  return 'bg-neutral-200/90 text-neutral-700'
}

function statusLabel(status: InstitutionStatus) {
  return status === 'active' ? 'Aktif' : 'Nonaktif'
}

function contentPreview(item: InstitutionItem) {
  return stripHtml(item.contentHtml || '').slice(0, 140)
}

function createInstitutionSlug(title: string) {
  const baseSlug = slugify(title) || 'lembaga'
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

function toTimestamp(value?: number | string | null) {
  if (!value) return 0
  if (typeof value === 'number') return value < 10_000_000_000 ? value * 1000 : value

  const time = new Date(value).getTime()
  return Number.isFinite(time) ? time : 0
}

function formatDate(value?: number | string | null) {
  const timestamp = toTimestamp(value)
  if (!timestamp) return '-'

  return new Intl.DateTimeFormat('id-ID', {
    day: '2-digit',
    month: 'short',
    year: 'numeric'
  }).format(new Date(timestamp))
}

function formatTimeOnly(value: number) {
  return new Intl.DateTimeFormat('id-ID', {
    hour: '2-digit',
    minute: '2-digit'
  }).format(new Date(value))
}

function isValidUrl(value: string) {
  try {
    const url = new URL(value)
    return ['http:', 'https:'].includes(url.protocol)
  } catch {
    return false
  }
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
  showDelete.value = false
  closeForm()
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

.institution-content :deep(h1) {
  margin: 1rem 0 0.75rem;
  font-size: 1.875rem;
  line-height: 2.25rem;
  font-weight: 900;
  color: rgb(23 23 23);
}

.institution-content :deep(h2) {
  margin: 1rem 0 0.75rem;
  font-size: 1.5rem;
  line-height: 2rem;
  font-weight: 900;
  color: rgb(23 23 23);
}

.institution-content :deep(h3) {
  margin: 0.875rem 0 0.5rem;
  font-size: 1.25rem;
  line-height: 1.75rem;
  font-weight: 900;
  color: rgb(23 23 23);
}

.institution-content :deep(p) {
  margin: 0.75rem 0;
  font-size: 0.95rem;
  line-height: 1.85;
  font-weight: 500;
  color: rgb(64 64 64);
}

.institution-content :deep(ul),
.institution-content :deep(ol) {
  margin: 0.75rem 0;
  padding-left: 1.25rem;
  color: rgb(64 64 64);
}

.institution-content :deep(ul) {
  list-style: disc;
}

.institution-content :deep(ol) {
  list-style: decimal;
}

.institution-content :deep(img) {
  max-width: 100%;
  height: auto;
  margin: 1rem 0;
  border-radius: 1rem;
}

.institution-content :deep(iframe) {
  width: 100%;
  min-height: 320px;
  margin: 1rem 0;
  border-radius: 1rem;
}

.institution-content :deep(table) {
  width: 100%;
  border-collapse: collapse;
  margin: 1rem 0;
}

.institution-content :deep(th),
.institution-content :deep(td) {
  border: 1px solid rgb(229 229 229);
  padding: 0.75rem;
  text-align: left;
}

.institution-content :deep(th) {
  background: rgb(239 246 255);
  color: rgb(29 78 216);
  font-weight: 900;
}
</style>
