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
                  <Icon icon="solar:users-group-rounded-bold-duotone" class="h-3.5 w-3.5" />
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
              class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-black text-neutral-700 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700 disabled:cursor-not-allowed disabled:opacity-60"
              :disabled="isLoading"
              @click.stop="reloadOrganizations"
            >
              <Icon icon="solar:refresh-bold-duotone" class="h-5 w-5" :class="isLoading ? 'animate-spin' : ''" />
              Refresh
            </button>

            <button
              type="button"
              class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700"
              @click.stop="openCreateOrganizationModal"
            >
              <Icon icon="lucide:plus" class="h-5 w-5" />
              Tambah Organisasi
            </button>
          </div>
        </div>
      </section>

      <section class="grid gap-3 sm:grid-cols-2 xl:grid-cols-4">
        <div class="rounded-3xl border border-neutral-200 bg-white p-4 shadow-sm">
          <div class="flex items-center justify-between gap-3">
            <div>
              <p class="text-[11px] font-black uppercase tracking-[0.14em] text-neutral-400">Total Organisasi</p>
              <p class="mt-2 text-2xl font-black text-neutral-950">{{ normalizedOrganizations.length }}</p>
            </div>
            <div class="grid h-11 w-11 place-items-center rounded-2xl bg-blue-50 text-blue-600">
              <Icon icon="solar:buildings-3-bold-duotone" class="h-6 w-6" />
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
            <div class="grid h-11 w-11 place-items-center rounded-2xl bg-amber-50 text-amber-600">
              <Icon icon="solar:pause-circle-bold-duotone" class="h-6 w-6" />
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
              v-for="option in typeFilterOptions"
              :key="option.value"
              type="button"
              class="inline-flex shrink-0 items-center gap-2 rounded-2xl px-4 py-2.5 text-xs font-black transition"
              :class="selectedTypeFilter === option.value ? 'bg-blue-600 text-white shadow-lg shadow-blue-600/20' : 'border border-neutral-200 bg-white text-neutral-600 hover:bg-neutral-50'"
              @click.stop="selectedTypeFilter = option.value"
            >
              <Icon :icon="option.icon" class="h-4 w-4" />
              {{ option.label }}
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
          :class="selectedStatusFilter === option.value
            ? 'bg-neutral-950 text-white shadow-lg shadow-neutral-950/15'
            : 'border border-neutral-200 bg-white text-neutral-600 hover:bg-neutral-50'"
          @click.stop="selectedStatusFilter = option.value"
        >
          <Icon :icon="option.icon" class="h-4 w-4" />
          {{ option.label }}
          <span
            class="rounded-full px-2 py-0.5 text-[10px] font-black"
            :class="selectedStatusFilter === option.value ? 'bg-white/15 text-white' : 'bg-neutral-100 text-neutral-500'"
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

      <section v-else-if="filteredOrganizations.length === 0" class="rounded-[1.75rem] border border-dashed border-neutral-300 bg-white p-8 text-center shadow-sm">
        <div class="mx-auto grid h-14 w-14 place-items-center rounded-3xl bg-blue-50 text-blue-600">
          <Icon icon="solar:users-group-rounded-bold-duotone" class="h-7 w-7" />
        </div>

        <h2 class="mt-4 text-xl font-black text-neutral-950">Belum ada organisasi</h2>
        <p class="mx-auto mt-2 max-w-md text-sm font-medium leading-6 text-neutral-500">
          {{ profile.emptyDescription }}
        </p>

        <button
          type="button"
          class="mt-5 inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700"
          @click.stop="openCreateOrganizationModal"
        >
          <Icon icon="lucide:plus" class="h-5 w-5" />
          Tambah
        </button>
      </section>

      <section v-else class="grid gap-3 sm:grid-cols-2 xl:grid-cols-3">
        <article
          v-for="item in pagedOrganizations"
          :key="item.id"
          class="group relative overflow-hidden rounded-[1.75rem] border border-neutral-200 bg-white shadow-sm transition hover:-translate-y-0.5 hover:border-blue-200 hover:shadow-xl hover:shadow-blue-900/5"
        >
          <div class="relative h-44 overflow-hidden bg-neutral-100">
            <img
              v-if="organizationCover(item) && !failedCovers[item.id]"
              :src="organizationCover(item)"
              :alt="organizationTitle(item)"
              class="h-full w-full object-cover transition duration-500 group-hover:scale-105"
              loading="lazy"
              @error="markCoverFailed(item.id)"
            >

            <div v-else class="flex h-full w-full items-center justify-center bg-gradient-to-br from-blue-50 via-white to-sky-50 text-blue-600">
              <Icon :icon="organizationIcon(item)" class="h-10 w-10" />
            </div>

            <div class="absolute inset-0 bg-gradient-to-t from-neutral-950/60 via-neutral-950/10 to-transparent"></div>

            <div class="absolute left-3 top-3 flex flex-wrap gap-2">
              <span class="inline-flex items-center gap-1.5 rounded-full bg-white/90 px-3 py-1 text-[11px] font-black text-neutral-900 shadow-sm backdrop-blur">
                <Icon :icon="organizationIcon(item)" class="h-3.5 w-3.5 text-blue-600" />
                {{ organizationTypeLabel(item.organizationType) }}
              </span>

              <span class="rounded-full px-3 py-1 text-[11px] font-black shadow-sm backdrop-blur" :class="statusClass(item.status)">
                {{ statusLabel(item.status) }}
              </span>
            </div>

            <button
              type="button"
              class="absolute right-3 top-3 grid h-10 w-10 place-items-center rounded-2xl border border-white/70 bg-white/95 text-neutral-700 shadow-lg shadow-neutral-950/10 backdrop-blur transition hover:bg-neutral-950 hover:text-white"
              aria-label="Buka menu organisasi"
              @click.stop="openEllipsisMenu(item, $event)"
            >
              <Icon icon="lucide:ellipsis" class="h-5 w-5" />
            </button>
          </div>

          <div class="p-4">
            <div class="mb-2 flex items-center justify-between gap-3">
              <p class="truncate text-[11px] font-black uppercase tracking-[0.14em] text-blue-600">
                {{ item.slug || tenantSlug }}
              </p>
              <p class="shrink-0 text-[11px] font-bold text-neutral-400">{{ item.isFeatured ? 'Unggulan' : 'Reguler' }}</p>
            </div>

            <div class="flex items-start gap-3">
              <div class="grid h-12 w-12 shrink-0 place-items-center overflow-hidden rounded-2xl border border-blue-100 bg-white p-1.5 shadow-sm">
                <img
                  v-if="item.logoUrl && !failedLogos[item.id]"
                  :src="item.logoUrl"
                  :alt="organizationTitle(item)"
                  class="h-full w-full object-contain"
                  loading="lazy"
                  @error="markLogoFailed(item.id)"
                >
                <Icon v-else :icon="organizationIcon(item)" class="h-6 w-6 text-blue-600" />
              </div>

              <div class="min-w-0 flex-1">
                <h3 class="line-clamp-2 text-base font-black leading-6 text-neutral-950 group-hover:text-blue-700">
                  {{ organizationTitle(item) }}
                </h3>

                <p class="mt-2 line-clamp-3 text-sm font-medium leading-6 text-neutral-500">
                  {{ item.shortDescription || plainDescription(item).slice(0, 130) || 'Informasi organisasi belum ditambahkan.' }}
                </p>
              </div>
            </div>
          </div>
        </article>
      </section>

      <div v-if="hasMore && !isLoading" class="flex justify-center">
        <button
          type="button"
          class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-5 text-sm font-black text-neutral-700 transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
          @click.stop="viewPage += 1"
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
          v-if="activeMenuOrganization"
          class="fixed z-[9999] w-56 overflow-hidden rounded-3xl border border-neutral-200 bg-white p-2 shadow-[0_24px_90px_rgba(15,23,42,0.22)]"
          :style="{ top: `${ellipsisMenuPosition.top}px`, left: `${ellipsisMenuPosition.left}px` }"
          @click.stop
        >
          <button
            type="button"
            class="flex w-full items-center gap-3 rounded-2xl px-3 py-2.5 text-left text-sm font-black text-neutral-700 transition hover:bg-blue-50 hover:text-blue-700"
            @click="openView(activeMenuOrganization)"
          >
            <Icon icon="solar:eye-bold-duotone" class="h-5 w-5 text-blue-600" />
            Lihat
          </button>

          <button
            type="button"
            class="flex w-full items-center gap-3 rounded-2xl px-3 py-2.5 text-left text-sm font-black text-neutral-700 transition disabled:cursor-not-allowed disabled:opacity-50"
            :class="activeMenuOrganization.status === 'inactive'
              ? 'hover:bg-emerald-50 hover:text-emerald-700'
              : 'hover:bg-amber-50 hover:text-amber-700'"
            :disabled="isMutating"
            @click="toggleOrganizationStatus(activeMenuOrganization)"
          >
            <Icon
              :icon="activeMenuOrganization.status === 'inactive' ? 'solar:check-circle-bold-duotone' : 'solar:pause-circle-bold-duotone'"
              class="h-5 w-5"
              :class="activeMenuOrganization.status === 'inactive' ? 'text-emerald-600' : 'text-amber-600'"
            />
            {{ activeMenuOrganization.status === 'inactive' ? 'Aktifkan' : 'Nonaktifkan' }}
          </button>

          <button
            type="button"
            class="flex w-full items-center gap-3 rounded-2xl px-3 py-2.5 text-left text-sm font-black text-neutral-700 transition hover:bg-neutral-100 hover:text-neutral-950"
            @click="openEditOrganizationModal(activeMenuOrganization)"
          >
            <Icon icon="solar:pen-2-bold-duotone" class="h-5 w-5 text-neutral-600" />
            Edit
          </button>

          <div class="my-1 border-t border-neutral-100"></div>

          <button
            type="button"
            class="flex w-full items-center gap-3 rounded-2xl px-3 py-2.5 text-left text-sm font-black text-red-600 transition hover:bg-red-50"
            @click="openDelete(activeMenuOrganization)"
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
          v-if="organizationModalOpen"
          class="fixed inset-0 z-[120] grid place-items-center bg-neutral-950/60 p-4 backdrop-blur-sm"
          role="dialog"
          aria-modal="true"
          @click.self="closeOrganizationModal"
        >
          <section class="flex max-h-[92dvh] w-full max-w-5xl flex-col overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-[0_32px_110px_rgba(15,23,42,0.28)]">
            <div class="border-b border-neutral-200 bg-gradient-to-br from-blue-50 via-white to-white p-5">
              <div class="flex items-start justify-between gap-4">
                <div>
                  <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">Organisasi</p>
                  <h2 class="mt-1 text-2xl font-black tracking-tight text-neutral-950">
                    {{ editingOrganization ? 'Edit Organisasi' : 'Tambah Organisasi' }}
                  </h2>
                  <p class="mt-1 text-sm font-semibold leading-6 text-neutral-500">
                    Form dibuat seragam seperti berita: slug otomatis, status default aktif, draft lokal, media upload/link, dan editor reusable.
                  </p>
                </div>

                <button
                  type="button"
                  class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl border border-neutral-200 bg-white text-neutral-500 transition hover:bg-neutral-50 hover:text-neutral-950"
                  aria-label="Tutup modal organisasi"
                  @click="closeOrganizationModal"
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
              @submit.prevent="submitOrganizationForm"
              @keyup.capture="handleDraftKeyup"
              @input.capture="queueOrganizationDraftSave"
              @change.capture="queueOrganizationDraftSave"
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
                      <Icon icon="solar:buildings-3-bold-duotone" class="h-5 w-5" />
                    </div>
                    <div>
                      <h3 class="text-base font-black text-neutral-950">Informasi Utama</h3>
                      <p class="mt-1 text-sm font-medium leading-6 text-neutral-500">Isi nama, tipe organisasi, dan ringkasan. Slug dibuat otomatis saat disimpan.</p>
                    </div>
                  </div>
                </div>

                <div class="grid gap-4 md:grid-cols-2">
                  <label class="block">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Nama Organisasi</span>
                    <input
                      v-model="organizationForm.name"
                      type="text"
                      class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10"
                      placeholder="Contoh: Karang Taruna Martopuro"
                      required
                    >
                  </label>

                  <label class="block">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Nama Tampilan</span>
                    <input
                      v-model="organizationForm.displayName"
                      type="text"
                      class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10"
                      placeholder="Nama yang tampil di website"
                    >
                  </label>

                  <label class="block">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Tipe Organisasi</span>
                    <select
                      v-model="organizationForm.organizationType"
                      class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10"
                    >
                      <option v-for="item in typeOptions" :key="item.value" :value="item.value">
                        {{ item.label }}
                      </option>
                    </select>
                  </label>

                  <label class="block">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Urutan Tampil</span>
                    <input
                      v-model.number="organizationForm.sortOrder"
                      type="number"
                      class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10"
                      placeholder="0"
                    >
                  </label>

                  <label class="block md:col-span-2">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Ringkasan Singkat</span>
                    <textarea
                      v-model="organizationForm.shortDescription"
                      rows="4"
                      class="w-full resize-none rounded-2xl border border-neutral-200 bg-white px-4 py-3 text-sm font-bold leading-7 text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10"
                      placeholder="Tulis ringkasan pendek yang mudah dipahami warga."
                    ></textarea>
                  </label>

                  <button
                    type="button"
                    class="md:col-span-2 flex items-center justify-between rounded-2xl border border-neutral-200 bg-white p-4 text-left transition hover:border-blue-200 hover:bg-blue-50"
                    @click.stop="organizationForm.isFeatured = !organizationForm.isFeatured"
                  >
                    <span>
                      <span class="block text-sm font-black text-neutral-950">Tampilkan sebagai unggulan</span>
                      <span class="block text-xs font-semibold leading-5 text-neutral-500">Data unggulan dapat ditonjolkan pada halaman publik.</span>
                    </span>
                    <span
                      class="relative h-7 w-12 rounded-full transition"
                      :class="organizationForm.isFeatured ? 'bg-blue-600' : 'bg-neutral-200'"
                    >
                      <span
                        class="absolute top-1 h-5 w-5 rounded-full bg-white shadow-sm transition"
                        :class="organizationForm.isFeatured ? 'left-6' : 'left-1'"
                      ></span>
                    </span>
                  </button>
                </div>
              </div>

              <div v-show="formStep === 2" class="space-y-4">
                <div class="rounded-[1.5rem] border border-neutral-200 bg-neutral-50 p-4">
                  <div class="flex items-start gap-3">
                    <div class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl bg-white text-blue-600 shadow-sm">
                      <Icon icon="solar:gallery-wide-bold-duotone" class="h-5 w-5" />
                    </div>
                    <div>
                      <h3 class="text-base font-black text-neutral-950">Media Organisasi</h3>
                      <p class="mt-1 text-sm font-medium leading-6 text-neutral-500">Upload ke Cloudinary atau gunakan link. Preview cukup gambar saja.</p>
                    </div>
                  </div>
                </div>

                <div class="grid gap-4 lg:grid-cols-2">
                  <section class="space-y-3 rounded-[1.5rem] border border-neutral-200 bg-white p-4">
                    <div class="flex items-center justify-between gap-3">
                      <div>
                        <h4 class="text-sm font-black text-neutral-950">Logo</h4>
                        <p class="mt-1 text-xs font-semibold text-neutral-400">Logo kecil untuk identitas organisasi.</p>
                      </div>
                      <div class="flex rounded-2xl bg-neutral-50 p-1">
                        <button type="button" class="rounded-xl px-3 py-2 text-xs font-black transition" :class="logoInputMode === 'upload' ? 'bg-blue-600 text-white' : 'text-neutral-600 hover:bg-neutral-100'" @click.stop="setLogoInputMode('upload')">File</button>
                        <button type="button" class="rounded-xl px-3 py-2 text-xs font-black transition" :class="logoInputMode === 'link' ? 'bg-blue-600 text-white' : 'text-neutral-600 hover:bg-neutral-100'" @click.stop="setLogoInputMode('link')">Link</button>
                      </div>
                    </div>

                    <input ref="logoInputRef" type="file" accept="image/jpeg,image/jpg,image/png,image/webp" class="hidden" @change="onPickLogoFile">

                    <button
                      v-if="logoInputMode === 'upload'"
                      type="button"
                      class="flex w-full items-center justify-center gap-3 rounded-[1.5rem] border-2 border-dashed border-blue-200 bg-blue-50 px-4 py-6 text-center text-blue-700 transition hover:border-blue-400 hover:bg-blue-100 disabled:cursor-not-allowed disabled:opacity-60"
                      :disabled="mediaUploadDisabled"
                      @click.stop="pickLogoFile"
                    >
                      <Icon icon="solar:cloud-upload-bold-duotone" class="h-7 w-7 shrink-0" />
                      <span class="min-w-0 truncate text-sm font-black">{{ logoFile ? logoFile.name : 'Pilih file logo' }}</span>
                    </button>

                    <input
                      v-else
                      v-model="organizationForm.logoUrl"
                      type="url"
                      class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10"
                      placeholder="https://domain.com/logo.png"
                      @input="clearLogoFile(false)"
                    >

                    <div class="overflow-hidden rounded-[1.2rem] border border-neutral-200 bg-neutral-50">
                      <img v-if="logoPreview" :src="logoPreview" alt="Preview logo" class="h-40 w-full object-contain p-5">
                      <div v-else class="grid h-40 place-items-center text-blue-600">
                        <Icon icon="solar:gallery-wide-bold-duotone" class="h-10 w-10" />
                      </div>
                    </div>
                  </section>

                  <section class="space-y-3 rounded-[1.5rem] border border-neutral-200 bg-white p-4">
                    <div class="flex items-center justify-between gap-3">
                      <div>
                        <h4 class="text-sm font-black text-neutral-950">Gambar Utama</h4>
                        <p class="mt-1 text-xs font-semibold text-neutral-400">Cover untuk kartu organisasi.</p>
                      </div>
                      <div class="flex rounded-2xl bg-neutral-50 p-1">
                        <button type="button" class="rounded-xl px-3 py-2 text-xs font-black transition" :class="coverInputMode === 'upload' ? 'bg-blue-600 text-white' : 'text-neutral-600 hover:bg-neutral-100'" @click.stop="setCoverInputMode('upload')">File</button>
                        <button type="button" class="rounded-xl px-3 py-2 text-xs font-black transition" :class="coverInputMode === 'link' ? 'bg-blue-600 text-white' : 'text-neutral-600 hover:bg-neutral-100'" @click.stop="setCoverInputMode('link')">Link</button>
                      </div>
                    </div>

                    <input ref="coverInputRef" type="file" accept="image/jpeg,image/jpg,image/png,image/webp" class="hidden" @change="onPickCoverFile">

                    <button
                      v-if="coverInputMode === 'upload'"
                      type="button"
                      class="flex w-full items-center justify-center gap-3 rounded-[1.5rem] border-2 border-dashed border-blue-200 bg-blue-50 px-4 py-6 text-center text-blue-700 transition hover:border-blue-400 hover:bg-blue-100 disabled:cursor-not-allowed disabled:opacity-60"
                      :disabled="mediaUploadDisabled"
                      @click.stop="pickCoverFile"
                    >
                      <Icon icon="solar:cloud-upload-bold-duotone" class="h-7 w-7 shrink-0" />
                      <span class="min-w-0 truncate text-sm font-black">{{ coverFile ? coverFile.name : 'Pilih gambar utama' }}</span>
                    </button>

                    <input
                      v-else
                      v-model="organizationForm.coverUrl"
                      type="url"
                      class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10"
                      placeholder="https://domain.com/cover.jpg"
                      @input="clearCoverFile(false)"
                    >

                    <div class="overflow-hidden rounded-[1.2rem] border border-neutral-200 bg-neutral-50">
                      <img v-if="coverPreview" :src="coverPreview" alt="Preview cover" class="h-40 w-full object-cover">
                      <div v-else class="grid h-40 place-items-center text-blue-600">
                        <Icon icon="solar:gallery-wide-bold-duotone" class="h-10 w-10" />
                      </div>
                    </div>
                  </section>
                </div>

                <div v-if="isMediaUploading" class="flex items-center gap-2 rounded-2xl bg-blue-50 px-4 py-3 text-xs font-black text-blue-700">
                  <Icon icon="solar:refresh-bold-duotone" class="h-4 w-4 animate-spin" />
                  Mengupload gambar...
                </div>
              </div>

              <div v-show="formStep === 3" class="space-y-4">
                <div class="rounded-[1.5rem] border border-neutral-200 bg-neutral-50 p-4">
                  <div class="flex items-start gap-3">
                    <div class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl bg-white text-blue-600 shadow-sm">
                      <Icon icon="solar:pen-new-square-bold-duotone" class="h-5 w-5" />
                    </div>
                    <div>
                      <h3 class="text-base font-black text-neutral-950">Detail & Kontak</h3>
                      <p class="mt-1 text-sm font-medium leading-6 text-neutral-500">Tulis detail organisasi dan kontak utama.</p>
                    </div>
                  </div>
                </div>

                <div class="grid gap-4 lg:grid-cols-[1fr_22rem]">
                  <div class="overflow-hidden rounded-[1.8rem] bg-white p-1">
                    <RichText v-model="organizationForm.descriptionHtml" placeholder="Tulis informasi lengkap organisasi di sini..." />
                  </div>

                  <div class="space-y-4">
                    <div class="grid gap-4 rounded-[1.5rem] border border-neutral-200 bg-white p-4">
                      <label class="block">
                        <span class="mb-2 block text-sm font-black text-neutral-800">WhatsApp</span>
                        <input v-model="organizationForm.whatsapp" type="text" class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10" placeholder="628...">
                      </label>

                      <label class="block">
                        <span class="mb-2 block text-sm font-black text-neutral-800">Email</span>
                        <input v-model="organizationForm.email" type="email" class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10" placeholder="nama@email.com">
                      </label>

                      <label class="block">
                        <span class="mb-2 block text-sm font-black text-neutral-800">Website</span>
                        <input v-model="organizationForm.websiteUrl" type="url" class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10" placeholder="https://...">
                      </label>

                      <label class="block">
                        <span class="mb-2 block text-sm font-black text-neutral-800">Alamat</span>
                        <textarea v-model="organizationForm.address" rows="4" class="w-full resize-none rounded-2xl border border-neutral-200 bg-white px-4 py-3 text-sm font-bold leading-7 text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10" placeholder="Tulis alamat organisasi..."></textarea>
                      </label>
                    </div>
                  </div>
                </div>
              </div>
            </form>

            <div class="flex flex-col-reverse gap-2 border-t border-neutral-200 bg-white p-5 sm:flex-row sm:items-center sm:justify-between">
              <div class="text-xs font-bold text-neutral-400">
                <span v-if="editingOrganization">Mode edit tidak menimpa draft lokal.</span>
                <span v-else-if="lastDraftSavedAt">Draft lokal tersimpan {{ lastDraftSavedAt }}.</span>
                <span v-else>Draft lokal akan tersimpan setelah kamu mulai mengetik.</span>
              </div>

              <div class="flex flex-col-reverse gap-2 sm:flex-row">
                <button
                  type="button"
                  class="inline-flex h-12 items-center justify-center rounded-2xl border border-neutral-200 bg-white px-5 text-sm font-black text-neutral-700 transition hover:bg-neutral-50"
                  @click="formStep === 1 ? closeOrganizationModal() : prevFormStep()"
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
                  :disabled="isSubmittingOrganization || isMediaUploading || !canSubmit"
                  @click="submitOrganizationForm"
                >
                  <Icon
                    :icon="isSubmittingOrganization || isMediaUploading ? 'solar:refresh-bold-duotone' : 'solar:diskette-bold-duotone'"
                    class="h-5 w-5"
                    :class="isSubmittingOrganization || isMediaUploading ? 'animate-spin' : ''"
                  />
                  {{ isMediaUploading ? 'Upload Gambar...' : isSubmittingOrganization ? 'Menyimpan...' : editingOrganization ? 'Simpan Perubahan' : 'Tambah Organisasi' }}
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
          v-if="viewModalOpen && selectedOrganization"
          class="fixed inset-0 z-[130] grid place-items-center bg-neutral-950/60 p-4 backdrop-blur-sm"
          role="dialog"
          aria-modal="true"
          @click.self="closeView"
        >
          <section class="flex max-h-[92dvh] w-full max-w-4xl flex-col overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-[0_32px_110px_rgba(15,23,42,0.28)]">
            <div class="flex items-start justify-between gap-4 border-b border-neutral-200 p-5">
              <div>
                <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">Detail Organisasi</p>
                <h2 class="mt-1 text-2xl font-black tracking-tight text-neutral-950">{{ organizationTitle(selectedOrganization) }}</h2>
              </div>

              <button
                type="button"
                class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl border border-neutral-200 bg-white text-neutral-500 transition hover:bg-neutral-50 hover:text-neutral-950"
                aria-label="Tutup detail organisasi"
                @click="closeView"
              >
                <Icon icon="lucide:x" class="h-5 w-5" />
              </button>
            </div>

            <div class="min-h-0 flex-1 overflow-y-auto p-5">
              <img
                v-if="organizationCover(selectedOrganization)"
                :src="organizationCover(selectedOrganization)"
                :alt="organizationTitle(selectedOrganization)"
                class="mb-5 h-72 w-full rounded-[1.5rem] object-cover"
              >

              <div class="mb-5 flex flex-wrap items-center gap-2">
                <span class="inline-flex items-center gap-2 rounded-full bg-blue-50 px-3 py-1 text-xs font-black text-blue-700">
                  <Icon :icon="organizationIcon(selectedOrganization)" class="h-4 w-4" />
                  {{ organizationTypeLabel(selectedOrganization.organizationType) }}
                </span>
                <span class="rounded-full px-3 py-1 text-xs font-black" :class="statusClass(selectedOrganization.status)">
                  {{ statusLabel(selectedOrganization.status) }}
                </span>
              </div>

              <p class="mb-5 rounded-2xl bg-neutral-50 p-4 text-sm font-semibold leading-7 text-neutral-600">
                {{ selectedOrganization.shortDescription || 'Belum ada ringkasan.' }}
              </p>

              <div class="organization-content rounded-2xl border border-neutral-200 p-5" v-html="selectedOrganizationContent"></div>
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
          v-if="deleteModalOpen && selectedOrganization"
          class="fixed inset-0 z-[140] grid place-items-center bg-neutral-950/60 p-4 backdrop-blur-sm"
          role="dialog"
          aria-modal="true"
          @click.self="closeDelete"
        >
          <section class="w-full max-w-md rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-[0_32px_110px_rgba(15,23,42,0.28)]">
            <div class="grid h-14 w-14 place-items-center rounded-3xl bg-red-50 text-red-600">
              <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-7 w-7" />
            </div>

            <h2 class="mt-5 text-xl font-black tracking-tight text-neutral-950">Hapus Organisasi?</h2>
            <p class="mt-2 text-sm font-medium leading-6 text-neutral-500">
              Data <strong class="text-neutral-900">{{ organizationTitle(selectedOrganization) }}</strong> akan dihapus dari daftar.
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
import type {
  CreateOrganizationPayload,
  OrganizationItem,
  OrganizationStatus,
  OrganizationType,
  UpdateOrganizationPayload
} from '~/types/organization'
import RichText from '~/components/widget/RichText.vue'
import { useOrganizationsSQL } from '~/composables/data/useOrganizations'
import { useCloudinaryUpload } from '~/composables/useCloudinaryUpload'

definePageMeta({
  layout: 'app',
  layoutProps: {
    title: 'Organisasi'
  }
})

type ToastType = 'success' | 'error'
type ImageInputMode = 'upload' | 'link'
type LocalStatusFilter = 'all' | OrganizationStatus | 'featured'
type LocalTypeFilter = 'all' | OrganizationType

type OrganizationDraft = OrganizationForm & {
  updatedAt?: string
}

type OrganizationForm = {
  name: string
  displayName: string
  organizationType: OrganizationType
  shortDescription: string
  descriptionHtml: string
  logoUrl: string
  coverUrl: string
  email: string
  phone: string
  whatsapp: string
  websiteUrl: string
  address: string
  instagram: string
  facebook: string
  youtube: string
  tiktok: string
  isFeatured: boolean
  sortOrder: number
}

const runtime = useRuntimeConfig()
const {
  tenantSlug,
  q: apiSearch,
  selectedType: apiSelectedType,
  selectedStatus: apiSelectedStatus,
  featuredOnly: apiFeaturedOnly,
  page: apiPage,
  limit,
  sort,
  organizations,
  pending,
  error,
  refresh,
  createOrganization,
  updateOrganization,
  deleteOrganization
} = useOrganizationsSQL()

const { uploading: cloudinaryUploading, uploadImage } = useCloudinaryUpload()

const search = ref('')
const selectedTypeFilter = ref<LocalTypeFilter>('all')
const selectedStatusFilter = ref<LocalStatusFilter>('all')
const viewPage = ref(1)
const pageSize = 12

const organizationModalOpen = ref(false)
const viewModalOpen = ref(false)
const deleteModalOpen = ref(false)

const formStep = ref(1)
const editingOrganization = ref<OrganizationItem | null>(null)
const selectedOrganization = ref<OrganizationItem | null>(null)
const formError = ref('')

const draftLoaded = ref(false)
const draftReady = ref(false)
const draftStarted = ref(false)
const localDraftExists = ref(false)
const lastDraftSavedAt = ref('')

const activeMenuOrganization = ref<OrganizationItem | null>(null)
const ellipsisMenuPosition = reactive({ top: 0, left: 0 })
const statusPatchedOrganizations = ref<Record<string, OrganizationItem>>({})

const logoInputMode = ref<ImageInputMode>('upload')
const coverInputMode = ref<ImageInputMode>('upload')
const logoInputRef = ref<HTMLInputElement | null>(null)
const coverInputRef = ref<HTMLInputElement | null>(null)
const logoFile = ref<File | null>(null)
const coverFile = ref<File | null>(null)
const logoLocalPreview = ref('')
const coverLocalPreview = ref('')

const failedCovers = ref<Record<string, boolean>>({})
const failedLogos = ref<Record<string, boolean>>({})

const isSubmittingOrganization = ref(false)
let draftTimer: ReturnType<typeof setTimeout> | null = null
let toastTimer: ReturnType<typeof setTimeout> | null = null

const toast = reactive({
  show: false,
  type: 'success' as ToastType,
  title: '',
  message: ''
})

const organizationForm = reactive<OrganizationForm>({
  name: '',
  displayName: '',
  organizationType: 'custom',
  shortDescription: '',
  descriptionHtml: '',
  logoUrl: '',
  coverUrl: '',
  email: '',
  phone: '',
  whatsapp: '',
  websiteUrl: '',
  address: '',
  instagram: '',
  facebook: '',
  youtube: '',
  tiktok: '',
  isFeatured: true,
  sortOrder: 0
})

const formSteps = [
  {
    value: 1,
    title: 'Informasi',
    description: 'Nama dan tipe',
    icon: 'solar:buildings-3-bold-duotone'
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
    description: 'Kontak dan konten',
    icon: 'solar:pen-new-square-bold-duotone'
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

const profile = computed(() => {
  return {
    name: 'Arsades',
    title: 'Kelola Organisasi',
    badge: 'Organizations',
    icon: 'solar:users-group-rounded-bold-duotone',
    description: 'Kelola profil organisasi, logo, gambar utama, kontak, status, dan konten publik dengan tampilan seragam seperti halaman berita.',
    searchPlaceholder: 'Cari organisasi, slug, kontak, atau deskripsi...',
    emptyDescription: 'Belum ada organisasi. Mulai tambahkan organisasi pertama agar tampil pada halaman publik.',
    publicBase: '/organizations'
  }
})

const appLogo = computed(() => {
  return String(
    runtime.public.appLogo ||
    runtime.public.logoUrl ||
    runtime.public.siteLogo ||
    runtime.public.favicon ||
    ''
  ).trim()
})

const isLoading = computed(() => Boolean(unref(pending)))
const isMutating = computed(() => Boolean(isSubmittingOrganization.value || unref(cloudinaryUploading)))
const isMediaUploading = computed(() => Boolean(unref(cloudinaryUploading)))
const mediaUploadDisabled = computed(() => Boolean(isSubmittingOrganization.value || isMediaUploading.value))

const logoPreview = computed(() => logoLocalPreview.value || organizationForm.logoUrl.trim())
const coverPreview = computed(() => coverLocalPreview.value || organizationForm.coverUrl.trim())

const visibleError = computed(() => {
  const value = unref(error)
  if (!value) return ''
  return getErrorMessage(value, 'Data organisasi belum berhasil dimuat.')
})

const normalizedOrganizations = computed<OrganizationItem[]>(() => {
  const baseItems = Array.isArray(unref(organizations)) ? [...unref(organizations)] : []
  const merged = new Map<string, OrganizationItem>()

  for (const item of baseItems) {
    if (item?.id) merged.set(String(item.id), item)
  }

  for (const item of Object.values(statusPatchedOrganizations.value)) {
    if (!item?.id) continue
    const existing = merged.get(String(item.id))
    merged.set(String(item.id), {
      ...(existing || {}),
      ...item,
      metadata: {
        ...(existing?.metadata || {}),
        ...(item.metadata || {})
      }
    } as OrganizationItem)
  }

  return Array.from(merged.values()).sort((a, b) => {
    const sortA = Number(a.sortOrder || 0)
    const sortB = Number(b.sortOrder || 0)
    if (sortA !== sortB) return sortA - sortB
    return organizationTitle(a).localeCompare(organizationTitle(b))
  })
})

const activeCount = computed(() => normalizedOrganizations.value.filter((item) => item.status === 'active').length)
const inactiveCount = computed(() => normalizedOrganizations.value.filter((item) => item.status === 'inactive').length)
const featuredCount = computed(() => normalizedOrganizations.value.filter((item) => Boolean(item.isFeatured)).length)

const typeFilterOptions = computed<Array<{ value: LocalTypeFilter; label: string; icon: string }>>(() => [
  { value: 'all', label: 'Semua', icon: 'solar:layers-bold-duotone' },
  ...typeOptions
])

const statusFilterOptions = computed<Array<{ value: LocalStatusFilter; label: string; icon: string; count: number }>>(() => [
  { value: 'all', label: 'Semua', icon: 'solar:layers-bold-duotone', count: normalizedOrganizations.value.length },
  { value: 'active', label: 'Aktif', icon: 'solar:check-circle-bold-duotone', count: activeCount.value },
  { value: 'inactive', label: 'Nonaktif', icon: 'solar:pause-circle-bold-duotone', count: inactiveCount.value },
  { value: 'featured', label: 'Unggulan', icon: 'solar:star-bold-duotone', count: featuredCount.value }
])

const filteredOrganizations = computed(() => {
  const keyword = search.value.trim().toLowerCase()

  return normalizedOrganizations.value.filter((item) => {
    const matchKeyword = !keyword || [
      item.name,
      item.displayName,
      item.slug,
      item.shortDescription,
      item.description,
      item.email,
      item.phone,
      item.whatsapp,
      item.websiteUrl,
      item.address,
      organizationTypeLabel(item.organizationType)
    ]
      .filter(Boolean)
      .join(' ')
      .toLowerCase()
      .includes(keyword)

    const matchType = selectedTypeFilter.value === 'all' || item.organizationType === selectedTypeFilter.value
    const matchStatus = (selectedStatusFilter.value === 'all' || selectedStatusFilter.value === 'featured')
      ? selectedStatusFilter.value === 'all' || Boolean(item.isFeatured)
      : item.status === selectedStatusFilter.value

    return matchKeyword && matchType && matchStatus
  })
})

const pagedOrganizations = computed(() => filteredOrganizations.value.slice(0, viewPage.value * pageSize))
const hasMore = computed(() => pagedOrganizations.value.length < filteredOrganizations.value.length)

const canGoNext = computed(() => {
  if (formStep.value === 1) return organizationForm.name.trim().length >= 2
  if (formStep.value === 2) return true
  return true
})

const canSubmit = computed(() => organizationForm.name.trim().length >= 2)
const organizationDraftKey = computed(() => `organizations-form-draft:${tenantSlug.value}`)

const selectedOrganizationContent = computed(() => {
  if (!selectedOrganization.value) return ''
  return sanitizeHtml(descriptionHtmlFromItem(selectedOrganization.value))
})

useSeoMeta({
  title: () => `${profile.value.title} · ${tenantSlug.value}`,
  description: () => profile.value.description,
  ogTitle: () => `${profile.value.title} · ${tenantSlug.value}`,
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

watch([search, selectedTypeFilter, selectedStatusFilter], () => {
  viewPage.value = 1
})

watch(
  organizationForm,
  () => {
    if (!draftStarted.value) return
    queueOrganizationDraftSave()
  },
  { deep: true }
)

onMounted(async () => {
  prepareApiFilters()
  refreshLocalDraftState()
  await reloadOrganizations(true)
  document.addEventListener('keydown', handleEscape)
  window.addEventListener('resize', closeEllipsisMenu)
  window.addEventListener('scroll', closeEllipsisMenu, true)
})

onBeforeUnmount(() => {
  if (draftTimer) clearTimeout(draftTimer)
  if (toastTimer) clearTimeout(toastTimer)
  clearLogoFile(false)
  clearCoverFile(false)
  document.removeEventListener('keydown', handleEscape)
  window.removeEventListener('resize', closeEllipsisMenu)
  window.removeEventListener('scroll', closeEllipsisMenu, true)
})

function prepareApiFilters() {
  apiSearch.value = ''
  apiSelectedType.value = 'all'
  apiSelectedStatus.value = 'all'
  apiFeaturedOnly.value = false
  apiPage.value = 1
  limit.value = 120
  sort.value = 'sort_order'
}

async function reloadOrganizations(silent = false) {
  try {
    prepareApiFilters()
    await refresh()
    if (!silent) showToast('success', 'Data Diperbarui', 'Daftar organisasi berhasil dimuat ulang.')
  } catch (error) {
    if (!silent) showToast('error', 'Gagal Memuat Data', getErrorMessage(error, 'Data organisasi belum berhasil dimuat.'))
  }
}

function createEmptyOrganizationForm(): OrganizationForm {
  return {
    name: '',
    displayName: '',
    organizationType: 'custom',
    shortDescription: '',
    descriptionHtml: '',
    logoUrl: '',
    coverUrl: '',
    email: '',
    phone: '',
    whatsapp: '',
    websiteUrl: '',
    address: '',
    instagram: '',
    facebook: '',
    youtube: '',
    tiktok: '',
    isFeatured: true,
    sortOrder: 0
  }
}

function resetOrganizationForm() {
  Object.assign(organizationForm, createEmptyOrganizationForm())
  clearLogoFile(false)
  clearCoverFile(false)
  logoInputMode.value = 'upload'
  coverInputMode.value = 'upload'
}

async function openCreateOrganizationModal() {
  closeEllipsisMenu()
  editingOrganization.value = null
  formStep.value = 1
  formError.value = ''
  draftLoaded.value = false
  draftStarted.value = false
  draftReady.value = false
  resetOrganizationForm()

  const draft = readOrganizationDraft()

  if (draft) {
    Object.assign(organizationForm, {
      ...createEmptyOrganizationForm(),
      ...draft
    })
    draftLoaded.value = true
    if (draft.logoUrl) logoInputMode.value = 'link'
    if (draft.coverUrl) coverInputMode.value = 'link'
  }

  organizationModalOpen.value = true
  await nextTick()
  draftReady.value = true
}

async function openEditOrganizationModal(item: OrganizationItem) {
  closeEllipsisMenu()
  editingOrganization.value = item
  formStep.value = 1
  formError.value = ''
  draftLoaded.value = false
  draftStarted.value = false
  draftReady.value = false

  Object.assign(organizationForm, {
    name: item.name || '',
    displayName: item.displayName || item.name || '',
    organizationType: item.organizationType || 'custom',
    shortDescription: item.shortDescription || '',
    descriptionHtml: descriptionHtmlFromItem(item),
    logoUrl: item.logoUrl || '',
    coverUrl: organizationCover(item) || '',
    email: item.email || item.contact?.email || '',
    phone: item.phone || item.contact?.phone || '',
    whatsapp: item.whatsapp || item.contact?.whatsapp || '',
    websiteUrl: item.websiteUrl || '',
    address: item.address || '',
    instagram: safeString(item.social?.instagram || item.metadata?.instagram),
    facebook: safeString(item.social?.facebook || item.metadata?.facebook),
    youtube: safeString(item.social?.youtube || item.metadata?.youtube),
    tiktok: safeString(item.social?.tiktok || item.metadata?.tiktok),
    isFeatured: Boolean(item.isFeatured),
    sortOrder: Number(item.sortOrder || 0)
  })

  clearLogoFile(false)
  clearCoverFile(false)
  logoInputMode.value = item.logoUrl ? 'link' : 'upload'
  coverInputMode.value = organizationCover(item) ? 'link' : 'upload'

  organizationModalOpen.value = true
  await nextTick()
  draftReady.value = true
}

function closeOrganizationModal() {
  organizationModalOpen.value = false
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

  if (formStep.value === 1 && organizationForm.name.trim().length < 2) {
    formError.value = 'Nama organisasi minimal 2 karakter.'
    return false
  }

  if (formStep.value === 2) {
    if (logoInputMode.value === 'link' && organizationForm.logoUrl.trim() && !isValidUrl(organizationForm.logoUrl.trim())) {
      formError.value = 'Link logo belum valid.'
      return false
    }

    if (coverInputMode.value === 'link' && organizationForm.coverUrl.trim() && !isValidUrl(organizationForm.coverUrl.trim())) {
      formError.value = 'Link gambar utama belum valid.'
      return false
    }
  }

  if (formStep.value === 3) {
    if (organizationForm.email.trim() && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(organizationForm.email.trim())) {
      formError.value = 'Format email belum valid.'
      return false
    }

    if (organizationForm.websiteUrl.trim() && !isValidUrl(organizationForm.websiteUrl.trim())) {
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

async function submitOrganizationForm() {
  if (!canSubmit.value || isSubmittingOrganization.value) return
  if (!validateAllSteps()) return

  isSubmittingOrganization.value = true
  formError.value = ''

  try {
    const media = await resolveMediaBeforeSubmit()
    const payload = createOrganizationPayload(editingOrganization.value?.status || 'active', media.logoUrl, media.coverUrl)

    if (editingOrganization.value) {
      await updateOrganization(editingOrganization.value.id, payload as UpdateOrganizationPayload)
      showToast('success', 'Organisasi Diupdate', 'Perubahan organisasi berhasil disimpan.')
    } else {
      await createOrganization(payload as CreateOrganizationPayload)
      clearOrganizationDraft()
      showToast('success', 'Organisasi Ditambahkan', 'Data organisasi berhasil ditambahkan.')
    }

    closeOrganizationModal()
    await reloadOrganizations(true)
  } catch (error) {
    const message = getErrorMessage(error, 'Data organisasi belum berhasil disimpan.')
    formError.value = message
    showToast('error', 'Gagal Menyimpan', message)
  } finally {
    isSubmittingOrganization.value = false
  }
}

async function resolveMediaBeforeSubmit() {
  let logoUrl = organizationForm.logoUrl.trim()
  let coverUrl = organizationForm.coverUrl.trim()

  if (logoInputMode.value === 'upload' && logoFile.value) {
    logoUrl = await uploadFileImage(logoFile.value, `${tenantSlug.value}/organizations/logo`)
    organizationForm.logoUrl = logoUrl
    clearLogoFile(false)
  }

  if (coverInputMode.value === 'upload' && coverFile.value) {
    coverUrl = await uploadFileImage(coverFile.value, `${tenantSlug.value}/organizations/cover`)
    organizationForm.coverUrl = coverUrl
    clearCoverFile(false)
  }

  if (logoUrl && !isValidUrl(logoUrl)) throw new Error('Link logo belum valid.')
  if (coverUrl && !isValidUrl(coverUrl)) throw new Error('Link gambar utama belum valid.')

  return { logoUrl, coverUrl }
}

async function uploadFileImage(file: File, folder: string) {
  const result = await uploadImage(file, {
    folder,
    maxWidth: 1800,
    maxHeight: 1800,
    quality: 0.82,
    maxBytes: 5 * 1024 * 1024
  })

  return safeString((result as any).secure_url || (result as any).url)
}

function createOrganizationPayload(status: OrganizationStatus, logoUrl?: string, coverUrl?: string) {
  const cleanName = organizationForm.name.trim()
  const displayName = organizationForm.displayName.trim() || cleanName
  const cleanSlug = editingOrganization.value?.slug || createOrganizationSlug(cleanName)
  const descriptionHtml = organizationForm.descriptionHtml.trim() || '<p></p>'
  const previousMetadata = editingOrganization.value?.metadata || {}
  const icon = organizationIconFromType(organizationForm.organizationType)
  const images = Array.from(new Set([coverUrl, ...(Array.isArray(previousMetadata.images) ? previousMetadata.images : [])].map((item) => safeString(item)).filter(Boolean)))

  return {
    organizationType: organizationForm.organizationType,
    name: cleanName,
    displayName,
    slug: cleanSlug,
    shortDescription: organizationForm.shortDescription.trim(),
    description: descriptionHtml,
    logoUrl: safeString(logoUrl) || null,
    coverUrl: safeString(coverUrl) || null,
    email: organizationForm.email.trim() || null,
    phone: organizationForm.phone.trim() || null,
    whatsapp: organizationForm.whatsapp.trim() || null,
    websiteUrl: organizationForm.websiteUrl.trim() || null,
    address: organizationForm.address.trim() || null,
    contact: {
      email: organizationForm.email.trim() || null,
      phone: organizationForm.phone.trim() || null,
      whatsapp: organizationForm.whatsapp.trim() || null
    },
    social: {
      instagram: normalizeOptional(organizationForm.instagram),
      facebook: normalizeOptional(organizationForm.facebook),
      youtube: normalizeOptional(organizationForm.youtube),
      tiktok: normalizeOptional(organizationForm.tiktok)
    },
    metadata: {
      ...previousMetadata,
      icon,
      images,
      descriptionHtml,
      instagram: normalizeOptional(organizationForm.instagram),
      facebook: normalizeOptional(organizationForm.facebook),
      youtube: normalizeOptional(organizationForm.youtube),
      tiktok: normalizeOptional(organizationForm.tiktok),
      updatedFrom: 'app-organizations-news-style'
    },
    status,
    isFeatured: Boolean(organizationForm.isFeatured),
    sortOrder: Number(organizationForm.sortOrder || 0)
  }
}

async function toggleOrganizationStatus(item: OrganizationItem) {
  if (item.status === 'inactive') {
    await activateOrganization(item)
    return
  }

  await deactivateOrganization(item)
}

async function deactivateOrganization(item: OrganizationItem) {
  closeEllipsisMenu()

  try {
    const nextItem = patchOrganizationStatus(item, 'inactive')
    await updateOrganization(item.id, createPayloadFromItem(nextItem, 'inactive') as UpdateOrganizationPayload)
    statusPatchedOrganizations.value[item.id] = nextItem
    showToast('success', 'Organisasi Dinonaktifkan', 'Status organisasi berhasil diubah menjadi nonaktif.')
    await reloadOrganizations(true)
  } catch (error) {
    showToast('error', 'Gagal Menonaktifkan', getErrorMessage(error, 'Organisasi gagal dinonaktifkan.'))
  }
}

async function activateOrganization(item: OrganizationItem) {
  closeEllipsisMenu()

  try {
    const nextItem = patchOrganizationStatus(item, 'active')
    await updateOrganization(item.id, createPayloadFromItem(nextItem, 'active') as UpdateOrganizationPayload)
    statusPatchedOrganizations.value[item.id] = nextItem
    showToast('success', 'Organisasi Diaktifkan', 'Organisasi berhasil diaktifkan kembali.')
    await reloadOrganizations(true)
  } catch (error) {
    showToast('error', 'Gagal Mengaktifkan', getErrorMessage(error, 'Organisasi gagal diaktifkan.'))
  }
}

function patchOrganizationStatus(item: OrganizationItem, status: OrganizationStatus): OrganizationItem {
  return {
    ...item,
    status,
    metadata: {
      ...(item.metadata || {}),
      statusPatchedAt: new Date().toISOString()
    }
  }
}

function createPayloadFromItem(item: OrganizationItem, status: OrganizationStatus) {
  const metadata = item.metadata || {}
  const descriptionHtml = descriptionHtmlFromItem(item)
  const coverUrl = organizationCover(item)
  const icon = safeString(metadata.icon) || organizationIconFromType(item.organizationType || 'custom')
  const images = getOrganizationImages(item)

  return {
    organizationType: item.organizationType || 'custom',
    name: item.name || organizationTitle(item),
    displayName: item.displayName || item.name || organizationTitle(item),
    slug: item.slug || createOrganizationSlug(item.name || organizationTitle(item)),
    shortDescription: item.shortDescription || plainDescription(item).slice(0, 180),
    description: descriptionHtml,
    logoUrl: item.logoUrl || null,
    coverUrl: coverUrl || null,
    email: item.email || item.contact?.email || null,
    phone: item.phone || item.contact?.phone || null,
    whatsapp: item.whatsapp || item.contact?.whatsapp || null,
    websiteUrl: item.websiteUrl || null,
    address: item.address || null,
    contact: {
      email: item.email || item.contact?.email || null,
      phone: item.phone || item.contact?.phone || null,
      whatsapp: item.whatsapp || item.contact?.whatsapp || null
    },
    social: {
      instagram: normalizeOptional(safeString(item.social?.instagram || metadata.instagram)),
      facebook: normalizeOptional(safeString(item.social?.facebook || metadata.facebook)),
      youtube: normalizeOptional(safeString(item.social?.youtube || metadata.youtube)),
      tiktok: normalizeOptional(safeString(item.social?.tiktok || metadata.tiktok))
    },
    metadata: {
      ...metadata,
      icon,
      images,
      descriptionHtml,
      updatedFrom: 'app-organizations-news-style'
    },
    status,
    isFeatured: Boolean(item.isFeatured),
    sortOrder: Number(item.sortOrder || 0)
  }
}

function openView(item: OrganizationItem) {
  selectedOrganization.value = item
  viewModalOpen.value = true
  closeEllipsisMenu()
}

function closeView() {
  viewModalOpen.value = false
  selectedOrganization.value = null
}

function openDelete(item: OrganizationItem) {
  selectedOrganization.value = item
  deleteModalOpen.value = true
  closeEllipsisMenu()
}

function closeDelete() {
  deleteModalOpen.value = false
  selectedOrganization.value = null
}

async function confirmDelete() {
  if (!selectedOrganization.value || isMutating.value) return

  try {
    await deleteOrganization(selectedOrganization.value.id)
    delete statusPatchedOrganizations.value[selectedOrganization.value.id]
    showToast('success', 'Organisasi Dihapus', 'Data organisasi berhasil dihapus.')
    closeDelete()
    await reloadOrganizations(true)
  } catch (error) {
    showToast('error', 'Gagal Menghapus', getErrorMessage(error, 'Data organisasi gagal dihapus.'))
  }
}

function openEllipsisMenu(item: OrganizationItem, event: MouseEvent) {
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
  activeMenuOrganization.value = item
}

function closeEllipsisMenu() {
  activeMenuOrganization.value = null
}

function handleDraftKeyup() {
  if (editingOrganization.value) return
  draftStarted.value = true
  queueOrganizationDraftSave()
}

function queueOrganizationDraftSave() {
  if (editingOrganization.value) return
  if (!organizationModalOpen.value || !draftReady.value || !draftStarted.value) return

  if (draftTimer) clearTimeout(draftTimer)

  draftTimer = setTimeout(() => {
    saveOrganizationDraft()
  }, 250)
}

function readOrganizationDraft(): OrganizationDraft | null {
  if (!import.meta.client) return null

  try {
    const raw = localStorage.getItem(organizationDraftKey.value)
    if (!raw) return null
    return JSON.parse(raw) as OrganizationDraft
  } catch {
    return null
  }
}

function saveOrganizationDraft() {
  if (!import.meta.client) return

  const hasDraft = Boolean(
    organizationForm.name.trim() ||
    organizationForm.displayName.trim() ||
    organizationForm.shortDescription.trim() ||
    organizationForm.descriptionHtml.trim() ||
    organizationForm.logoUrl.trim() ||
    organizationForm.coverUrl.trim() ||
    organizationForm.email.trim() ||
    organizationForm.phone.trim() ||
    organizationForm.whatsapp.trim() ||
    organizationForm.address.trim()
  )

  if (!hasDraft) {
    localStorage.removeItem(organizationDraftKey.value)
    refreshLocalDraftState()
    return
  }

  const payload: OrganizationDraft = {
    ...organizationForm,
    updatedAt: new Date().toISOString()
  }

  localStorage.setItem(organizationDraftKey.value, JSON.stringify(payload))
  lastDraftSavedAt.value = formatTimeOnly(Date.now())
  refreshLocalDraftState()
}

function clearOrganizationDraft() {
  if (!import.meta.client) return
  localStorage.removeItem(organizationDraftKey.value)
  draftLoaded.value = false
  localDraftExists.value = false
  lastDraftSavedAt.value = ''
}

function refreshLocalDraftState() {
  if (!import.meta.client) return
  localDraftExists.value = Boolean(localStorage.getItem(organizationDraftKey.value))
}

function setLogoInputMode(mode: ImageInputMode) {
  logoInputMode.value = mode
  formError.value = ''
  if (mode === 'link') clearLogoFile(false)
}

function setCoverInputMode(mode: ImageInputMode) {
  coverInputMode.value = mode
  formError.value = ''
  if (mode === 'link') clearCoverFile(false)
}

function pickLogoFile() {
  if (mediaUploadDisabled.value) return
  logoInputRef.value?.click()
}

function pickCoverFile() {
  if (mediaUploadDisabled.value) return
  coverInputRef.value?.click()
}

function onPickLogoFile(event: Event) {
  const input = event.target as HTMLInputElement
  const file = input.files?.[0] || null
  if (!file) return
  if (!isAllowedImageFile(file)) {
    if (logoInputRef.value) logoInputRef.value.value = ''
    return
  }

  clearLogoFile(false)
  logoFile.value = file
  logoLocalPreview.value = URL.createObjectURL(file)
  organizationForm.logoUrl = ''
  draftStarted.value = true
  queueOrganizationDraftSave()
}

function onPickCoverFile(event: Event) {
  const input = event.target as HTMLInputElement
  const file = input.files?.[0] || null
  if (!file) return
  if (!isAllowedImageFile(file)) {
    if (coverInputRef.value) coverInputRef.value.value = ''
    return
  }

  clearCoverFile(false)
  coverFile.value = file
  coverLocalPreview.value = URL.createObjectURL(file)
  organizationForm.coverUrl = ''
  draftStarted.value = true
  queueOrganizationDraftSave()
}

function clearLogoFile(resetInput = true) {
  if (logoLocalPreview.value) URL.revokeObjectURL(logoLocalPreview.value)
  logoFile.value = null
  logoLocalPreview.value = ''
  if (resetInput && logoInputRef.value) logoInputRef.value.value = ''
}

function clearCoverFile(resetInput = true) {
  if (coverLocalPreview.value) URL.revokeObjectURL(coverLocalPreview.value)
  coverFile.value = null
  coverLocalPreview.value = ''
  if (resetInput && coverInputRef.value) coverInputRef.value.value = ''
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

function organizationTitle(item: OrganizationItem) {
  return safeString(item.displayName || item.name || 'Tanpa Nama')
}

function organizationCover(item: OrganizationItem) {
  return safeString(item.coverUrl || getOrganizationImages(item)[0] || item.logoUrl)
}

function organizationIcon(item: OrganizationItem) {
  return safeString(item.metadata?.icon) || organizationIconFromType(item.organizationType || 'custom')
}

function organizationIconFromType(type: OrganizationType) {
  return typeOptions.find((item) => item.value === type)?.icon || 'solar:widget-5-bold-duotone'
}

function organizationTypeLabel(type: OrganizationType) {
  return typeOptions.find((item) => item.value === type)?.label || 'Organisasi'
}

function statusLabel(status: OrganizationStatus) {
  if (status === 'inactive') return 'Nonaktif'
  return 'Aktif'
}

function statusClass(status: OrganizationStatus) {
  if (status === 'inactive') return 'bg-amber-100/90 text-amber-800'
  return 'bg-emerald-100/90 text-emerald-800'
}

function primaryContact(item: OrganizationItem) {
  return safeString(item.whatsapp || item.contact?.whatsapp || item.phone || item.contact?.phone || item.email || item.contact?.email)
}

function getOrganizationImages(item: OrganizationItem) {
  const metadataImages = Array.isArray(item.metadata?.images) ? item.metadata.images : []
  return Array.from(new Set([item.coverUrl, ...metadataImages].map((value) => safeString(value)).filter(Boolean)))
}

function descriptionHtmlFromItem(item: OrganizationItem) {
  return sanitizeHtml(safeString(item.metadata?.descriptionHtml || item.description || '<p></p>'))
}

function plainDescription(item: OrganizationItem) {
  return stripHtml(descriptionHtmlFromItem(item))
}

function createOrganizationSlug(title: string) {
  const baseSlug = slugify(title) || 'organisasi'
  return editingOrganization.value?.slug || `${baseSlug}-${createTimestampUuid()}`
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

function markCoverFailed(id: string) {
  failedCovers.value = {
    ...failedCovers.value,
    [id]: true
  }
}

function markLogoFailed(id: string) {
  failedLogos.value = {
    ...failedLogos.value,
    [id]: true
  }
}

function formatTimeOnly(value: number) {
  return new Intl.DateTimeFormat('id-ID', {
    hour: '2-digit',
    minute: '2-digit'
  }).format(new Date(value))
}

function normalizeOptional(value: string) {
  return safeString(value) || null
}

function isValidUrl(value: string) {
  try {
    const url = new URL(value)
    return ['http:', 'https:'].includes(url.protocol)
  } catch {
    return false
  }
}

function stripHtml(value: string) {
  return safeString(value)
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
  return safeString(value)
    .replace(/<script[\s\S]*?>[\s\S]*?<\/script>/gi, '')
    .replace(/<style[\s\S]*?>[\s\S]*?<\/style>/gi, '')
    .replace(/\son\w+="[^"]*"/gi, '')
    .replace(/\son\w+='[^']*'/gi, '')
    .replace(/javascript:/gi, '')
}

function safeString(value: unknown) {
  return String(value || '').trim()
}

function getErrorMessage(error: unknown, fallback: string) {
  if (!error) return fallback
  if (typeof error === 'string') return error

  if (typeof error === 'object' && error !== null) {
    const record = error as Record<string, any>
    const data = record.data && typeof record.data === 'object' ? record.data : {}
    return safeString(data.statusMessage || data.message || record.statusMessage || record.message || fallback)
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
  closeOrganizationModal()
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

.organization-content :deep(h1) {
  margin: 1rem 0 0.75rem;
  font-size: 1.875rem;
  line-height: 2.25rem;
  font-weight: 900;
  color: rgb(23 23 23);
}

.organization-content :deep(h2) {
  margin: 1rem 0 0.75rem;
  font-size: 1.5rem;
  line-height: 2rem;
  font-weight: 900;
  color: rgb(23 23 23);
}

.organization-content :deep(h3) {
  margin: 0.875rem 0 0.5rem;
  font-size: 1.25rem;
  line-height: 1.75rem;
  font-weight: 900;
  color: rgb(23 23 23);
}

.organization-content :deep(p) {
  margin: 0.75rem 0;
  font-size: 0.95rem;
  line-height: 1.85;
  font-weight: 500;
  color: rgb(64 64 64);
}

.organization-content :deep(ul),
.organization-content :deep(ol) {
  margin: 0.75rem 0;
  padding-left: 1.25rem;
  color: rgb(64 64 64);
}

.organization-content :deep(ul) {
  list-style: disc;
}

.organization-content :deep(ol) {
  list-style: decimal;
}

.organization-content :deep(img) {
  max-width: 100%;
  height: auto;
  margin: 1rem 0;
  border-radius: 1rem;
}

.organization-content :deep(iframe) {
  width: 100%;
  min-height: 320px;
  margin: 1rem 0;
  border-radius: 1rem;
}

.organization-content :deep(table) {
  width: 100%;
  border-collapse: collapse;
  margin: 1rem 0;
}

.organization-content :deep(th),
.organization-content :deep(td) {
  border: 1px solid rgb(229 229 229);
  padding: 0.75rem;
  text-align: left;
}

.organization-content :deep(th) {
  background: rgb(239 246 255);
  color: rgb(29 78 216);
  font-weight: 900;
}
</style>
