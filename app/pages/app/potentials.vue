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
                @error="appLogoFailed = true"
              >
              <div v-else class="grid h-full w-full place-items-center rounded-2xl bg-blue-600 text-white">
                <Icon :icon="profile.icon" class="h-7 w-7" />
              </div>
            </div>

            <div class="min-w-0">
              <div class="mb-2 flex flex-wrap items-center gap-2">
                <span class="inline-flex items-center gap-1.5 rounded-full bg-blue-50 px-3 py-1 text-[11px] font-black uppercase tracking-[0.14em] text-blue-700">
                  <Icon icon="solar:leaf-bold-duotone" class="h-3.5 w-3.5" />
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
              :disabled="pending"
              @click.stop="reloadPotentials"
            >
              <Icon icon="solar:refresh-bold-duotone" class="h-5 w-5" :class="pending ? 'animate-spin' : ''" />
              Refresh
            </button>

            <button
              type="button"
              class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700"
              @click.stop="openCreatePotentialModal"
            >
              <Icon icon="lucide:plus" class="h-5 w-5" />
              Tambah Potensi
            </button>
          </div>
        </div>
      </section>

      <section class="grid gap-3 sm:grid-cols-2 xl:grid-cols-4">
        <div class="rounded-3xl border border-neutral-200 bg-white p-4 shadow-sm">
          <div class="flex items-center justify-between gap-3">
            <div>
              <p class="text-[11px] font-black uppercase tracking-[0.14em] text-neutral-400">Total Potensi</p>
              <p class="mt-2 text-2xl font-black text-neutral-950">{{ normalizedPotentials.length }}</p>
            </div>
            <div class="grid h-11 w-11 place-items-center rounded-2xl bg-blue-50 text-blue-600">
              <Icon icon="solar:documents-bold-duotone" class="h-6 w-6" />
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
              :placeholder="profile.searchPlaceholder"
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
              v-for="type in potentialTypeOptions"
              :key="type.value"
              type="button"
              class="inline-flex shrink-0 items-center gap-2 rounded-2xl px-4 py-2.5 text-xs font-black transition"
              :class="selectedType === type.value ? 'bg-blue-600 text-white shadow-lg shadow-blue-600/20' : 'border border-neutral-200 bg-white text-neutral-600 hover:bg-neutral-50'"
              @click.stop="selectedType = type.value"
            >
              <Icon :icon="type.icon" class="h-4 w-4" />
              {{ type.label }}
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

      <section v-if="pending" class="grid gap-3 sm:grid-cols-2 xl:grid-cols-3">
        <div v-for="item in 6" :key="item" class="h-80 animate-pulse rounded-[1.75rem] border border-neutral-200 bg-white p-3">
          <div class="h-44 rounded-[1.35rem] bg-neutral-100"></div>
          <div class="mt-4 h-4 w-2/3 rounded-full bg-neutral-100"></div>
          <div class="mt-3 h-3 w-full rounded-full bg-neutral-100"></div>
          <div class="mt-2 h-3 w-4/5 rounded-full bg-neutral-100"></div>
        </div>
      </section>

      <section v-else-if="filteredPotentials.length === 0" class="rounded-[1.75rem] border border-dashed border-neutral-300 bg-white p-8 text-center shadow-sm">
        <div class="mx-auto grid h-14 w-14 place-items-center rounded-3xl bg-blue-50 text-blue-600">
          <Icon icon="solar:leaf-bold-duotone" class="h-7 w-7" />
        </div>

        <h2 class="mt-4 text-xl font-black text-neutral-950">Belum ada potensi</h2>
        <p class="mx-auto mt-2 max-w-md text-sm font-medium leading-6 text-neutral-500">
          {{ profile.emptyDescription }}
        </p>

        <button
          type="button"
          class="mt-5 inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700"
          @click.stop="openCreatePotentialModal"
        >
          <Icon icon="lucide:plus" class="h-5 w-5" />
          Tambah Potensi
        </button>
      </section>

      <section v-else class="grid gap-3 sm:grid-cols-2 xl:grid-cols-3">
        <article
          v-for="item in pagedPotentials"
          :key="item.id"
          class="group relative overflow-hidden rounded-[1.75rem] border border-neutral-200 bg-white shadow-sm transition hover:-translate-y-0.5 hover:border-blue-200 hover:shadow-xl hover:shadow-blue-900/5"
        >
          <div class="relative h-44 overflow-hidden bg-neutral-100">
            <img
              v-if="getPotentialCover(item) && !failedImages[item.id]"
              :src="getPotentialCover(item)"
              :alt="getPotentialTitle(item)"
              class="h-full w-full object-cover transition duration-500 group-hover:scale-105"
              loading="lazy"
              @error="markImageFailed(item.id)"
            >

            <div v-else class="flex h-full w-full items-center justify-center bg-gradient-to-br from-blue-50 via-white to-sky-50 text-blue-600">
              <Icon :icon="item.icon || getPotentialTypeIcon(item.potentialType)" class="h-10 w-10" />
            </div>

            <div class="absolute inset-0 bg-gradient-to-t from-neutral-950/60 via-neutral-950/10 to-transparent"></div>

            <div class="absolute left-3 top-3 flex flex-wrap gap-2">
              <span class="inline-flex items-center gap-1.5 rounded-full bg-white/90 px-3 py-1 text-[11px] font-black text-neutral-900 shadow-sm backdrop-blur">
                <Icon :icon="item.icon || getPotentialTypeIcon(item.potentialType)" class="h-3.5 w-3.5 text-blue-600" />
                {{ potentialTypeLabel(item.potentialType) }}
              </span>

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
              aria-label="Buka menu potensi"
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
              <p class="shrink-0 text-[11px] font-bold text-neutral-400">{{ formatDate(item.updatedAt || item.createdAt) }}</p>
            </div>

            <h3 class="line-clamp-2 text-base font-black leading-6 text-neutral-950 group-hover:text-blue-700">
              {{ getPotentialTitle(item) }}
            </h3>

            <p class="mt-2 line-clamp-3 text-sm font-medium leading-6 text-neutral-500">
              {{ item.subtitle || item.shortDescription || plainText(item.contentHtml || '').slice(0, 130) || 'Informasi potensi belum diisi.' }}
            </p>

            <div class="mt-4 grid grid-cols-2 gap-2">
              <div class="rounded-2xl bg-neutral-50 p-3">
                <p class="text-[10px] font-black uppercase tracking-[0.14em] text-neutral-400">Pasar</p>
                <p class="mt-1 truncate text-sm font-black text-neutral-700">{{ item.marketReach || '-' }}</p>
              </div>
              <div class="rounded-2xl bg-neutral-50 p-3">
                <p class="text-[10px] font-black uppercase tracking-[0.14em] text-neutral-400">Produksi</p>
                <p class="mt-1 truncate text-sm font-black text-neutral-700">{{ item.productionCapacity || '-' }}</p>
              </div>
            </div>
          </div>
        </article>
      </section>

      <div v-if="hasMore && !pending" class="flex justify-center">
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
          v-if="activeMenuPotential"
          class="fixed z-[9999] w-56 overflow-hidden rounded-3xl border border-neutral-200 bg-white p-2 shadow-[0_24px_90px_rgba(15,23,42,0.22)]"
          :style="{ top: `${ellipsisMenuPosition.top}px`, left: `${ellipsisMenuPosition.left}px` }"
          @click.stop
        >
          <button
            type="button"
            class="flex w-full items-center gap-3 rounded-2xl px-3 py-2.5 text-left text-sm font-black text-neutral-700 transition hover:bg-blue-50 hover:text-blue-700"
            @click="openView(activeMenuPotential)"
          >
            <Icon icon="solar:eye-bold-duotone" class="h-5 w-5 text-blue-600" />
            Lihat
          </button>

          <button
            type="button"
            class="flex w-full items-center gap-3 rounded-2xl px-3 py-2.5 text-left text-sm font-black text-neutral-700 transition disabled:cursor-not-allowed disabled:opacity-50"
            :class="activeMenuPotential.status === 'inactive'
              ? 'hover:bg-emerald-50 hover:text-emerald-700'
              : 'hover:bg-amber-50 hover:text-amber-700'"
            :disabled="isMutating"
            @click="togglePotentialStatus(activeMenuPotential)"
          >
            <Icon
              :icon="activeMenuPotential.status === 'inactive' ? 'solar:check-circle-bold-duotone' : 'solar:archive-bold-duotone'"
              class="h-5 w-5"
              :class="activeMenuPotential.status === 'inactive' ? 'text-emerald-600' : 'text-amber-600'"
            />
            {{ activeMenuPotential.status === 'inactive' ? 'Tampilkan' : 'Simpan' }}
          </button>

          <button
            type="button"
            class="flex w-full items-center gap-3 rounded-2xl px-3 py-2.5 text-left text-sm font-black text-neutral-700 transition hover:bg-neutral-100 hover:text-neutral-950"
            @click="openEditPotentialModal(activeMenuPotential)"
          >
            <Icon icon="solar:pen-2-bold-duotone" class="h-5 w-5 text-neutral-600" />
            Edit
          </button>

          <div class="my-1 border-t border-neutral-100"></div>

          <button
            type="button"
            class="flex w-full items-center gap-3 rounded-2xl px-3 py-2.5 text-left text-sm font-black text-red-600 transition hover:bg-red-50"
            @click="openDelete(activeMenuPotential)"
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
          v-if="potentialModalOpen"
          class="fixed inset-0 z-[120] grid place-items-center bg-neutral-950/60 p-4 backdrop-blur-sm"
          role="dialog"
          aria-modal="true"
          @click.self="closePotentialModal"
        >
          <section class="flex max-h-[92dvh] w-full max-w-5xl flex-col overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-[0_32px_110px_rgba(15,23,42,0.28)]">
            <div class="border-b border-neutral-200 bg-gradient-to-br from-blue-50 via-white to-white p-5">
              <div class="flex items-start justify-between gap-4">
                <div>
                  <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">Potensi Desa</p>
                  <h2 class="mt-1 text-2xl font-black tracking-tight text-neutral-950">
                    {{ editingPotential ? 'Edit Potensi Desa' : 'Tambah Potensi Desa' }}
                  </h2>
                  <p class="mt-1 text-sm font-semibold leading-6 text-neutral-500">
                    Form sederhana: slug tersembunyi otomatis, status default tampil, dan draft lokal tersimpan setelah mulai mengetik.
                  </p>
                </div>

                <button
                  type="button"
                  class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl border border-neutral-200 bg-white text-neutral-500 transition hover:bg-neutral-50 hover:text-neutral-950"
                  aria-label="Tutup modal potensi"
                  @click="closePotentialModal"
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
              @submit.prevent="submitPotentialForm"
              @keyup.capture="handleDraftKeyup"
              @input.capture="queuePotentialDraftSave"
              @change.capture="queuePotentialDraftSave"
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
                      <p class="mt-1 text-sm font-medium leading-6 text-neutral-500">Isi nama, tipe, ikon, dan ringkasan singkat. Slug otomatis dibuat saat disimpan.</p>
                    </div>
                  </div>
                </div>

                <div class="grid gap-4 md:grid-cols-2">
                  <label class="block md:col-span-2">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Nama Potensi</span>
                    <input
                      v-model="potentialForm.title"
                      type="text"
                      class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10"
                      :placeholder="profile.titlePlaceholder"
                      required
                    >
                  </label>

                  <label class="block">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Tipe Potensi</span>
                    <select
                      v-model="potentialForm.potentialType"
                      class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10"
                      @change="syncIconFromType"
                    >
                      <option v-for="type in potentialTypeOptions" :key="type.value" :value="type.value">
                        {{ type.label }}
                      </option>
                    </select>
                  </label>

                  <label class="block">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Iconify Icon</span>
                    <input
                      v-model="potentialForm.icon"
                      type="text"
                      class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10"
                      placeholder="lucide:wheat"
                    >
                  </label>

                  <label class="block md:col-span-2">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Ringkasan Singkat</span>
                    <textarea
                      v-model="potentialForm.subtitle"
                      rows="4"
                      class="w-full resize-none rounded-2xl border border-neutral-200 bg-white px-4 py-3 text-sm font-bold leading-7 text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10"
                      :placeholder="profile.excerptPlaceholder"
                    ></textarea>
                  </label>

                  <label class="flex items-start gap-3 rounded-2xl border border-neutral-200 bg-neutral-50 p-4 md:col-span-2">
                    <input
                      v-model="potentialForm.isFeatured"
                      type="checkbox"
                      class="mt-1 h-4 w-4 rounded border-neutral-300 text-blue-600 focus:ring-blue-500"
                    >
                    <span>
                      <span class="block text-sm font-black text-neutral-800">Jadikan potensi unggulan</span>
                      <span class="mt-1 block text-sm font-semibold leading-6 text-neutral-500">Data unggulan dapat diprioritaskan pada halaman publik.</span>
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
                      <h3 class="text-base font-black text-neutral-950">Media Potensi</h3>
                      <p class="mt-1 text-sm font-medium leading-6 text-neutral-500">Gunakan upload file ke Cloudinary atau link gambar yang sudah tersedia. Preview cukup gambar saja.</p>
                    </div>
                  </div>
                </div>

                <div class="grid gap-4 lg:grid-cols-2">
                  <div class="rounded-[1.5rem] border border-neutral-200 bg-white p-4">
                    <div class="flex items-start justify-between gap-3">
                      <div>
                        <h4 class="text-sm font-black text-neutral-950">Gambar Utama</h4>
                        <p class="mt-1 text-xs font-semibold leading-5 text-neutral-500">Tampil sebagai cover utama pada card dan detail.</p>
                      </div>
                      <Icon icon="solar:gallery-wide-bold-duotone" class="h-6 w-6 text-blue-600" />
                    </div>

                    <div class="mt-4 overflow-hidden rounded-[1.2rem] bg-neutral-100">
                      <img v-if="potentialForm.imageUrl" :src="potentialForm.imageUrl" alt="Preview gambar utama" class="h-56 w-full object-cover">
                      <div v-else class="grid h-56 place-items-center bg-gradient-to-br from-blue-50 via-white to-sky-50 text-blue-600">
                        <Icon icon="solar:gallery-wide-bold-duotone" class="h-10 w-10" />
                      </div>
                    </div>

                    <div class="mt-4 grid gap-2 sm:grid-cols-2">
                      <button type="button" class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700 disabled:opacity-60" :disabled="isCoverUploading" @click.stop="pickMediaFile('cover')">
                        <Icon :icon="isCoverUploading ? 'solar:refresh-bold-duotone' : 'solar:upload-square-bold-duotone'" class="h-5 w-5" :class="isCoverUploading ? 'animate-spin' : ''" />
                        File
                      </button>
                      <button type="button" class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl border border-red-200 bg-red-50 px-4 text-sm font-black text-red-600 transition hover:bg-red-100" @click.stop="potentialForm.imageUrl = ''">
                        <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-5 w-5" />
                        Hapus
                      </button>
                    </div>

                    <input v-model="potentialForm.imageUrl" type="url" class="mt-3 h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10" placeholder="Atau tempel link gambar utama">
                  </div>

                  <div class="rounded-[1.5rem] border border-neutral-200 bg-white p-4">
                    <div class="flex items-start justify-between gap-3">
                      <div>
                        <h4 class="text-sm font-black text-neutral-950">Logo Potensi</h4>
                        <p class="mt-1 text-xs font-semibold leading-5 text-neutral-500">Opsional untuk identitas brand atau produk.</p>
                      </div>
                      <Icon icon="solar:sticker-smile-circle-2-bold-duotone" class="h-6 w-6 text-blue-600" />
                    </div>

                    <div class="mt-4 overflow-hidden rounded-[1.2rem] bg-neutral-100">
                      <img v-if="potentialForm.logoUrl" :src="potentialForm.logoUrl" alt="Preview logo" class="h-56 w-full object-contain p-5">
                      <div v-else class="grid h-56 place-items-center bg-gradient-to-br from-blue-50 via-white to-sky-50 text-blue-600">
                        <Icon :icon="potentialForm.icon || getPotentialTypeIcon(potentialForm.potentialType)" class="h-10 w-10" />
                      </div>
                    </div>

                    <div class="mt-4 grid gap-2 sm:grid-cols-2">
                      <button type="button" class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700 disabled:opacity-60" :disabled="isLogoUploading" @click.stop="pickMediaFile('logo')">
                        <Icon :icon="isLogoUploading ? 'solar:refresh-bold-duotone' : 'solar:upload-square-bold-duotone'" class="h-5 w-5" :class="isLogoUploading ? 'animate-spin' : ''" />
                        File
                      </button>
                      <button type="button" class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl border border-red-200 bg-red-50 px-4 text-sm font-black text-red-600 transition hover:bg-red-100" @click.stop="potentialForm.logoUrl = ''">
                        <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-5 w-5" />
                        Hapus
                      </button>
                    </div>

                    <input v-model="potentialForm.logoUrl" type="url" class="mt-3 h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10" placeholder="Atau tempel link logo">
                  </div>

                  <div class="rounded-[1.5rem] border border-neutral-200 bg-white p-4 lg:col-span-2">
                    <div class="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
                      <div>
                        <h4 class="text-sm font-black text-neutral-950">Galeri</h4>
                        <p class="mt-1 text-xs font-semibold leading-5 text-neutral-500">Tambahkan beberapa gambar pendukung.</p>
                      </div>
                      <button type="button" class="inline-flex h-10 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700 disabled:opacity-60" :disabled="isGalleryUploading" @click.stop="pickMediaFile('gallery')">
                        <Icon :icon="isGalleryUploading ? 'solar:refresh-bold-duotone' : 'solar:add-circle-bold-duotone'" class="h-5 w-5" :class="isGalleryUploading ? 'animate-spin' : ''" />
                        Tambah Gambar
                      </button>
                    </div>

                    <div v-if="potentialForm.images.length" class="mt-4 grid gap-3 sm:grid-cols-3 lg:grid-cols-5">
                      <div v-for="(image, index) in potentialForm.images" :key="`${image}-${index}`" class="group relative overflow-hidden rounded-2xl border border-neutral-200 bg-neutral-100">
                        <img :src="image" alt="Galeri potensi" class="h-32 w-full object-cover">
                        <button type="button" class="absolute right-2 top-2 grid h-8 w-8 place-items-center rounded-xl bg-white/90 text-red-600 opacity-0 shadow-sm backdrop-blur transition group-hover:opacity-100" @click="removeGalleryImage(index)">
                          <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-4 w-4" />
                        </button>
                      </div>
                    </div>

                    <div v-else class="mt-4 rounded-2xl border border-dashed border-neutral-300 bg-neutral-50 p-6 text-center text-sm font-semibold text-neutral-500">
                      Belum ada gambar galeri.
                    </div>

                    <div class="mt-3 flex flex-col gap-2 sm:flex-row">
                      <input v-model="galleryLink" type="url" class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10" placeholder="Tempel link gambar galeri">
                      <button type="button" class="inline-flex h-12 shrink-0 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700" @click="addGalleryLink">
                        <Icon icon="solar:link-bold-duotone" class="h-5 w-5" />
                        Tambah Link
                      </button>
                    </div>
                  </div>
                </div>

                <input ref="mediaFileInput" type="file" accept="image/jpeg,image/jpg,image/png,image/webp" class="hidden" @change="onPickMediaFile">
              </div>

              <div v-show="formStep === 3" class="space-y-4">
                <div class="rounded-[1.5rem] border border-neutral-200 bg-neutral-50 p-4">
                  <div class="flex items-start gap-3">
                    <div class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl bg-white text-blue-600 shadow-sm">
                      <Icon icon="solar:pen-new-square-bold-duotone" class="h-5 w-5" />
                    </div>
                    <div>
                      <h3 class="text-base font-black text-neutral-950">Detail Potensi</h3>
                      <p class="mt-1 text-sm font-medium leading-6 text-neutral-500">Tulis konten lengkap, pengelola, jangkauan pasar, dan kontak. Konten memakai komponen RichText reusable.</p>
                    </div>
                  </div>
                </div>

                <div class="overflow-hidden rounded-[1.8rem] bg-white p-1">
                  <RichText
                    v-model="potentialForm.contentHtml"
                    placeholder="Tulis deskripsi lengkap potensi desa di sini..."
                  />
                </div>

                <div class="grid gap-4 md:grid-cols-2">
                  <label class="block">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Pengelola / Pemilik</span>
                    <input v-model="potentialForm.ownerName" type="text" class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10" placeholder="Nama pemilik atau kelompok">
                  </label>

                  <label class="block">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Penanggung Jawab</span>
                    <input v-model="potentialForm.managerName" type="text" class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10" placeholder="Nama pengelola">
                  </label>

                  <label class="block">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Kapasitas Produksi</span>
                    <input v-model="potentialForm.productionCapacity" type="text" class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10" placeholder="Contoh: 2 ton / bulan">
                  </label>

                  <label class="block">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Jangkauan Pasar</span>
                    <input v-model="potentialForm.marketReach" type="text" class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10" placeholder="Lokal, kabupaten, nasional...">
                  </label>

                  <label class="block">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Website / Sosial Media</span>
                    <input v-model="potentialForm.websiteUrl" type="url" class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10" placeholder="https://...">
                  </label>

                  <label class="block">
                    <span class="mb-2 block text-sm font-black text-neutral-800">WhatsApp</span>
                    <input v-model="potentialForm.whatsapp" type="text" class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10" placeholder="62812...">
                  </label>

                  <label class="block md:col-span-2">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Alamat</span>
                    <textarea v-model="potentialForm.address" rows="3" class="w-full resize-none rounded-2xl border border-neutral-200 bg-white px-4 py-3 text-sm font-bold leading-7 text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10" placeholder="Alamat atau lokasi potensi"></textarea>
                  </label>

                  <label class="block">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Latitude</span>
                    <input v-model="potentialForm.latitude" type="text" class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10" placeholder="-7.655...">
                  </label>

                  <label class="block">
                    <span class="mb-2 block text-sm font-black text-neutral-800">Longitude</span>
                    <input v-model="potentialForm.longitude" type="text" class="h-12 w-full rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-bold text-neutral-900 outline-none transition placeholder:text-neutral-400 focus:border-blue-500 focus:ring-4 focus:ring-blue-600/10" placeholder="112.789...">
                  </label>
                </div>
              </div>
            </form>

            <div class="flex flex-col-reverse gap-2 border-t border-neutral-200 bg-white p-5 sm:flex-row sm:items-center sm:justify-between">
              <div class="text-xs font-bold text-neutral-400">
                <span v-if="editingPotential">Mode edit tidak menimpa draft lokal.</span>
                <span v-else-if="lastDraftSavedAt">Draft lokal tersimpan {{ lastDraftSavedAt }}.</span>
                <span v-else>Draft lokal akan tersimpan setelah kamu mulai mengetik.</span>
              </div>

              <div class="flex flex-col-reverse gap-2 sm:flex-row">
                <button
                  type="button"
                  class="inline-flex h-12 items-center justify-center rounded-2xl border border-neutral-200 bg-white px-5 text-sm font-black text-neutral-700 transition hover:bg-neutral-50"
                  @click="formStep === 1 ? closePotentialModal() : prevFormStep()"
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
                  :disabled="isSaving || anyMediaUploading || !canSubmit"
                  @click="submitPotentialForm"
                >
                  <Icon
                    :icon="isSaving || anyMediaUploading ? 'solar:refresh-bold-duotone' : 'solar:diskette-bold-duotone'"
                    class="h-5 w-5"
                    :class="isSaving || anyMediaUploading ? 'animate-spin' : ''"
                  />
                  {{ anyMediaUploading ? 'Upload Gambar...' : isSaving ? 'Menyimpan...' : editingPotential ? 'Simpan Perubahan' : 'Tambah Potensi' }}
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
          v-if="viewModalOpen && selectedPotential"
          class="fixed inset-0 z-[130] grid place-items-center bg-neutral-950/60 p-4 backdrop-blur-sm"
          role="dialog"
          aria-modal="true"
          @click.self="closeView"
        >
          <section class="flex max-h-[92dvh] w-full max-w-4xl flex-col overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-[0_32px_110px_rgba(15,23,42,0.28)]">
            <div class="flex items-start justify-between gap-4 border-b border-neutral-200 p-5">
              <div>
                <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">Detail Potensi</p>
                <h2 class="mt-1 text-2xl font-black tracking-tight text-neutral-950">{{ getPotentialTitle(selectedPotential) }}</h2>
              </div>

              <button
                type="button"
                class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl border border-neutral-200 bg-white text-neutral-500 transition hover:bg-neutral-50 hover:text-neutral-950"
                aria-label="Tutup detail potensi"
                @click="closeView"
              >
                <Icon icon="lucide:x" class="h-5 w-5" />
              </button>
            </div>

            <div class="min-h-0 flex-1 overflow-y-auto p-5">
              <img
                v-if="getPotentialCover(selectedPotential)"
                :src="getPotentialCover(selectedPotential)"
                :alt="getPotentialTitle(selectedPotential)"
                class="mb-5 h-72 w-full rounded-[1.5rem] object-cover"
              >

              <div class="mb-5 flex flex-wrap items-center gap-2">
                <span class="rounded-full bg-blue-50 px-3 py-1 text-xs font-black text-blue-700">
                  {{ potentialTypeLabel(selectedPotential.potentialType) }}
                </span>
                <span class="rounded-full px-3 py-1 text-xs font-black" :class="statusClass(selectedPotential.status)">
                  {{ statusLabel(selectedPotential.status) }}
                </span>
                <span v-if="selectedPotential.isFeatured" class="rounded-full bg-neutral-100 px-3 py-1 text-xs font-black text-neutral-600">
                  Unggulan
                </span>
              </div>

              <p class="mb-5 rounded-2xl bg-neutral-50 p-4 text-sm font-semibold leading-7 text-neutral-600">
                {{ selectedPotential.subtitle || selectedPotential.shortDescription || 'Belum ada ringkasan.' }}
              </p>

              <div class="mb-5 grid gap-3 md:grid-cols-2">
                <div class="rounded-2xl border border-neutral-200 bg-white p-4">
                  <p class="text-[10px] font-black uppercase tracking-[0.14em] text-neutral-400">Pengelola</p>
                  <p class="mt-1 text-sm font-black text-neutral-800">{{ selectedPotential.ownerName || selectedPotential.managerName || '-' }}</p>
                </div>
                <div class="rounded-2xl border border-neutral-200 bg-white p-4">
                  <p class="text-[10px] font-black uppercase tracking-[0.14em] text-neutral-400">Pasar</p>
                  <p class="mt-1 text-sm font-black text-neutral-800">{{ selectedPotential.marketReach || '-' }}</p>
                </div>
              </div>

              <div class="potential-content rounded-2xl border border-neutral-200 p-5" v-html="selectedPotentialContent"></div>
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
          v-if="deleteModalOpen && selectedPotential"
          class="fixed inset-0 z-[140] grid place-items-center bg-neutral-950/60 p-4 backdrop-blur-sm"
          role="dialog"
          aria-modal="true"
          @click.self="closeDelete"
        >
          <section class="w-full max-w-md rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-[0_32px_110px_rgba(15,23,42,0.28)]">
            <div class="grid h-14 w-14 place-items-center rounded-3xl bg-red-50 text-red-600">
              <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-7 w-7" />
            </div>

            <h2 class="mt-5 text-xl font-black tracking-tight text-neutral-950">Hapus Potensi?</h2>
            <p class="mt-2 text-sm font-medium leading-6 text-neutral-500">
              Data <strong class="text-neutral-900">{{ getPotentialTitle(selectedPotential) }}</strong> akan dihapus dari daftar.
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
import { useAppApi } from '~/composables/useAppApi'
import { useCloudinaryUpload } from '~/composables/useCloudinaryUpload'

definePageMeta({
  layout: 'app',
  layoutProps: {
    title: 'Potensi'
  }
})

type ToastType = 'success' | 'error'
type PotentialStatus = 'active' | 'inactive'
type StatusFilter = 'all' | 'active' | 'inactive' | 'featured'
type SortOption = 'newest' | 'oldest' | 'name' | 'sort_order'
type MediaTarget = 'cover' | 'logo' | 'gallery'

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
  | string

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
  metadata?: Record<string, any> | null
  createdAt?: number | string | null
  updatedAt?: number | string | null
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
  isFeatured: boolean
  sortOrder: number
  images: string[]
}

type PotentialDraft = PotentialForm & {
  updatedAt?: string
}

const runtime = useRuntimeConfig()
const requestUrl = useRequestURL()
const { tenantApiUrl } = useAppApi()
const { uploading: cloudinaryUploading, uploadImage } = useCloudinaryUpload()

const search = ref('')
const selectedType = ref<PotentialType | 'all'>('all')
const selectedStatus = ref<StatusFilter>('all')
const sortBy = ref<SortOption>('sort_order')
const page = ref(1)
const pageSize = 12

const potentialModalOpen = ref(false)
const viewModalOpen = ref(false)
const deleteModalOpen = ref(false)

const formStep = ref(1)
const editingPotential = ref<PotentialItem | null>(null)
const selectedPotential = ref<PotentialItem | null>(null)
const formError = ref('')

const draftLoaded = ref(false)
const draftReady = ref(false)
const draftStarted = ref(false)
const localDraftExists = ref(false)
const lastDraftSavedAt = ref('')

const activeMenuPotential = ref<PotentialItem | null>(null)
const ellipsisMenuPosition = reactive({ top: 0, left: 0 })
const statusPatchedPotentials = ref<Record<string, PotentialItem>>({})

const mediaFileInput = ref<HTMLInputElement | null>(null)
const pendingMediaTarget = ref<MediaTarget>('cover')
const mediaUploadingTarget = ref<MediaTarget | null>(null)
const galleryLink = ref('')

const appLogoFailed = ref(false)
const failedImages = ref<Record<string, boolean>>({})
const isSaving = ref(false)
const isDeleting = ref(false)
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

const potentialForm = reactive<PotentialForm>({
  id: '',
  title: '',
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
  isFeatured: true,
  sortOrder: 0,
  images: []
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

const potentialTypeOptions: Array<{ value: PotentialType; label: string; icon: string }> = [
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
  { value: 'custom', label: 'Lainnya', icon: 'lucide:layers' }
]

const profile = computed(() => {
  const clientName = String(runtime.public.clientName || 'martopuro').trim().toLowerCase()
  const isMartopuro = clientName.includes('martopuro')

  if (isMartopuro) {
    return {
      name: 'Desa Martopuro',
      title: 'Kelola Potensi Desa',
      badge: 'Village Potential',
      icon: 'solar:leaf-bold-duotone',
      description: 'Kelola potensi desa, UMKM, wisata, budaya, pertanian, dan sumber daya lokal dengan tampilan yang rapi.',
      searchPlaceholder: 'Cari potensi, lokasi, pengelola, pasar...',
      emptyDescription: 'Belum ada potensi desa. Mulai tambahkan UMKM, wisata, budaya, atau sumber daya lokal agar tampil di website publik.',
      titlePlaceholder: 'Contoh: Sentra Padi Organik Martopuro',
      excerptPlaceholder: 'Tulis ringkasan singkat agar pembaca memahami potensi ini...'
    }
  }

  return {
    name: 'Obayan',
    title: 'Kelola Potensi',
    badge: 'Potential Data',
    icon: 'solar:leaf-bold-duotone',
    description: 'Kelola potensi, produk lokal, peluang ekonomi, dan informasi unggulan dengan layout yang bersih.',
    searchPlaceholder: 'Cari potensi, pengelola, pasar, atau lokasi...',
    emptyDescription: 'Belum ada potensi. Mulai tambahkan data unggulan agar tampil di halaman publik.',
    titlePlaceholder: 'Contoh: Produk Lokal Unggulan',
    excerptPlaceholder: 'Tulis ringkasan potensi agar pembaca memahami poin utamanya...'
  }
})

const hostname = computed(() => String(requestUrl.hostname || '').replace(/^www\./, '').toLowerCase())
const tenantSlug = computed(() => {
  const envClient = String(runtime.public.clientName || 'martopuro').trim().toLowerCase()
  if (hostname.value.includes('martopuro')) return 'martopuro'
  if (hostname.value.includes('obayan')) return 'obayan'
  return envClient || 'martopuro'
})

const appLogo = computed(() => {
  if (appLogoFailed.value) return ''

  return String(
    runtime.public.appLogo ||
      runtime.public.logoUrl ||
      runtime.public.siteLogo ||
      runtime.public.favicon ||
      ''
  ).trim()
})

const apiUrl = computed(() => tenantApiUrl(tenantSlug.value, '/potentials'))

const {
  data,
  pending,
  error,
  refresh
} = await useFetch<PotentialListResponse>(apiUrl, {
  key: computed(() => `app-potentials-${tenantSlug.value}-${selectedType.value}-${sortBy.value}`),
  query: computed(() => ({
    type: selectedType.value === 'all' ? undefined : selectedType.value,
    potentialType: selectedType.value === 'all' ? undefined : selectedType.value,
    limit: 100,
    sort: sortBy.value
  })),
  watch: [tenantSlug, selectedType, sortBy],
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

const isMutating = computed(() => Boolean(isSaving.value || isDeleting.value))
const anyMediaUploading = computed(() => Boolean(cloudinaryUploading.value || mediaUploadingTarget.value))
const isCoverUploading = computed(() => mediaUploadingTarget.value === 'cover')
const isLogoUploading = computed(() => mediaUploadingTarget.value === 'logo')
const isGalleryUploading = computed(() => mediaUploadingTarget.value === 'gallery')

const visibleError = computed(() => {
  if (localError.value) return localError.value
  if (!error.value) return ''
  return getErrorMessage(error.value, 'Terjadi kesalahan saat memuat data potensi.')
})

const rawPotentials = computed(() => data.value?.data || [])

const normalizedPotentials = computed<PotentialItem[]>(() => {
  const merged = new Map<string, PotentialItem>()

  for (const item of rawPotentials.value) {
    merged.set(item.id, normalizePotentialItem(item))
  }

  for (const item of Object.values(statusPatchedPotentials.value)) {
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

  return Array.from(merged.values()).sort(sortPotentials)
})

const filteredPotentials = computed(() => {
  const keyword = search.value.trim().toLowerCase()

  return normalizedPotentials.value.filter((item) => {
    const matchKeyword = !keyword || [
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

    const matchType = selectedType.value === 'all' || item.potentialType === selectedType.value
    const matchStatus = selectedStatus.value === 'all'
      ? true
      : selectedStatus.value === 'featured'
        ? Boolean(item.isFeatured)
        : item.status === selectedStatus.value

    return matchKeyword && matchType && matchStatus
  })
})

const pagedPotentials = computed(() => filteredPotentials.value.slice(0, page.value * pageSize))
const hasMore = computed(() => pagedPotentials.value.length < filteredPotentials.value.length)

const activeCount = computed(() => normalizedPotentials.value.filter((item) => item.status === 'active').length)
const inactiveCount = computed(() => normalizedPotentials.value.filter((item) => item.status === 'inactive').length)
const featuredCount = computed(() => normalizedPotentials.value.filter((item) => item.isFeatured).length)

const statusFilterOptions = computed<Array<{ value: StatusFilter; label: string; icon: string; count: number }>>(() => [
  { value: 'all', label: 'Semua', icon: 'solar:layers-bold-duotone', count: normalizedPotentials.value.length },
  { value: 'active', label: 'Tampil', icon: 'solar:check-circle-bold-duotone', count: activeCount.value },
  { value: 'inactive', label: 'Disimpan', icon: 'solar:archive-bold-duotone', count: inactiveCount.value },
  { value: 'featured', label: 'Unggulan', icon: 'solar:star-bold-duotone', count: featuredCount.value }
])

const canGoNext = computed(() => {
  if (formStep.value === 1) return potentialForm.title.trim().length >= 3
  if (formStep.value === 2) return true
  return true
})

const canSubmit = computed(() => potentialForm.title.trim().length >= 3)
const potentialDraftKey = computed(() => `potential-form-draft:${tenantSlug.value}`)
const selectedPotentialContent = computed(() => sanitizeHtml(selectedPotential.value?.contentHtml || ''))

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

watch([search, selectedType, selectedStatus, sortBy], () => {
  page.value = 1
})

watch(
  potentialForm,
  () => {
    if (!draftStarted.value) return
    queuePotentialDraftSave()
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
  document.removeEventListener('keydown', handleEscape)
  window.removeEventListener('resize', closeEllipsisMenu)
  window.removeEventListener('scroll', closeEllipsisMenu, true)
})

async function reloadPotentials() {
  localLoading.value = true
  localError.value = ''

  try {
    await refresh()
    showToast('success', 'Data Diperbarui', 'Daftar potensi berhasil dimuat ulang.')
  } catch (err) {
    const message = getErrorMessage(err, 'Data potensi gagal dimuat.')
    localError.value = message
    showToast('error', 'Gagal Memuat', message)
  } finally {
    localLoading.value = false
  }
}

function createEmptyPotentialForm(): PotentialForm {
  return {
    id: '',
    title: '',
    subtitle: '',
    shortDescription: '',
    contentHtml: '',
    potentialType: 'custom',
    icon: getPotentialTypeIcon('custom'),
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
    isFeatured: true,
    sortOrder: 0,
    images: []
  }
}

function resetPotentialForm() {
  Object.assign(potentialForm, createEmptyPotentialForm())
  galleryLink.value = ''
}

async function openCreatePotentialModal() {
  closeEllipsisMenu()
  editingPotential.value = null
  formStep.value = 1
  formError.value = ''
  draftLoaded.value = false
  draftStarted.value = false
  draftReady.value = false
  resetPotentialForm()

  const draft = readPotentialDraft()

  if (draft) {
    Object.assign(potentialForm, {
      ...createEmptyPotentialForm(),
      ...draft
    })
    draftLoaded.value = true
  }

  potentialModalOpen.value = true

  await nextTick()

  draftReady.value = true
}

async function openEditPotentialModal(item: PotentialItem) {
  closeEllipsisMenu()
  editingPotential.value = item
  formStep.value = 1
  formError.value = ''
  draftLoaded.value = false
  draftStarted.value = false
  draftReady.value = false

  Object.assign(potentialForm, {
    id: item.id,
    title: getPotentialTitle(item),
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
    latitude: item.latitude == null ? '' : String(item.latitude),
    longitude: item.longitude == null ? '' : String(item.longitude),
    ownerName: item.ownerName || '',
    managerName: item.managerName || '',
    productionCapacity: item.productionCapacity || '',
    productionUnit: item.productionUnit || '',
    marketReach: item.marketReach || '',
    estimatedValue: item.estimatedValue == null ? '' : String(item.estimatedValue),
    isFeatured: Boolean(item.isFeatured),
    sortOrder: Number(item.sortOrder || 0),
    images: getPotentialImages(item).filter((image) => image !== item.imageUrl && image !== item.coverUrl && image !== item.logoUrl)
  })

  galleryLink.value = ''
  potentialModalOpen.value = true

  await nextTick()

  draftReady.value = true
}

function closePotentialModal() {
  potentialModalOpen.value = false
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

  if (formStep.value === 1 && potentialForm.title.trim().length < 3) {
    formError.value = 'Nama potensi minimal 3 karakter.'
    return false
  }

  if (formStep.value === 2) {
    const urls = [potentialForm.imageUrl, potentialForm.logoUrl, ...potentialForm.images].filter(Boolean)
    const hasInvalidUrl = urls.some((url) => !isValidUrl(url))

    if (hasInvalidUrl) {
      formError.value = 'Ada link gambar yang belum valid.'
      return false
    }
  }

  if (formStep.value === 3) {
    if (potentialForm.websiteUrl && !isValidUrl(potentialForm.websiteUrl)) {
      formError.value = 'Link website atau sosial media belum valid.'
      return false
    }

    if (potentialForm.email && !/^\S+@\S+\.\S+$/.test(potentialForm.email)) {
      formError.value = 'Format email belum valid.'
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

async function submitPotentialForm() {
  if (!canSubmit.value || isSaving.value) return
  if (!validateAllSteps()) return

  isSaving.value = true
  formError.value = ''

  try {
    const payload = createPotentialPayload(editingPotential.value?.status || 'active')

    if (editingPotential.value) {
      await $fetch(`${apiUrl.value}/${editingPotential.value.id}`, {
        method: 'PUT',
        body: payload
      })
      showToast('success', 'Potensi Diupdate', 'Perubahan potensi berhasil disimpan.')
    } else {
      await $fetch(apiUrl.value, {
        method: 'POST',
        body: payload
      })
      clearPotentialDraft()
      showToast('success', 'Potensi Ditambahkan', 'Data potensi berhasil ditambahkan.')
    }

    closePotentialModal()
    await refresh()
  } catch (err) {
    const message = getErrorMessage(err, 'Gagal menyimpan data potensi.')
    formError.value = message
    showToast('error', 'Gagal Menyimpan', message)
  } finally {
    isSaving.value = false
  }
}

function createPotentialPayload(status: PotentialStatus) {
  const title = potentialForm.title.trim()
  const slug = editingPotential.value?.slug || createPotentialSlug(title)
  const contentHtml = potentialForm.contentHtml || ''
  const shortDescription = potentialForm.shortDescription.trim() || potentialForm.subtitle.trim() || plainText(contentHtml).slice(0, 160)
  const imageUrl = potentialForm.imageUrl.trim()

  return {
    title,
    name: title,
    slug,
    subtitle: potentialForm.subtitle.trim(),
    shortDescription,
    contentHtml,
    potentialType: potentialForm.potentialType,
    icon: potentialForm.icon || getPotentialTypeIcon(potentialForm.potentialType),
    logoUrl: cleanNullable(potentialForm.logoUrl),
    imageUrl: cleanNullable(imageUrl),
    coverUrl: cleanNullable(imageUrl),
    phone: cleanNullable(potentialForm.phone),
    whatsapp: cleanNullable(potentialForm.whatsapp),
    email: cleanNullable(potentialForm.email),
    websiteUrl: cleanNullable(potentialForm.websiteUrl),
    address: cleanNullable(potentialForm.address),
    latitude: parseNullableNumber(potentialForm.latitude),
    longitude: parseNullableNumber(potentialForm.longitude),
    ownerName: cleanNullable(potentialForm.ownerName),
    managerName: cleanNullable(potentialForm.managerName),
    productionCapacity: cleanNullable(potentialForm.productionCapacity),
    productionUnit: cleanNullable(potentialForm.productionUnit),
    marketReach: cleanNullable(potentialForm.marketReach),
    estimatedValue: parseNullableNumber(potentialForm.estimatedValue),
    status,
    isFeatured: Boolean(potentialForm.isFeatured),
    sortOrder: Number(potentialForm.sortOrder || 0),
    metadata: {
      ...(editingPotential.value?.metadata || {}),
      images: potentialForm.images.filter(Boolean),
      updatedFrom: 'app-potentials'
    }
  }
}

function createPayloadFromItem(item: PotentialItem, status: PotentialStatus) {
  const imageUrl = getPotentialCover(item)

  return {
    title: getPotentialTitle(item),
    name: getPotentialTitle(item),
    slug: item.slug || createPotentialSlug(getPotentialTitle(item)),
    subtitle: item.subtitle || item.shortDescription || '',
    shortDescription: item.shortDescription || item.subtitle || plainText(item.contentHtml || '').slice(0, 160),
    contentHtml: item.contentHtml || '',
    potentialType: item.potentialType || 'custom',
    icon: item.icon || getPotentialTypeIcon(item.potentialType || 'custom'),
    logoUrl: item.logoUrl || null,
    imageUrl: imageUrl || null,
    coverUrl: imageUrl || null,
    phone: item.phone || null,
    whatsapp: item.whatsapp || null,
    email: item.email || null,
    websiteUrl: item.websiteUrl || null,
    address: item.address || null,
    latitude: parseNullableNumber(item.latitude == null ? '' : String(item.latitude)),
    longitude: parseNullableNumber(item.longitude == null ? '' : String(item.longitude)),
    ownerName: item.ownerName || null,
    managerName: item.managerName || null,
    productionCapacity: item.productionCapacity || null,
    productionUnit: item.productionUnit || null,
    marketReach: item.marketReach || null,
    estimatedValue: parseNullableNumber(item.estimatedValue == null ? '' : String(item.estimatedValue)),
    status,
    isFeatured: Boolean(item.isFeatured),
    sortOrder: Number(item.sortOrder || 0),
    metadata: {
      ...(item.metadata || {}),
      images: getPotentialImages(item),
      updatedFrom: 'app-potentials-status'
    }
  }
}

async function togglePotentialStatus(item: PotentialItem) {
  closeEllipsisMenu()

  const nextStatus: PotentialStatus = item.status === 'inactive' ? 'active' : 'inactive'

  try {
    const nextItem = patchPotentialStatus(item, nextStatus)
    await $fetch(`${apiUrl.value}/${item.id}`, {
      method: 'PUT',
      body: createPayloadFromItem(nextItem, nextStatus)
    })

    statusPatchedPotentials.value[item.id] = nextItem
    showToast('success', nextStatus === 'active' ? 'Potensi Ditampilkan' : 'Potensi Disimpan', nextStatus === 'active' ? 'Potensi berhasil ditampilkan kembali.' : 'Potensi berhasil disimpan dari tampilan publik.')
    await refresh()
  } catch (err) {
    showToast('error', 'Gagal Mengubah Status', getErrorMessage(err, 'Status potensi belum berhasil diubah.'))
  }
}

function patchPotentialStatus(item: PotentialItem, status: PotentialStatus): PotentialItem {
  return {
    ...item,
    status,
    updatedAt: Date.now(),
    metadata: {
      ...(item.metadata || {}),
      statusPatchedAt: Date.now()
    }
  }
}

function openView(item: PotentialItem) {
  selectedPotential.value = item
  viewModalOpen.value = true
  closeEllipsisMenu()
}

function closeView() {
  viewModalOpen.value = false
  selectedPotential.value = null
}

function openDelete(item: PotentialItem) {
  selectedPotential.value = item
  deleteModalOpen.value = true
  closeEllipsisMenu()
}

function closeDelete() {
  deleteModalOpen.value = false
  selectedPotential.value = null
}

async function confirmDelete() {
  if (!selectedPotential.value || isDeleting.value) return

  isDeleting.value = true

  try {
    await $fetch(`${apiUrl.value}/${selectedPotential.value.id}`, {
      method: 'DELETE'
    })

    delete statusPatchedPotentials.value[selectedPotential.value.id]
    showToast('success', 'Potensi Dihapus', 'Data potensi berhasil dihapus.')
    closeDelete()
    await refresh()
  } catch (err) {
    showToast('error', 'Gagal Menghapus', getErrorMessage(err, 'Data potensi belum berhasil dihapus.'))
  } finally {
    isDeleting.value = false
  }
}

function openEllipsisMenu(item: PotentialItem, event: MouseEvent) {
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
  activeMenuPotential.value = item
}

function closeEllipsisMenu() {
  activeMenuPotential.value = null
}

function handleDraftKeyup() {
  if (editingPotential.value) return
  draftStarted.value = true
  queuePotentialDraftSave()
}

function queuePotentialDraftSave() {
  if (editingPotential.value) return
  if (!potentialModalOpen.value || !draftReady.value || !draftStarted.value) return

  if (draftTimer) clearTimeout(draftTimer)

  draftTimer = setTimeout(() => {
    savePotentialDraft()
  }, 250)
}

function readPotentialDraft(): PotentialDraft | null {
  if (!import.meta.client) return null

  try {
    const raw = localStorage.getItem(potentialDraftKey.value)
    if (!raw) return null
    return JSON.parse(raw) as PotentialDraft
  } catch {
    return null
  }
}

function savePotentialDraft() {
  if (!import.meta.client) return

  const hasDraft = Boolean(
    potentialForm.title.trim() ||
      potentialForm.subtitle.trim() ||
      potentialForm.imageUrl.trim() ||
      potentialForm.logoUrl.trim() ||
      potentialForm.contentHtml.trim() ||
      potentialForm.images.length
  )

  if (!hasDraft) {
    localStorage.removeItem(potentialDraftKey.value)
    refreshLocalDraftState()
    return
  }

  const payload: PotentialDraft = {
    ...potentialForm,
    updatedAt: new Date().toISOString()
  }

  localStorage.setItem(potentialDraftKey.value, JSON.stringify(payload))
  lastDraftSavedAt.value = formatTimeOnly(Date.now())
  refreshLocalDraftState()
}

function clearPotentialDraft() {
  if (!import.meta.client) return
  localStorage.removeItem(potentialDraftKey.value)
  draftLoaded.value = false
  localDraftExists.value = false
  lastDraftSavedAt.value = ''
}

function refreshLocalDraftState() {
  if (!import.meta.client) return
  localDraftExists.value = Boolean(localStorage.getItem(potentialDraftKey.value))
}

function pickMediaFile(target: MediaTarget) {
  if (anyMediaUploading.value) return
  pendingMediaTarget.value = target
  mediaFileInput.value?.click()
}

async function onPickMediaFile(event: Event) {
  const input = event.target as HTMLInputElement
  const file = input.files?.[0] || null

  if (!file) return

  if (!isAllowedImageFile(file)) {
    input.value = ''
    return
  }

  const target = pendingMediaTarget.value
  mediaUploadingTarget.value = target

  try {
    const result = await uploadImage(file, {
      folder: `${tenantSlug.value}/potentials`,
      maxWidth: 1800,
      maxHeight: 1800,
      quality: 0.82,
      maxBytes: 5 * 1024 * 1024
    })

    const url = (result as any).secure_url || (result as any).url || ''

    if (target === 'cover') potentialForm.imageUrl = url
    if (target === 'logo') potentialForm.logoUrl = url
    if (target === 'gallery' && url && !potentialForm.images.includes(url)) potentialForm.images.push(url)

    draftStarted.value = true
    queuePotentialDraftSave()
    showToast('success', 'Gambar Ditambahkan', 'Gambar berhasil diupload ke Cloudinary.')
  } catch (err) {
    showToast('error', 'Upload Gagal', getErrorMessage(err, 'Gambar belum berhasil diupload.'))
  } finally {
    mediaUploadingTarget.value = null
    input.value = ''
  }
}

function addGalleryLink() {
  const url = galleryLink.value.trim()
  if (!url) return

  if (!isValidUrl(url)) {
    showToast('error', 'Link Belum Valid', 'Pastikan link gambar diawali dengan http atau https.')
    return
  }

  if (!potentialForm.images.includes(url)) {
    potentialForm.images.push(url)
  }

  galleryLink.value = ''
  draftStarted.value = true
  queuePotentialDraftSave()
}

function removeGalleryImage(index: number) {
  potentialForm.images = potentialForm.images.filter((_, itemIndex) => itemIndex !== index)
}

function syncIconFromType() {
  potentialForm.icon = getPotentialTypeIcon(potentialForm.potentialType)
}

function normalizePotentialItem(item: PotentialItem): PotentialItem {
  return {
    ...item,
    id: String(item.id || item.slug || createPotentialSlug(getPotentialTitle(item))),
    title: getPotentialTitle(item),
    name: item.name || getPotentialTitle(item),
    slug: String(item.slug || slugify(getPotentialTitle(item))),
    status: normalizeStatus(item.status),
    potentialType: item.potentialType || 'custom',
    icon: item.icon || getPotentialTypeIcon(item.potentialType || 'custom'),
    contentHtml: item.contentHtml || '',
    metadata: item.metadata || {}
  }
}

function sortPotentials(a: PotentialItem, b: PotentialItem) {
  if (sortBy.value === 'name') return getPotentialTitle(a).localeCompare(getPotentialTitle(b))
  if (sortBy.value === 'newest') return toTimestamp(b.createdAt || b.updatedAt) - toTimestamp(a.createdAt || a.updatedAt)
  if (sortBy.value === 'oldest') return toTimestamp(a.createdAt || a.updatedAt) - toTimestamp(b.createdAt || b.updatedAt)

  const sortA = Number(a.sortOrder || 0)
  const sortB = Number(b.sortOrder || 0)
  if (sortA !== sortB) return sortA - sortB
  return getPotentialTitle(a).localeCompare(getPotentialTitle(b))
}

function getPotentialTitle(item: PotentialItem) {
  return String(item.title || item.name || 'Potensi').trim()
}

function getPotentialImages(item: PotentialItem) {
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

function getPotentialCover(item: PotentialItem) {
  return getPotentialImages(item)[0] || ''
}

function markImageFailed(id: string) {
  failedImages.value = {
    ...failedImages.value,
    [id]: true
  }
}

function potentialTypeLabel(type?: PotentialType | null) {
  return potentialTypeOptions.find((item) => item.value === type)?.label || 'Potensi'
}

function getPotentialTypeIcon(type?: PotentialType | null) {
  return potentialTypeOptions.find((item) => item.value === type)?.icon || 'lucide:layers'
}

function statusLabel(status?: PotentialStatus) {
  return status === 'inactive' ? 'Disimpan' : 'Tampil'
}

function statusClass(status?: PotentialStatus) {
  return status === 'inactive'
    ? 'bg-amber-100/90 text-amber-800'
    : 'bg-emerald-100/90 text-emerald-800'
}

function normalizeStatus(value: unknown): PotentialStatus {
  return String(value || 'active').toLowerCase() === 'inactive' ? 'inactive' : 'active'
}

function createPotentialSlug(title: string) {
  const baseSlug = slugify(title) || 'potensi-desa'
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

function sanitizeHtml(value: string) {
  return String(value || '')
    .replace(/<script[\s\S]*?>[\s\S]*?<\/script>/gi, '')
    .replace(/<style[\s\S]*?>[\s\S]*?<\/style>/gi, '')
    .replace(/\son\w+="[^"]*"/gi, '')
    .replace(/\son\w+='[^']*'/gi, '')
    .replace(/javascript:/gi, '')
}

function cleanNullable(value: string) {
  const cleanValue = String(value || '').trim()
  return cleanValue || null
}

function parseNullableNumber(value: string) {
  const trimmed = String(value || '').trim()
  if (!trimmed) return null

  const number = Number(trimmed)
  return Number.isFinite(number) ? number : null
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

function getErrorMessage(err: unknown, fallback: string) {
  if (!err) return fallback
  if (typeof err === 'string') return err

  const payload = err as {
    data?: {
      message?: string
      statusMessage?: string
      error?: string
    }
    message?: string
    statusMessage?: string
  }

  return payload.data?.message || payload.data?.statusMessage || payload.data?.error || payload.statusMessage || payload.message || fallback
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
  closePotentialModal()
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

.potential-content :deep(h1) {
  margin: 1rem 0 0.75rem;
  font-size: 1.875rem;
  line-height: 2.25rem;
  font-weight: 900;
  color: rgb(23 23 23);
}

.potential-content :deep(h2) {
  margin: 1rem 0 0.75rem;
  font-size: 1.5rem;
  line-height: 2rem;
  font-weight: 900;
  color: rgb(23 23 23);
}

.potential-content :deep(h3) {
  margin: 0.875rem 0 0.5rem;
  font-size: 1.25rem;
  line-height: 1.75rem;
  font-weight: 900;
  color: rgb(23 23 23);
}

.potential-content :deep(p) {
  margin: 0.75rem 0;
  font-size: 0.95rem;
  line-height: 1.85;
  font-weight: 500;
  color: rgb(64 64 64);
}

.potential-content :deep(ul),
.potential-content :deep(ol) {
  margin: 0.75rem 0;
  padding-left: 1.25rem;
  color: rgb(64 64 64);
}

.potential-content :deep(ul) {
  list-style: disc;
}

.potential-content :deep(ol) {
  list-style: decimal;
}

.potential-content :deep(img) {
  max-width: 100%;
  height: auto;
  margin: 1rem 0;
  border-radius: 1rem;
}

.potential-content :deep(iframe) {
  width: 100%;
  min-height: 320px;
  margin: 1rem 0;
  border: 0;
  border-radius: 1rem;
  background: rgb(245 245 245);
}

.potential-content :deep(table) {
  width: 100%;
  border-collapse: collapse;
  margin: 1rem 0;
}

.potential-content :deep(th),
.potential-content :deep(td) {
  border: 1px solid rgb(229 229 229);
  padding: 0.75rem;
  text-align: left;
}

.potential-content :deep(th) {
  background: rgb(239 246 255);
  color: rgb(29 78 216);
  font-weight: 900;
}
</style>
