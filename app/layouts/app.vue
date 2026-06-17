<template>
  <div class="min-h-dvh bg-neutral-100 text-neutral-900">
    <!-- Desktop Sidebar -->
    <aside
      class="fixed inset-y-0 start-0 z-50 hidden overflow-hidden border-e border-white/10 bg-neutral-950 text-white shadow-[18px_0_60px_rgba(15,23,42,0.22)] transition-all duration-300 lg:flex lg:flex-col"
      :class="desktopSidebarCollapsed ? 'lg:w-20' : 'lg:w-72'"
    >
      <div class="pointer-events-none absolute inset-0 overflow-hidden">
        <div class="absolute -left-24 -top-24 h-56 w-56 rounded-full bg-blue-600/20 blur-3xl"></div>
        <div class="absolute -bottom-24 right-0 h-56 w-56 rounded-full bg-sky-500/10 blur-3xl"></div>
        <div class="absolute inset-0 bg-sidebar-grid opacity-[0.16]"></div>
      </div>

      <!-- Brand -->
      <div class="relative flex h-16 items-center gap-3 border-b border-white/10 px-3">
        <NuxtLink
          to="/app"
          class="group flex min-w-0 flex-1 items-center gap-3 rounded-2xl px-2 py-2 transition hover:bg-white/5"
        >
          <div class="grid h-10 w-10 shrink-0 place-items-center overflow-hidden rounded-2xl border border-white/10 bg-white text-blue-600 shadow-lg shadow-blue-950/20">
            <img
              v-if="appLogo && !logoError"
              :src="appLogo"
              :alt="appName"
              class="h-8 w-8 rounded-xl object-contain"
              @error="logoError = true"
            >
            <Icon
              v-else
              icon="lucide:blocks"
              class="h-6 w-6"
            />
          </div>

          <div
            v-if="!desktopSidebarCollapsed"
            class="min-w-0"
          >
            <p class="truncate text-sm font-black tracking-tight text-white">
              {{ appName }}
            </p>
            <p class="truncate text-xs font-semibold text-white/45">
              {{ appSubtitle }}
            </p>
          </div>
        </NuxtLink>

        <button
          type="button"
          class="grid h-9 w-9 shrink-0 place-items-center rounded-2xl border border-white/10 bg-white/5 text-white/60 transition hover:bg-white/10 hover:text-white"
          aria-label="Ubah ukuran sidebar"
          @click="desktopSidebarCollapsed = !desktopSidebarCollapsed"
        >
          <Icon
            :icon="desktopSidebarCollapsed ? 'lucide:panel-left-open' : 'lucide:panel-left-close'"
            class="h-5 w-5"
          />
        </button>
      </div>

      <!-- Search -->
      <div class="relative border-b border-white/10 p-3">
        <button
          type="button"
          class="flex w-full items-center gap-2 rounded-2xl border border-white/10 bg-white/[0.06] px-3 py-2.5 text-sm font-bold text-white/55 transition hover:border-blue-500/40 hover:bg-blue-600/10 hover:text-white"
          :class="desktopSidebarCollapsed ? 'justify-center px-2' : ''"
        >
          <Icon icon="lucide:search" class="h-[18px] w-[18px] shrink-0" />

          <span
            v-if="!desktopSidebarCollapsed"
            class="truncate"
          >
            Cari menu
          </span>

          <span
            v-if="!desktopSidebarCollapsed"
            class="ms-auto rounded-lg border border-white/10 bg-white/5 px-1.5 py-0.5 text-[10px] font-black text-white/35"
          >
            ⌘K
          </span>
        </button>
      </div>

      <!-- Desktop Menu -->
      <nav class="relative min-h-0 flex-1 overflow-y-auto p-3 scrollbar-thin-dark">
        <div
          v-for="group in sidebarGroups"
          :key="group.title"
          class="mb-5 last:mb-0"
        >
          <p
            v-if="!desktopSidebarCollapsed"
            class="mb-2 px-2 text-[10px] font-black uppercase tracking-[0.18em] text-white/35"
          >
            {{ group.title }}
          </p>

          <ul class="space-y-1">
            <li
              v-for="item in group.items"
              :key="item.href"
            >
              <button
                v-if="isProItem(item)"
                type="button"
                class="group flex w-full items-center gap-3 rounded-2xl px-3 py-2.5 text-left text-sm font-bold text-white/60 transition hover:bg-blue-600/15 hover:text-white"
                :class="desktopSidebarCollapsed ? 'justify-center px-2' : ''"
                @click="openProFeature(item)"
              >
                <span class="grid h-8 w-8 shrink-0 place-items-center rounded-xl bg-white/[0.06] text-white/55 transition group-hover:bg-blue-600 group-hover:text-white">
                  <Icon
                    :icon="item.icon"
                    class="h-[18px] w-[18px]"
                  />
                </span>

                <span
                  v-if="!desktopSidebarCollapsed"
                  class="truncate"
                >
                  {{ item.label }}
                </span>

                <span
                  v-if="!desktopSidebarCollapsed"
                  class="ms-auto rounded-full border border-blue-400/20 bg-blue-600/15 px-2 py-0.5 text-[10px] font-black text-blue-200"
                >
                  PRO
                </span>
              </button>

              <NuxtLink
                v-else
                :to="item.href"
                class="group flex items-center gap-3 rounded-2xl px-3 py-2.5 text-sm font-bold transition"
                :class="[
                  isActive(item.href)
                    ? 'bg-blue-600 text-white shadow-lg shadow-blue-950/30'
                    : 'text-white/60 hover:bg-white/[0.07] hover:text-white',
                  desktopSidebarCollapsed ? 'justify-center px-2' : ''
                ]"
              >
                <span
                  class="grid h-8 w-8 shrink-0 place-items-center rounded-xl transition"
                  :class="isActive(item.href)
                    ? 'bg-white/15 text-white'
                    : 'bg-white/[0.06] text-white/45 group-hover:bg-white/10 group-hover:text-white'"
                >
                  <Icon
                    :icon="item.icon"
                    class="h-[18px] w-[18px]"
                  />
                </span>

                <span
                  v-if="!desktopSidebarCollapsed"
                  class="truncate"
                >
                  {{ item.label }}
                </span>
              </NuxtLink>
            </li>
          </ul>
        </div>
      </nav>

      <!-- Desktop Footer User -->
      <div class="relative border-t border-white/10 p-3">
        <div
          class="rounded-3xl border border-white/10 bg-white/[0.06] p-3 shadow-inner shadow-white/5"
          :class="desktopSidebarCollapsed ? 'px-2' : ''"
        >
          <div
            class="flex items-center gap-3"
            :class="desktopSidebarCollapsed ? 'justify-center' : ''"
          >
            <img
              :src="displayUser.avatar"
              :alt="displayUser.name"
              class="h-10 w-10 shrink-0 rounded-2xl object-cover ring-1 ring-white/10"
            >

            <div
              v-if="!desktopSidebarCollapsed"
              class="min-w-0 flex-1"
            >
              <p class="truncate text-sm font-black text-white">
                {{ displayUser.name }}
              </p>
              <p class="truncate text-xs font-semibold text-white/40">
                {{ displayUser.email }}
              </p>
            </div>
          </div>

          <button
            v-if="!desktopSidebarCollapsed"
            type="button"
            class="mt-3 inline-flex w-full items-center justify-center gap-2 rounded-2xl border border-white/10 bg-white/[0.06] px-3 py-2 text-xs font-black text-white/60 transition hover:border-red-400/30 hover:bg-red-500/10 hover:text-red-100"
            @click="openLogoutModal"
          >
            <Icon icon="lucide:log-out" class="h-4 w-4" />
            Logout
          </button>
        </div>
      </div>
    </aside>

    <!-- Top Header -->
    <header
      class="fixed inset-x-0 top-0 z-40 border-b border-neutral-200/80 bg-white/85 backdrop-blur-xl transition-all duration-300"
      :class="desktopSidebarCollapsed ? 'lg:ps-20' : 'lg:ps-72'"
    >
      <div class="flex h-16 items-center gap-3 px-4 sm:px-6">
        <!-- Mobile Brand -->
        <NuxtLink
          to="/app"
          class="flex min-w-0 items-center gap-3 lg:hidden"
        >
          <div class="grid h-10 w-10 shrink-0 place-items-center overflow-hidden rounded-2xl border border-neutral-200 bg-white text-blue-600 shadow-sm">
            <img
              v-if="appLogo && !logoError"
              :src="appLogo"
              :alt="appName"
              class="h-8 w-8 rounded-xl object-contain"
              @error="logoError = true"
            >
            <Icon
              v-else
              icon="lucide:blocks"
              class="h-6 w-6"
            />
          </div>

          <div class="min-w-0">
            <p class="truncate text-sm font-black text-neutral-950">
              {{ appName }}
            </p>
            <p class="truncate text-xs font-semibold text-neutral-500">
              {{ currentPageTitle }}
            </p>
          </div>
        </NuxtLink>

        <!-- Desktop Title -->
        <div class="hidden min-w-0 lg:block">
          <p class="text-[10px] font-black uppercase tracking-[0.18em] text-blue-600">
            Workspace
          </p>
          <h1 class="truncate text-lg font-black tracking-tight text-neutral-950">
            {{ currentPageTitle }}
          </h1>
        </div>

        <div class="ms-auto flex items-center gap-2">
          <button
            type="button"
            class="hidden items-center gap-2 rounded-2xl border border-neutral-200 bg-white px-3 py-2 text-sm font-bold text-neutral-600 shadow-sm transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700 sm:inline-flex"
          >
            <Icon icon="lucide:search" class="h-[18px] w-[18px]" />
            <span class="hidden md:inline">Cari</span>
          </button>

          <button
            type="button"
            class="relative grid h-10 w-10 place-items-center rounded-2xl border border-neutral-200 bg-white text-neutral-600 shadow-sm transition hover:border-blue-200 hover:bg-blue-50 hover:text-blue-700"
            @click="rightOpen = true"
          >
            <Icon icon="lucide:bell" class="h-5 w-5" />
            <span class="absolute right-2.5 top-2.5 h-2 w-2 rounded-full bg-blue-600 ring-2 ring-white"></span>
          </button>

          <!-- Account Dropdown -->
          <div class="relative">
            <button
              type="button"
              class="flex items-center gap-2 rounded-2xl border border-neutral-200 bg-white p-1.5 pe-3 shadow-sm transition hover:border-blue-200 hover:bg-blue-50"
              @click="accountOpen = !accountOpen"
            >
              <img
                :src="displayUser.avatar"
                :alt="displayUser.name"
                class="h-8 w-8 rounded-xl object-cover"
              >

              <span class="hidden max-w-28 truncate text-sm font-black text-neutral-700 sm:inline">
                {{ displayUser.name }}
              </span>

              <Icon
                icon="lucide:chevron-down"
                class="hidden h-4 w-4 text-neutral-400 sm:block"
              />
            </button>

            <Transition
              enter-active-class="transition duration-150 ease-out"
              enter-from-class="translate-y-1 opacity-0"
              enter-to-class="translate-y-0 opacity-100"
              leave-active-class="transition duration-100 ease-in"
              leave-from-class="translate-y-0 opacity-100"
              leave-to-class="translate-y-1 opacity-0"
            >
              <div
                v-if="accountOpen"
                class="absolute right-0 top-12 z-50 w-72 overflow-hidden rounded-3xl border border-neutral-200 bg-white shadow-[0_24px_80px_rgba(15,23,42,0.14)]"
              >
                <div class="bg-gradient-to-br from-blue-50 via-white to-white p-4">
                  <div class="flex items-center gap-3">
                    <img
                      :src="displayUser.avatar"
                      :alt="displayUser.name"
                      class="h-12 w-12 rounded-2xl object-cover ring-1 ring-neutral-200"
                    >

                    <div class="min-w-0">
                      <p class="truncate text-sm font-black text-neutral-950">
                        {{ displayUser.name }}
                      </p>
                      <p class="truncate text-xs font-semibold text-neutral-500">
                        {{ displayUser.email }}
                      </p>
                    </div>
                  </div>
                </div>

                <div class="border-t border-neutral-100 p-2">
                  <NuxtLink
                    v-for="item in accountLinks"
                    :key="item.href"
                    :to="item.href"
                    class="flex items-center gap-3 rounded-2xl px-3 py-2.5 text-sm font-bold text-neutral-600 transition hover:bg-blue-50 hover:text-blue-700"
                    @click="accountOpen = false"
                  >
                    <Icon :icon="item.icon" class="h-5 w-5 text-blue-600" />
                    {{ item.label }}
                  </NuxtLink>

                  <button
                    type="button"
                    class="flex w-full items-center gap-3 rounded-2xl px-3 py-2.5 text-sm font-bold text-red-600 transition hover:bg-red-50"
                    @click="openLogoutModal"
                  >
                    <Icon icon="lucide:log-out" class="h-5 w-5" />
                    Logout
                  </button>
                </div>
              </div>
            </Transition>
          </div>
        </div>
      </div>
    </header>

    <!-- Page Content -->
    <main
      class="min-h-dvh pt-16 transition-all duration-300 lg:pb-0"
      :class="[
        desktopSidebarCollapsed ? 'lg:ps-20' : 'lg:ps-72',
        'pb-24'
      ]"
    >
      <div class="p-3 sm:p-4 lg:p-5">
        <div class="min-h-[calc(100dvh-5.75rem)] overflow-hidden rounded-[1.75rem] border border-neutral-200 bg-white shadow-sm ring-1 ring-white">
          <div class="min-h-[calc(100dvh-5.75rem)]">
            <slot />
          </div>
        </div>
      </div>
    </main>

    <!-- Notification Panel -->
    <Transition
      enter-active-class="transition duration-300 ease-out"
      enter-from-class="translate-x-full opacity-0"
      enter-to-class="translate-x-0 opacity-100"
      leave-active-class="transition duration-200 ease-in"
      leave-from-class="translate-x-0 opacity-100"
      leave-to-class="translate-x-full opacity-0"
    >
      <div
        v-if="rightOpen"
        class="fixed inset-0 z-[80]"
      >
        <div
          class="absolute inset-0 bg-neutral-950/50 backdrop-blur-[3px]"
          @click="rightOpen = false"
        ></div>

        <aside class="absolute inset-y-0 right-0 flex w-full max-w-sm flex-col border-l border-neutral-200 bg-white shadow-2xl">
          <div class="flex h-16 items-center justify-between border-b border-neutral-200 px-4">
            <div>
              <p class="text-sm font-black text-neutral-950">
                Notifikasi
              </p>
              <p class="text-xs font-semibold text-neutral-500">
                Aktivitas terbaru dashboard
              </p>
            </div>

            <button
              type="button"
              class="grid h-10 w-10 place-items-center rounded-2xl text-neutral-500 transition hover:bg-neutral-100 hover:text-neutral-950"
              @click="rightOpen = false"
            >
              <Icon icon="lucide:x" class="h-5 w-5" />
            </button>
          </div>

          <div class="grid flex-1 place-items-center p-6 text-center">
            <div>
              <div class="mx-auto grid h-14 w-14 place-items-center rounded-3xl bg-blue-50 text-blue-600">
                <Icon icon="lucide:bell-ring" class="h-7 w-7" />
              </div>
              <p class="mt-4 text-sm font-black text-neutral-950">
                Belum ada notifikasi baru
              </p>
              <p class="mt-1 text-sm font-medium leading-6 text-neutral-500">
                Aktivitas penting akan muncul di sini.
              </p>
            </div>
          </div>
        </aside>
      </div>
    </Transition>

    <!-- Mobile Bottom Dock -->
    <nav
      class="fixed inset-x-0 bottom-0 z-50 border-t border-white/10 bg-neutral-950/95 px-3 pb-[max(0.75rem,env(safe-area-inset-bottom))] pt-2 shadow-[0_-16px_50px_rgba(15,23,42,0.28)] backdrop-blur-xl lg:hidden"
      @touchstart.passive="onDockTouchStart"
      @touchend.passive="onDockTouchEnd"
    >
      <div class="mx-auto mb-2 h-1.5 w-12 rounded-full bg-white/15"></div>

      <div class="mx-auto grid max-w-md grid-cols-5 gap-1">
        <template
          v-for="item in mobileDockItems"
          :key="item.href"
        >
          <button
            v-if="isProItem(item)"
            type="button"
            class="relative flex flex-col items-center justify-center gap-1 rounded-2xl px-2 py-2 text-[11px] font-black text-white/55 transition hover:bg-blue-600/15 hover:text-white"
            @click="openProFeature(item)"
          >
            <Icon :icon="item.icon" class="h-5 w-5" />
            <span class="truncate">
              {{ item.label }}
            </span>
            <span class="absolute right-1.5 top-1.5 rounded-full bg-blue-600 px-1.5 py-0.5 text-[8px] leading-none text-white">
              PRO
            </span>
          </button>

          <NuxtLink
            v-else
            :to="item.href"
            class="flex flex-col items-center justify-center gap-1 rounded-2xl px-2 py-2 text-[11px] font-black transition"
            :class="isActive(item.href)
              ? 'bg-blue-600 text-white shadow-lg shadow-blue-950/25'
              : 'text-white/55 hover:bg-white/10 hover:text-white'"
          >
            <Icon :icon="item.icon" class="h-5 w-5" />
            <span class="truncate">
              {{ item.label }}
            </span>
          </NuxtLink>
        </template>

        <button
          type="button"
          class="flex flex-col items-center justify-center gap-1 rounded-2xl px-2 py-2 text-[11px] font-black text-white/55 transition hover:bg-white/10 hover:text-white"
          @click="openMobileMenu"
        >
          <Icon icon="lucide:menu" class="h-5 w-5" />
          <span>Menu</span>
        </button>
      </div>
    </nav>

    <!-- Mobile Menu Bottom Sheet -->
    <Transition
      enter-active-class="transition duration-300 ease-out"
      enter-from-class="translate-y-full opacity-0"
      enter-to-class="translate-y-0 opacity-100"
      leave-active-class="transition duration-200 ease-in"
      leave-from-class="translate-y-0 opacity-100"
      leave-to-class="translate-y-full opacity-0"
    >
      <div
        v-if="mobileMenuOpen"
        class="fixed inset-0 z-[90] lg:hidden"
      >
        <div
          class="absolute inset-0 bg-neutral-950/60 backdrop-blur-[3px]"
          @click="closeMobileMenu"
        ></div>

        <section
          class="absolute inset-x-0 bottom-0 max-h-[88dvh] overflow-hidden rounded-t-[2rem] border-t border-white/10 bg-neutral-950 text-white shadow-[0_-24px_80px_rgba(15,23,42,0.35)]"
          :style="mobileSheetStyle"
          @touchstart.passive="onSheetTouchStart"
          @touchmove.passive="onSheetTouchMove"
          @touchend.passive="onSheetTouchEnd"
        >
          <div class="pointer-events-none absolute inset-0 overflow-hidden">
            <div class="absolute -left-20 top-0 h-56 w-56 rounded-full bg-blue-600/20 blur-3xl"></div>
            <div class="absolute bottom-0 right-0 h-52 w-52 rounded-full bg-sky-500/10 blur-3xl"></div>
            <div class="absolute inset-0 bg-sidebar-grid opacity-[0.12]"></div>
          </div>

          <div class="sticky top-0 z-10 border-b border-white/10 bg-neutral-950/90 px-4 pb-3 pt-3 backdrop-blur-xl">
            <div class="mx-auto mb-3 h-1.5 w-14 rounded-full bg-white/15"></div>

            <div class="flex items-center justify-between gap-3">
              <div class="flex min-w-0 items-center gap-3">
                <div class="grid h-11 w-11 shrink-0 place-items-center overflow-hidden rounded-2xl border border-white/10 bg-white text-blue-600">
                  <img
                    v-if="appLogo && !logoError"
                    :src="appLogo"
                    :alt="appName"
                    class="h-8 w-8 rounded-xl object-contain"
                    @error="logoError = true"
                  >
                  <Icon
                    v-else
                    icon="lucide:blocks"
                    class="h-6 w-6"
                  />
                </div>

                <div class="min-w-0">
                  <p class="truncate text-sm font-black text-white">
                    {{ appName }}
                  </p>
                  <p class="truncate text-xs font-semibold text-white/45">
                    Swipe down untuk menutup
                  </p>
                </div>
              </div>

              <button
                type="button"
                class="grid h-10 w-10 place-items-center rounded-2xl border border-white/10 bg-white/[0.06] text-white/60 transition hover:bg-white/10 hover:text-white"
                @click="closeMobileMenu"
              >
                <Icon icon="lucide:x" class="h-5 w-5" />
              </button>
            </div>
          </div>

          <div class="relative max-h-[calc(88dvh-5.5rem)] overflow-y-auto px-4 pb-[calc(1rem+env(safe-area-inset-bottom))] pt-4 scrollbar-thin-dark">
            <div class="mb-4 rounded-3xl border border-white/10 bg-white/[0.06] p-4">
              <div class="flex items-center gap-3">
                <img
                  :src="displayUser.avatar"
                  :alt="displayUser.name"
                  class="h-12 w-12 rounded-2xl object-cover ring-1 ring-white/10"
                >

                <div class="min-w-0">
                  <p class="truncate text-sm font-black text-white">
                    {{ displayUser.name }}
                  </p>
                  <p class="truncate text-xs font-semibold text-white/40">
                    {{ displayUser.email }}
                  </p>
                </div>
              </div>
            </div>

            <div
              v-for="group in sidebarGroups"
              :key="group.title"
              class="mb-5 last:mb-0"
            >
              <p class="mb-2 px-1 text-[10px] font-black uppercase tracking-[0.18em] text-white/35">
                {{ group.title }}
              </p>

              <div class="grid grid-cols-2 gap-2">
                <template
                  v-for="item in group.items"
                  :key="item.href"
                >
                  <button
                    v-if="isProItem(item)"
                    type="button"
                    class="group rounded-3xl border border-white/10 bg-white/[0.06] p-4 text-left transition hover:border-blue-500/30 hover:bg-blue-600/15"
                    @click="openProFeature(item)"
                  >
                    <div class="flex items-start justify-between gap-2">
                      <div class="grid h-11 w-11 place-items-center rounded-2xl bg-white/10 text-white/65 transition group-hover:bg-blue-600 group-hover:text-white">
                        <Icon :icon="item.icon" class="h-5 w-5" />
                      </div>

                      <span class="rounded-full border border-blue-300/20 bg-blue-600/20 px-2 py-1 text-[10px] font-black text-blue-100">
                        PRO
                      </span>
                    </div>

                    <p class="mt-3 truncate text-sm font-black text-white">
                      {{ item.label }}
                    </p>
                    <p class="mt-1 line-clamp-2 text-xs font-semibold leading-5 text-white/40">
                      {{ item.description || 'Buka menu dashboard' }}
                    </p>
                  </button>

                  <NuxtLink
                    v-else
                    :to="item.href"
                    class="group rounded-3xl border p-4 transition"
                    :class="isActive(item.href)
                      ? 'border-blue-500 bg-blue-600 text-white shadow-lg shadow-blue-950/25'
                      : 'border-white/10 bg-white/[0.06] text-white/70 hover:border-white/15 hover:bg-white/10 hover:text-white'"
                    @click="closeMobileMenu"
                  >
                    <div
                      class="grid h-11 w-11 place-items-center rounded-2xl transition"
                      :class="isActive(item.href)
                        ? 'bg-white/15 text-white'
                        : 'bg-white/10 text-white/50 group-hover:text-white'"
                    >
                      <Icon :icon="item.icon" class="h-5 w-5" />
                    </div>

                    <p class="mt-3 truncate text-sm font-black">
                      {{ item.label }}
                    </p>
                    <p
                      class="mt-1 line-clamp-2 text-xs font-semibold leading-5"
                      :class="isActive(item.href) ? 'text-white/70' : 'text-white/35'"
                    >
                      {{ item.description || 'Buka menu dashboard' }}
                    </p>
                  </NuxtLink>
                </template>
              </div>
            </div>

            <button
              type="button"
              class="mt-2 flex w-full items-center justify-center gap-2 rounded-3xl border border-red-400/20 bg-red-500/10 px-4 py-3 text-sm font-black text-red-100 transition hover:bg-red-500/15"
              @click="openLogoutModal"
            >
              <Icon icon="lucide:log-out" class="h-5 w-5" />
              Logout
            </button>
          </div>
        </section>
      </div>
    </Transition>

    <!-- Logout Confirmation Modal -->
    <Transition
      enter-active-class="transition duration-200 ease-out"
      enter-from-class="opacity-0"
      enter-to-class="opacity-100"
      leave-active-class="transition duration-150 ease-in"
      leave-from-class="opacity-100"
      leave-to-class="opacity-0"
    >
      <div
        v-if="logoutModalOpen"
        class="fixed inset-0 z-[110] grid place-items-center bg-neutral-950/55 p-4 backdrop-blur-sm"
        role="dialog"
        aria-modal="true"
        aria-label="Konfirmasi keluar akun"
        @click.self="closeLogoutModal"
      >
        <Transition
          enter-active-class="transition duration-200 ease-out"
          enter-from-class="translate-y-4 scale-95 opacity-0"
          enter-to-class="translate-y-0 scale-100 opacity-100"
          leave-active-class="transition duration-150 ease-in"
          leave-from-class="translate-y-0 scale-100 opacity-100"
          leave-to-class="translate-y-4 scale-95 opacity-0"
        >
          <section class="relative w-full max-w-[28rem] overflow-hidden rounded-[2rem] border border-neutral-200 bg-white p-5 text-neutral-950 shadow-[0_32px_110px_rgba(15,23,42,0.26)]">
            <div class="pointer-events-none absolute inset-0 overflow-hidden">
              <div class="absolute -right-20 -top-20 h-56 w-56 rounded-full bg-blue-100 blur-3xl"></div>
              <div class="absolute -bottom-24 -left-16 h-56 w-56 rounded-full bg-red-100/80 blur-3xl"></div>
              <div class="absolute inset-0 bg-modal-grid opacity-[0.45]"></div>
            </div>

            <div class="relative">
              <div class="flex items-start justify-between gap-4">
                <div class="flex items-center gap-3">
                  <div class="grid h-14 w-14 shrink-0 place-items-center overflow-hidden rounded-3xl border border-neutral-200 bg-white shadow-sm">
                    <img
                      :src="displayUser.avatar"
                      :alt="displayUser.name"
                      class="h-full w-full object-cover"
                    >
                  </div>

                  <div class="min-w-0">
                    <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">
                      Konfirmasi Akun
                    </p>
                    <h2 class="mt-1 text-xl font-black tracking-tight text-neutral-950">
                      Keluar dari dashboard?
                    </h2>
                  </div>
                </div>

                <button
                  type="button"
                  class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl border border-neutral-200 bg-white text-neutral-400 transition hover:bg-neutral-50 hover:text-neutral-700 disabled:cursor-not-allowed disabled:opacity-50"
                  :disabled="isLoggingOut"
                  aria-label="Tutup modal keluar"
                  @click="closeLogoutModal"
                >
                  <Icon icon="lucide:x" class="h-5 w-5" />
                </button>
              </div>

              <div class="mt-5 rounded-3xl border border-neutral-200 bg-neutral-50/80 p-4">
                <div class="flex items-center gap-3">
                  <div class="grid h-11 w-11 shrink-0 place-items-center rounded-2xl bg-blue-600 text-white shadow-lg shadow-blue-600/20">
                    <Icon icon="lucide:shield-check" class="h-5 w-5" />
                  </div>
                  <div class="min-w-0">
                    <p class="truncate text-sm font-black text-neutral-950">
                      {{ displayUser.name }}
                    </p>
                    <p class="truncate text-xs font-semibold text-neutral-500">
                      {{ displayUser.email }}
                    </p>
                  </div>
                </div>

                <p class="mt-4 text-sm font-semibold leading-6 text-neutral-500">
                  Sesi dashboard akan ditutup dari perangkat ini. Pastikan perubahan terakhir sudah tersimpan sebelum keluar.
                </p>
              </div>

              <div class="mt-5 grid gap-2 sm:grid-cols-2">
                <button
                  type="button"
                  class="inline-flex h-12 items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-black text-neutral-700 transition hover:-translate-y-0.5 hover:bg-neutral-50 disabled:cursor-not-allowed disabled:translate-y-0 disabled:opacity-50"
                  :disabled="isLoggingOut"
                  @click="closeLogoutModal"
                >
                  Tetap di sini
                </button>

                <button
                  type="button"
                  class="inline-flex h-12 items-center justify-center gap-2 rounded-2xl bg-red-600 px-4 text-sm font-black text-white shadow-lg shadow-red-600/20 transition hover:-translate-y-0.5 hover:bg-red-700 disabled:cursor-wait disabled:translate-y-0 disabled:opacity-80"
                  :disabled="isLoggingOut"
                  @click="confirmLogout"
                >
                  <Icon
                    :icon="isLoggingOut ? 'lucide:loader-circle' : 'lucide:log-out'"
                    class="h-4 w-4"
                    :class="isLoggingOut ? 'animate-spin' : ''"
                  />
                  {{ isLoggingOut ? 'Memproses...' : 'Ya, keluar' }}
                </button>
              </div>
            </div>
          </section>
        </Transition>
      </div>
    </Transition>

    <!-- Pro Feature View -->
    <Transition
      enter-active-class="transition duration-200 ease-out"
      enter-from-class="opacity-0"
      enter-to-class="opacity-100"
      leave-active-class="transition duration-150 ease-in"
      leave-from-class="opacity-100"
      leave-to-class="opacity-0"
    >
      <div
        v-if="proModalOpen"
        class="fixed inset-0 z-[100] grid place-items-center bg-neutral-950/65 p-4 backdrop-blur-sm"
        @click.self="closeProFeature"
      >
        <Transition
          enter-active-class="transition duration-200 ease-out"
          enter-from-class="translate-y-3 scale-95 opacity-0"
          enter-to-class="translate-y-0 scale-100 opacity-100"
          leave-active-class="transition duration-150 ease-in"
          leave-from-class="translate-y-0 scale-100 opacity-100"
          leave-to-class="translate-y-3 scale-95 opacity-0"
        >
          <section class="relative w-full max-w-md overflow-hidden rounded-[2rem] border border-white/10 bg-neutral-950 p-5 text-white shadow-[0_30px_100px_rgba(15,23,42,0.45)]">
            <div class="pointer-events-none absolute inset-0 overflow-hidden">
              <div class="absolute -right-14 -top-16 h-44 w-44 rounded-full bg-blue-600/30 blur-3xl"></div>
              <div class="absolute -bottom-14 -left-12 h-44 w-44 rounded-full bg-sky-400/10 blur-3xl"></div>
              <div class="absolute inset-0 bg-sidebar-grid opacity-[0.14]"></div>
            </div>

            <div class="relative">
              <div class="flex items-start justify-between gap-4">
                <div class="grid h-14 w-14 place-items-center rounded-3xl bg-blue-600 text-white shadow-xl shadow-blue-950/30">
                  <Icon :icon="selectedProFeature?.icon || 'lucide:sparkles'" class="h-7 w-7" />
                </div>

                <button
                  type="button"
                  class="grid h-10 w-10 place-items-center rounded-2xl border border-white/10 bg-white/[0.06] text-white/60 transition hover:bg-white/10 hover:text-white"
                  @click="closeProFeature"
                >
                  <Icon icon="lucide:x" class="h-5 w-5" />
                </button>
              </div>

              <div class="mt-5">
                <span class="inline-flex rounded-full border border-blue-300/20 bg-blue-600/15 px-3 py-1 text-[10px] font-black uppercase tracking-[0.16em] text-blue-100">
                  Paket Pro
                </span>

                <h2 class="mt-3 text-2xl font-black tracking-tight text-white">
                  Ini fitur Pro, tingkatkan paket Anda
                </h2>

                <p class="mt-3 text-sm font-medium leading-7 text-white/60">
                  {{ selectedProFeature?.label || 'Fitur ini' }} tersedia untuk paket lanjutan. Tingkatkan paket agar bisa memakai fitur ini bersama seluruh kemampuan premium lainnya.
                </p>
              </div>

              <div class="mt-5 rounded-3xl border border-white/10 bg-white/[0.06] p-4">
                <p class="text-xs font-black uppercase tracking-[0.16em] text-white/35">
                  Fitur yang akan dibuka
                </p>
                <div class="mt-3 flex items-center gap-3">
                  <div class="grid h-10 w-10 place-items-center rounded-2xl bg-blue-600/20 text-blue-100">
                    <Icon :icon="selectedProFeature?.icon || 'lucide:sparkles'" class="h-5 w-5" />
                  </div>
                  <div class="min-w-0">
                    <p class="truncate text-sm font-black text-white">
                      {{ selectedProFeature?.label || 'Fitur Pro' }}
                    </p>
                    <p class="truncate text-xs font-semibold text-white/40">
                      {{ selectedProFeature?.description || 'Fitur lanjutan untuk operasional desa.' }}
                    </p>
                  </div>
                </div>
              </div>

              <div class="mt-5 grid gap-2 sm:grid-cols-2">
                <a
                  :href="upgradeHref"
                  class="inline-flex items-center justify-center gap-2 rounded-2xl bg-blue-600 px-4 py-3 text-sm font-black text-white shadow-lg shadow-blue-950/30 transition hover:-translate-y-0.5 hover:bg-blue-700"
                >
                  Tingkatkan Paket
                  <Icon icon="lucide:arrow-up-right" class="h-4 w-4" />
                </a>

                <button
                  type="button"
                  class="inline-flex items-center justify-center gap-2 rounded-2xl border border-white/10 bg-white/[0.06] px-4 py-3 text-sm font-black text-white/70 transition hover:-translate-y-0.5 hover:bg-white/10 hover:text-white"
                  @click="closeProFeature"
                >
                  Nanti Saja
                </button>
              </div>
            </div>
          </section>
        </Transition>
      </div>
    </Transition>
  </div>
</template>

<script setup lang="ts">
import { Icon } from '@iconify/vue'
import { computed, onBeforeUnmount, onMounted, ref, watch } from 'vue'
import {
  navigateTo,
  useHead,
  useRoute,
  useRuntimeConfig,
  useSeoMeta
} from 'nuxt/app'
import { useAuth } from '../composables/data/useAuth'

type SidebarItem = {
  label: string
  href: string
  icon: string
  badge?: string
  description?: string
  pro?: boolean
}

type SidebarGroup = {
  title: string
  items: SidebarItem[]
}

const route = useRoute()
const config = useRuntimeConfig()

const {
  user: authUser,
  fetchMe,
  logout
} = useAuth()

const rightOpen = ref(false)
const accountOpen = ref(false)
const mobileMenuOpen = ref(false)
const proModalOpen = ref(false)
const logoutModalOpen = ref(false)
const isLoggingOut = ref(false)
const selectedProFeature = ref<SidebarItem | null>(null)
const desktopSidebarCollapsed = ref(false)
const logoError = ref(false)

const dockTouchStartY = ref(0)
const sheetTouchStartY = ref(0)
const sheetDragY = ref(0)

const appName = computed(() => {
  return String(
    config.public.appName ||
    config.public.siteName ||
    config.public.clientDisplayName ||
    'Obayan'
  )
})

const appSubtitle = computed(() => {
  return String(
    config.public.appSubtitle ||
    config.public.clientName ||
    'Dashboard'
  )
})

const appLogo = computed(() => {
  return normalizeAssetUrl(
    String(
      config.public.appLogo ||
      config.public.logo ||
      '/logo.png'
    )
  )
})

const siteUrl = computed(() => {
  return String(config.public.siteUrl || 'https://obayan.id').replace(/\/$/, '')
})

const pageUrl = computed(() => {
  return `${siteUrl.value}${route.fullPath || '/app'}`
})

const upgradeHref = computed(() => {
  return String(config.public.upgradeUrl || config.public.billingUrl || '/app/profile')
})

const currentPageTitle = computed(() => {
  const allItems = sidebarGroups.value.flatMap((group) => group.items)
  const found = allItems.find((item) => !isProItem(item) && isActive(item.href))

  return found?.label || 'Dashboard'
})

const displayUser = computed(() => {
  const current = authUser.value as any

  return {
    name:
      current?.name ||
      current?.fullName ||
      current?.email?.split('@')?.[0] ||
      'Admin',
    email:
      current?.email ||
      'admin@obayan.id',
    avatar:
      current?.avatar ||
      current?.avatarUrl ||
      current?.photoUrl ||
      '/assets/pp.jpg'
  }
})

const accountLinks = [
  {
    label: 'Profil Akun',
    icon: 'lucide:user-round',
    href: '/app/profile'
  }
]

const sidebarGroups = ref<SidebarGroup[]>([
  {
    title: 'Platform Desa',
    items: [
      {
        label: 'Dashboard',
        href: '/app',
        icon: 'lucide:layout-dashboard',
        description: 'Ringkasan workspace dan aktivitas terbaru.'
      },
      {
        label: 'Berita',
        href: '/app/news',
        icon: 'lucide:newspaper',
        description: 'Kelola berita, informasi publik, agenda, dan pengumuman.'
      },
      {
        label: 'Organisasi',
        href: '/app/organizations',
        icon: 'lucide:users-round',
        description: 'Kelola organisasi, komunitas, dan kelompok masyarakat.'
      },
      {
        label: 'Fasilitas',
        href: '/app/facilities',
        icon: 'lucide:building-2',
        description: 'Kelola fasilitas umum, layanan, lokasi, dan kontak.'
      },
      {
        label: 'Pengaduan',
        href: '/app/complaints',
        icon: 'lucide:message-square-warning',
        description: 'Pantau aduan, laporan, dan pengajuan warga.'
      },
      {
        label: 'Potensi',
        href: '/app/potentials',
        icon: 'lucide:sprout',
        description: 'Kelola potensi desa, produk unggulan, wisata, dan UMKM.'
      },
      {
        label: 'Lembaga',
        href: '/app/institutions',
        icon: 'lucide:landmark',
        description: 'Kelola lembaga, struktur, profil, dan informasi publik.'
      },
      {
        label: 'Struktur Organisasi',
        href: '/app/structure',
        icon: 'bi:diagram-2-fill',
        description: 'Kelola lembaga, struktur, profil, dan informasi publik.'
      },
      {
        label: 'Keuangan',
        href: '/app/#finance',
        icon: 'lucide:wallet-cards',
        badge: 'PRO',
        pro: true,
        description: 'Kelola APBDes, pemasukan, pengeluaran, dan laporan.'
      },
      {
        label: 'Dokumen Letter C',
        href: '/app/#letter-c',
        icon: 'lucide:folder-key',
        badge: 'PRO',
        pro: true,
        description: 'Manajemen arsip tanah dan dokumen pertanahan.'
      },
      {
        label: 'Pengajuan Surat Online',
        href: '/app/#letters',
        icon: 'lucide:file-signature',
        badge: 'PRO',
        pro: true,
        description: 'Kelola pengajuan surat warga secara online.'
      }
    ]
  },
  {
    title: 'Pengaturan',
    items: [
      {
        label: 'Profil Desa',
        href: '/app/profile',
        icon: 'lucide:id-card',
        description: 'Kelola identitas, logo, alamat, dan kontak desa.'
      }
    ]
  }
])

const mobileDockItems = computed<SidebarItem[]>(() => {
  return [
    {
      label: 'Home',
      href: '/app',
      icon: 'lucide:layout-dashboard'
    },
    {
      label: 'Berita',
      href: '/app/news',
      icon: 'lucide:newspaper'
    },
    {
      label: 'Aduan',
      href: '/app/complaints',
      icon: 'lucide:message-square-warning',
      description: 'Pantau aduan dan laporan warga.'
    },
    {
      label: 'Surat',
      href: '/app/#letters',
      icon: 'lucide:file-signature',
      badge: 'PRO',
      pro: true,
      description: 'Kelola pengajuan surat warga secara online.'
    }
  ]
})

const mobileSheetStyle = computed(() => {
  return {
    transform: `translateY(${sheetDragY.value}px)`,
    transition: sheetDragY.value === 0 ? 'transform 180ms ease' : 'none'
  }
})

useSeoMeta({
  title: () => `${currentPageTitle.value} · ${appName.value}`,
  description: () => `Dashboard ${appName.value}`,
  ogTitle: () => `${currentPageTitle.value} · ${appName.value}`,
  ogDescription: () => `Dashboard ${appName.value}`,
  ogType: 'website',
  ogUrl: () => pageUrl.value,
  robots: 'noindex, nofollow',
  themeColor: '#2563eb'
})

useHead(() => ({
  htmlAttrs: {
    lang: 'id'
  },
  link: [
    {
      rel: 'canonical',
      href: pageUrl.value
    },
    {
      rel: 'icon',
      href: appLogo.value
    },
    {
      rel: 'apple-touch-icon',
      href: appLogo.value
    }
  ],
  meta: [
    {
      name: 'theme-color',
      content: '#2563eb'
    }
  ]
}))

function isProItem(item: SidebarItem) {
  return Boolean(item.pro || item.badge === 'PRO')
}

function isActive(href: string) {
  if (!href || href.includes('#')) return false

  if (href === '/app') {
    return route.path === '/app'
  }

  return route.path === href || route.path.startsWith(`${href}/`)
}

function openProFeature(item: SidebarItem) {
  selectedProFeature.value = item
  proModalOpen.value = true
  accountOpen.value = false
  rightOpen.value = false
  closeMobileMenu()
}

function closeProFeature() {
  proModalOpen.value = false
  selectedProFeature.value = null
}

function openMobileMenu() {
  sheetDragY.value = 0
  mobileMenuOpen.value = true
}

function closeMobileMenu() {
  sheetDragY.value = 0
  mobileMenuOpen.value = false
}

function onDockTouchStart(event: TouchEvent) {
  dockTouchStartY.value = event.changedTouches[0]?.clientY || 0
}

function onDockTouchEnd(event: TouchEvent) {
  const endY = event.changedTouches[0]?.clientY || 0
  const deltaY = endY - dockTouchStartY.value

  if (deltaY < -32) {
    openMobileMenu()
  }
}

function onSheetTouchStart(event: TouchEvent) {
  sheetTouchStartY.value = event.changedTouches[0]?.clientY || 0
}

function onSheetTouchMove(event: TouchEvent) {
  const currentY = event.changedTouches[0]?.clientY || 0
  const deltaY = currentY - sheetTouchStartY.value

  sheetDragY.value = Math.max(0, deltaY)
}

function onSheetTouchEnd() {
  if (sheetDragY.value > 90) {
    closeMobileMenu()
    return
  }

  sheetDragY.value = 0
}

function openLogoutModal() {
  accountOpen.value = false
  rightOpen.value = false
  closeMobileMenu()
  closeProFeature()
  logoutModalOpen.value = true
}

function closeLogoutModal() {
  if (isLoggingOut.value) return

  logoutModalOpen.value = false
}

async function confirmLogout() {
  if (isLoggingOut.value) return

  isLoggingOut.value = true

  try {
    await logout()
    logoutModalOpen.value = false
  } catch {
    await navigateTo('/login')
  } finally {
    isLoggingOut.value = false
  }
}

function normalizeAssetUrl(value: string) {
  const cleanValue = String(value || '').trim()

  if (!cleanValue) return '/logo.png'
  if (/^https?:\/\//i.test(cleanValue)) return cleanValue
  if (cleanValue.startsWith('/')) return cleanValue

  return `/${cleanValue}`
}

function lockDocumentScroll() {
  if (typeof document === 'undefined') return

  if (rightOpen.value || mobileMenuOpen.value || proModalOpen.value || logoutModalOpen.value) {
    document.documentElement.classList.add('overflow-hidden')
    document.body.classList.add('overflow-hidden')
  } else {
    document.documentElement.classList.remove('overflow-hidden')
    document.body.classList.remove('overflow-hidden')
  }
}

function handleEscape(event: KeyboardEvent) {
  if (event.key !== 'Escape') return

  rightOpen.value = false
  accountOpen.value = false
  closeMobileMenu()
  closeProFeature()
  closeLogoutModal()
}

watch(
  () => route.fullPath,
  () => {
    rightOpen.value = false
    accountOpen.value = false
    closeMobileMenu()
    closeLogoutModal()
  }
)

watch([rightOpen, mobileMenuOpen, proModalOpen, logoutModalOpen], lockDocumentScroll)

onMounted(async () => {
  try {
    await fetchMe()
  } catch {
    // layout tetap tampil walaupun data user gagal dimuat
  }

  lockDocumentScroll()
  window.addEventListener('keydown', handleEscape)
})

onBeforeUnmount(() => {
  window.removeEventListener('keydown', handleEscape)

  if (typeof document !== 'undefined') {
    document.documentElement.classList.remove('overflow-hidden')
    document.body.classList.remove('overflow-hidden')
  }
})
</script>

<style scoped>
.bg-modal-grid {
  background-size: 36px 36px;
  background-image:
    linear-gradient(to right, rgba(37, 99, 235, 0.08) 1px, transparent 1px),
    linear-gradient(to bottom, rgba(37, 99, 235, 0.08) 1px, transparent 1px);
}

.bg-sidebar-grid {
  background-size: 42px 42px;
  background-image:
    linear-gradient(to right, rgba(255, 255, 255, 0.12) 1px, transparent 1px),
    linear-gradient(to bottom, rgba(255, 255, 255, 0.12) 1px, transparent 1px);
}

.scrollbar-thin-dark {
  scrollbar-width: thin;
  scrollbar-color: rgba(255, 255, 255, 0.22) transparent;
}

.scrollbar-thin-dark::-webkit-scrollbar {
  width: 8px;
}

.scrollbar-thin-dark::-webkit-scrollbar-track {
  background: transparent;
}

.scrollbar-thin-dark::-webkit-scrollbar-thumb {
  background: rgba(255, 255, 255, 0.22);
  border-radius: 999px;
}

.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>
