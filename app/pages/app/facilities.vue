<!-- /pages/app/facilities.vue -->
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
                @error="logoFailed = true"
              >
              <div v-else class="grid h-full w-full place-items-center rounded-2xl bg-blue-600 text-white">
                <Icon icon="solar:map-point-wave-bold-duotone" class="h-7 w-7" />
              </div>
            </div>

            <div class="min-w-0">
              <div class="mb-2 flex flex-wrap items-center gap-2">
                <span class="inline-flex items-center gap-1.5 rounded-full bg-blue-50 px-3 py-1 text-[11px] font-black uppercase tracking-[0.14em] text-blue-700">
                  <Icon icon="solar:map-point-wave-bold-duotone" class="h-3.5 w-3.5" />
                  Fasilitas Desa
                </span>

                <span class="rounded-full border border-neutral-200 bg-neutral-50 px-3 py-1 text-[11px] font-bold text-neutral-500">
                  {{ tenantSlug }}
                </span>
              </div>

              <h1 class="text-2xl font-black tracking-tight text-neutral-950 sm:text-3xl">
                Kelola Fasilitas
              </h1>

              <p class="mt-1.5 max-w-3xl text-sm font-medium leading-6 text-neutral-500">
                Kelola fasilitas publik desa dengan tampilan yang seragam, rapi, mudah dicari, dan siap tampil di halaman publik.
              </p>
            </div>
          </div>

          <div class="flex flex-wrap gap-2">
            <button
              type="button"
              class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-black text-neutral-700 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
              :disabled="isLoading"
              @click.stop="reloadFacilities"
            >
              <Icon icon="solar:refresh-bold-duotone" class="h-5 w-5" :class="isLoading ? 'animate-spin' : ''" />
              Refresh
            </button>

            <button
              type="button"
              class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700"
              @click.stop="openCreateFacilityModal"
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
              <p class="text-[11px] font-black uppercase tracking-[0.14em] text-neutral-400">Total Fasilitas</p>
              <p class="mt-2 text-2xl font-black text-neutral-950">{{ normalizedFacilities.length }}</p>
            </div>
            <div class="grid h-11 w-11 place-items-center rounded-2xl bg-blue-50 text-blue-600">
              <Icon icon="solar:map-point-wave-bold-duotone" class="h-6 w-6" />
            </div>
          </div>
        </div>

        <div class="rounded-3xl border border-neutral-200 bg-white p-4 shadow-sm">
          <div class="flex items-center justify-between gap-3">
            <div>
              <p class="text-[11px] font-black uppercase tracking-[0.14em] text-neutral-400">Tampil</p>
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
              <p class="text-[11px] font-black uppercase tracking-[0.14em] text-neutral-400">Disimpan</p>
              <p class="mt-2 text-2xl font-black text-neutral-950">{{ inactiveCount }}</p>
            </div>
            <div class="grid h-11 w-11 place-items-center rounded-2xl bg-amber-50 text-amber-600">
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
              placeholder="Cari nama, kategori, alamat, kontak, atau deskripsi..."
              class="h-12 w-full rounded-2xl border border-neutral-200 bg-neutral-50 pl-12 pr-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:bg-white focus:ring-4 focus:ring-blue-600/10"
            >
          </div>

          <div class="flex gap-2 overflow-x-auto pb-1 lg:max-w-xl">
            <button
              type="button"
              class="shrink-0 rounded-2xl px-4 py-2.5 text-xs font-black transition"
              :class="selectedType === 'all' ? 'bg-blue-600 text-white shadow-lg shadow-blue-600/20' : 'border border-neutral-200 bg-white text-neutral-600 hover:bg-neutral-50'"
              @click.stop="selectedType = 'all'"
            >
              Semua
            </button>

            <button
              v-for="type in facilityTypeOptions"
              :key="type.value"
              type="button"
              class="shrink-0 rounded-2xl px-4 py-2.5 text-xs font-black transition"
              :class="selectedType === type.value ? 'bg-blue-600 text-white shadow-lg shadow-blue-600/20' : 'border border-neutral-200 bg-white text-neutral-600 hover:bg-neutral-50'"
              @click.stop="selectedType = type.value"
            >
              {{ type.label }}
            </button>
          </div>
        </div>
      </section>

      <div class="mt-3 flex gap-2 overflow-x-auto pb-5">
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

      <section v-else-if="filteredFacilities.length === 0" class="rounded-[1.75rem] border border-dashed border-neutral-300 bg-white p-8 text-center shadow-sm">
        <div class="mx-auto grid h-14 w-14 place-items-center rounded-3xl bg-blue-50 text-blue-600">
          <Icon icon="solar:map-point-wave-bold-duotone" class="h-7 w-7" />
        </div>

        <h2 class="mt-4 text-xl font-black text-neutral-950">Belum ada fasilitas</h2>
        <p class="mx-auto mt-2 max-w-md text-sm font-medium leading-6 text-neutral-500">
          Tambahkan fasilitas agar warga dapat melihat informasi, lokasi, dan kontaknya di halaman publik.
        </p>

        <button
          type="button"
          class="mt-5 inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700"
          @click.stop="openCreateFacilityModal"
        >
          <Icon icon="lucide:plus" class="h-5 w-5" />
          Tambah Fasilitas
        </button>
      </section>

      <section v-else class="grid gap-3 sm:grid-cols-2 xl:grid-cols-3">
        <article
          v-for="item in pagedFacilities"
          :key="item.id"
          class="group relative overflow-hidden rounded-[1.75rem] border border-neutral-200 bg-white shadow-sm transition hover:-translate-y-0.5 hover:border-blue-200 hover:shadow-xl hover:shadow-blue-900/5"
        >
          <div class="relative h-44 overflow-hidden bg-neutral-100">
            <img
              v-if="getFacilityCover(item) && !failedImages[item.id]"
              :src="getFacilityCover(item)"
              :alt="facilityTitle(item)"
              class="h-full w-full object-cover transition duration-500 group-hover:scale-105"
              loading="lazy"
              @error="markImageFailed(item.id)"
            >

            <div v-else class="flex h-full w-full items-center justify-center bg-gradient-to-br from-blue-50 via-white to-sky-50 text-blue-600">
              <Icon :icon="item.icon || getFacilityTypeIcon(item.facilityType)" class="h-10 w-10" />
            </div>

            <div class="absolute inset-0 bg-gradient-to-t from-neutral-950/60 via-neutral-950/10 to-transparent"></div>

            <div class="absolute left-3 top-3 flex flex-wrap gap-2">
              <span class="inline-flex items-center gap-1.5 rounded-full bg-white/90 px-3 py-1 text-[11px] font-black text-neutral-900 shadow-sm backdrop-blur">
                <Icon :icon="item.icon || getFacilityTypeIcon(item.facilityType)" class="h-3.5 w-3.5 text-blue-600" />
                {{ facilityTypeLabel(item.facilityType) }}
              </span>

              <span class="rounded-full px-3 py-1 text-[11px] font-black shadow-sm backdrop-blur" :class="statusClass(item.status)">
                {{ statusLabel(item.status) }}
              </span>
            </div>

            <button
              type="button"
              class="absolute right-3 top-3 grid h-10 w-10 place-items-center rounded-2xl border border-white/70 bg-white/95 text-neutral-700 shadow-lg shadow-neutral-950/10 backdrop-blur transition hover:bg-neutral-950 hover:text-white"
              aria-label="Buka menu fasilitas"
              @click.stop="openEllipsisMenu(item, $event)"
            >
              <Icon icon="lucide:ellipsis" class="h-5 w-5" />
            </button>
          </div>

          <div class="p-4">
            <div class="mb-2 flex items-center justify-between gap-3">
              <p class="truncate text-[11px] font-black uppercase tracking-[0.14em] text-blue-600">
                {{ tenantSlug }}
              </p>
              <p class="shrink-0 text-[11px] font-bold text-neutral-400">{{ formatDate(item.updatedAt || item.createdAt) }}</p>
            </div>

            <h3 class="line-clamp-2 text-base font-black leading-6 text-neutral-950 group-hover:text-blue-700">
              {{ facilityTitle(item) }}
            </h3>

            <p class="mt-2 line-clamp-3 text-sm font-medium leading-6 text-neutral-500">
              {{ item.subtitle || item.shortDescription || plainText(item.contentHtml || '').slice(0, 130) || 'Informasi fasilitas belum diisi.' }}
            </p>

            <div v-if="item.address" class="mt-3 flex items-center gap-1.5 text-xs font-bold text-neutral-500">
              <Icon icon="solar:map-point-bold-duotone" class="h-4 w-4 shrink-0 text-blue-600" />
              <span class="truncate">{{ item.address }}</span>
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
          v-if="activeMenuFacility"
          class="fixed z-[9999] w-56 overflow-hidden rounded-3xl border border-neutral-200 bg-white p-2 shadow-[0_24px_90px_rgba(15,23,42,0.22)]"
          :style="{ top: `${ellipsisMenuPosition.top}px`, left: `${ellipsisMenuPosition.left}px` }"
          @click.stop
        >
          <button
            type="button"
            class="flex w-full items-center gap-3 rounded-2xl px-3 py-2.5 text-left text-sm font-black text-neutral-700 transition hover:bg-blue-50 hover:text-blue-700"
            @click="openView(activeMenuFacility)"
          >
            <Icon icon="solar:eye-bold-duotone" class="h-5 w-5 text-blue-600" />
            Lihat
          </button>

          <button
            type="button"
            class="flex w-full items-center gap-3 rounded-2xl px-3 py-2.5 text-left text-sm font-black text-neutral-700 transition disabled:cursor-not-allowed disabled:opacity-50"
            :class="activeMenuFacility.status === 'inactive'
              ? 'hover:bg-emerald-50 hover:text-emerald-700'
              : 'hover:bg-amber-50 hover:text-amber-700'"
            :disabled="isMutating"
            @click="toggleFacilityStatus(activeMenuFacility)"
          >
            <Icon
              :icon="activeMenuFacility.status === 'inactive' ? 'solar:check-circle-bold-duotone' : 'solar:archive-bold-duotone'"
              class="h-5 w-5"
              :class="activeMenuFacility.status === 'inactive' ? 'text-emerald-600' : 'text-amber-600'"
            />
            {{ activeMenuFacility.status === 'inactive' ? 'Tampilkan' : 'Simpan' }}
          </button>

          <button
            type="button"
            class="flex w-full items-center gap-3 rounded-2xl px-3 py-2.5 text-left text-sm font-black text-neutral-700 transition hover:bg-neutral-100 hover:text-neutral-950"
            @click="openEditFacilityModal(activeMenuFacility)"
          >
            <Icon icon="solar:pen-2-bold-duotone" class="h-5 w-5 text-neutral-600" />
            Edit
          </button>

          <div class="my-1 border-t border-neutral-100"></div>

          <button
            type="button"
            class="flex w-full items-center gap-3 rounded-2xl px-3 py-2.5 text-left text-sm font-black text-red-600 transition hover:bg-red-50"
            @click="openDelete(activeMenuFacility)"
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
          v-if="facilityModalOpen"
          class="fixed inset-0 z-[120] grid place-items-center bg-neutral-950/60 p-4 backdrop-blur-sm"
          role="dialog"
          aria-modal="true"
          @click.self="closeFacilityModal"
        >
          <section class="flex max-h-[92dvh] w-full max-w-5xl flex-col overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-[0_32px_110px_rgba(15,23,42,0.28)]">
            <div class="border-b border-neutral-200 bg-gradient-to-br from-blue-50 via-white to-white p-5">
              <div class="flex items-start justify-between gap-4">
                <div>
                  <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">Fasilitas Desa</p>
                  <h2 class="mt-1 text-2xl font-black tracking-tight text-neutral-950">
                    {{ editingFacility ? 'Edit Fasilitas' : 'Tambah Fasilitas' }}
                  </h2>
                  <p class="mt-1 text-sm font-semibold leading-6 text-neutral-500">
                    Form dibuat sederhana: slug dan status dibuat otomatis, draft lokal tersimpan setelah mulai mengetik.
                  </p>
                </div>

                <button
                  type="button"
                  class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl border border-neutral-200 bg-white text-neutral-500 transition hover:bg-neutral-50 hover:text-neutral-950"
                  aria-label="Tutup modal fasilitas"
                  @click="closeFacilityModal"
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
              @submit.prevent="submitFacilityForm"
              @keyup.capture="handleDraftKeyup"
              @input.capture="queueFacilityDraftSave"
              @change.capture="queueFacilityDraftSave"
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
                      <p class="mt-1 text-sm font-medium leading-6 text-neutral-500">Isi nama, kategori, dan ringkasan. Slug dibuat otomatis saat disimpan.</p>
                    </div>
                  </div>
                </div>

                <div class="grid gap-4 md:grid-cols-2">
                  <label class="block md:col-span-2">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Nama Fasilitas</span>
                    <input
                      v-model="facilityForm.title"
                      type="text"
                      class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10"
                      placeholder="Contoh: Balai Desa Martopuro"
                      required
                    >
                  </label>

                  <label class="block">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Kategori</span>
                    <select
                      v-model="facilityForm.facilityType"
                      class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10"
                    >
                      <option v-for="type in facilityTypeOptions" :key="type.value" :value="type.value">
                        {{ type.label }}
                      </option>
                    </select>
                  </label>

                  <label class="block">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Ikon</span>
                    <input
                      v-model="facilityForm.icon"
                      type="text"
                      class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10"
                      placeholder="solar:map-point-wave-bold-duotone"
                    >
                  </label>

                  <label class="block md:col-span-2">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Kalimat Pembuka</span>
                    <input
                      v-model="facilityForm.subtitle"
                      type="text"
                      class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10"
                      placeholder="Ringkasan pendek yang tampil pada kartu fasilitas"
                    >
                  </label>

                  <label class="block md:col-span-2">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Ringkasan Singkat</span>
                    <textarea
                      v-model="facilityForm.shortDescription"
                      rows="4"
                      class="w-full resize-none rounded-2xl border border-neutral-200 bg-white px-4 py-3 text-sm font-bold leading-7 text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10"
                      placeholder="Jelaskan fungsi, manfaat, dan layanan utama fasilitas ini."
                    ></textarea>
                  </label>

                  <label class="flex items-start gap-3 rounded-2xl border border-neutral-200 bg-neutral-50 p-4 md:col-span-2">
                    <input
                      v-model="facilityForm.isFeatured"
                      type="checkbox"
                      class="mt-1 h-4 w-4 rounded border-neutral-300 text-blue-600 focus:ring-blue-500"
                    >
                    <span>
                      <span class="block text-sm font-black text-neutral-800">Jadikan fasilitas unggulan</span>
                      <span class="mt-1 block text-sm font-semibold leading-6 text-neutral-500">Fasilitas unggulan dapat ditampilkan lebih menonjol pada halaman publik.</span>
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
                      <h3 class="text-base font-black text-neutral-950">Media Fasilitas</h3>
                      <p class="mt-1 text-sm font-medium leading-6 text-neutral-500">Pilih upload file ke Cloudinary atau pakai link gambar. Preview cukup gambar saja.</p>
                    </div>
                  </div>
                </div>

                <div class="grid gap-4 lg:grid-cols-2">
                  <div class="space-y-4 rounded-[1.5rem] border border-neutral-200 bg-white p-4">
                    <div>
                      <h4 class="text-sm font-black text-neutral-950">Gambar Utama</h4>
                      <p class="mt-1 text-xs font-semibold leading-5 text-neutral-500">Tampil sebagai cover utama di kartu dan halaman publik.</p>
                    </div>

                    <div class="grid gap-2 rounded-[1.5rem] border border-neutral-200 bg-white p-2 sm:grid-cols-2">
                      <button
                        type="button"
                        class="inline-flex h-12 items-center justify-center gap-2 rounded-2xl text-sm font-black transition"
                        :class="coverInputMode === 'upload' ? 'bg-blue-600 text-white shadow-lg shadow-blue-600/20' : 'bg-neutral-50 text-neutral-600 hover:bg-neutral-100'"
                        @click.stop="setImageInputMode('cover', 'upload')"
                      >
                        <Icon icon="solar:upload-square-bold-duotone" class="h-5 w-5" />
                        File
                      </button>

                      <button
                        type="button"
                        class="inline-flex h-12 items-center justify-center gap-2 rounded-2xl text-sm font-black transition"
                        :class="coverInputMode === 'link' ? 'bg-blue-600 text-white shadow-lg shadow-blue-600/20' : 'bg-neutral-50 text-neutral-600 hover:bg-neutral-100'"
                        @click.stop="setImageInputMode('cover', 'link')"
                      >
                        <Icon icon="solar:link-bold-duotone" class="h-5 w-5" />
                        Link
                      </button>
                    </div>

                    <div v-if="coverInputMode === 'upload'" class="space-y-3">
                      <input ref="coverInputRef" type="file" accept="image/jpeg,image/jpg,image/png,image/webp" class="hidden" @change="onPickImageFile($event, 'cover')">

                      <button
                        type="button"
                        class="flex w-full items-center justify-center gap-3 rounded-[1.5rem] border-2 border-dashed border-blue-200 bg-blue-50 px-4 py-8 text-center text-blue-700 transition hover:border-blue-400 hover:bg-blue-100 disabled:cursor-not-allowed disabled:opacity-60"
                        :disabled="imageUploadDisabled"
                        @click.stop="coverInputRef?.click()"
                      >
                        <Icon icon="solar:cloud-upload-bold-duotone" class="h-7 w-7 shrink-0" />
                        <span class="min-w-0 truncate text-sm font-black">{{ coverFile ? coverFile.name : 'Klik untuk pilih gambar utama' }}</span>
                      </button>
                    </div>

                    <label v-else class="block">
                      <span class="mb-2 block text-sm font-black text-neutral-800">Link Gambar Utama</span>
                      <input
                        v-model="facilityForm.imageUrl"
                        type="url"
                        class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10"
                        placeholder="https://domain.com/gambar.jpg"
                        @input="clearImageFile('cover', false)"
                      >
                    </label>

                    <div class="overflow-hidden rounded-[1.25rem] border border-neutral-200 bg-neutral-50 p-2">
                      <img v-if="coverPreview" :src="coverPreview" alt="Preview gambar utama" class="h-56 w-full rounded-2xl object-cover">
                      <div v-else class="grid h-56 place-items-center rounded-2xl bg-gradient-to-br from-blue-50 via-white to-sky-50 text-blue-600">
                        <Icon icon="solar:gallery-wide-bold-duotone" class="h-10 w-10" />
                      </div>
                    </div>
                  </div>

                  <div class="space-y-4 rounded-[1.5rem] border border-neutral-200 bg-white p-4">
                    <div>
                      <h4 class="text-sm font-black text-neutral-950">Logo Fasilitas</h4>
                      <p class="mt-1 text-xs font-semibold leading-5 text-neutral-500">Opsional untuk identitas fasilitas.</p>
                    </div>

                    <div class="grid gap-2 rounded-[1.5rem] border border-neutral-200 bg-white p-2 sm:grid-cols-2">
                      <button
                        type="button"
                        class="inline-flex h-12 items-center justify-center gap-2 rounded-2xl text-sm font-black transition"
                        :class="logoInputMode === 'upload' ? 'bg-blue-600 text-white shadow-lg shadow-blue-600/20' : 'bg-neutral-50 text-neutral-600 hover:bg-neutral-100'"
                        @click.stop="setImageInputMode('logo', 'upload')"
                      >
                        <Icon icon="solar:upload-square-bold-duotone" class="h-5 w-5" />
                        File
                      </button>

                      <button
                        type="button"
                        class="inline-flex h-12 items-center justify-center gap-2 rounded-2xl text-sm font-black transition"
                        :class="logoInputMode === 'link' ? 'bg-blue-600 text-white shadow-lg shadow-blue-600/20' : 'bg-neutral-50 text-neutral-600 hover:bg-neutral-100'"
                        @click.stop="setImageInputMode('logo', 'link')"
                      >
                        <Icon icon="solar:link-bold-duotone" class="h-5 w-5" />
                        Link
                      </button>
                    </div>

                    <div v-if="logoInputMode === 'upload'" class="space-y-3">
                      <input ref="logoInputRef" type="file" accept="image/jpeg,image/jpg,image/png,image/webp" class="hidden" @change="onPickImageFile($event, 'logo')">

                      <button
                        type="button"
                        class="flex w-full items-center justify-center gap-3 rounded-[1.5rem] border-2 border-dashed border-blue-200 bg-blue-50 px-4 py-8 text-center text-blue-700 transition hover:border-blue-400 hover:bg-blue-100 disabled:cursor-not-allowed disabled:opacity-60"
                        :disabled="imageUploadDisabled"
                        @click.stop="logoInputRef?.click()"
                      >
                        <Icon icon="solar:cloud-upload-bold-duotone" class="h-7 w-7 shrink-0" />
                        <span class="min-w-0 truncate text-sm font-black">{{ logoFile ? logoFile.name : 'Klik untuk pilih logo' }}</span>
                      </button>
                    </div>

                    <label v-else class="block">
                      <span class="mb-2 block text-sm font-black text-neutral-800">Link Logo</span>
                      <input
                        v-model="facilityForm.logoUrl"
                        type="url"
                        class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10"
                        placeholder="https://domain.com/logo.png"
                        @input="clearImageFile('logo', false)"
                      >
                    </label>

                    <div class="overflow-hidden rounded-[1.25rem] border border-neutral-200 bg-neutral-50 p-2">
                      <img v-if="logoPreview" :src="logoPreview" alt="Preview logo" class="h-56 w-full rounded-2xl object-contain bg-white p-4">
                      <div v-else class="grid h-56 place-items-center rounded-2xl bg-gradient-to-br from-blue-50 via-white to-sky-50 text-blue-600">
                        <Icon :icon="facilityForm.icon || getFacilityTypeIcon(facilityForm.facilityType)" class="h-10 w-10" />
                      </div>
                    </div>
                  </div>
                </div>

                <div v-if="isImageUploading" class="flex items-center gap-2 rounded-2xl bg-blue-50 px-4 py-3 text-xs font-black text-blue-700">
                  <Icon icon="solar:refresh-bold-duotone" class="h-4 w-4 animate-spin" />
                  Mengupload gambar ke Cloudinary...
                </div>
              </div>

              <div v-show="formStep === 3" class="space-y-4">
                <div class="rounded-[1.5rem] border border-neutral-200 bg-neutral-50 p-4">
                  <div class="flex items-start gap-3">
                    <div class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl bg-white text-blue-600 shadow-sm">
                      <Icon icon="solar:pen-new-square-bold-duotone" class="h-5 w-5" />
                    </div>
                    <div>
                      <h3 class="text-base font-black text-neutral-950">Detail, Kontak, dan Lokasi</h3>
                      <p class="mt-1 text-sm font-medium leading-6 text-neutral-500">Gunakan RichText reusable untuk deskripsi detail, lalu lengkapi alamat dan kontak.</p>
                    </div>
                  </div>
                </div>

                <div class="overflow-hidden rounded-[1.8rem] bg-white p-1">
                  <RichText
                    v-model="facilityForm.contentHtml"
                    placeholder="Tulis detail fasilitas, layanan utama, jadwal, dan informasi penting lainnya..."
                  />
                </div>

                <div class="grid gap-4 md:grid-cols-2">
                  <label class="block md:col-span-2">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Alamat</span>
                    <textarea
                      v-model="facilityForm.address"
                      rows="4"
                      class="w-full resize-none rounded-2xl border border-neutral-200 bg-white px-4 py-3 text-sm font-bold leading-7 text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10"
                      placeholder="Tuliskan alamat lengkap fasilitas"
                    ></textarea>
                  </label>

                  <label class="block">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Latitude</span>
                    <input v-model="facilityForm.latitude" type="text" class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10" placeholder="-7.600000">
                  </label>

                  <label class="block">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Longitude</span>
                    <input v-model="facilityForm.longitude" type="text" class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10" placeholder="112.700000">
                  </label>

                  <label class="block">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Telepon</span>
                    <input v-model="facilityForm.phone" type="text" class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10" placeholder="0343...">
                  </label>

                  <label class="block">
                    <span class="mb-2 block text-sm font-black text-neutral-800">WhatsApp</span>
                    <input v-model="facilityForm.whatsapp" type="text" class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10" placeholder="62812...">
                  </label>

                  <label class="block">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Email</span>
                    <input v-model="facilityForm.email" type="email" class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10" placeholder="email@domain.com">
                  </label>

                  <label class="block">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Website / Media Sosial</span>
                    <input v-model="facilityForm.websiteUrl" type="url" class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10" placeholder="https://...">
                  </label>
                </div>
              </div>
            </form>

            <div class="flex flex-col-reverse gap-2 border-t border-neutral-200 bg-white p-5 sm:flex-row sm:items-center sm:justify-between">
              <div class="text-xs font-bold text-neutral-400">
                <span v-if="editingFacility">Mode edit tidak menimpa draft lokal.</span>
                <span v-else-if="lastDraftSavedAt">Draft lokal tersimpan {{ lastDraftSavedAt }}.</span>
                <span v-else>Draft lokal akan tersimpan setelah kamu mulai mengetik.</span>
              </div>

              <div class="flex flex-col-reverse gap-2 sm:flex-row">
                <button
                  type="button"
                  class="inline-flex h-12 items-center justify-center rounded-2xl border border-neutral-200 bg-white px-5 text-sm font-black text-neutral-700 transition hover:bg-neutral-50"
                  @click="formStep === 1 ? closeFacilityModal() : prevFormStep()"
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
                  :disabled="isSubmittingFacility || isImageUploading || !canSubmit"
                  @click="submitFacilityForm"
                >
                  <Icon
                    :icon="isSubmittingFacility || isImageUploading ? 'solar:refresh-bold-duotone' : 'solar:diskette-bold-duotone'"
                    class="h-5 w-5"
                    :class="isSubmittingFacility || isImageUploading ? 'animate-spin' : ''"
                  />
                  {{ isImageUploading ? 'Upload Gambar...' : isSubmittingFacility ? 'Menyimpan...' : editingFacility ? 'Simpan Perubahan' : 'Tambah Fasilitas' }}
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
          v-if="viewModalOpen && selectedFacility"
          class="fixed inset-0 z-[130] grid place-items-center bg-neutral-950/60 p-4 backdrop-blur-sm"
          role="dialog"
          aria-modal="true"
          @click.self="closeView"
        >
          <section class="flex max-h-[92dvh] w-full max-w-4xl flex-col overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-[0_32px_110px_rgba(15,23,42,0.28)]">
            <div class="flex items-start justify-between gap-4 border-b border-neutral-200 p-5">
              <div>
                <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">Detail Fasilitas</p>
                <h2 class="mt-1 text-2xl font-black tracking-tight text-neutral-950">{{ facilityTitle(selectedFacility) }}</h2>
              </div>

              <button
                type="button"
                class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl border border-neutral-200 bg-white text-neutral-500 transition hover:bg-neutral-50 hover:text-neutral-950"
                aria-label="Tutup detail fasilitas"
                @click="closeView"
              >
                <Icon icon="lucide:x" class="h-5 w-5" />
              </button>
            </div>

            <div class="min-h-0 flex-1 overflow-y-auto p-5">
              <img
                v-if="getFacilityCover(selectedFacility)"
                :src="getFacilityCover(selectedFacility)"
                :alt="facilityTitle(selectedFacility)"
                class="mb-5 h-72 w-full rounded-[1.5rem] object-cover"
              >

              <div class="mb-5 flex flex-wrap items-center gap-2">
                <span class="inline-flex items-center gap-1.5 rounded-full bg-blue-50 px-3 py-1 text-xs font-black text-blue-700">
                  <Icon :icon="selectedFacility.icon || getFacilityTypeIcon(selectedFacility.facilityType)" class="h-4 w-4" />
                  {{ facilityTypeLabel(selectedFacility.facilityType) }}
                </span>
                <span class="rounded-full px-3 py-1 text-xs font-black" :class="statusClass(selectedFacility.status)">
                  {{ statusLabel(selectedFacility.status) }}
                </span>
                <span v-if="selectedFacility.isFeatured" class="rounded-full bg-neutral-100 px-3 py-1 text-xs font-black text-neutral-600">
                  Unggulan
                </span>
              </div>

              <p class="mb-5 rounded-2xl bg-neutral-50 p-4 text-sm font-semibold leading-7 text-neutral-600">
                {{ selectedFacility.subtitle || selectedFacility.shortDescription || 'Belum ada ringkasan.' }}
              </p>

              <div class="mb-5 grid gap-3 md:grid-cols-2">
                <div v-if="selectedFacility.address" class="rounded-2xl border border-neutral-200 bg-white p-4">
                  <p class="text-xs font-black uppercase tracking-[0.14em] text-neutral-400">Alamat</p>
                  <p class="mt-2 text-sm font-bold leading-6 text-neutral-700">{{ selectedFacility.address }}</p>
                </div>
                <div v-if="selectedFacility.phone || selectedFacility.whatsapp || selectedFacility.email" class="rounded-2xl border border-neutral-200 bg-white p-4">
                  <p class="text-xs font-black uppercase tracking-[0.14em] text-neutral-400">Kontak</p>
                  <p class="mt-2 text-sm font-bold leading-6 text-neutral-700">{{ selectedFacility.phone || selectedFacility.whatsapp || selectedFacility.email }}</p>
                </div>
              </div>

              <div class="content-view rounded-2xl border border-neutral-200 p-5" v-html="selectedFacilityContent"></div>
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
          v-if="deleteModalOpen && selectedFacility"
          class="fixed inset-0 z-[140] grid place-items-center bg-neutral-950/60 p-4 backdrop-blur-sm"
          role="dialog"
          aria-modal="true"
          @click.self="closeDelete"
        >
          <section class="w-full max-w-md rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-[0_32px_110px_rgba(15,23,42,0.28)]">
            <div class="grid h-14 w-14 place-items-center rounded-3xl bg-red-50 text-red-600">
              <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-7 w-7" />
            </div>

            <h2 class="mt-5 text-xl font-black tracking-tight text-neutral-950">Hapus Fasilitas?</h2>
            <p class="mt-2 text-sm font-medium leading-6 text-neutral-500">
              Data <strong class="text-neutral-900">{{ facilityTitle(selectedFacility) }}</strong> akan dihapus dari daftar fasilitas.
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
                :disabled="isDeleting"
                @click="confirmDelete"
              >
                <Icon
                  :icon="isDeleting ? 'solar:refresh-bold-duotone' : 'solar:trash-bin-trash-bold-duotone'"
                  class="h-5 w-5"
                  :class="isDeleting ? 'animate-spin' : ''"
                />
                {{ isDeleting ? 'Menghapus...' : 'Hapus' }}
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
import { computed, nextTick, onBeforeUnmount, onMounted, reactive, ref, watch } from 'vue'
import { useHead, useRequestURL, useRuntimeConfig, useSeoMeta } from '#imports'
import RichText from '~/components/widget/RichText.vue'
import { useCloudinaryUpload } from '~/composables/useCloudinaryUpload'

definePageMeta({
  layout: 'app',
  layoutProps: {
    title: 'Fasilitas'
  }
})

type ToastType = 'success' | 'error'
type ImageInputMode = 'upload' | 'link'
type ImageTarget = 'cover' | 'logo'
type FacilityStatus = 'active' | 'inactive'
type FacilityFilterStatus = 'all' | FacilityStatus | 'featured'

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
  slug?: string | null
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
  title: string
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
  isFeatured: boolean
}

type FacilityDraft = FacilityForm & {
  updatedAt?: string
}

const runtime = useRuntimeConfig()
const requestUrl = useRequestURL()
const { tenantApiUrl } = useAppApi()
const { uploading: cloudinaryUploading, uploadImage } = useCloudinaryUpload()

const search = ref('')
const selectedType = ref<FacilityType | 'all'>('all')
const selectedStatus = ref<FacilityFilterStatus>('all')
const sort = ref<'newest' | 'oldest' | 'name' | 'sort_order'>('sort_order')
const page = ref(1)
const pageSize = 12

const facilityModalOpen = ref(false)
const viewModalOpen = ref(false)
const deleteModalOpen = ref(false)

const formStep = ref(1)
const editingFacility = ref<FacilityItem | null>(null)
const selectedFacility = ref<FacilityItem | null>(null)
const formError = ref('')

const draftLoaded = ref(false)
const draftReady = ref(false)
const draftStarted = ref(false)
const localDraftExists = ref(false)
const lastDraftSavedAt = ref('')

const activeMenuFacility = ref<FacilityItem | null>(null)
const ellipsisMenuPosition = reactive({ top: 0, left: 0 })
const statusPatchedFacilities = ref<Record<string, FacilityItem>>({})

const coverInputMode = ref<ImageInputMode>('upload')
const logoInputMode = ref<ImageInputMode>('upload')
const coverInputRef = ref<HTMLInputElement | null>(null)
const logoInputRef = ref<HTMLInputElement | null>(null)
const coverFile = ref<File | null>(null)
const logoFile = ref<File | null>(null)
const coverLocalPreview = ref('')
const logoLocalPreview = ref('')

const logoFailed = ref(false)
const failedImages = ref<Record<string, boolean>>({})
const isSubmittingFacility = ref(false)
const isDeleting = ref(false)
let draftTimer: ReturnType<typeof setTimeout> | null = null
let toastTimer: ReturnType<typeof setTimeout> | null = null

const toast = reactive({
  show: false,
  type: 'success' as ToastType,
  title: '',
  message: ''
})

const facilityForm = reactive<FacilityForm>({
  title: '',
  subtitle: '',
  shortDescription: '',
  facilityType: 'public_service',
  icon: 'solar:map-point-wave-bold-duotone',
  logoUrl: '',
  imageUrl: '',
  contentHtml: '',
  phone: '',
  whatsapp: '',
  email: '',
  websiteUrl: '',
  address: '',
  latitude: '',
  longitude: '',
  isFeatured: false
})

const formSteps = [
  {
    value: 1,
    title: 'Informasi',
    description: 'Nama dan ringkasan',
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
    title: 'Detail',
    description: 'Konten dan kontak',
    icon: 'solar:pen-new-square-bold-duotone'
  }
]

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
  key: computed(() => `app-facilities-${tenantSlug.value}-${sort.value}`),
  query: computed(() => ({
    status: 'all',
    limit: 100,
    sort: sort.value
  })),
  watch: [tenantSlug, sort],
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

const visibleError = computed(() => {
  if (!error.value) return ''
  return error.value?.message || 'Terjadi kesalahan saat memuat data fasilitas.'
})

const isLoading = computed(() => Boolean(pending.value))
const isMutating = computed(() => Boolean(isSubmittingFacility.value || isDeleting.value))
const isImageUploading = computed(() => Boolean(cloudinaryUploading.value))
const imageUploadDisabled = computed(() => Boolean(isSubmittingFacility.value || isImageUploading.value))
const coverPreview = computed(() => coverLocalPreview.value || facilityForm.imageUrl.trim())
const logoPreview = computed(() => logoLocalPreview.value || facilityForm.logoUrl.trim())

const rawFacilities = computed<FacilityItem[]>(() => data.value?.data || [])

const normalizedFacilities = computed<FacilityItem[]>(() => {
  const baseItems = rawFacilities.value.filter((item) => item.id)
  const merged = new Map<string, FacilityItem>()

  for (const item of baseItems) {
    merged.set(item.id, item)
  }

  for (const item of Object.values(statusPatchedFacilities.value)) {
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

  return Array.from(merged.values()).sort((a, b) => sortFacilities(a, b))
})

const activeCount = computed(() => normalizedFacilities.value.filter((item) => normalizeStatus(item.status) === 'active').length)
const inactiveCount = computed(() => normalizedFacilities.value.filter((item) => normalizeStatus(item.status) === 'inactive').length)
const featuredCount = computed(() => normalizedFacilities.value.filter((item) => item.isFeatured).length)

const statusFilterOptions = computed<Array<{ value: FacilityFilterStatus; label: string; icon: string; count: number }>>(() => {
  return [
    {
      value: 'all',
      label: 'Semua',
      icon: 'solar:layers-bold-duotone',
      count: normalizedFacilities.value.length
    },
    {
      value: 'active',
      label: 'Tampil',
      icon: 'solar:check-circle-bold-duotone',
      count: activeCount.value
    },
    {
      value: 'inactive',
      label: 'Disimpan',
      icon: 'solar:archive-bold-duotone',
      count: inactiveCount.value
    },
    {
      value: 'featured',
      label: 'Unggulan',
      icon: 'solar:star-bold-duotone',
      count: featuredCount.value
    }
  ]
})

const filteredFacilities = computed(() => {
  const keyword = search.value.trim().toLowerCase()

  return normalizedFacilities.value.filter((item) => {
    const matchKeyword = !keyword || [
      item.title,
      item.name,
      item.subtitle,
      item.shortDescription,
      item.slug,
      item.facilityType,
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

    const matchType = selectedType.value === 'all' || item.facilityType === selectedType.value
    const matchStatus =
      selectedStatus.value === 'all' ||
      (selectedStatus.value === 'featured' ? Boolean(item.isFeatured) : normalizeStatus(item.status) === selectedStatus.value)

    return matchKeyword && matchType && matchStatus
  })
})

const pagedFacilities = computed(() => filteredFacilities.value.slice(0, page.value * pageSize))
const hasMore = computed(() => pagedFacilities.value.length < filteredFacilities.value.length)

const canGoNext = computed(() => {
  if (formStep.value === 1) return facilityForm.title.trim().length >= 3
  if (formStep.value === 2) return true
  return facilityForm.contentHtml.trim().length > 0
})

const canSubmit = computed(() => {
  return facilityForm.title.trim().length >= 3 && facilityForm.contentHtml.trim().length > 0
})

const facilityDraftKey = computed(() => `facility-form-draft:${tenantSlug.value}`)

const selectedFacilityContent = computed(() => {
  return sanitizeHtml(selectedFacility.value?.contentHtml || '')
})

useSeoMeta({
  title: () => `Kelola Fasilitas · ${appName.value}`,
  description: 'Kelola fasilitas publik desa dari dashboard admin.',
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

watch([search, selectedType, selectedStatus, sort], () => {
  page.value = 1
})

watch(
  facilityForm,
  () => {
    if (!draftStarted.value) return
    queueFacilityDraftSave()
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
  if (draftTimer) clearTimeout(draftTimer)
  if (toastTimer) clearTimeout(toastTimer)
  clearImageFile('cover', false)
  clearImageFile('logo', false)
  document.removeEventListener('keydown', handleEscape)
  window.removeEventListener('resize', closeEllipsisMenu)
  window.removeEventListener('scroll', closeEllipsisMenu, true)
})

async function reloadFacilities() {
  try {
    await refresh()
    showToast('success', 'Data diperbarui', 'Daftar fasilitas berhasil dimuat ulang.')
  } catch (err) {
    showToast('error', 'Gagal memuat data', getErrorMessage(err, 'Coba beberapa saat lagi.'))
  }
}

function createEmptyFacilityForm(): FacilityForm {
  return {
    title: '',
    subtitle: '',
    shortDescription: '',
    facilityType: 'public_service',
    icon: 'solar:map-point-wave-bold-duotone',
    logoUrl: '',
    imageUrl: '',
    contentHtml: '',
    phone: '',
    whatsapp: '',
    email: '',
    websiteUrl: '',
    address: '',
    latitude: '',
    longitude: '',
    isFeatured: false
  }
}

function resetFacilityForm() {
  Object.assign(facilityForm, createEmptyFacilityForm())
  clearImageFile('cover', false)
  clearImageFile('logo', false)
  coverInputMode.value = 'upload'
  logoInputMode.value = 'upload'
}

async function openCreateFacilityModal() {
  closeEllipsisMenu()
  editingFacility.value = null
  formStep.value = 1
  formError.value = ''
  draftLoaded.value = false
  draftStarted.value = false
  draftReady.value = false
  resetFacilityForm()

  const draft = readFacilityDraft()

  if (draft) {
    Object.assign(facilityForm, {
      ...createEmptyFacilityForm(),
      ...draft
    })
    draftLoaded.value = true

    if (draft.imageUrl) coverInputMode.value = 'link'
    if (draft.logoUrl) logoInputMode.value = 'link'
  }

  facilityModalOpen.value = true

  await nextTick()

  draftReady.value = true
}

async function openEditFacilityModal(item: FacilityItem) {
  closeEllipsisMenu()
  editingFacility.value = item
  formStep.value = 1
  formError.value = ''
  draftLoaded.value = false
  draftStarted.value = false
  draftReady.value = false

  Object.assign(facilityForm, {
    title: facilityTitle(item),
    subtitle: String(item.subtitle || ''),
    shortDescription: String(item.shortDescription || ''),
    facilityType: item.facilityType || 'public_service',
    icon: String(item.icon || getFacilityTypeIcon(item.facilityType)),
    logoUrl: String(item.logoUrl || ''),
    imageUrl: String(item.imageUrl || item.coverUrl || ''),
    contentHtml: String(item.contentHtml || ''),
    phone: String(item.phone || ''),
    whatsapp: String(item.whatsapp || ''),
    email: String(item.email || ''),
    websiteUrl: String(item.websiteUrl || ''),
    address: String(item.address || ''),
    latitude: item.latitude == null ? '' : String(item.latitude),
    longitude: item.longitude == null ? '' : String(item.longitude),
    isFeatured: Boolean(item.isFeatured)
  })

  clearImageFile('cover', false)
  clearImageFile('logo', false)
  coverInputMode.value = facilityForm.imageUrl ? 'link' : 'upload'
  logoInputMode.value = facilityForm.logoUrl ? 'link' : 'upload'

  facilityModalOpen.value = true

  await nextTick()

  draftReady.value = true
}

function closeFacilityModal() {
  facilityModalOpen.value = false
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

  if (formStep.value === 1 && facilityForm.title.trim().length < 3) {
    formError.value = 'Nama fasilitas minimal 3 karakter.'
    return false
  }

  if (formStep.value === 2) {
    if (coverInputMode.value === 'link' && facilityForm.imageUrl.trim() && !isValidUrl(facilityForm.imageUrl.trim())) {
      formError.value = 'Link gambar utama tidak valid.'
      return false
    }

    if (logoInputMode.value === 'link' && facilityForm.logoUrl.trim() && !isValidUrl(facilityForm.logoUrl.trim())) {
      formError.value = 'Link logo tidak valid.'
      return false
    }
  }

  if (formStep.value === 3) {
    if (!facilityForm.contentHtml.trim()) {
      formError.value = 'Detail fasilitas wajib diisi.'
      return false
    }

    if (facilityForm.email.trim() && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(facilityForm.email.trim())) {
      formError.value = 'Format email belum valid.'
      return false
    }

    if (facilityForm.websiteUrl.trim() && !isValidUrl(facilityForm.websiteUrl.trim())) {
      formError.value = 'Link website belum valid.'
      return false
    }
  }

  return true
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

async function submitFacilityForm() {
  if (!canSubmit.value || isSubmittingFacility.value) return
  if (!validateAllSteps()) return

  isSubmittingFacility.value = true
  formError.value = ''

  try {
    const media = await resolveMediaBeforeSubmit()
    const payload = createFacilityPayload(editingFacility.value?.status || 'active', media.imageUrl, media.logoUrl)

    if (editingFacility.value) {
      await $fetch<{ data: FacilityItem }>(`${apiUrl.value}/${editingFacility.value.id}`, {
        method: 'PUT',
        body: payload
      })
      showToast('success', 'Fasilitas Diupdate', 'Perubahan fasilitas berhasil disimpan.')
    } else {
      await $fetch<{ data: FacilityItem }>(apiUrl.value, {
        method: 'POST',
        body: payload
      })
      clearFacilityDraft()
      showToast('success', 'Fasilitas Ditambahkan', 'Fasilitas desa berhasil ditambahkan.')
    }

    closeFacilityModal()
    await refresh()
  } catch (err) {
    const message = getErrorMessage(err, 'Gagal menyimpan fasilitas.')
    formError.value = message
    showToast('error', 'Gagal Menyimpan', message)
  } finally {
    isSubmittingFacility.value = false
  }
}

async function resolveMediaBeforeSubmit() {
  let imageUrl = facilityForm.imageUrl.trim()
  let logoUrl = facilityForm.logoUrl.trim()

  if (coverInputMode.value === 'upload' && coverFile.value) {
    const result = await uploadImage(coverFile.value, {
      folder: `${tenantSlug.value}/facilities/covers`,
      maxWidth: 1800,
      maxHeight: 1800,
      quality: 0.84,
      maxBytes: 5 * 1024 * 1024
    })
    imageUrl = result.secure_url
    facilityForm.imageUrl = imageUrl
    clearImageFile('cover', false)
  }

  if (logoInputMode.value === 'upload' && logoFile.value) {
    const result = await uploadImage(logoFile.value, {
      folder: `${tenantSlug.value}/facilities/logos`,
      maxWidth: 1200,
      maxHeight: 1200,
      quality: 0.84,
      maxBytes: 5 * 1024 * 1024
    })
    logoUrl = result.secure_url
    facilityForm.logoUrl = logoUrl
    clearImageFile('logo', false)
  }

  if (imageUrl && !isValidUrl(imageUrl)) {
    throw new Error('Link gambar utama tidak valid.')
  }

  if (logoUrl && !isValidUrl(logoUrl)) {
    throw new Error('Link logo tidak valid.')
  }

  return {
    imageUrl,
    logoUrl
  }
}

function createFacilityPayload(status: FacilityStatus, imageUrl?: string, logoUrl?: string) {
  const title = facilityForm.title.trim()
  const slug = editingFacility.value?.slug || createFacilitySlug(title)
  const cleanImage = safeString(imageUrl || facilityForm.imageUrl)
  const cleanLogo = safeString(logoUrl || facilityForm.logoUrl)

  return {
    title,
    name: title,
    slug,
    subtitle: safeString(facilityForm.subtitle),
    shortDescription: safeString(facilityForm.shortDescription),
    facilityType: facilityForm.facilityType,
    icon: safeString(facilityForm.icon) || getFacilityTypeIcon(facilityForm.facilityType),
    logoUrl: cleanLogo,
    imageUrl: cleanImage,
    coverUrl: cleanImage,
    contentHtml: facilityForm.contentHtml,
    phone: safeString(facilityForm.phone),
    whatsapp: safeString(facilityForm.whatsapp),
    email: safeString(facilityForm.email),
    websiteUrl: safeString(facilityForm.websiteUrl),
    address: safeString(facilityForm.address),
    latitude: parseNullableNumber(facilityForm.latitude),
    longitude: parseNullableNumber(facilityForm.longitude),
    status,
    isFeatured: Boolean(facilityForm.isFeatured),
    sortOrder: Number(editingFacility.value?.sortOrder || 0),
    metadata: {
      ...(editingFacility.value?.metadata || {}),
      updatedFrom: 'app-facilities',
      images: getFacilityImages(editingFacility.value).filter(Boolean)
    }
  }
}

async function toggleFacilityStatus(item: FacilityItem) {
  if (normalizeStatus(item.status) === 'inactive') {
    await updateFacilityStatus(item, 'active')
    return
  }

  await updateFacilityStatus(item, 'inactive')
}

async function updateFacilityStatus(item: FacilityItem, status: FacilityStatus) {
  closeEllipsisMenu()

  try {
    const nextItem = patchFacilityStatus(item, status)

    await $fetch<{ data: FacilityItem }>(`${apiUrl.value}/${item.id}`, {
      method: 'PUT',
      body: createPayloadFromItem(nextItem, status)
    })

    statusPatchedFacilities.value[item.id] = nextItem

    showToast(
      'success',
      status === 'active' ? 'Fasilitas Ditampilkan' : 'Fasilitas Disimpan',
      status === 'active' ? 'Fasilitas berhasil ditampilkan kembali.' : 'Fasilitas berhasil disimpan dan disembunyikan dari publik.'
    )

    await refresh()
  } catch (err) {
    showToast('error', 'Gagal Mengubah Status', getErrorMessage(err, 'Status fasilitas gagal diubah.'))
  }
}

function patchFacilityStatus(item: FacilityItem, status: FacilityStatus): FacilityItem {
  return {
    ...item,
    status,
    updatedAt: Date.now()
  }
}

function createPayloadFromItem(item: FacilityItem, status: FacilityStatus) {
  const title = facilityTitle(item)
  const imageUrl = safeString(item.imageUrl || item.coverUrl)
  const metadata = item.metadata || {}

  return {
    title,
    name: title,
    slug: safeString(item.slug) || createFacilitySlug(title),
    subtitle: safeString(item.subtitle),
    shortDescription: safeString(item.shortDescription),
    facilityType: item.facilityType || 'public_service',
    icon: safeString(item.icon) || getFacilityTypeIcon(item.facilityType),
    logoUrl: safeString(item.logoUrl),
    imageUrl,
    coverUrl: imageUrl,
    contentHtml: safeString(item.contentHtml),
    phone: safeString(item.phone),
    whatsapp: safeString(item.whatsapp),
    email: safeString(item.email),
    websiteUrl: safeString(item.websiteUrl),
    address: safeString(item.address),
    latitude: item.latitude ?? null,
    longitude: item.longitude ?? null,
    status,
    isFeatured: Boolean(item.isFeatured),
    sortOrder: Number(item.sortOrder || 0),
    metadata: {
      ...metadata,
      images: getFacilityImages(item)
    }
  }
}

function openView(item: FacilityItem) {
  selectedFacility.value = item
  viewModalOpen.value = true
  closeEllipsisMenu()
}

function closeView() {
  viewModalOpen.value = false
  selectedFacility.value = null
}

function openDelete(item: FacilityItem) {
  selectedFacility.value = item
  deleteModalOpen.value = true
  closeEllipsisMenu()
}

function closeDelete() {
  deleteModalOpen.value = false
  selectedFacility.value = null
}

async function confirmDelete() {
  if (!selectedFacility.value || isDeleting.value) return

  isDeleting.value = true

  try {
    await $fetch<{ message: string }>(`${apiUrl.value}/${selectedFacility.value.id}`, {
      method: 'DELETE'
    })

    delete statusPatchedFacilities.value[selectedFacility.value.id]
    await refresh()
    showToast('success', 'Fasilitas Dihapus', 'Data fasilitas berhasil dihapus.')
    closeDelete()
  } catch (err) {
    showToast('error', 'Gagal Menghapus', getErrorMessage(err, 'Data fasilitas gagal dihapus.'))
  } finally {
    isDeleting.value = false
  }
}

function openEllipsisMenu(item: FacilityItem, event: MouseEvent) {
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
  activeMenuFacility.value = item
}

function closeEllipsisMenu() {
  activeMenuFacility.value = null
}

function handleDraftKeyup() {
  if (editingFacility.value) return
  draftStarted.value = true
  queueFacilityDraftSave()
}

function queueFacilityDraftSave() {
  if (editingFacility.value) return
  if (!facilityModalOpen.value || !draftReady.value || !draftStarted.value) return

  if (draftTimer) clearTimeout(draftTimer)

  draftTimer = setTimeout(() => {
    saveFacilityDraft()
  }, 250)
}

function readFacilityDraft(): FacilityDraft | null {
  if (!import.meta.client) return null

  try {
    const raw = localStorage.getItem(facilityDraftKey.value)
    if (!raw) return null
    return JSON.parse(raw) as FacilityDraft
  } catch {
    return null
  }
}

function saveFacilityDraft() {
  if (!import.meta.client) return

  const hasDraft = Boolean(
    facilityForm.title.trim() ||
    facilityForm.subtitle.trim() ||
    facilityForm.shortDescription.trim() ||
    facilityForm.imageUrl.trim() ||
    facilityForm.logoUrl.trim() ||
    facilityForm.contentHtml.trim() ||
    facilityForm.address.trim()
  )

  if (!hasDraft) {
    localStorage.removeItem(facilityDraftKey.value)
    refreshLocalDraftState()
    return
  }

  const payload: FacilityDraft = {
    ...facilityForm,
    updatedAt: new Date().toISOString()
  }

  localStorage.setItem(facilityDraftKey.value, JSON.stringify(payload))
  lastDraftSavedAt.value = formatTimeOnly(Date.now())
  refreshLocalDraftState()
}

function clearFacilityDraft() {
  if (!import.meta.client) return
  localStorage.removeItem(facilityDraftKey.value)
  draftLoaded.value = false
  localDraftExists.value = false
  lastDraftSavedAt.value = ''
}

function refreshLocalDraftState() {
  if (!import.meta.client) return
  localDraftExists.value = Boolean(localStorage.getItem(facilityDraftKey.value))
}

function setImageInputMode(target: ImageTarget, mode: ImageInputMode) {
  formError.value = ''

  if (target === 'cover') {
    coverInputMode.value = mode
    if (mode === 'link') clearImageFile('cover', false)
    return
  }

  logoInputMode.value = mode
  if (mode === 'link') clearImageFile('logo', false)
}

function onPickImageFile(event: Event, target: ImageTarget) {
  const input = event.target as HTMLInputElement
  const file = input.files?.[0] || null

  if (!file) return

  if (!isAllowedImageFile(file)) {
    input.value = ''
    return
  }

  clearImageFile(target, false)

  if (target === 'cover') {
    coverFile.value = file
    coverLocalPreview.value = URL.createObjectURL(file)
    facilityForm.imageUrl = ''
  } else {
    logoFile.value = file
    logoLocalPreview.value = URL.createObjectURL(file)
    facilityForm.logoUrl = ''
  }

  draftStarted.value = true
  queueFacilityDraftSave()
}

function clearImageFile(target: ImageTarget, resetInput = true) {
  if (target === 'cover') {
    if (coverLocalPreview.value) URL.revokeObjectURL(coverLocalPreview.value)
    coverFile.value = null
    coverLocalPreview.value = ''
    if (resetInput && coverInputRef.value) coverInputRef.value.value = ''
    return
  }

  if (logoLocalPreview.value) URL.revokeObjectURL(logoLocalPreview.value)
  logoFile.value = null
  logoLocalPreview.value = ''
  if (resetInput && logoInputRef.value) logoInputRef.value.value = ''
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

function getFacilityImages(item?: FacilityItem | null) {
  if (!item) return []

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

function facilityTitle(item: FacilityItem) {
  return safeString(item.title || item.name || 'Tanpa Judul')
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

function normalizeStatus(status?: FacilityStatus | null): FacilityStatus {
  return status === 'inactive' ? 'inactive' : 'active'
}

function statusLabel(status?: FacilityStatus | null) {
  return normalizeStatus(status) === 'active' ? 'Tampil' : 'Disimpan'
}

function statusClass(status?: FacilityStatus | null) {
  return normalizeStatus(status) === 'active'
    ? 'bg-emerald-100/90 text-emerald-800'
    : 'bg-amber-100/90 text-amber-800'
}

function sortFacilities(a: FacilityItem, b: FacilityItem) {
  if (sort.value === 'name') {
    return facilityTitle(a).localeCompare(facilityTitle(b))
  }

  if (sort.value === 'newest') {
    return toTimestamp(b.createdAt || b.updatedAt) - toTimestamp(a.createdAt || a.updatedAt)
  }

  if (sort.value === 'oldest') {
    return toTimestamp(a.createdAt || a.updatedAt) - toTimestamp(b.createdAt || b.updatedAt)
  }

  const sortA = Number(a.sortOrder || 0)
  const sortB = Number(b.sortOrder || 0)

  if (sortA !== sortB) return sortA - sortB

  return facilityTitle(a).localeCompare(facilityTitle(b))
}

function createFacilitySlug(title: string) {
  const baseSlug = slugify(title) || 'fasilitas-desa'
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

function parseNullableNumber(value: string) {
  const cleanValue = String(value || '').trim()
  if (!cleanValue) return null

  const parsed = Number(cleanValue)
  return Number.isFinite(parsed) ? parsed : null
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

function safeString(value: unknown) {
  return String(value || '').trim()
}

function getErrorMessage(error: unknown, fallback: string) {
  if (!error) return fallback

  if (typeof error === 'string') return error

  if (typeof error === 'object' && error) {
    const payload = error as Record<string, any>
    const data = typeof payload.data === 'object' && payload.data ? payload.data : {}
    return safeString(data.statusMessage || data.message || payload.statusMessage || payload.message || fallback)
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
  closeFacilityModal()
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

.content-view :deep(h1) {
  margin: 1rem 0 0.75rem;
  font-size: 1.875rem;
  line-height: 2.25rem;
  font-weight: 900;
  color: rgb(23 23 23);
}

.content-view :deep(h2) {
  margin: 1rem 0 0.75rem;
  font-size: 1.5rem;
  line-height: 2rem;
  font-weight: 900;
  color: rgb(23 23 23);
}

.content-view :deep(h3) {
  margin: 0.875rem 0 0.5rem;
  font-size: 1.25rem;
  line-height: 1.75rem;
  font-weight: 900;
  color: rgb(23 23 23);
}

.content-view :deep(p) {
  margin: 0.75rem 0;
  font-size: 0.95rem;
  line-height: 1.85;
  font-weight: 500;
  color: rgb(64 64 64);
}

.content-view :deep(ul),
.content-view :deep(ol) {
  margin: 0.75rem 0;
  padding-left: 1.25rem;
  color: rgb(64 64 64);
}

.content-view :deep(ul) {
  list-style: disc;
}

.content-view :deep(ol) {
  list-style: decimal;
}

.content-view :deep(img) {
  max-width: 100%;
  height: auto;
  margin: 1rem 0;
  border-radius: 1rem;
}

.content-view :deep(iframe) {
  width: 100%;
  min-height: 320px;
  margin: 1rem 0;
  border-radius: 1rem;
}

.content-view :deep(table) {
  width: 100%;
  border-collapse: collapse;
  margin: 1rem 0;
}

.content-view :deep(th),
.content-view :deep(td) {
  border: 1px solid rgb(229 229 229);
  padding: 0.75rem;
  text-align: left;
}

.content-view :deep(th) {
  background: rgb(239 246 255);
  color: rgb(29 78 216);
  font-weight: 900;
}
</style>
