<template>
  <main class="min-h-screen bg-neutral-50 text-neutral-950">
    <div class="pointer-events-none fixed inset-0 -z-10 overflow-hidden">
      <div class="absolute -left-32 top-0 h-80 w-80 rounded-full bg-blue-100/80 blur-3xl"></div>
      <div class="absolute right-0 top-24 h-96 w-96 rounded-full bg-sky-100/70 blur-3xl"></div>
      <div class="absolute bottom-0 left-1/2 h-72 w-72 -translate-x-1/2 rounded-full bg-indigo-100/60 blur-3xl"></div>
      <div class="absolute inset-0 bg-grid opacity-50"></div>
    </div>

    <section class="mx-auto max-w-7xl px-4 py-5 sm:px-6 lg:px-8">
      <!-- Header -->
      <div class="mb-5 overflow-hidden rounded-[2rem] border border-neutral-200 bg-white/90 shadow-sm shadow-neutral-900/5 backdrop-blur-xl">
        <div class="relative p-4 sm:p-5">
          <div class="absolute inset-x-0 top-0 h-24 bg-gradient-to-r from-blue-600 via-sky-500 to-blue-500 opacity-95"></div>
          <div class="absolute right-6 top-6 hidden h-24 w-24 rounded-full bg-white/20 blur-2xl sm:block"></div>

          <div class="relative flex flex-col gap-4 sm:flex-row sm:items-end sm:justify-between">
            <div class="flex min-w-0 items-end gap-4">
              <div class="grid h-20 w-20 shrink-0 place-items-center overflow-hidden rounded-[1.5rem] border border-white/70 bg-white p-2 shadow-xl shadow-blue-950/10 ring-4 ring-white/45 sm:h-24 sm:w-24">
                <img
                  v-if="siteLogo"
                  :src="siteLogo"
                  :alt="siteTitle"
                  class="h-full w-full object-contain"
                >
                <Icon
                  v-else
                  icon="solar:buildings-3-bold-duotone"
                  class="h-10 w-10 text-blue-600"
                />
              </div>

              <div class="min-w-0 pb-1">
                <div class="mb-2 inline-flex items-center gap-2 rounded-full border border-white/40 bg-white/85 px-3 py-1 text-[11px] font-black uppercase tracking-[0.14em] text-blue-700 shadow-sm backdrop-blur">
                  <Icon icon="solar:settings-bold-duotone" class="h-4 w-4" />
                  Profil Desa
                </div>

                <h1 class="truncate text-2xl font-black tracking-tight text-white drop-shadow-sm sm:text-3xl">
                  {{ siteTitle }}
                </h1>

                <p class="mt-1 max-w-2xl truncate text-sm font-semibold text-white/80">
                  Kelola identitas, tampilan, kontak, dan narasi utama website desa.
                </p>
              </div>
            </div>

            <div class="flex flex-wrap gap-2">
              <NuxtLink
                to="/"
                target="_blank"
                class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl border border-white/25 bg-white/15 px-4 text-sm font-black text-white shadow-sm backdrop-blur transition hover:-translate-y-0.5 hover:bg-white hover:text-neutral-950"
              >
                <Icon icon="solar:eye-bold-duotone" class="h-5 w-5" />
                Lihat Website
              </NuxtLink>

              <button
                type="button"
                class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-white px-4 text-sm font-black text-blue-700 shadow-lg shadow-blue-950/10 transition hover:-translate-y-0.5 hover:bg-blue-50"
                @click="openEditor"
              >
                <Icon icon="solar:pen-new-square-bold-duotone" class="h-5 w-5" />
                Edit Profil
              </button>
            </div>
          </div>
        </div>
      </div>

      <!-- Loading/Error -->
      <div
        v-if="pending"
        class="mb-5 rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm"
      >
        <div class="grid animate-pulse gap-4 md:grid-cols-[1fr_320px]">
          <div>
            <div class="h-5 w-44 rounded-full bg-neutral-100"></div>
            <div class="mt-4 h-9 w-2/3 rounded-2xl bg-neutral-100"></div>
            <div class="mt-3 h-4 w-full rounded-full bg-neutral-100"></div>
            <div class="mt-2 h-4 w-4/5 rounded-full bg-neutral-100"></div>
          </div>
          <div class="h-32 rounded-[1.5rem] bg-neutral-100"></div>
        </div>
      </div>

      <div
        v-if="visibleError"
        class="mb-5 rounded-[1.5rem] border border-red-200 bg-red-50 p-4 text-sm font-bold leading-6 text-red-700"
      >
        {{ visibleError }}
      </div>

      <!-- Overview -->
      <div class="grid gap-5 lg:grid-cols-[1fr_360px]">
        <section class="space-y-5">
          <article class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm shadow-neutral-900/5">
            <div class="flex flex-wrap items-start justify-between gap-4">
              <div>
                <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">
                  Identitas Website
                </p>
                <h2 class="mt-2 text-2xl font-black tracking-tight text-neutral-950">
                  {{ siteTitle }}
                </h2>
              </div>

              <span
                class="inline-flex items-center gap-2 rounded-full px-3 py-1.5 text-xs font-black"
                :class="siteStatus === 'active'
                  ? 'bg-blue-50 text-blue-700 ring-1 ring-blue-100'
                  : 'bg-neutral-100 text-neutral-600 ring-1 ring-neutral-200'"
              >
                <span class="h-2 w-2 rounded-full" :class="siteStatus === 'active' ? 'bg-blue-600' : 'bg-neutral-400'"></span>
                {{ siteStatusLabel }}
              </span>
            </div>

            <p class="mt-4 max-w-3xl text-sm font-medium leading-7 text-neutral-600">
              {{ siteDescription || 'Belum ada deskripsi singkat. Tambahkan narasi agar warga dan pengunjung lebih mudah memahami profil desa.' }}
            </p>

            <div class="mt-5 grid gap-3 sm:grid-cols-2">
              <InfoCard
                icon="solar:link-round-bold-duotone"
                label="Alamat Website"
                :value="safeDisplayUrl(siteUrl) || 'Belum diisi'"
              />
              <InfoCard
                icon="solar:map-point-bold-duotone"
                label="Wilayah / Slug"
                :value="tenantSlug"
              />
            </div>
          </article>

          <article class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm shadow-neutral-900/5">
            <div class="flex items-start justify-between gap-4">
              <div>
                <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">
                  Hero Website
                </p>
                <h2 class="mt-2 text-xl font-black tracking-tight text-neutral-950">
                  {{ heroTitle || 'Judul utama belum diatur' }}
                </h2>
              </div>

              <div class="grid h-11 w-11 shrink-0 place-items-center rounded-2xl bg-blue-50 text-blue-600">
                <Icon icon="solar:stars-bold-duotone" class="h-6 w-6" />
              </div>
            </div>

            <p class="mt-3 text-sm font-medium leading-7 text-neutral-600">
              {{ heroSubtitle || 'Atur teks sambutan, gambar utama, dan tombol ajakan pada halaman depan website.' }}
            </p>

            <div
              v-if="heroImage"
              class="mt-5 overflow-hidden rounded-[1.5rem] border border-neutral-200 bg-neutral-100"
            >
              <img
                :src="heroImage"
                :alt="heroTitle || siteTitle"
                class="h-64 w-full object-cover"
              >
            </div>
          </article>

          <article class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm shadow-neutral-900/5">
            <div class="mb-4 flex items-center justify-between gap-4">
              <div>
                <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">
                  Narasi Profil
                </p>
                <h2 class="mt-2 text-xl font-black tracking-tight text-neutral-950">
                  Tentang Desa
                </h2>
              </div>
            </div>

            <div
              v-if="aboutHtml"
              class="prose-preview"
              v-html="safeAboutHtml"
            ></div>

            <div
              v-else
              class="rounded-[1.5rem] border border-dashed border-neutral-300 bg-neutral-50 p-6 text-center"
            >
              <Icon icon="solar:document-text-bold-duotone" class="mx-auto h-9 w-9 text-neutral-400" />
              <p class="mt-3 text-sm font-bold text-neutral-500">
                Narasi profil belum diisi.
              </p>
            </div>
          </article>
        </section>

        <aside class="space-y-5">
          <article class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm shadow-neutral-900/5">
            <p class="text-sm font-black text-neutral-950">
              Kesiapan Profil
            </p>

            <div class="mt-4 space-y-2">
              <ReadinessRow
                v-for="item in readinessItems"
                :key="item.label"
                :done="item.done"
                :label="item.label"
                :description="item.description"
              />
            </div>
          </article>

          <article class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm shadow-neutral-900/5">
            <p class="text-sm font-black text-neutral-950">
              Kontak Desa
            </p>

            <div class="mt-4 space-y-3">
              <ContactRow
                icon="solar:phone-bold-duotone"
                label="Telepon"
                :value="contactPhone || 'Belum diisi'"
              />
              <ContactRow
                icon="solar:chat-round-call-bold-duotone"
                label="WhatsApp"
                :value="contactWhatsapp || 'Belum diisi'"
              />
              <ContactRow
                icon="solar:letter-bold-duotone"
                label="Email"
                :value="contactEmail || 'Belum diisi'"
              />
              <ContactRow
                icon="solar:map-point-bold-duotone"
                label="Alamat"
                :value="contactAddress || 'Belum diisi'"
              />
            </div>
          </article>

          <article class="rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-sm shadow-neutral-900/5">
            <p class="text-sm font-black text-neutral-950">
              Halaman Publik
            </p>

            <div class="mt-4 grid gap-2">
              <NuxtLink
                v-for="link in publicLinks"
                :key="link.href"
                :to="link.href"
                target="_blank"
                class="group flex items-center justify-between gap-3 rounded-2xl border border-neutral-200 bg-neutral-50 px-3 py-3 transition hover:-translate-y-0.5 hover:border-blue-200 hover:bg-blue-50"
              >
                <span class="inline-flex min-w-0 items-center gap-3">
                  <span class="grid h-9 w-9 shrink-0 place-items-center rounded-xl bg-white text-blue-600 shadow-sm">
                    <Icon :icon="link.icon" class="h-5 w-5" />
                  </span>
                  <span class="truncate text-sm font-black text-neutral-800">
                    {{ link.label }}
                  </span>
                </span>
                <Icon icon="solar:arrow-right-up-linear" class="h-4 w-4 text-neutral-400 transition group-hover:text-blue-600" />
              </NuxtLink>
            </div>
          </article>
        </aside>
      </div>
    </section>

    <!-- Stepper Modal -->
    <Teleport to="body">
      <transition name="modal-fade">
        <div
          v-if="isEditorOpen"
          class="fixed inset-0 z-[80] flex items-center justify-center bg-neutral-950/50 p-3 backdrop-blur-sm"
          @mousedown.self="requestCloseEditor"
        >
          <section class="flex max-h-[94vh] w-full max-w-6xl flex-col overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-2xl shadow-neutral-950/25">
            <header class="border-b border-neutral-200 bg-white px-4 py-4 sm:px-5">
              <div class="flex items-start justify-between gap-4">
                <div class="flex min-w-0 items-center gap-3">
                  <div class="grid h-12 w-12 shrink-0 place-items-center overflow-hidden rounded-2xl border border-neutral-200 bg-white p-1.5 shadow-sm">
                    <img
                      v-if="form.logoUrl"
                      :src="form.logoUrl"
                      :alt="form.displayName || form.name"
                      class="h-full w-full object-contain"
                    >
                    <Icon
                      v-else
                      icon="solar:buildings-3-bold-duotone"
                      class="h-7 w-7 text-blue-600"
                    />
                  </div>

                  <div class="min-w-0">
                    <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">
                      Pengaturan Profil
                    </p>
                    <h2 class="truncate text-lg font-black text-neutral-950">
                      {{ form.displayName || form.name || 'Profil Website Desa' }}
                    </h2>
                  </div>
                </div>

                <button
                  type="button"
                  class="grid h-10 w-10 place-items-center rounded-2xl border border-neutral-200 bg-white text-neutral-500 transition hover:bg-neutral-50 hover:text-neutral-950"
                  @click="requestCloseEditor"
                >
                  <Icon icon="solar:close-circle-bold-duotone" class="h-5 w-5" />
                </button>
              </div>

              <div class="mt-4 grid gap-2 sm:grid-cols-5">
                <button
                  v-for="(step, index) in steps"
                  :key="step.key"
                  type="button"
                  class="group rounded-2xl border px-3 py-3 text-left transition"
                  :class="activeStep === index
                    ? 'border-blue-200 bg-blue-50 text-blue-700 shadow-sm'
                    : index < activeStep
                      ? 'border-blue-100 bg-white text-blue-600'
                      : 'border-neutral-200 bg-neutral-50 text-neutral-500 hover:bg-white'"
                  @click="goStep(index)"
                >
                  <span class="flex items-center gap-2">
                    <span
                      class="grid h-7 w-7 place-items-center rounded-xl text-xs font-black"
                      :class="activeStep === index
                        ? 'bg-blue-600 text-white'
                        : index < activeStep
                          ? 'bg-blue-100 text-blue-700'
                          : 'bg-white text-neutral-500 ring-1 ring-neutral-200'"
                    >
                      <Icon
                        v-if="index < activeStep"
                        icon="solar:check-circle-bold-duotone"
                        class="h-4 w-4"
                      />
                      <span v-else>{{ index + 1 }}</span>
                    </span>
                    <span class="truncate text-xs font-black">
                      {{ step.label }}
                    </span>
                  </span>
                </button>
              </div>
            </header>

            <div class="min-h-0 flex-1 overflow-y-auto bg-neutral-50/70 px-4 py-5 sm:px-5">
              <!-- Step 1 -->
              <section v-show="activeStep === 0" class="grid gap-4 lg:grid-cols-[1fr_320px]">
                <div class="rounded-[1.75rem] border border-neutral-200 bg-white p-5 shadow-sm">
                  <SectionTitle
                    icon="solar:document-add-bold-duotone"
                    title="Identitas Dasar"
                    subtitle="Atur nama, alamat website, dan deskripsi singkat."
                  />

                  <div class="mt-5 grid gap-4 sm:grid-cols-2">
                    <Field label="Nama Website">
                      <input v-model.trim="form.name" type="text" class="input-field" placeholder="Contoh: Desa Martopuro">
                    </Field>

                    <Field label="Nama Tampilan">
                      <input v-model.trim="form.displayName" type="text" class="input-field" placeholder="Contoh: Website Desa Martopuro">
                    </Field>

                    <Field label="Kode Wilayah">
                      <input v-model.trim="form.slug" type="text" class="input-field" placeholder="martopuro">
                    </Field>

                    <Field label="Status Website">
                      <select v-model="form.status" class="input-field">
                        <option value="active">Aktif</option>
                        <option value="inactive">Tidak Aktif</option>
                      </select>
                    </Field>

                    <Field label="Alamat Domain">
                      <input v-model.trim="form.domain" type="text" class="input-field" placeholder="martopuro.desa.id">
                    </Field>

                    <Field label="Alamat Website">
                      <input v-model.trim="form.siteUrl" type="url" class="input-field" placeholder="https://martopuro.desa.id">
                    </Field>

                    <Field label="Deskripsi Singkat" class="sm:col-span-2">
                      <textarea
                        v-model.trim="form.description"
                        rows="4"
                        class="textarea-field"
                        placeholder="Tulis ringkasan singkat tentang desa..."
                      ></textarea>
                    </Field>
                  </div>
                </div>

                <PreviewCard />
              </section>

              <!-- Step 2 -->
              <section v-show="activeStep === 1" class="grid gap-4 lg:grid-cols-[1fr_320px]">
                <div class="rounded-[1.75rem] border border-neutral-200 bg-white p-5 shadow-sm">
                  <SectionTitle
                    icon="solar:palette-bold-duotone"
                    title="Brand & Tampilan"
                    subtitle="Atur logo, ikon, gambar berbagi, dan warna utama website."
                  />

                  <div class="mt-5 grid gap-4">
                    <div class="grid gap-4 sm:grid-cols-3">
                      <MediaInput
                        label="Logo Website"
                        :value="form.logoUrl"
                        preview="contain"
                        @update:value="form.logoUrl = $event"
                        @upload="uploadToField($event, 'logoUrl')"
                      />

                      <MediaInput
                        label="Ikon Website"
                        :value="form.faviconUrl"
                        preview="contain"
                        @update:value="form.faviconUrl = $event"
                        @upload="uploadToField($event, 'faviconUrl')"
                      />

                      <MediaInput
                        label="Gambar Berbagi"
                        :value="form.ogImageUrl"
                        preview="cover"
                        @update:value="form.ogImageUrl = $event"
                        @upload="uploadToField($event, 'ogImageUrl')"
                      />
                    </div>

                    <div class="grid gap-4 sm:grid-cols-[220px_1fr]">
                      <Field label="Warna Utama">
                        <div class="flex gap-2">
                          <input v-model="form.primaryColor" type="color" class="h-12 w-14 rounded-2xl border border-neutral-200 bg-white p-1">
                          <input v-model.trim="form.primaryColor" type="text" class="input-field" placeholder="#2563eb">
                        </div>
                      </Field>

                      <Field label="Catatan Tampilan">
                        <input
                          v-model.trim="form.themeNote"
                          type="text"
                          class="input-field"
                          placeholder="Contoh: Clean, resmi, informatif, dan ramah warga"
                        >
                      </Field>
                    </div>
                  </div>
                </div>

                <PreviewCard />
              </section>

              <!-- Step 3 -->
              <section v-show="activeStep === 2" class="grid gap-4">
                <div class="rounded-[1.75rem] border border-neutral-200 bg-white p-5 shadow-sm">
                  <SectionTitle
                    icon="solar:stars-bold-duotone"
                    title="Hero & Narasi Profil"
                    subtitle="Atur sambutan utama dan konten profil yang tampil di halaman depan."
                  />

                  <div class="mt-5 grid gap-4 lg:grid-cols-[1fr_320px]">
                    <div class="space-y-4">
                      <div class="grid gap-4 sm:grid-cols-2">
                        <Field label="Judul Hero">
                          <input v-model.trim="form.heroTitle" type="text" class="input-field" placeholder="Selamat Datang di Desa Martopuro">
                        </Field>

                        <Field label="Teks Sorotan">
                          <input v-model.trim="form.heroHighlight" type="text" class="input-field" placeholder="Maju, Mandiri, dan Berdaya">
                        </Field>

                        <Field label="Subtitle Hero" class="sm:col-span-2">
                          <textarea
                            v-model.trim="form.heroSubtitle"
                            rows="3"
                            class="textarea-field"
                            placeholder="Tulis kalimat pendek untuk memperkenalkan desa..."
                          ></textarea>
                        </Field>

                        <Field label="Label Tombol">
                          <input v-model.trim="form.heroCtaLabel" type="text" class="input-field" placeholder="Jelajahi Desa">
                        </Field>

                        <Field label="Tujuan Tombol">
                          <input v-model.trim="form.heroCtaHref" type="text" class="input-field" placeholder="/profile">
                        </Field>
                      </div>

                      <MediaInput
                        label="Gambar Utama"
                        :value="form.heroImageUrl"
                        preview="cover"
                        wide
                        @update:value="form.heroImageUrl = $event"
                        @upload="uploadToField($event, 'heroImageUrl')"
                      />
                    </div>

                    <div class="rounded-[1.5rem] border border-neutral-200 bg-neutral-50 p-4">
                      <p class="text-sm font-black text-neutral-950">
                        Preview Hero
                      </p>
                      <div class="mt-3 overflow-hidden rounded-[1.25rem] border border-neutral-200 bg-white">
                        <div class="relative h-48 bg-blue-600">
                          <img
                            v-if="form.heroImageUrl"
                            :src="form.heroImageUrl"
                            class="h-full w-full object-cover opacity-80"
                            alt=""
                          >
                          <div class="absolute inset-0 bg-gradient-to-t from-neutral-950/80 to-transparent"></div>
                          <div class="absolute inset-x-0 bottom-0 p-4">
                            <p class="text-xl font-black leading-tight text-white">
                              {{ form.heroTitle || 'Judul Hero' }}
                              <span class="text-blue-200">{{ form.heroHighlight }}</span>
                            </p>
                            <p class="mt-2 line-clamp-2 text-xs font-semibold leading-5 text-white/75">
                              {{ form.heroSubtitle || 'Subtitle hero website desa.' }}
                            </p>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>

                  <div class="mt-5">
                    <p class="mb-2 text-sm font-black text-neutral-950">
                      Narasi Profil
                    </p>
                    <RichTextEditor />
                  </div>
                </div>
              </section>

              <!-- Step 4 -->
              <section v-show="activeStep === 3" class="grid gap-4 lg:grid-cols-[1fr_320px]">
                <div class="rounded-[1.75rem] border border-neutral-200 bg-white p-5 shadow-sm">
                  <SectionTitle
                    icon="solar:phone-calling-rounded-bold-duotone"
                    title="Kontak & Media Sosial"
                    subtitle="Lengkapi kontak agar warga mudah menghubungi pengelola desa."
                  />

                  <div class="mt-5 grid gap-4 sm:grid-cols-2">
                    <Field label="Telepon">
                      <input v-model.trim="form.contactPhone" type="text" class="input-field" placeholder="0343xxxxxx">
                    </Field>

                    <Field label="WhatsApp">
                      <input v-model.trim="form.contactWhatsapp" type="text" class="input-field" placeholder="62812xxxxxxx">
                    </Field>

                    <Field label="Email">
                      <input v-model.trim="form.contactEmail" type="email" class="input-field" placeholder="desa@email.com">
                    </Field>

                    <Field label="Alamat Peta">
                      <input v-model.trim="form.contactMapUrl" type="url" class="input-field" placeholder="https://maps.google.com/...">
                    </Field>

                    <Field label="Alamat Lengkap" class="sm:col-span-2">
                      <textarea
                        v-model.trim="form.contactAddress"
                        rows="3"
                        class="textarea-field"
                        placeholder="Tulis alamat kantor desa..."
                      ></textarea>
                    </Field>

                    <Field label="Instagram">
                      <input v-model.trim="form.socialInstagram" type="text" class="input-field" placeholder="@desamartopuro">
                    </Field>

                    <Field label="Facebook">
                      <input v-model.trim="form.socialFacebook" type="text" class="input-field" placeholder="Desa Martopuro">
                    </Field>

                    <Field label="YouTube">
                      <input v-model.trim="form.socialYoutube" type="text" class="input-field" placeholder="https://youtube.com/...">
                    </Field>

                    <Field label="TikTok">
                      <input v-model.trim="form.socialTiktok" type="text" class="input-field" placeholder="@desamartopuro">
                    </Field>

                    <Field label="Teks Footer" class="sm:col-span-2">
                      <input v-model.trim="form.footerText" type="text" class="input-field" placeholder="© Desa Martopuro. Semua hak dilindungi.">
                    </Field>
                  </div>
                </div>

                <PreviewCard />
              </section>

              <!-- Step 5 -->
              <section v-show="activeStep === 4" class="grid gap-4 lg:grid-cols-[1fr_360px]">
                <div class="rounded-[1.75rem] border border-neutral-200 bg-white p-5 shadow-sm">
                  <SectionTitle
                    icon="solar:clipboard-check-bold-duotone"
                    title="Review & Simpan"
                    subtitle="Periksa kembali informasi sebelum diterapkan ke website."
                  />

                  <div class="mt-5 grid gap-3 sm:grid-cols-2">
                    <ReviewRow label="Nama Website" :value="form.displayName || form.name || '-'" />
                    <ReviewRow label="Status" :value="form.status === 'active' ? 'Aktif' : 'Tidak Aktif'" />
                    <ReviewRow label="Domain" :value="form.domain || '-'" />
                    <ReviewRow label="Logo" :value="form.logoUrl ? 'Sudah ada' : 'Belum ada'" />
                    <ReviewRow label="Hero" :value="form.heroTitle || '-'" />
                    <ReviewRow label="Kontak" :value="form.contactPhone || form.contactWhatsapp || form.contactEmail || '-'" />
                  </div>

                  <div class="mt-5 rounded-[1.5rem] border border-blue-100 bg-blue-50 p-4">
                    <div class="flex items-start gap-3">
                      <div class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl bg-white text-blue-600">
                        <Icon icon="solar:shield-check-bold-duotone" class="h-5 w-5" />
                      </div>
                      <div>
                        <p class="text-sm font-black text-blue-900">
                          Data siap disimpan
                        </p>
                        <p class="mt-1 text-sm font-semibold leading-6 text-blue-700">
                          Setelah disimpan, perubahan akan tampil pada website publik sesuai data yang berhasil diperbarui.
                        </p>
                      </div>
                    </div>
                  </div>
                </div>

                <PreviewCard />
              </section>
            </div>

            <footer class="border-t border-neutral-200 bg-white px-4 py-4 sm:px-5">
              <div class="flex flex-col-reverse gap-3 sm:flex-row sm:items-center sm:justify-between">
                <button
                  type="button"
                  class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-black text-neutral-700 transition hover:bg-neutral-50"
                  @click="activeStep === 0 ? requestCloseEditor() : prevStep()"
                >
                  <Icon :icon="activeStep === 0 ? 'solar:close-circle-bold-duotone' : 'solar:alt-arrow-left-linear'" class="h-5 w-5" />
                  {{ activeStep === 0 ? 'Tutup' : 'Kembali' }}
                </button>

                <div class="flex gap-2">
                  <button
                    v-if="activeStep < steps.length - 1"
                    type="button"
                    class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-5 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:-translate-y-0.5 hover:bg-blue-700"
                    @click="nextStep"
                  >
                    Lanjutkan
                    <Icon icon="solar:alt-arrow-right-linear" class="h-5 w-5" />
                  </button>

                  <button
                    v-else
                    type="button"
                    class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-5 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:-translate-y-0.5 hover:bg-blue-700 disabled:cursor-not-allowed disabled:opacity-60"
                    :disabled="isSaving"
                    @click="saveSite"
                  >
                    <Icon
                      :icon="isSaving ? 'svg-spinners:180-ring' : 'solar:diskette-bold-duotone'"
                      class="h-5 w-5"
                    />
                    {{ isSaving ? 'Menyimpan...' : 'Simpan Profil' }}
                  </button>
                </div>
              </div>
            </footer>
          </section>
        </div>
      </transition>
    </Teleport>

    <!-- Link Modal -->
    <Teleport to="body">
      <transition name="modal-fade">
        <div
          v-if="isLinkModalOpen"
          class="fixed inset-0 z-[95] flex items-center justify-center bg-neutral-950/50 p-4 backdrop-blur-sm"
          @mousedown.self="closeLinkModal"
        >
          <section class="w-full max-w-md rounded-[2rem] border border-neutral-200 bg-white p-5 shadow-2xl">
            <div class="flex items-start justify-between gap-4">
              <div>
                <p class="text-xs font-black uppercase tracking-[0.16em] text-blue-600">
                  Tambah Link
                </p>
                <h3 class="mt-1 text-xl font-black text-neutral-950">
                  Sisipkan tautan
                </h3>
              </div>
              <button
                type="button"
                class="grid h-10 w-10 place-items-center rounded-2xl border border-neutral-200 text-neutral-500 hover:bg-neutral-50"
                @click="closeLinkModal"
              >
                <Icon icon="solar:close-circle-bold-duotone" class="h-5 w-5" />
              </button>
            </div>

            <div class="mt-5 space-y-4">
              <Field label="Teks">
                <input v-model.trim="linkForm.text" type="text" class="input-field" placeholder="Contoh: Baca selengkapnya">
              </Field>

              <Field label="Alamat Link">
                <input v-model.trim="linkForm.href" type="url" class="input-field" placeholder="https://...">
              </Field>
            </div>

            <div class="mt-5 flex justify-end gap-2">
              <button
                type="button"
                class="inline-flex h-11 items-center justify-center rounded-2xl border border-neutral-200 px-4 text-sm font-black text-neutral-700 hover:bg-neutral-50"
                @click="closeLinkModal"
              >
                Batal
              </button>
              <button
                type="button"
                class="inline-flex h-11 items-center justify-center rounded-2xl bg-blue-600 px-4 text-sm font-black text-white hover:bg-blue-700 disabled:opacity-60"
                :disabled="!linkForm.href"
                @click="applyLink"
              >
                Terapkan
              </button>
            </div>
          </section>
        </div>
      </transition>
    </Teleport>

    <!-- Embed Modal -->
    <Teleport to="body">
      <transition name="modal-fade">
        <div
          v-if="isEmbedModalOpen"
          class="fixed inset-0 z-[95] flex items-center justify-center bg-neutral-950/45 p-4 backdrop-blur-sm"
          @mousedown.self="closeEmbedModal"
        >
          <section class="w-full max-w-2xl overflow-hidden rounded-[2rem] border border-neutral-200 bg-white shadow-2xl shadow-neutral-950/20">
            <div class="border-b border-neutral-100 bg-gradient-to-br from-blue-50 via-white to-white p-5">
              <div class="flex items-start justify-between gap-4">
                <div class="flex min-w-0 items-center gap-3">
                  <div class="grid h-12 w-12 shrink-0 place-items-center rounded-2xl bg-blue-600 text-white shadow-lg shadow-blue-600/20">
                    <Icon :icon="embedIcon" class="h-6 w-6" />
                  </div>

                  <div class="min-w-0">
                    <p class="text-[11px] font-black uppercase tracking-[0.16em] text-blue-600">
                      Media Konten
                    </p>
                    <h3 class="mt-1 truncate text-xl font-black text-neutral-950">
                      {{ embedModalTitle }}
                    </h3>
                  </div>
                </div>

                <button
                  type="button"
                  class="grid h-10 w-10 place-items-center rounded-2xl text-neutral-500 transition hover:bg-white hover:text-neutral-950"
                  @click="closeEmbedModal"
                >
                  <Icon icon="solar:close-circle-bold-duotone" class="h-6 w-6" />
                </button>
              </div>

              <div
                v-if="isUploadableEmbed"
                class="mt-5 grid grid-cols-2 gap-2 rounded-2xl bg-white p-1 shadow-sm ring-1 ring-neutral-200"
              >
                <button
                  type="button"
                  class="inline-flex h-10 items-center justify-center gap-2 rounded-xl text-xs font-black transition"
                  :class="embedMode === 'upload'
                    ? 'bg-blue-600 text-white shadow-sm shadow-blue-600/20'
                    : 'text-neutral-600 hover:bg-neutral-50 hover:text-neutral-950'"
                  @click="embedMode = 'upload'"
                >
                  <Icon icon="solar:cloud-upload-bold-duotone" class="h-4 w-4" />
                  Unggah
                </button>

                <button
                  type="button"
                  class="inline-flex h-10 items-center justify-center gap-2 rounded-xl text-xs font-black transition"
                  :class="embedMode === 'url'
                    ? 'bg-blue-600 text-white shadow-sm shadow-blue-600/20'
                    : 'text-neutral-600 hover:bg-neutral-50 hover:text-neutral-950'"
                  @click="embedMode = 'url'"
                >
                  <Icon icon="solar:link-circle-bold-duotone" class="h-4 w-4" />
                  Tautan
                </button>
              </div>
            </div>

            <div class="space-y-4 p-5">
              <template v-if="isUploadableEmbed && embedMode === 'upload'">
                <input
                  ref="embedFileInput"
                  type="file"
                  :accept="embedAccept"
                  class="hidden"
                  @change="pickEmbedFile"
                >

                <button
                  type="button"
                  class="group flex w-full flex-col items-center justify-center rounded-[1.5rem] border border-dashed border-blue-200 bg-blue-50/60 px-5 py-8 text-center transition hover:border-blue-400 hover:bg-blue-50"
                  @click="openEmbedFilePicker"
                >
                  <span class="grid h-14 w-14 place-items-center rounded-2xl bg-white text-blue-600 shadow-sm transition group-hover:-translate-y-0.5">
                    <Icon icon="solar:upload-square-bold-duotone" class="h-7 w-7" />
                  </span>
                  <span class="mt-4 text-sm font-black text-neutral-950">
                    {{ embedFile ? embedFile.name : 'Pilih file dari perangkat' }}
                  </span>
                  <span class="mt-1 text-xs font-semibold text-neutral-500">
                    {{ embedFile ? formatFileSize(embedFile.size) : embedForm.type === 'pdf' ? 'PDF hingga 10 MB' : 'JPG, PNG, atau WebP hingga 5 MB' }}
                  </span>
                </button>

                <button
                  v-if="embedFile"
                  type="button"
                  class="inline-flex items-center gap-2 rounded-xl px-3 py-2 text-xs font-black text-red-600 transition hover:bg-red-50"
                  @click="clearEmbedFile"
                >
                  <Icon icon="solar:trash-bin-trash-bold-duotone" class="h-4 w-4" />
                  Hapus pilihan
                </button>
              </template>

              <template v-else>
                <input
                  v-model.trim="embedForm.url"
                  type="url"
                  class="input-field"
                  :placeholder="embedPlaceholder"
                >
              </template>

              <div class="rounded-2xl border border-blue-100 bg-blue-50 px-4 py-3 text-xs font-semibold leading-5 text-blue-700">
                Kamu bisa mengunggah file dari perangkat atau memakai tautan yang sudah tersedia.
              </div>
            </div>

            <div class="flex flex-col-reverse gap-3 border-t border-neutral-100 bg-neutral-50/70 p-5 sm:flex-row sm:justify-end">
              <button
                type="button"
                class="inline-flex h-11 items-center justify-center rounded-2xl border border-neutral-200 bg-white px-4 text-sm font-black text-neutral-700 transition hover:bg-neutral-50"
                @click="closeEmbedModal"
              >
                Batal
              </button>
              <button
                type="button"
                class="inline-flex h-11 items-center justify-center gap-2 rounded-2xl bg-blue-600 px-5 text-sm font-black text-white shadow-lg shadow-blue-600/20 transition hover:bg-blue-700 disabled:cursor-not-allowed disabled:opacity-60"
                :disabled="!canInsertEmbed || isUploading"
                @click="applyEmbed"
              >
                <Icon
                  :icon="isUploading ? 'solar:refresh-bold-duotone' : 'solar:add-circle-bold-duotone'"
                  class="h-5 w-5"
                  :class="isUploading ? 'animate-spin' : ''"
                />
                {{ isUploading ? 'Menambahkan...' : 'Sisipkan' }}
              </button>
            </div>
          </section>
        </div>
      </transition>
    </Teleport>

    <!-- Confirm Close Modal -->
    <Teleport to="body">
      <transition name="modal-fade">
        <div
          v-if="isCloseConfirmOpen"
          class="fixed inset-0 z-[100] flex items-center justify-center bg-neutral-950/50 p-4 backdrop-blur-sm"
          @mousedown.self="isCloseConfirmOpen = false"
        >
          <section class="w-full max-w-md rounded-[2rem] border border-neutral-200 bg-white p-5 text-center shadow-2xl">
            <div class="mx-auto grid h-14 w-14 place-items-center rounded-3xl bg-blue-50 text-blue-600">
              <Icon icon="solar:question-circle-bold-duotone" class="h-8 w-8" />
            </div>
            <h3 class="mt-4 text-xl font-black text-neutral-950">
              Tutup pengaturan?
            </h3>
            <p class="mt-2 text-sm font-semibold leading-6 text-neutral-500">
              Perubahan yang belum disimpan akan tetap berada di form sementara sampai halaman dimuat ulang.
            </p>

            <div class="mt-5 grid gap-2 sm:grid-cols-2">
              <button
                type="button"
                class="inline-flex h-11 items-center justify-center rounded-2xl border border-neutral-200 text-sm font-black text-neutral-700 hover:bg-neutral-50"
                @click="isCloseConfirmOpen = false"
              >
                Lanjut Edit
              </button>
              <button
                type="button"
                class="inline-flex h-11 items-center justify-center rounded-2xl bg-blue-600 text-sm font-black text-white hover:bg-blue-700"
                @click="closeEditor"
              >
                Tutup
              </button>
            </div>
          </section>
        </div>
      </transition>
    </Teleport>

    <!-- Toast -->
    <transition name="toast">
      <div
        v-if="toast.show"
        class="fixed bottom-5 right-5 z-[120] w-[min(420px,calc(100vw-2rem))] rounded-[1.5rem] border border-neutral-200 bg-white p-4 shadow-2xl shadow-neutral-950/15"
      >
        <div class="flex items-start gap-3">
          <div
            class="grid h-10 w-10 shrink-0 place-items-center rounded-2xl"
            :class="toast.type === 'success' ? 'bg-blue-50 text-blue-600' : 'bg-red-50 text-red-600'"
          >
            <Icon :icon="toast.type === 'success' ? 'solar:check-circle-bold-duotone' : 'solar:danger-circle-bold-duotone'" class="h-6 w-6" />
          </div>
          <div class="min-w-0 flex-1">
            <p class="font-black text-neutral-950">
              {{ toast.title }}
            </p>
            <p class="mt-1 text-sm font-semibold leading-6 text-neutral-500">
              {{ toast.message }}
            </p>
          </div>
          <button
            type="button"
            class="grid h-8 w-8 place-items-center rounded-xl text-neutral-400 hover:bg-neutral-50 hover:text-neutral-700"
            @click="closeToast"
          >
            <Icon icon="solar:close-circle-bold-duotone" class="h-5 w-5" />
          </button>
        </div>
      </div>
    </transition>
  </main>
</template>

<script setup lang="ts">
import { computed, defineComponent, h, nextTick, onBeforeUnmount, reactive, ref, unref, watch } from 'vue'
import { Icon } from '@iconify/vue'
import { EditorContent, useEditor } from '@tiptap/vue-3'
import { Node, mergeAttributes } from '@tiptap/core'
import StarterKit from '@tiptap/starter-kit'
import Link from '@tiptap/extension-link'
import Image from '@tiptap/extension-image'
import Underline from '@tiptap/extension-underline'
import Placeholder from '@tiptap/extension-placeholder'
import Youtube from '@tiptap/extension-youtube'
import { Table } from '@tiptap/extension-table'
import TableRow from '@tiptap/extension-table-row'
import TableCell from '@tiptap/extension-table-cell'
import TableHeader from '@tiptap/extension-table-header'
import { useCloudinaryUpload } from '../../composables/useCloudinaryUpload'
import { useAppApi } from '../../composables/useAppApi'
import { useTenantSite } from '../../composables/data/useTenantSite'

type SiteStatus = 'active' | 'inactive'
type ToastType = 'success' | 'error'
type UploadField = 'logoUrl' | 'faviconUrl' | 'ogImageUrl' | 'heroImageUrl'
type EmbedType = 'image' | 'youtube' | 'pdf' | 'maps'

definePageMeta({
  layout: 'app',
  layoutProps: {
    title: 'Profile'
  }
})

const Iframe = Node.create({
  name: 'iframe',
  group: 'block',
  atom: true,
  addAttributes() {
    return {
      src: { default: null },
      class: { default: null },
      title: { default: 'Embedded content' },
      allow: { default: 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share' },
      allowfullscreen: { default: 'true' },
      loading: { default: 'lazy' },
      referrerpolicy: { default: 'no-referrer-when-downgrade' }
    }
  },
  parseHTML() {
    return [{ tag: 'iframe' }]
  },
  renderHTML({ HTMLAttributes }) {
    return ['iframe', mergeAttributes(HTMLAttributes)]
  }
})

const runtime = useRuntimeConfig()
const { tenantSlug, site, pending, error, refresh } = useTenantSite()
const { tenantApiUrl } = useAppApi()
const mediaUploader = useCloudinaryUpload() as any

const isEditorOpen = ref(false)
const isCloseConfirmOpen = ref(false)
const isLinkModalOpen = ref(false)
const isEmbedModalOpen = ref(false)
const isSaving = ref(false)
const isUploading = ref(false)
const embedMode = ref<'upload' | 'url'>('url')
const embedFile = ref<File | null>(null)
const embedFileInput = ref<HTMLInputElement | null>(null)
const activeStep = ref(0)

const steps = [
  { key: 'identity', label: 'Identitas' },
  { key: 'brand', label: 'Brand' },
  { key: 'hero', label: 'Hero' },
  { key: 'contact', label: 'Kontak' },
  { key: 'review', label: 'Review' }
]

const form = reactive({
  name: '',
  displayName: '',
  slug: '',
  domain: '',
  siteUrl: '',
  description: '',
  status: 'active' as SiteStatus,

  logoUrl: '',
  faviconUrl: '',
  ogImageUrl: '',
  primaryColor: '#2563eb',
  themeNote: '',

  heroTitle: '',
  heroHighlight: '',
  heroSubtitle: '',
  heroImageUrl: '',
  heroCtaLabel: '',
  heroCtaHref: '',

  aboutHtml: '',

  contactPhone: '',
  contactWhatsapp: '',
  contactEmail: '',
  contactAddress: '',
  contactMapUrl: '',

  socialInstagram: '',
  socialFacebook: '',
  socialYoutube: '',
  socialTiktok: '',

  footerText: ''
})

const linkForm = reactive({
  text: '',
  href: ''
})

const embedForm = reactive({
  type: 'image' as EmbedType,
  url: ''
})

const toast = reactive({
  show: false,
  type: 'success' as ToastType,
  title: '',
  message: ''
})

let toastTimer: ReturnType<typeof setTimeout> | null = null

const editor = useEditor({
  extensions: [
    StarterKit.configure({
      heading: {
        levels: [1, 2, 3]
      }
    }),
    Underline,
    Link.configure({
      openOnClick: false,
      autolink: true,
      linkOnPaste: true,
      HTMLAttributes: {
        class: 'text-blue-600 font-bold underline underline-offset-4'
      }
    }),
    Image.configure({
      HTMLAttributes: {
        class: 'rounded-2xl border border-neutral-200'
      }
    }),
    Youtube.configure({
      controls: true,
      nocookie: true,
      HTMLAttributes: {
        class: 'rounded-2xl overflow-hidden'
      }
    }),
    Table.configure({
      resizable: true,
      HTMLAttributes: {
        class: 'tiptap-table'
      }
    }),
    TableRow,
    TableHeader,
    TableCell,
    Iframe,
    Placeholder.configure({
      placeholder: 'Tulis profil desa, sejarah singkat, visi, misi, pelayanan, atau informasi penting lainnya...'
    })
  ],
  content: '',
  editorProps: {
    attributes: {
      class: 'prose prose-neutral max-w-none focus:outline-none'
    }
  },
  onUpdate({ editor }) {
    form.aboutHtml = editor.getHTML()
  }
})

const visibleError = computed(() => {
  if (!error.value) return ''
  return error.value?.message || 'Data profil belum bisa dimuat.'
})

const siteData = computed<any>(() => site.value || {})

const siteTitle = computed(() => {
  return String(siteData.value.displayName || siteData.value.name || tenantSlug.value || 'Website Desa')
})

const siteLogo = computed(() => {
  return String(siteData.value.logoUrl || form.logoUrl || runtime.public.appLogo || '').trim()
})

const siteDescription = computed(() => {
  return String(siteData.value.description || '').trim()
})

const siteStatus = computed<SiteStatus>(() => {
  return siteData.value.status === 'inactive' ? 'inactive' : 'active'
})

const siteStatusLabel = computed(() => {
  return siteStatus.value === 'active' ? 'Aktif' : 'Tidak Aktif'
})

const siteUrl = computed(() => {
  return String(siteData.value.siteUrl || siteData.value.domain || '').trim()
})

const heroTitle = computed(() => {
  return String(siteData.value.hero?.title || siteData.value.hero?.heading || '').trim()
})

const heroSubtitle = computed(() => {
  return String(siteData.value.hero?.subtitle || siteData.value.hero?.description || '').trim()
})

const heroImage = computed(() => {
  return String(siteData.value.hero?.imageUrl || siteData.value.hero?.image || siteData.value.ogImageUrl || '').trim()
})

const aboutHtml = computed(() => {
  return String(siteData.value.hero?.contentHtml || siteData.value.metadata?.aboutHtml || siteData.value.description || '').trim()
})

const safeAboutHtml = computed(() => sanitizeHtml(aboutHtml.value))

const contactPhone = computed(() => String(siteData.value.contact?.phone || '').trim())
const contactWhatsapp = computed(() => String(siteData.value.contact?.whatsapp || '').trim())
const contactEmail = computed(() => String(siteData.value.contact?.email || '').trim())
const contactAddress = computed(() => String(siteData.value.contact?.address || '').trim())

const publicLinks = [
  { label: 'Berita', href: '/news', icon: 'solar:document-text-bold-duotone' },
  { label: 'Organisasi', href: '/organizations', icon: 'solar:users-group-rounded-bold-duotone' },
  { label: 'Fasilitas', href: '/facilities', icon: 'solar:buildings-3-bold-duotone' },
  { label: 'Potensi', href: '/potentials', icon: 'solar:graph-up-bold-duotone' },
  { label: 'Lembaga', href: '/institutions', icon: 'solar:shield-star-bold-duotone' }
]

const readinessItems = computed(() => [
  {
    label: 'Logo website',
    description: form.logoUrl || siteData.value.logoUrl ? 'Logo sudah tersedia.' : 'Tambahkan logo resmi desa.',
    done: Boolean(form.logoUrl || siteData.value.logoUrl)
  },
  {
    label: 'Deskripsi profil',
    description: form.description || siteData.value.description ? 'Narasi singkat sudah tersedia.' : 'Tambahkan deskripsi singkat desa.',
    done: Boolean(form.description || siteData.value.description)
  },
  {
    label: 'Hero halaman depan',
    description: heroTitle.value || form.heroTitle ? 'Judul hero sudah diatur.' : 'Lengkapi judul utama website.',
    done: Boolean(heroTitle.value || form.heroTitle)
  },
  {
    label: 'Kontak warga',
    description: contactPhone.value || contactWhatsapp.value || contactEmail.value || form.contactPhone || form.contactWhatsapp || form.contactEmail
      ? 'Kontak sudah tersedia.'
      : 'Lengkapi nomor atau email.',
    done: Boolean(contactPhone.value || contactWhatsapp.value || contactEmail.value || form.contactPhone || form.contactWhatsapp || form.contactEmail)
  }
])

const embedTitle = computed(() => {
  const labels: Record<EmbedType, string> = {
    image: 'Gambar',
    youtube: 'YouTube',
    pdf: 'PDF',
    maps: 'Peta'
  }

  return labels[embedForm.type]
})

const embedModalTitle = computed(() => {
  if (embedForm.type === 'image') return 'Tambahkan Gambar'
  if (embedForm.type === 'youtube') return 'Tambahkan Video'
  if (embedForm.type === 'pdf') return 'Tambahkan Dokumen'
  return 'Tambahkan Lokasi'
})

const embedIcon = computed(() => {
  if (embedForm.type === 'image') return 'solar:gallery-add-bold-duotone'
  if (embedForm.type === 'youtube') return 'solar:video-frame-play-horizontal-bold-duotone'
  if (embedForm.type === 'pdf') return 'solar:file-text-bold-duotone'
  return 'solar:map-point-bold-duotone'
})

const isUploadableEmbed = computed(() => {
  return embedForm.type === 'image' || embedForm.type === 'pdf'
})

const embedAccept = computed(() => {
  if (embedForm.type === 'pdf') return 'application/pdf'
  return 'image/jpeg,image/jpg,image/png,image/webp'
})

const canInsertEmbed = computed(() => {
  if (isUploadableEmbed.value && embedMode.value === 'upload') {
    return Boolean(embedFile.value)
  }

  return Boolean(embedForm.url.trim())
})

const embedInputLabel = computed(() => {
  if (embedForm.type === 'image') return 'Alamat gambar'
  if (embedForm.type === 'youtube') return 'Alamat video'
  if (embedForm.type === 'pdf') return 'Alamat dokumen'
  return 'Alamat peta'
})

const embedPlaceholder = computed(() => {
  if (embedForm.type === 'image') return 'Tempel tautan gambar, misalnya https://domain.com/gambar.jpg'
  if (embedForm.type === 'youtube') return 'Tempel tautan YouTube'
  if (embedForm.type === 'pdf') return 'Tempel tautan dokumen PDF'
  return 'Tempel tautan Google Maps'
})

watch(site, () => {
  hydrateForm()
}, { immediate: true })

watch(isEditorOpen, async (value) => {
  if (value) {
    document.body.style.overflow = 'hidden'
    await nextTick()
    editor.value?.commands.setContent(form.aboutHtml || '', false)
  } else {
    document.body.style.overflow = ''
  }
})

onBeforeUnmount(() => {
  document.body.style.overflow = ''
  if (toastTimer) clearTimeout(toastTimer)
  editor.value?.destroy()
})

function hydrateForm() {
  const current = siteData.value || {}
  const hero = current.hero || {}
  const theme = current.theme || {}
  const contact = current.contact || {}
  const social = current.social || {}
  const footer = current.footer || {}
  const metadata = current.metadata || {}

  form.name = String(current.name || '').trim()
  form.displayName = String(current.displayName || '').trim()
  form.slug = String(current.slug || tenantSlug.value || '').trim()
  form.domain = String(current.domain || '').trim()
  form.siteUrl = String(current.siteUrl || '').trim()
  form.description = String(current.description || '').trim()
  form.status = current.status === 'inactive' ? 'inactive' : 'active'

  form.logoUrl = String(current.logoUrl || '').trim()
  form.faviconUrl = String(current.faviconUrl || '').trim()
  form.ogImageUrl = String(current.ogImageUrl || '').trim()
  form.primaryColor = String(current.primaryColor || theme.primaryColor || '#2563eb').trim()
  form.themeNote = String(theme.note || metadata.themeNote || '').trim()

  form.heroTitle = String(hero.title || hero.heading || '').trim()
  form.heroHighlight = String(hero.highlight || '').trim()
  form.heroSubtitle = String(hero.subtitle || hero.description || '').trim()
  form.heroImageUrl = String(hero.imageUrl || hero.image || '').trim()
  form.heroCtaLabel = String(hero.ctaLabel || hero.primaryCta?.label || '').trim()
  form.heroCtaHref = String(hero.ctaHref || hero.primaryCta?.href || '').trim()

  form.aboutHtml = String(hero.contentHtml || metadata.aboutHtml || '').trim()

  form.contactPhone = String(contact.phone || '').trim()
  form.contactWhatsapp = String(contact.whatsapp || '').trim()
  form.contactEmail = String(contact.email || '').trim()
  form.contactAddress = String(contact.address || '').trim()
  form.contactMapUrl = String(contact.mapUrl || contact.mapsUrl || '').trim()

  form.socialInstagram = String(social.instagram || '').trim()
  form.socialFacebook = String(social.facebook || '').trim()
  form.socialYoutube = String(social.youtube || '').trim()
  form.socialTiktok = String(social.tiktok || '').trim()

  form.footerText = String(footer.text || footer.copyright || '').trim()
}

function openEditor() {
  hydrateForm()
  activeStep.value = 0
  isEditorOpen.value = true
}

function requestCloseEditor() {
  isCloseConfirmOpen.value = true
}

function closeEditor() {
  isCloseConfirmOpen.value = false
  isEditorOpen.value = false
}

function goStep(index: number) {
  activeStep.value = Math.max(0, Math.min(index, steps.length - 1))
}

function nextStep() {
  goStep(activeStep.value + 1)
}

function prevStep() {
  goStep(activeStep.value - 1)
}

async function saveSite() {
  if (isSaving.value) return

  isSaving.value = true

  const payload = buildPayload()
  const url = tenantApiUrl(tenantSlug.value, '/site')

  try {
    await $fetch(url, {
      method: 'PUT',
      body: payload
    })

    await refresh()
    showToast('success', 'Profil tersimpan', 'Perubahan profil website desa berhasil diterapkan.')
    isEditorOpen.value = false
  } catch (putError) {
    try {
      await $fetch(url, {
        method: 'PATCH',
        body: payload
      })

      await refresh()
      showToast('success', 'Profil tersimpan', 'Perubahan profil website desa berhasil diterapkan.')
      isEditorOpen.value = false
    } catch (patchError: any) {
      showToast('error', 'Gagal menyimpan', patchError?.data?.message || patchError?.message || 'Periksa kembali data lalu coba lagi.')
    }
  } finally {
    isSaving.value = false
  }
}

function buildPayload() {
  const current = siteData.value || {}

  return {
    name: form.name,
    displayName: form.displayName,
    slug: form.slug || tenantSlug.value,
    tenantType: current.tenantType || 'custom',
    domain: form.domain || null,
    siteUrl: form.siteUrl || null,
    logoUrl: form.logoUrl || null,
    faviconUrl: form.faviconUrl || null,
    ogImageUrl: form.ogImageUrl || null,
    primaryColor: form.primaryColor || '#2563eb',
    description: form.description || null,
    status: form.status,

    theme: {
      ...(current.theme || {}),
      primaryColor: form.primaryColor || '#2563eb',
      note: form.themeNote || ''
    },
    seo: {
      ...(current.seo || {}),
      title: form.displayName || form.name,
      description: form.description,
      ogImage: form.ogImageUrl
    },
    hero: {
      ...(current.hero || {}),
      title: form.heroTitle,
      highlight: form.heroHighlight,
      subtitle: form.heroSubtitle,
      description: form.heroSubtitle,
      imageUrl: form.heroImageUrl,
      ctaLabel: form.heroCtaLabel,
      ctaHref: form.heroCtaHref,
      primaryCta: {
        label: form.heroCtaLabel,
        href: form.heroCtaHref
      },
      contentHtml: form.aboutHtml
    },
    contact: {
      ...(current.contact || {}),
      phone: form.contactPhone,
      whatsapp: form.contactWhatsapp,
      email: form.contactEmail,
      address: form.contactAddress,
      mapUrl: form.contactMapUrl
    },
    footer: {
      ...(current.footer || {}),
      text: form.footerText,
      copyright: form.footerText
    },
    social: {
      ...(current.social || {}),
      instagram: form.socialInstagram,
      facebook: form.socialFacebook,
      youtube: form.socialYoutube,
      tiktok: form.socialTiktok
    },
    statistic: current.statistic || {},
    culture: current.culture || {},
    warta: current.warta || {},
    navigation: current.navigation || [],
    metadata: {
      ...(current.metadata || {}),
      aboutHtml: form.aboutHtml,
      themeNote: form.themeNote
    }
  }
}

async function uploadToField(event: Event, field: UploadField) {
  const input = event.target as HTMLInputElement
  const file = input.files?.[0]

  if (!file) return

  try {
    const url = await uploadMedia(file, 'image')
    form[field] = url
    showToast('success', 'Gambar ditambahkan', 'Gambar berhasil dipasang ke form.')
  } catch (err: any) {
    showToast('error', 'Gagal mengunggah', friendlyUploadError(err))
  } finally {
    input.value = ''
  }
}

async function uploadEditorImage(event: Event) {
  const input = event.target as HTMLInputElement
  const file = input.files?.[0]

  if (!file) return

  try {
    const url = await uploadMedia(file, 'image')
    embedForm.url = url
    showToast('success', 'Gambar siap digunakan', 'Gambar berhasil ditambahkan ke form media.')
  } catch (err: any) {
    showToast('error', 'Gagal mengunggah', friendlyUploadError(err))
  } finally {
    input.value = ''
  }
}

async function uploadMedia(file: File, kind: 'image' | 'document' = 'image') {
  if (isUploading.value || Boolean(unref(mediaUploader.uploading))) {
    throw new Error('Tunggu proses sebelumnya selesai.')
  }

  isUploading.value = true

  try {
    const method =
      kind === 'document'
        ? mediaUploader.uploadFile || mediaUploader.uploadDocument || mediaUploader.uploadRaw || mediaUploader.uploadImage
        : mediaUploader.uploadImage || mediaUploader.uploadFile || mediaUploader.uploadDocument || mediaUploader.uploadRaw

    if (typeof method !== 'function') {
      throw new Error('upload-service-not-ready')
    }

    const response = await method(file, {
      folder: `${tenantSlug.value}/site`,
      maxWidth: kind === 'image' ? 1600 : undefined,
      maxHeight: kind === 'image' ? 1600 : undefined,
      quality: kind === 'image' ? 0.82 : undefined,
      maxBytes: kind === 'document' ? 10 * 1024 * 1024 : 5 * 1024 * 1024,
      resourceType: kind === 'document' ? 'raw' : 'image'
    })

    const url = getUploadedUrl(response)

    if (!url) {
      throw new Error('upload-url-not-found')
    }

    return url
  } finally {
    isUploading.value = false
  }
}

function getUploadedUrl(response: any) {
  return String(
    response?.secure_url ||
    response?.secureUrl ||
    response?.url ||
    response?.data?.secure_url ||
    response?.data?.secureUrl ||
    response?.data?.url ||
    response?.file?.url ||
    ''
  ).trim()
}

function friendlyUploadError(err: any) {
  const message = String(
    err?.data?.message ||
    err?.data?.statusMessage ||
    err?.statusMessage ||
    err?.message ||
    ''
  )

  if (
    !message ||
    message.includes('upload-service-not-ready') ||
    message.includes('upload-url-not-found') ||
    message.toLowerCase().includes('layanan unggah') ||
    message.toLowerCase().includes('cloudinary') ||
    message.toLowerCase().includes('endpoint')
  ) {
    return 'Fitur unggah belum siap. Gunakan opsi tautan terlebih dahulu.'
  }

  return message
}

function openLinkModal() {
  linkForm.text = ''
  linkForm.href = editor.value?.getAttributes('link')?.href || ''
  isLinkModalOpen.value = true
}

function closeLinkModal() {
  isLinkModalOpen.value = false
}

function applyLink() {
  if (!editor.value || !linkForm.href) return

  if (linkForm.text) {
    editor.value
      .chain()
      .focus()
      .insertContent(`<a href="${escapeHtml(linkForm.href)}">${escapeHtml(linkForm.text)}</a>`)
      .run()
  } else {
    editor.value
      .chain()
      .focus()
      .extendMarkRange('link')
      .setLink({ href: linkForm.href })
      .run()
  }

  closeLinkModal()
}

function openEmbedModal(type: EmbedType) {
  embedForm.type = type
  embedForm.url = ''
  embedMode.value = type === 'image' || type === 'pdf' ? 'upload' : 'url'
  embedFile.value = null

  if (embedFileInput.value) {
    embedFileInput.value.value = ''
  }

  isEmbedModalOpen.value = true
}

function closeEmbedModal() {
  isEmbedModalOpen.value = false
  embedFile.value = null

  if (embedFileInput.value) {
    embedFileInput.value.value = ''
  }
}

function openEmbedFilePicker() {
  embedFileInput.value?.click()
}

function pickEmbedFile(event: Event) {
  const input = event.target as HTMLInputElement
  const file = input.files?.[0] || null

  if (!file) return

  embedFile.value = file
}

function clearEmbedFile() {
  embedFile.value = null

  if (embedFileInput.value) {
    embedFileInput.value.value = ''
  }
}

async function applyEmbed() {
  if (!editor.value) return

  let url = ''

  if (isUploadableEmbed.value && embedMode.value === 'upload') {
    if (!embedFile.value) return

    try {
      url = await uploadMedia(embedFile.value, embedForm.type === 'pdf' ? 'document' : 'image')
    } catch (err: any) {
      showToast('error', 'Gagal menambahkan media', friendlyUploadError(err))
      return
    }
  } else {
    url = embedForm.url.trim()
  }

  if (!url) return

  if (embedForm.type === 'image') {
    editor.value.chain().focus().setImage({ src: url }).run()
  }

  if (embedForm.type === 'youtube') {
    editor.value.chain().focus().setYoutubeVideo({ src: url, width: 800, height: 450 }).run()
  }

  if (embedForm.type === 'pdf') {
    editor.value
      .chain()
      .focus()
      .insertContent({
        type: 'iframe',
        attrs: {
          src: url,
          class: 'tiptap-pdf',
          title: 'Dokumen'
        }
      })
      .run()
  }

  if (embedForm.type === 'maps') {
    editor.value
      .chain()
      .focus()
      .insertContent({
        type: 'iframe',
        attrs: {
          src: url,
          class: 'tiptap-map',
          title: 'Peta'
        }
      })
      .run()
  }

  closeEmbedModal()
}


function formatFileSize(bytes: number) {
  if (!bytes) return '0 KB'

  const kb = bytes / 1024

  if (kb < 1024) return `${Math.round(kb)} KB`

  return `${(kb / 1024).toFixed(1)} MB`
}


function safeDisplayUrl(value: string) {
  return String(value || '').replace(/^https?:\/\//, '').replace(/\/$/, '')
}

function sanitizeHtml(value: string) {
  return String(value || '')
    .replace(/<script[\s\S]*?>[\s\S]*?<\/script>/gi, '')
    .replace(/\son\w+="[^"]*"/gi, '')
    .replace(/\son\w+='[^']*'/gi, '')
    .replace(/javascript:/gi, '')
}

function escapeHtml(value: string) {
  return String(value || '')
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;')
    .replaceAll("'", '&#039;')
}

function showToast(type: ToastType, title: string, message: string) {
  if (toastTimer) clearTimeout(toastTimer)

  toast.type = type
  toast.title = title
  toast.message = message
  toast.show = true

  toastTimer = setTimeout(() => {
    toast.show = false
  }, 3200)
}

function closeToast() {
  if (toastTimer) clearTimeout(toastTimer)
  toast.show = false
}

const Field = defineComponent({
  props: {
    label: {
      type: String,
      required: true
    }
  },
  setup(props, { slots, attrs }) {
    return () =>
      h('label', { class: ['block', attrs.class] }, [
        h('span', { class: 'mb-2 block text-sm font-black text-neutral-800' }, props.label),
        slots.default?.()
      ])
  }
})

const SectionTitle = defineComponent({
  props: {
    icon: {
      type: String,
      required: true
    },
    title: {
      type: String,
      required: true
    },
    subtitle: {
      type: String,
      required: true
    }
  },
  setup(props) {
    return () =>
      h('div', { class: 'flex items-start gap-3' }, [
        h('div', { class: 'grid h-11 w-11 shrink-0 place-items-center rounded-2xl bg-blue-50 text-blue-600' }, [
          h(Icon, { icon: props.icon, class: 'h-6 w-6' })
        ]),
        h('div', { class: 'min-w-0' }, [
          h('h3', { class: 'text-lg font-black text-neutral-950' }, props.title),
          h('p', { class: 'mt-1 text-sm font-semibold leading-6 text-neutral-500' }, props.subtitle)
        ])
      ])
  }
})

const InfoCard = defineComponent({
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
    }
  },
  setup(props) {
    return () =>
      h('div', { class: 'flex items-center gap-3 rounded-[1.25rem] border border-neutral-200 bg-neutral-50 p-3' }, [
        h('div', { class: 'grid h-10 w-10 shrink-0 place-items-center rounded-2xl bg-white text-blue-600 shadow-sm' }, [
          h(Icon, { icon: props.icon, class: 'h-5 w-5' })
        ]),
        h('div', { class: 'min-w-0' }, [
          h('p', { class: 'text-[11px] font-black uppercase tracking-[0.14em] text-neutral-400' }, props.label),
          h('p', { class: 'mt-1 truncate text-sm font-black text-neutral-800' }, props.value)
        ])
      ])
  }
})

const ContactRow = InfoCard

const ReadinessRow = defineComponent({
  props: {
    done: {
      type: Boolean,
      required: true
    },
    label: {
      type: String,
      required: true
    },
    description: {
      type: String,
      required: true
    }
  },
  setup(props) {
    return () =>
      h('div', { class: 'flex items-start gap-3 rounded-[1.25rem] border border-neutral-200 bg-neutral-50 p-3' }, [
        h('div', {
          class: [
            'mt-0.5 grid h-8 w-8 shrink-0 place-items-center rounded-xl',
            props.done ? 'bg-blue-600 text-white' : 'bg-white text-neutral-400 ring-1 ring-neutral-200'
          ]
        }, [
          h(Icon, { icon: props.done ? 'solar:check-circle-bold-duotone' : 'solar:clock-circle-bold-duotone', class: 'h-5 w-5' })
        ]),
        h('div', { class: 'min-w-0' }, [
          h('p', { class: 'text-sm font-black text-neutral-900' }, props.label),
          h('p', { class: 'mt-1 text-xs font-semibold leading-5 text-neutral-500' }, props.description)
        ])
      ])
  }
})

const ReviewRow = defineComponent({
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
      h('div', { class: 'rounded-[1.25rem] border border-neutral-200 bg-neutral-50 p-4' }, [
        h('p', { class: 'text-xs font-black uppercase tracking-[0.14em] text-neutral-400' }, props.label),
        h('p', { class: 'mt-1 truncate text-sm font-black text-neutral-950' }, props.value)
      ])
  }
})

const PreviewCard = defineComponent({
  setup() {
    return () =>
      h('aside', { class: 'rounded-[1.75rem] border border-neutral-200 bg-white p-5 shadow-sm' }, [
        h('p', { class: 'text-sm font-black text-neutral-950' }, 'Preview Singkat'),
        h('div', { class: 'mt-4 flex items-center gap-3' }, [
          h('div', { class: 'grid h-14 w-14 shrink-0 place-items-center overflow-hidden rounded-2xl border border-neutral-200 bg-neutral-50 p-2' }, [
            form.logoUrl
              ? h('img', { src: form.logoUrl, class: 'h-full w-full object-contain', alt: '' })
              : h(Icon, { icon: 'solar:buildings-3-bold-duotone', class: 'h-8 w-8 text-blue-600' })
          ]),
          h('div', { class: 'min-w-0' }, [
            h('p', { class: 'truncate font-black text-neutral-950' }, form.displayName || form.name || 'Website Desa'),
            h('p', { class: 'truncate text-xs font-semibold text-neutral-500' }, form.siteUrl || form.domain || form.slug || 'alamat website')
          ])
        ]),
        h('p', { class: 'mt-4 line-clamp-3 text-sm font-semibold leading-6 text-neutral-500' }, form.description || 'Deskripsi singkat website desa akan tampil di sini.'),
        h('div', { class: 'mt-4 rounded-2xl bg-blue-50 p-3 text-xs font-black text-blue-700' }, form.heroTitle || 'Judul hero belum diisi')
      ])
  }
})

const MediaInput = defineComponent({
  props: {
    label: {
      type: String,
      required: true
    },
    value: {
      type: String,
      default: ''
    },
    preview: {
      type: String,
      default: 'cover'
    },
    wide: {
      type: Boolean,
      default: false
    }
  },
  emits: ['update:value', 'upload'],
  setup(props, { emit }) {
    return () =>
      h('div', { class: props.wide ? 'rounded-[1.5rem] border border-neutral-200 bg-neutral-50 p-4' : 'rounded-[1.5rem] border border-neutral-200 bg-neutral-50 p-4' }, [
        h('p', { class: 'mb-3 text-sm font-black text-neutral-950' }, props.label),
        h('div', {
          class: [
            'overflow-hidden rounded-2xl border border-neutral-200 bg-white',
            props.wide ? 'h-44' : 'h-32'
          ]
        }, [
          props.value
            ? h('img', {
                src: props.value,
                class: ['h-full w-full', props.preview === 'contain' ? 'object-contain p-3' : 'object-cover'],
                alt: props.label
              })
            : h('div', { class: 'grid h-full w-full place-items-center text-neutral-400' }, [
                h(Icon, { icon: 'solar:gallery-add-bold-duotone', class: 'h-8 w-8' })
              ])
        ]),
        h('div', { class: 'mt-3 space-y-2' }, [
          h('input', {
            value: props.value,
            placeholder: 'Tempel alamat gambar...',
            class: 'input-field',
            onInput: (event: Event) => emit('update:value', (event.target as HTMLInputElement).value)
          }),
          h('input', {
            type: 'file',
            accept: 'image/*',
            class: 'block w-full cursor-pointer rounded-2xl border border-neutral-200 bg-white text-xs font-semibold text-neutral-600 file:mr-3 file:border-0 file:bg-blue-600 file:px-3 file:py-2.5 file:text-xs file:font-black file:text-white',
            onChange: (event: Event) => emit('upload', event)
          })
        ])
      ])
  }
})

const RichTextEditor = defineComponent({
  setup() {
    const toolbarGroups = [
      [
        { icon: 'solar:text-bold', label: 'Paragraf', action: () => editor.value?.chain().focus().setParagraph().run() },
        { text: 'H1', label: 'Heading 1', action: () => editor.value?.chain().focus().toggleHeading({ level: 1 }).run() },
        { text: 'H2', label: 'Heading 2', action: () => editor.value?.chain().focus().toggleHeading({ level: 2 }).run() },
        { text: 'H3', label: 'Heading 3', action: () => editor.value?.chain().focus().toggleHeading({ level: 3 }).run() }
      ],
      [
        { icon: 'solar:bold-bold', label: 'Tebal', action: () => editor.value?.chain().focus().toggleBold().run() },
        { icon: 'solar:italic-bold', label: 'Miring', action: () => editor.value?.chain().focus().toggleItalic().run() },
        { icon: 'solar:underline-bold', label: 'Garis bawah', action: () => editor.value?.chain().focus().toggleUnderline().run() }
      ],
      [
        { icon: 'solar:list-bold', label: 'List dot', action: () => editor.value?.chain().focus().toggleBulletList().run() },
        { icon: 'solar:list-check-bold-duotone', label: 'List angka', action: () => editor.value?.chain().focus().toggleOrderedList().run() },
        { icon: 'solar:chat-square-quote-bold-duotone', label: 'Quote', action: () => editor.value?.chain().focus().toggleBlockquote().run() }
      ],
      [
        { icon: 'solar:table-bold-duotone', label: 'Tabel', action: () => editor.value?.chain().focus().insertTable({ rows: 3, cols: 3, withHeaderRow: true }).run() },
        { icon: 'solar:link-bold-duotone', label: 'Link', action: openLinkModal },
        { icon: 'solar:gallery-add-bold-duotone', label: 'Gambar', action: () => openEmbedModal('image') },
        { icon: 'solar:video-frame-play-horizontal-bold-duotone', label: 'YouTube', action: () => openEmbedModal('youtube') },
        { icon: 'solar:file-text-bold-duotone', label: 'PDF', action: () => openEmbedModal('pdf') },
        { icon: 'solar:map-point-bold-duotone', label: 'Maps', action: () => openEmbedModal('maps') }
      ]
    ]

    return () =>
      h('div', { class: 'overflow-hidden rounded-[1.5rem] border border-neutral-200 bg-white' }, [
        h('div', { class: 'flex flex-wrap gap-1 border-b border-neutral-200 bg-blue-50/40 p-2' },
          toolbarGroups.flatMap((group, groupIndex) => [
            ...group.map((item) =>
              h('button', {
                type: 'button',
                class: 'editor-btn',
                title: item.label,
                'aria-label': item.label,
                onClick: item.action
              }, [
                item.icon
                  ? h(Icon, { icon: item.icon, class: 'h-4 w-4' })
                  : h('span', { class: 'text-[11px] font-black leading-none' }, item.text),
                h('span', { class: 'editor-tooltip' }, item.label)
              ])
            ),
            groupIndex < toolbarGroups.length - 1 ? h('span', { class: 'mx-1 h-9 w-px bg-neutral-200' }) : null
          ])
        ),
        h('div', { class: 'editor-content bg-white p-4 sm:p-5' }, [
          h(EditorContent, { editor: editor.value })
        ])
      ])
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

.textarea-field {
  display: block;
  width: 100%;
  border-radius: 1rem;
  border: 1px solid rgb(229 229 229);
  background: rgb(250 250 250);
  padding: 0.75rem 1rem;
  font-size: 0.875rem;
  font-weight: 700;
  line-height: 1.6;
  color: rgb(38 38 38);
  outline: none;
  transition: 160ms ease;
}

.textarea-field:focus {
  border-color: rgb(37 99 235);
  background: white;
  box-shadow: 0 0 0 4px rgb(219 234 254);
}

.editor-btn {
  position: relative;
  display: inline-flex;
  height: 2.35rem;
  width: 2.35rem;
  align-items: center;
  justify-content: center;
  border-radius: 0.85rem;
  padding: 0;
  font-size: 0.75rem;
  font-weight: 900;
  color: rgb(64 64 64);
  transition: 160ms ease;
}

.editor-btn:hover {
  background: white;
  color: rgb(37 99 235);
  box-shadow: 0 8px 18px rgba(15, 23, 42, 0.06);
}

.editor-tooltip {
  pointer-events: none;
  position: absolute;
  bottom: calc(100% + 8px);
  left: 50%;
  z-index: 50;
  min-width: max-content;
  transform: translateX(-50%) translateY(4px);
  border-radius: 0.75rem;
  background: rgb(23 23 23);
  padding: 0.4rem 0.6rem;
  font-size: 0.7rem;
  font-weight: 800;
  color: white;
  opacity: 0;
  transition: 120ms ease;
  box-shadow: 0 12px 30px rgba(15, 23, 42, 0.18);
}

.editor-btn:hover .editor-tooltip {
  opacity: 1;
  transform: translateX(-50%) translateY(0);
}

.editor-content :deep(.ProseMirror) {
  min-height: 420px;
  outline: none;
}

.editor-content :deep(.ProseMirror p) {
  margin: 0.75rem 0;
}

.editor-content :deep(.ProseMirror h1) {
  margin: 1.4rem 0 0.8rem;
  font-size: 2rem;
  font-weight: 950;
  line-height: 1.15;
  letter-spacing: -0.04em;
}

.editor-content :deep(.ProseMirror h2) {
  margin: 1.25rem 0 0.75rem;
  font-size: 1.55rem;
  font-weight: 950;
  line-height: 1.2;
  letter-spacing: -0.03em;
}

.editor-content :deep(.ProseMirror h3) {
  margin: 1rem 0 0.5rem;
  font-size: 1.25rem;
  font-weight: 900;
  line-height: 1.3;
}

.editor-content :deep(.ProseMirror ul),
.editor-content :deep(.ProseMirror ol) {
  margin: 0.75rem 0;
  padding-left: 1.25rem;
}

.editor-content :deep(.ProseMirror blockquote) {
  margin: 1rem 0;
  border-left: 4px solid #2563eb;
  border-radius: 0.75rem;
  background: #eff6ff;
  padding: 1rem;
  color: #1e3a8a;
}

.editor-content :deep(.ProseMirror img) {
  max-width: 100%;
  height: auto;
  margin: 1rem 0;
  border-radius: 1rem;
  border: 1px solid #e5e5e5;
}

.editor-content :deep(.ProseMirror iframe) {
  width: 100%;
  min-height: 380px;
  margin: 1rem 0;
  border: 0;
  border-radius: 1rem;
  background: #f5f5f5;
}

.editor-content :deep(.ProseMirror .tiptap-pdf) {
  min-height: 520px;
}

.editor-content :deep(.ProseMirror .tiptap-map) {
  min-height: 420px;
}

.editor-content :deep(.ProseMirror table),
.prose-preview :deep(table) {
  width: 100%;
  border-collapse: collapse;
  overflow: hidden;
  border-radius: 1rem;
}

.editor-content :deep(.ProseMirror th),
.editor-content :deep(.ProseMirror td),
.prose-preview :deep(th),
.prose-preview :deep(td) {
  border: 1px solid #e5e5e5;
  padding: 0.75rem;
  vertical-align: top;
}

.editor-content :deep(.ProseMirror th),
.prose-preview :deep(th) {
  background: #eff6ff;
  font-weight: 900;
  color: #1e3a8a;
}

.prose-preview {
  color: #262626;
  font-size: 0.95rem;
  line-height: 1.8;
}

.prose-preview :deep(h1) {
  margin: 1.4rem 0 0.8rem;
  font-size: 2rem;
  font-weight: 950;
  letter-spacing: -0.04em;
  color: #171717;
}

.prose-preview :deep(h2) {
  margin: 1.25rem 0 0.75rem;
  font-size: 1.55rem;
  font-weight: 950;
  letter-spacing: -0.03em;
  color: #171717;
}

.prose-preview :deep(h3) {
  margin: 1rem 0 0.5rem;
  font-size: 1.25rem;
  font-weight: 900;
  color: #171717;
}

.prose-preview :deep(p) {
  margin: 0.85rem 0;
}

.prose-preview :deep(a) {
  color: #2563eb;
  font-weight: 800;
  text-decoration: underline;
  text-underline-offset: 4px;
}

.prose-preview :deep(img) {
  margin: 1rem 0;
  max-width: 100%;
  height: auto;
  border-radius: 1rem;
  border: 1px solid #e5e5e5;
}

.prose-preview :deep(iframe) {
  width: 100%;
  min-height: 380px;
  margin: 1rem 0;
  border: 0;
  border-radius: 1rem;
  background: #f5f5f5;
}

.modal-fade-enter-active,
.modal-fade-leave-active,
.toast-enter-active,
.toast-leave-active {
  transition: 180ms ease;
}

.modal-fade-enter-from,
.modal-fade-leave-to {
  opacity: 0;
  transform: scale(0.98);
}

.toast-enter-from,
.toast-leave-to {
  opacity: 0;
  transform: translateY(12px);
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
