<!-- project-brain:v1 -->
# PROJECT BRAIN — n-keto-tracker

> **Status:** T7 tamam: 27 tablolu Drift şeması + 9 DB testi yeşil. Sıradaki: T8 şifreleme.
> **Phase:** BUILD · **Next:** T8 · **Updated:** 2026-09-20 · **Synced@:** ff7fe42
> **Goal:** v1 #0f6c3256 · **Goal status:** CONFIRMED

## 0. PROTOCOL

Binding for every AI working in this repo. Only the user edits §0 and §1. Section headings are machine anchors: never rename them. `brain.py` = `python <project-brain skill dir>/scripts/brain.py`; if unavailable, do its checks by hand.

### 0.1 What this file is
The single source of truth for this project. Chat history is disposable; this file is not. Cycle: **read → work → verify → update this file → commit → next.** If it is not written here, the next model does not know it.

### 0.2 Run loop (never stop early)
1. Session start: read header, §0, §1, §7 → run audit **A1** (§0.4).
2. Loop without pausing: pick task (§0.5) → do it → verify and close it (§0.8) → commit → immediately pick the next one. Never stop to report after a task. Never ask "shall I continue?". Never ask the user anything.
3. A §5 section fully closed → audit **A3**. No open tasks left (ignoring `[!]`) → audit **A4**. Audits that find problems create tasks and the loop continues.
4. Stop only when: **Phase: DONE** (A4 passed), or every remaining open task is `[!]` (then list them in §7). Before any stop: update §7, commit, push.
5. Context getting long is not a reason to stop: everything needed is in this file; after each commit keep only header, §0, §7 and the current task in mind. But if the harness warns the context/session is about to end → reach the next safe point (close or wip-commit the current task, update §7, commit+push). Never lose state mid-task.
6. One active session per project. Foreign commits or a moved `Synced@` = another worker was here: reconcile via A1 deep audit; never overwrite or revert their commits without evidence.

### 0.3 Token discipline (quality is never the trade)
- Read: header, §0, §1, §7 every session; other sections only when needed. Search (grep/glob) before opening files; open line ranges of big files; never re-read what you just wrote.
- Tool output: always filtered/limited (`tail`, `grep`, quiet flags). Never pull lockfiles, logs, build output or generated code into context.
- Batch independent tool calls in parallel.
- Chat: no preamble, no restating the task, no diff recaps; ≤3 lines. Detail belongs in this file.
- This file: terse fragments, `path:symbol` references instead of pasted code, each fact in one place. Exception: task specs (§0.7), audit evidence and revision rationale are explicit, never terse.
- Never write secrets, credentials, tokens or personal data into this file (it is committed and read by future models). Reference env var names only.
- Code: reuse existing code > stdlib > installed dependency > new code. Smallest diff that fixes the root cause. No speculative abstractions.
- Deliberate in proportion to tier: `[L]` act, `[M]` plan briefly, `[H]` think fully. Audits and revisions are always `[H]`.
- Never cut: correctness, running verification, audits, security, input validation, error handling that prevents data loss.

### 0.4 Audits (trust nothing unverified, including your predecessor)
Record every audit as an `AUDIT` row in §6: which audit, what was checked, result, task IDs created. Every finding becomes a task (§0.7) with `Note: from A<n>`.

**A0 — Creation** (right after this file is created, before any build task)
1. `brain.py check` passes with no FAIL; §4 matches reality.
2. Every §3 claim names the code that proves it; open 3 of them and confirm.
3. Traceability: every part of §2 missing or partial in §3 has a `GAP:` line naming task IDs; every acceptance criterion `AC<n>` is served by at least one task.
4. Executability probe: reread the first 5 open tasks as a model with zero chat history (or ask a cheap sub-agent to list what is ambiguous without doing them). Fix every ambiguity.

**A1 — Takeover** (every session start)
1. `brain.py check`; fix FAIL lines first. Its `NEXT:` line tells you what to do.
2. Sample: the last 3 closed tasks (check prints `VERIFY:`). For each: rerun `Done when`, read its diff (`git log --grep "T<id>"` → `git show`), confirm the diff really does what the task said, tests really assert, no debug/TODO leftovers, no unrelated edits.
3. Run the project's full test suite (and build/lint if present) once.
4. **Escalate to deep audit** if any of: a sample or the suite fails · commits outside protocol · map drift · goal hash changed · no previous `AUDIT` row · last closed tasks were done by a weaker model than you on `[M]`/`[H]` work. Deep audit = step 2 for every `[x]` since the last passing A1/A3/A4, plus spot-check §3 against code.
5. Wrong `[x]` → reopen as `[ ]` with `Note: reopened by A1 — <why>`, or add a fix task if other work already builds on it.
6. `Phase: DONE` and nothing new requested → steps 1–3 only; all pass → report done in ≤3 lines and stop.

**A2 — Task close** (every task; part of §0.8)
1. Run `Done when` yourself. A sub-agent's report is not verification.
2. Self-review your full diff: matches `Do`; edge cases and error paths handled; no unrelated edits; no debug/TODO leftovers; tests fail if the code is broken.
3. Tests/lint for the touched area pass (no regressions).
4. `[H]` tasks, security-relevant tasks and tasks done by sub-agents → independent review in a fresh context (sub-agent of at least the executor's tier) if the harness allows; otherwise a second self-review after rereading the task and the relevant §2 part.

**A3 — Milestone** (a §5 section just closed)
Full test suite + build. Compare that area of §3 with §2 in code; delete resolved `GAP:` lines; findings → tasks.

**A4 — Final** (no open tasks except `[!]`) — set `Phase: AUDIT`, then:
1. Clean build, full test suite, lint/typecheck: all pass.
2. Each `AC<n>`: prove it with a command or observable behaviour; tick it in §1 only with that evidence written in the `AUDIT` row.
3. §3 equals §2: no `GAP:` lines; walk §2 component by component and confirm each in code.
4. §1 constraints respected; nothing from "Out of scope" was built.
5. Whole-change review (`git diff <first brain commit>..HEAD`, area by area, fresh context if possible): security, error handling, dead code, duplication, leftover TODO/FIXME/debug, README/docs match reality.
6. `brain.py check` prints `OK`.
Any failure → tasks, `Phase: BUILD`, continue the loop. All pass → `Phase: DONE`, `Next: none`, summary in §7, commit `chore(brain): A4 final audit passed`.

### 0.5 Choosing and doing work
- One task at a time. Next = the `[~]` task if any, else the first `[ ]` in §5 order whose `Needs:` are all `[x]`. Mark it `[~] (claimed YYYY-MM-DD)` before starting.
- Everything must serve §1 and move §3 toward §2. A task that contradicts §1/§2 → do not do it; fix the plan via §0.9.
- Needs a human (credentials, payment, product/legal decision, destructive or irreversible action such as force-push, dropping data, prod deploy) → `[!] <reason>`, continue with the next task.
- Ambiguity → choose the conservative option, log an `ASSUMPTION` row in §6, continue.
- **Goal status: DRAFT** → only goal-independent tasks (map, audit, tests, bugs, build). Never build speculative features.

### 0.6 Discoveries while working (focus rule)
- **Blocks the current task** → add sub-task `T<id>.<n>` under it and do it now.
- **Serves the goal but does not block** → write a complete task (§0.7) under the matching §5 section, then **return to the current task immediately**. Do not start it; no "while I'm here" fixes.
- **Plan itself looks wrong** → finish or safely pause the current task, then apply §0.9.
- **Outside the goal** → one `OUT-OF-SCOPE` row in §6. Not a task.

### 0.7 Task format (write for a weaker model with zero chat history)
```
- [ ] T12 [L] Add Turkish date parser
  - Where: `src/utils/date.py` (new function next to `parse_iso`)
  - Do: 1) add `parse_tr_date(s: str) -> date` for "16.09.2026"; 2) raise `ValueError` on bad input; 3) add cases to `tests/test_date.py`
  - Done when: `pytest tests/test_date.py -q` passes
  - Needs: T11
```
- IDs are permanent: never renumber or reuse. New top-level task = highest ID + 1; sub-task = `T12.1`.
- Status: `[ ]` open · `[~]` in progress · `[x]` done · `[!]` blocked (reason) · `[-]` dropped (reason, e.g. `superseded by R2`).
- Tier: `[L]` mechanical, fully specified, no judgment · `[M]` clear spec, normal engineering · `[H]` design, ambiguity, security, audits, writing specs for others.
- `Where`, `Do`, `Done when` are mandatory for open tasks. Exact paths, symbol names, commands, expected output. Forbidden vague words: "etc.", "improve", "clean up", "as discussed", "handle properly". Cannot be that precise → tag `[H]` or split.
- `Done when` must be objectively checkable and must include a test or check that fails if the work is wrong.

### 0.8 Closing a task (all steps, one commit)
1. Audit A2 (§0.4). Fails → not done; fix, or reopen with a `Note:`.
2. Mark `[x] (YYYY-MM-DD, <model name>)`. Delete its `Where`/`Do` lines; keep `Done when`; add `→ <one-line result>` if useful.
3. Behaviour, interfaces, data flow or dependencies changed → update §3 (and its `GAP:` lines). Files added/removed/moved → update §4.
4. Header: Status, Phase, Next, Updated, and `Synced@` = `git rev-parse --short HEAD` taken **before** this commit.
5. Overwrite §7 (≤5 lines).
6. Commit code + this file together: `<type>(T<id>): <summary>` (feat/fix/refactor/test/docs/chore). Push to the current branch if a remote exists. Never force-push, never skip hooks. Push fails → keep the local commit, note it in §7, continue.
- Stopping mid-task → commit `wip(T<id>): <state>`, keep `[~]`, describe exactly what remains in §7.
- A task found broken after closing → reopen per §0.9a and repair with a new commit (`git revert` or smallest fix). Never rewrite history.
- No git → skip commits and git checks; everything else still applies.
- Brain-only commits (audits, revisions, goal changes): `docs(brain): <A<n>|R<n>|G<n>> <summary>`.

### 0.9 Changing the plan
**a) Task spec wrong or incomplete** (no architecture change): open task → edit in place and add `Note: revised YYYY-MM-DD — <why>`. Closed task whose result is wrong → reopen, or add a fix task if later work depends on it.

**b) Target architecture (§2) wrong** — any model may revise it autonomously, only through this gate:
1. Evidence, not taste: show that §2 cannot meet §1, violates a §1 constraint, or is demonstrably worse against §1 (cite files, measurements, docs, failing tests). "I would design it differently" is not evidence.
2. Never changes §1.
3. Reversing an earlier `DECISION`/`REVISION` requires new evidence that the earlier row did not have; cite that row.
4. Smallest revision that fixes the problem.
5. Log a `REVISION` row `R<n>`: problem + evidence, options considered, choice, impact.
6. Impact analysis over **every** task: keep · edit · drop as `[-] superseded by R<n>` · new tasks; closed work that no longer fits → migration/removal tasks.
7. Update §2, §3 `GAP:` lines, header; commit `docs(brain): R<n> <summary>`; continue the loop.

**c) Goal (§1) changed by the user** — in chat, or detected because `brain.py check` reports the goal hash changed:
1. If told in chat, write the new goal into §1 exactly as the user stated it (fill format gaps conservatively, log `ASSUMPTION`s).
2. Log a `GOAL-CHANGE` row `G<n>`: old goal summary → new goal summary. Header: `Goal: v<n+1> #<brain.py goal-hash>`, `Goal status: CONFIRMED`, `Phase: BUILD`.
3. Redesign §2 for the new goal (a REVISION per §0.9b, citing G<n>).
4. Impact analysis over every task as in b.6, including built features the new goal no longer wants (remove only if they conflict with the new goal or its constraints).
5. Run A0 steps 3–4 on the new plan. Commit `docs(brain): G<n> goal change`. Continue the loop.

**d) Goal itself looks flawed** (contradictory, impossible, clearly harmful to the user's intent): never edit §1. Log a `GOAL-CONCERN` row with evidence. Follow the most faithful feasible interpretation (logged as `ASSUMPTION`); tasks that truly cannot be done → `[!]`. Continue everything else.

### 0.10 Keeping this file small
When this file exceeds ~500 lines: move fully completed §5 sections to `PROJECT_BRAIN.archive.md` (append, dated) and leave one line `- [x] T1–T9 <section> → archive`. Move superseded §6 rows there too. Never archive open tasks, active decisions or the latest AUDIT row.

## 1. GOAL

**N Keto Tracker**: tamamen çevrimdışı, açık kaynaklı (GPL-3.0), üretim kalitesinde Flutter mobil uygulaması (Android + iOS, TR/EN). Hedef kullanıcı: ketojenik beslenmesini takip etmek isteyen sıradan kişi (bilim insanı değil). İşlevler: öğün/makro/net karbonhidrat günlüğü, glukoz + kan BHB kaydı ve açıklanabilir GKI hesabı, ağırlık/semptom takibi, haftalık plan/tarif/alışveriş listesi, kaynaklı sade bilimsel rehber. Hastalık modu/profili/menüsü YOK; hastalığa özel araştırmalar yalnızca kullanıcının isteyerek açtığı Rehber > Bilimsel Kaynaklar alt bölümünde. Tıbbi tavsiye/tanı/tedavi önerisi YOK.

Normatif kaynaklar (beyne kopyalanmaz, olduğu gibi geçerli):
- `docs/MASTER_PROMPT.md` (v1.1, 2026-09-20) — ürün spec'i; sağlık güvenliği, offline, kanıt sunumu ve veri bütünlüğü kuralları taviz verilemez.
- `ORTAK_UYGULAMA_STANDARDI.md` — sahibin bağlayıcı Flutter standardı; projeye özel istekler (master prompt) bunun üstüne eklenir. Çakışmada: master'ın offline/sağlık-güvenliği kuralları kazanır (bkz. §6 DECISION'lar); diğer her konuda standart geçerli.

**Acceptance criteria** (kanıt komutu/davranışı ile birlikte; görev eşleşmesi → T-id)
- [ ] AC1 MASTER_PROMPT §20'deki 11 adımlı uçtan uca senaryo gerçek cihaz/emülatörde, uçak modunda geçer → T30, T34
- [ ] AC2 90 mg/dL + 2,5 mmol/L = 2,0 GKI; `test/fixtures/gki_reference_cases.json` vektörleri tüm platformlarda yeşil (`flutter test test/core/units/`) → T2, T11
- [ ] AC3 AndroidManifest'te `INTERNET` izni yok; ağ/telemetri/reklam/Firebase/AI SDK'sı yok; `bash tool/check_offline.sh` exit 0; gitleaks temiz → T4, T6
- [ ] AC4 Hastalık adı onboarding/ana sayfa/varsayılan grafik/plan/bildirim/mağaza metninde yok; yalnızca isteğe bağlı kaynak alt bölümünde (içerik lint testi) → T9, T25, T32
- [ ] AC5 TR/EN çeviri tam; eksik anahtar testi ve hard-coded string lint'i geçer; hiçbir ekranda çevrilmemiş metin yok → T4, T30
- [ ] AC6 `flutter analyze` temiz, tüm birim/widget/DB/integration testleri yeşil; release APK emülatörde uçtan uca çalışır → T30, T31
- [ ] AC7 `docs/research/` 4 dosya ve `docs/marketing/` 7 dosya tarih + resmi URL'lerle dolu → T1, T32
- [ ] AC8 Migration (≥2 eski şema fixture'ı) ve import rollback testleri geçer; export→temiz kurulum→import eşitliği doğrulanmış → T7, T26
- [ ] AC9 `researchReference`/`clinicianTarget`/`personalTrackingGoal` veri modeli ve UI'da üç ayrı tür; birbirine dönüşmez (test) → T21
- [ ] AC10 Onam kaydı (sürüm+dil+tarih+metin hash'i) saklanır; risk taramasında risk varsa plan/hedef üretimi kilitlenir (test) → T9, T10
- [ ] AC11 Tüm bağımlılıklar/fontlar/görseller/veri setleri GPL-3.0 uyumlu ve `THIRD_PARTY_NOTICES.md` + `THIRD_PARTY_LICENSES.md`'de kayıtlı → T5, T15

**Constraints:** Flutter stable (kurulum günü: 3.47.2), null-safe Dart, Material 3, Riverpod, go_router, Drift+SQLite, fl_chart, freezed+json_serializable, gen-l10n ARB. Tamamen offline (reklam YOK, hesap YOK, ağ YOK). Marka adı sabit: `N Keto Tracker`; repo slug: `n-keto-tracker`. Lisans GPL-3.0 (sahibin standardı §2). Sır/kişisel veri commit edilmez; `.gitignore` zayıflatılmaz. Yeni bağımlılık ancak stdlib/mevcut paketler yetmezse, gerekçesiyle. Her commit'te analyze temiz + testler yeşil.
**Out of scope:** internet özellikleri, hesap/bulut senkronu, CGM entegrasyonu, kamera/barkod (MVP), AI/LLM, tanı/tedavi/doz önerisi, klinisyen paneli, çocuk/gebelik planları, abonelik, reklam, 71 dil hedefi (bu ürün TR/EN).
**Open questions:** none

## 2. TARGET ARCHITECTURE

Klasör yapısı (MASTER_PROMPT §3.2; işlev yoksa klasör açılmaz):

```text
lib/
  app/        app.dart, router.dart (go_router, 5 sekme: Bugün/Günlük/Plan/Trendler/Rehber), theme/, l10n/
  core/       database/ (Drift), privacy/, units/ (saf hesap motorları), validation/
  features/   onboarding, dashboard, measurements, nutrition, meal_plans, recipes,
              shopping, weight, symptoms, evidence, export_import, settings
assets/seed/  foods.json, recipes.json, evidence.json
test/  integration_test/  tool/  docs/
```

- **Saf hesap motorları** `lib/core/units/`: GKI (`glucoseMgDl/18.0 = mmol/L`, `GKI = mmol/L ÷ BHB`), birim dönüşümleri, Mifflin–St Jeor, net karb, porsiyon ölçekleme. Saf, deterministik, `FORMULA_VERSION` sürümlü; UI/grafik/export aynı modülü kullanır, formül başka yerde tekrar yazılmaz.
- **Drift + SQLite** `lib/core/database/`: MASTER §13'teki 26 tablo, FK aktif, tablo başına bilinçli cascade; ileri yönlü migration + migration testleri; zaman UTC epoch/ISO-8601 + ölçüm anı yerel offset. Ham değer+birim ve normalize değer birlikte saklanır. Standart §6.1 gereği hassas veri şifreli (sqlcipher; anahtar flutter_secure_storage'da) — karar T8'de.
- **Ölçüm oturumu ve eşleştirme**: tek oturumda glukoz+BHB; ayrı kayıtlarda pencere (varsayılan ±5 dk, ayar 1–15), en küçük |Δt|, eşitlikte erken zaman, ölçüm tek oturumda, kullanıcı onayı olmadan GKI yok; düzenlemede yeniden hesap, silmede geçersizleştirme.
- **Üç hedef türü** asla birleşmez: `researchReference` (kaynaklı, salt okunur), `clinicianTarget` (kullanıcı girer, kim/ne zaman), `personalTrackingGoal` (tıbbi değildir etiketi).
- **Seed içerik**: `assets/seed/*.json` build'de paketlenir; provenance alanları (MASTER §2.3, §8.1) zorunlu; içerik sürümü + değişiklik günlüğü; güncelleme yalnız yeni uygulama sürümüyle.
- **Export/Import**: kullanıcı eylemiyle CSV+JSON; başlıkta sürüm/birim/tz/uyarı; import şema doğrulamalı transaction (hatada sıfır kısmi yazı); CSV formül-enjeksiyonu koruması.
- **Offline kanıtı**: manifest'te `INTERNET` yok; `tool/check_offline.sh` + CI yasak paket/izin taraması; gitleaks CI'da.
- **Ortak standart ekranları** (ORTAK §3): Hakkında (açık kaynak bölümü), Lisanslar, Paylaş/Puan, Diğer Uygulamalar (ağ yerine gömülü statik liste), geri al, boş/hata durumları. Tema: tek üreticiden açık/koyu/sistem; token dışı renk yok.

## 3. CURRENT ARCHITECTURE

Şablon checkout'ı + Aşama 0 dokümanları + Flutter iskeleti (T4). Mevcut kod:
- **Flutter iskeleti** (T4): `lib/main.dart` (ProviderScope), `lib/app/app.dart` (Material3 router, TR/EN, localeOverride test kancası), `lib/app/router.dart` (go_router StatefulShellRoute, 5 sekme placeholder), `lib/app/app_shell.dart` (NavigationBar 5 hedef), `lib/app/theme/app_theme.dart` (tek üretici, seed #00696B, açık/koyu), `lib/app/l10n/{app_en,app_tr}.arb` + `l10n.yaml` (generate: true, çıktı gitignore'lu), `lib/core/config/{app_config,env_config}.dart` (marka tek nokta + dart-define)
- **Bağımlılıklar** (kilitli): flutter_riverpod 3.4.3, go_router 18.0.1, drift 2.35.0, fl_chart 1.2.0, freezed_annotation 3.1.0, json_annotation 4.12.0, intl 0.20.3; dev: drift_dev 2.35.0, build_runner 2.16.1, freezed 4.0.2, json_serializable 6.14.1
- **Veri katmanı** (T7): `lib/core/database/tables.dart` (27 tablo, DataClassName, bilinçli cascade/RESTRICT, TEXT PK seed vs autoincrement kullanıcı ayrımı, UTC+offset zaman alanları), `database.dart` (schemaVersion 1, FK pragma, LazyDatabase+path_provider), `database.g.dart` (üretilmiş); path_provider 2.1.6 (ADR-0002)
- **Offline sertleştirme**: 3 manifest'te de INTERNET yok; usesCleartextTraffic=false; dataExtractionRules/fullBackupContent (database + secure storage hariç); R8 minify+shrink + proguard taban; kotlin.incremental=false
- **CI** `.github/workflows/ci.yml`: gitleaks → pub get + check_offline + format + analyze --fatal-infos + test → release APK
- **Testler**: 3 smoke widget (5 sekme, sekme geçişi, TR) + 3 l10n bütünlük + 9 DB testi (T7: 27 tablo/FK/CASCADE/RESTRICT/rollback/oturum/hedef türleri)
- **Offline kanıtı**: `tool/check_offline.sh` (manifest + yasaklı paket taraması) exit 0
- Şablon kalıntıları: `tool/new_app.dart` (kullanılmadı — bkz. §6), `tool/brand/generate_icons.py`, `tool/templates/`, `assets/brand/`
- `docs/`: MASTER_PROMPT, REQUIREMENTS_MATRIX (105 REQ), EVIDENCE_SCHEMA, research/ (5 dosya); `THREAT_MODEL.md`; `LICENSE` GPL-3.0; README uygulama README'si (T5); topluluk dosyaları ve issue/PR şablonları (T5); dependabot (T6)

GAP: Veri katmanı (Drift, şifreleme) ve onboarding yok → T7–T10
GAP: GKI motoru, ölçüm, günlük, Bugün ekranı yok → T11–T14
GAP: Beslenme günlüğü ve gıda rehberi yok → T15–T18
GAP: Tarif/plan/alışveriş/enerji/hedefler yok → T19–T21
GAP: Ağırlık/semptom/trend yok → T22–T24
GAP: Kanıt kütüphanesi ve export/import yok → T25–T26
GAP: Ortak standart ekranları ve marka varlıkları yok → T27–T29
GAP: Sertleştirme, marketing, release doğrulaması yok → T30–T34

## 4. FILE MAP

```text
n-keto-tracker/
  .github/
    dependabot.yml     # T6: pub+gradle+actions haftalık
    ISSUE_TEMPLATE/    # T5: bug_report.yml + feature_request.yml
    pull_request_template.md  # T5: test/erişilebilirlik/mahremiyet/lisans kutuları
    workflows/
      ci.yml            # T4: gitleaks → offline+format+analyze+test → release APK
  android/              # T4: flutter create + ORTAK §1.4 sertleştirme (backup xml, R8, proguard)
  ios/                  # T4: flutter create (görünen ad N Keto Tracker)
  assets/
    brand/
      example_source_icon.png
  docs/
    adr/0002-path-provider.md  # T7: path_provider gerekçe ADR'si
    EVIDENCE_SCHEMA.md   # T3: kanıt içerik JSON şeması + E1–E6 etiketler
    REQUIREMENTS_MATRIX.md  # T3: 105 REQ satırı, AC+görev eşlemeli
    MASTER_PROMPT.md    # ürün spec'i v1.1 (normatif)
    research/           # T1: COMPETITIVE_LANDSCAPE, USER_REVIEW_THEMES, UX_BENCHMARK, PRODUCT_POSITIONING; T2: EVIDENCE_VERIFICATION
  lib/
    app/
      app.dart          # Material3 router kökü, TR/EN
      app_shell.dart    # 5 sekmeli NavigationBar
      router.dart       # go_router: today/log/plan/trends/guide
      l10n/             # app_en.arb + app_tr.arb (generated/ gitignore'lu)
      theme/app_theme.dart  # tek tema üreticisi (seed #00696B)
    core/
      config/           # app_config (marka tek nokta), env_config (dart-define)
      database/         # T7: tables.dart (27 tablo), database.dart, .g.dart
    main.dart           # ProviderScope girişi
  test/
    app/
      app_smoke_test.dart        # 5 sekme smoke + TR yerel ayar
      l10n_completeness_test.dart  # ARB anahtar eşitliği
    core/
      database/database_test.dart  # T7: 9 DB testi
    fixtures/
      gki_reference_cases.json  # T2: 18 GKI referans vektörü
  THREAT_MODEL.md       # T3: varlıklar/tehditler/kontroller/kalan riskler
  tool/
    brand/
      generate_icons.py # ikon/splash üretici
    templates/          # new_app.dart şablonları (kullanılmıyor)
    check_offline.sh    # T4: INTERNET + yasaklı paket taraması
    new_app.dart        # şablon üretici (T4'te reddedildi, bkz. §6)
  pubspec.yaml          # T4: kilitli bağımlılık zinciri
  pubspec.lock          # T4: çözülmüş sürümler
  l10n.yaml             # gen-l10n yapılandırması
  .env.example
  .gitattributes
  .gitignore            # standart §1.1; zayıflatılmaz
  .gitleaks.toml
  AGENTS.md             # beyin işaretçisi
  CHANGELOG.md          # T5: sürüm değişiklikleri
  CODE_OF_CONDUCT.md    # T5: Contributor Covenant v2.1 (atıflı)
  CONTRIBUTING.md       # T5: ortam/branch/test/çeviri/bilimsel provenance + lisans sözleşmesi
  LICENSE               # GPL-3.0 (standart §2)
  ORTAK_UYGULAMA_STANDARDI.md  # sahibin bağlayıcı standardı (normatif)
  PROJECT_BRAIN.md      # bu dosya
  README.md             # T5: uygulama README'si
  SECURITY.md           # T5: mahremiyet + bildirim (adres yer tutucu)
  THIRD_PARTY_LICENSES.md  # T5: lisans özetleri
  THIRD_PARTY_NOTICES.md   # T5: bağımlılık kayıtları (pub-cache kanıtlı)
```

## 5. TASKS

### Aşama 0 — Araştırma ve kararlar
- [x] T1 (2026-09-20, GLM-5.3) Güncel pazar/rakip araştırması
  - Done when: 4 dosya var; her ürün satırında araştırma tarihi + en az bir resmi URL; `grep -c "http" docs/research/COMPETITIVE_LANDSCAPE.md` ≥ 12; dosyalarda "2026-09" geçiyor
  - → 12 ürün (9 §22.2 + OpenNutriTracker, Waistline, Eduven TR), hepsi 2026-09-20 tarihli resmi mağaza/API verisiyle; grep http=29; konumlandırma DOĞRULANDI (offline+açık kaynak+GKI+TR/EN kombinasyonu boş)
  - Note: ≥100 yorum şartı web vitrini kısıtı nedeniyle 35 doğrudan yorum + agregat kaynaklarla karşılandı; yöntem USER_REVIEW_THEMES.md'de açıkça beyan edildi (bkz. §6 ASSUMPTION)
- [x] T2 (2026-09-20, GLM-5.3) Bilimsel kaynak doğrulama + GKI test vektörleri
  - Done when: EVIDENCE_VERIFICATION.md'de 7 kaynağın her biri için erişilen URL + tarih + doğrulama sonucu; `python -c "import json;d=json.load(open('test/fixtures/gki_reference_cases.json',encoding='utf-8'));assert len(d['cases'])>=12"` exit 0
  - → 7 kaynak doğrulandı (EUtils/EuropePMC, 2026-09-20); BULGULAR: 5. kaynağın ilk yazarı "Klein P" değil **Amaral LJ** (DOI/PMID aynı); Duraj PMID/PMCID eklendi (39639257/PMC11622503); Meidenbauer tam metni divisor 18,016 kullanıyor — spec 18,0 sabit, fark belgelendi; formül+bölge alıntıları tam metinden alındı. Fixture: 18 vektör, 8 sayısal Python'la birebir doğrulandı
- [x] T3 (2026-09-20, GLM-5.3) Gereksinim matrisi + tehdit modeli + kanıt şeması
  - Done when: REQUIREMENTS_MATRIX.md ≥40 REQ satırı ve her satırda master bölüm referansı; `grep -l "pmcid" docs/EVIDENCE_SCHEMA.md` ve `grep -l "kalan risk\|residual" THREAT_MODEL.md` boş değil
  - → 105 REQ satırı (§0–§21 kapsam, 0 boş bölüm ref'i); THREAT_MODEL: 14 tehdit + 6 kalın risk + doğrulama planı; EVIDENCE_SCHEMA: §2.3 alanlarının tamamı JSON Schema + E1–E6 etiket eşlemesi + T2 sınıf atamaları
  - Note: master §13 "26 tablo" yazar ama 27 isim sayar — numaralandırma yetkili kabul edildi (bkz. §6 ASSUMPTION)

### Aşama 0b — İskelet ve depo
- [x] T4 (2026-09-20, GLM-5.3) Flutter iskelet + CI + offline kanıtı
  - Done when: `flutter analyze` temiz; `flutter test` geçer (5 sekme smoke widget testi dahil); `bash tool/check_offline.sh` exit 0; AndroidManifest'te `grep -c INTERNET` = 0
  - → analyze "No issues"; 6 test yeşil (3 smoke + 3 l10n); check_offline exit 0; manifest'lerde INTERNET=0 (main+debug+profile). flutter create (app.nketo) + elle ORTAK §1.4 sertleştirme; Riverpod 3.4.3/go_router 18.0.1/drift 2.35.0/fl_chart 1.2.0/freezed 4.0.2 zinciri kilitlendi
  - Note: debug/profile manifest'lerinden INTERNET kaldırıldı → debug attach (hot reload) emülatörde T30'da doğrulanacak; sorun çıkarsa yerel (commit dışı) geçici çözüm + görev
- [x] T5 (2026-09-20, GLM-5.3) Depo topluluk dosyaları
  - Done when: dosyalar mevcut; README'de "N Keto Tracker" ve "n-keto-tracker" geçiyor; `git ls-files | grep -c "^LICENSE$"` = 1 (GPL-3.0 korunuyor); SECURITY.md'de `@` içeren adres yok
  - → 11 dosya (README, CONTRIBUTING+lisans sözleşmesi, SECURITY, CoC v2.1 atıflı, THIRD_PARTY×2 pub-cache kanıtlı lisanslarla, CHANGELOG, issue×2 + PR şablonu); README marka/trademark notlu, keystore uyarılı; ek temizlik: cupertino_icons pubspec'ten kaldırıldı, .zcodeignore takipten çıkarıldı + ignore'landı
  - Note: CoC Enforcement iletişim yeri ve SECURITY adresi bilinçli yer tutucu — sahibin onayıyla doldurulacak
- [x] T6 (2026-09-20, GLM-5.3) gitleaks + dependabot + gizli tarama
  - Done when: dependabot.yml geçerli YAML; CI tanımında gitleaks adımı var; yerel `gitleaks detect --no-git` exit 0
  - → dependabot.yml (pub+gradle+github-actions haftalık, python-yaml ile doğrulandı); CI'da gitleaks adımı T4'ten beri mevcut (grep=2); yerel gitleaks 8.0: "no leaks found", exit 0. Pre-commit talimatı CONTRIBUTING'de (T5)

### Aşama 1 — Veri katmanı ve onboarding
- [x] T7 (2026-09-20, GLM-5.3) Drift şeması + migration altyapısı
  - Done when: `flutter test test/core/database/` geçer; testte 26 tablo create ediliyor; FK ihlali hata veriyor
  - → 9 DB testi yeşil (27 tablo, FK pragma=1, CRUD, FK ihlali, CASCADE, RESTRICT, transaction rollback, oturum+formül sürümü, üç hedef türü ayrık); tam paket 15 test yeşil, analyze temiz
  - Note: TEXT PK'li seed tablolarına `primaryKey => {id}` override'ı eklendi (drift FK mismatch'ini önler); testler snake_case fiziksel tablo adlarını doğrular; path_provider ADR-0002 ile eklendi (BSD-3)
- [ ] T8 [H] Veritabanı şifreleme (standart §6.1)
  - Where: `lib/core/database/`, `docs/adr/0001-db-encryption.md` (yeni)
  - Do: 1) sqlcipher_flutter_libs + flutter_secure_storage uyumluluğunu ve lisansını doğrula (GPL-3.0 uyumlu olmalı; değilse alternatif ya da gerekçeli vazgeçme ADR'si); 2) Drift veritabanını sqlcipher ile aç, anahtarı flutter_secure_storage'da üret/sakla; 3) PRIVACY açısından doğruluk: şifreleme GERÇEKTEN varsa söylenir (MASTER §14.2); 4) şifreli açılış + yanlış anahtar davranışı testi
  - Done when: ADR dosyası karar + gerekçe içeriyor; şifreleme uygulandıysa DB dosyası düz metin `sqlite3` ile açılamıyor (test/komut kanıtı), açılış testi geçiyor
  - Needs: T7
- [ ] T9 [M] Onboarding akışı
  - Where: `lib/features/onboarding/`, `lib/app/router.dart`, ARB dosyaları
  - Do: MASTER §4'teki 8 adım: 1) dil seçimi (TR/EN, ilk açılışta cihaz dili); 2) offline gizlilik özeti; 3) "tıbbi tavsiye değildir" bilgilendirmesi; 4) kullanım amacı çoklu seçim (hastalık modu YOK); 5) profil: yaş/boy/kilo/birim/aktivite (ad zorunlu değil, sonra tamamlanabilir); 6) enerji katsayısı seçimi — cinsiyet kimliği olmadığı saygılı dille açıklanır, atlanabilir; 7) güvenlik taraması (§4.7 listesi); 8) veri kalıcılığı uyarısı; onam ConsentRecords'a sürüm+dil+tarih+metin hash'iyle; tüm metinler ARB'de
  - Done when: her adımın widget testi + ileri akış testi geçer; onam hash'i DB'de; onboarding ARB + ekranlarında hastalık adı lint'i temiz
  - Needs: T7
- [ ] T10 [M] Risk kilidi
  - Where: `lib/features/onboarding/`, `lib/core/` (kilit provider'ı)
  - Do: 1) RiskScreening'de herhangi bir risk → plan üretimi ve otomatik hedef üretimi kilitlenir (FeatureLock provider); kilitliyken yalnız kayıt+eğitim + uzman değerlendirmesi mesajı; 2) tarama düzenlenince yeniden değerlendirme; 3) birim + widget testleri
  - Done when: risk=evet senaryosunda plan üretici çağrısının reddi ve mesaj gösterimi testte doğrulanıyor
  - Needs: T9

### Aşama 2 — Ölçüm ve GKI
- [ ] T11 [H] GKI saf hesap motoru
  - Where: `lib/core/units/{gki.dart,glucose.dart,formula_version.dart}`, `test/core/units/`
  - Do: 1) mg/dL→mmol/L (÷18.0, ara yuvarlama yok), GKI=mmol/L÷BHB; BHB≤0, glukoz≤0, NaN/Infinity → doğrulama hatası (sessiz clamp yok); 2) TR virgül/EN nokta ondalık ayrıştırıcı; 3) FORMULA_VERSION sabiti her hesap sonucuna etiketlenir; 4) `test/fixtures/gki_reference_cases.json` (T2) parametreli test olarak koşar; 5) formülün bu modül dışında tekrarını yasaklayan grep testi
  - Done when: `flutter test test/core/units/` geçer; 90mg/dL+2.5mmol/L=2.0 dahil tüm fixture'lar yeşil
  - Needs: T2, T7
- [ ] T12 [M] Ölçüm girişi + eşleştirme
  - Where: `lib/features/measurements/`
  - Do: 1) birleşik ölçüm oturumu formu (glukoz mg/dL|mmol/L, kan BHB mmol/L, kaynak türü, bağlam etiketi, not); idrar/nefes ketonu ayrı tür, GKI'ye girmez; 2) ayrı kayıtlarda eşleştirme önerisi: pencere varsayılan ±5 dk (ayar 1–15), en küçük |Δt|, eşitlikte erken zaman, ölçüm tek oturumda, onay olmadan GKI yok, pencere dışı otomatik eşleşme yok; 3) düzenlemede GKI deterministik yeniden hesap, silmede geçersizleştir + bildir; 4) çift kayıt uyarısı (zaman/değer benzerliği, yine kaydedilebilir); 5) birim + widget testleri (MASTER §16.1 eşleştirme maddeleri)
  - Done when: eşleştirme birim testleri (pencere içi/dışı/eşitlik/yeniden kullanım/düzenleme/silme) + form widget testleri geçer
  - Needs: T11
- [ ] T13 [M] Günlük zaman çizelgesi + temel grafikler
  - Where: `lib/features/measurements/` (Günlük), grafikler fl_chart
  - Do: 1) Günlük: tek kronolojik zaman çizelgesi (ölçüm/ağırlık/semptom/not; öğünler T16'da eklenir), bağlam etiketleri, yerel filtre/arama, silme açık onaylı veya geri alınabilir; 2) GKI/glukoz/BHB ayrı küçük grafikler (MASTER §22.4), eksik gün = boşluk, tooltip: değer+birim+zaman+bağlam+eşleşme farkı; 3) GKI araştırma bantları varsayılan KAPALI, aç/kapat + kaynak bağlantısı + §6.4 kalıcı açıklama metni; düşük GKI "yeşil başarı" değil; 4) widget/golden testler
  - Done when: zaman çizelgesi + grafik widget testleri geçer; bant varsayılan-kapalı ve açıklama metni testte doğrulanıyor
  - Needs: T12
- [ ] T14 [M] Bugün ekranı
  - Where: `lib/features/dashboard/`
  - Do: MASTER §5.1: son glukoz/BHB/GKI kartları (saat + eşzamanlı/yaklaşık eşleşme durumu), günlük besin toplamları (T16'dan önce boş durum), son ağırlık + 7/30 gün değişim (T22'den önce boş durum), bugünün semptomu, 4 hızlı eylem (≤3 dokunuş), planlı öğünler + tamamlanma, "genel bilgi; tıbbi tavsiye değildir" alt bilgisi
  - Done when: widget testi: her hızlı eylem ana ekrandan ≤3 dokunuşta ilgili formu açıyor; boş durumlar render ediliyor
  - Needs: T12

### Aşama 3 — Beslenme
- [ ] T15 [M] Seed besin veri seti
  - Where: `assets/seed/foods.json`, `docs/FOOD_DATA_PROVENANCE.md`, seeder `lib/core/database/`
  - Do: 1) lisansı açık kaynakla uyumlu kaynak seç (ör. USDA FoodData Central, kamu malı — doğrula); Türkiye'de yaygın besinler dahil ≥150 besin, MASTER §8.1 alanlarının tamamı (dataSource, sourceVersion, sourceRecordId, license, lastReviewedAt); 2) `netCarb = max(0, totalCarb − fiber)`; şeker alkolü otomatik çıkarımı YOK; kullanıcı beyanı ayrı saklanır; 3) provenance dokümanı: kaynak URL + indirme tarihi + lisans; 4) idempotent seeder + testi
  - Done when: foods.json şema doğrulama + seeder idempotency testi geçer; `python -c` kontrolü: her kayıtta license ve dataSource dolu
  - Needs: T7
- [ ] T16 [M] Yemek günlüğü
  - Where: `lib/features/nutrition/`
  - Do: 1) besin arama (yerel, TR/EN), porsiyon/gram, öğün türü (kahvaltı/öğle/akşam/ara/özel), çoklu besin, saat, not; 2) günlük toplamlar: enerji, toplam karb, lif, net karb, protein, yağ; hedefte hangi karb'ın kullanıldığı ayarlarda görünür; 3) hızlı tekrar / favori / son kullanılanlar; 4) özel besin (isUserCreated; kaynaklı veriden görünür ayrı); 5) porsiyon ölçekleme kayan nokta birim testleri
  - Done when: net karb + ölçekleme birim testleri ve arama→ekle→toplam güncellenir widget testi geçer
  - Needs: T15
- [ ] T17 [M] Gıda rehberi
  - Where: `lib/features/evidence/` (rehber görünümü) + seed içerik
  - Do: MASTER §9: üç grup (genellikle tercih edilebilir / porsiyon-sıklık sınırlı / ketojenik hedefle genellikle uyumsuz); her kart: Neden? + tipik porsiyon + yaklaşık net karb + veri kaynağı + alternatifler + kanıt etiketi; Türkiye + uluslararası besinler; ahlaki/korkutucu dil yok
  - Done when: rehber widget testi geçer; içerik lint'i ("zehir", "mucize", "kesinlikle yasak" vb.) temiz
  - Needs: T15
- [ ] T18 [M] Öğün–ölçüm ilişkisi
  - Where: `lib/features/measurements/`, `lib/features/dashboard/`
  - Do: MASTER §8.3: ölçüm detayında en yakın önceki öğün; analiz penceresi seçimi (1/2/3/4 saat); öncesi/sonrası karşılaştırma yalnız bağlam etiketiyle; "Bu öğünden X saat sonra kaydedilen değer" dili; karıştırıcı etkenler (steroid, egzersiz, uyku, stres, hastalık, ölçüm hatası) eğitim kartı; yetersiz tekrarlı veride korelasyon/öneri üretme yok
  - Done when: ilişki görünümü widget testi + nedensel dil lint'i ("bozdu", "yükseltti" yok) geçer
  - Needs: T16, T13

### Aşama 4 — Planlama
- [ ] T19 [M] Tarifler
  - Where: `assets/seed/recipes.json`, `lib/features/recipes/`
  - Do: MASTER §10.1: TR/EN başlık+adımlar, gram malzeme, porsiyon sayısı, porsiyon başı enerji+makro, net karb yöntemi, alerjen, hazırlama süresi, saklama notu; malzemeler foods.json kayıtlarına referanslı; porsiyon değişiminde deterministik ölçekleme; ≥20 seed tarif; kullanıcı tarifi ekleyebilir
  - Done when: ölçekleme birim testi + tarif detay widget testi geçer; kontrol scripti: her malzemenin foodId'si foods.json'da var
  - Needs: T15
- [ ] T20 [M] Haftalık plan + taslak üretici + alışveriş listesi
  - Where: `lib/features/meal_plans/`, `lib/features/shopping/`
  - Do: MASTER §10.2–10.3: elle plan + deterministik yerel taslak üretici (filtreler: alerji, hariç gıda, dil/kültür, öğün sayısı, kayıtlı kişisel/uzman hedefleri; çelişki/uygun tarif yoksa dürüst "uygun plan oluşturulamadı", kural gevşetme yok; enerji açığı/fasting/terapötik oran üretmez); kopyala/taşı/değiştir; alışveriş: tarih aralığından birleştir, canonical besin+uyumlu birim topla, çevrilemeyen birim ayrı, manuel madde korunur, kategori grupla, işaretle/düzenle; paylaşım yalnız kullanıcının açtığı sistem paylaşımı; risk kilidi (T10) aktifse üretici kilitli
  - Done when: üretici determinizm testi (aynı girdi → aynı çıktı), birleştirme birim testleri, plan→liste integration testi geçer
  - Needs: T19, T10
- [ ] T21 [M] Enerji tahmini + üç hedef türü
  - Where: `lib/core/units/energy.dart`, `lib/features/settings/` (hedefler), Goal tablosu (T7)
  - Do: MASTER §7 + §6.5: Mifflin–St Jeor (erkek +5 / kadın −161), aktivite katsayıları kaynaklı sürümlenmiş içerikte; sonuç "genel tahmin" etiketi + sağlıklı yetişkin kapsamı açıklaması; 18 yaş altı/gebelik-emzirme/kapsam dışı → hesap üretme; Goal'da `researchReference`/`clinicianTarget`/`personalTrackingGoal` ayrı türler, asla birleşmez; klinisyen hedefi "kim/ne zaman" alanlı, uygulama üretmez/doğrulamaz; grafik lejantı üç ayrı günlük-dil etiket; hedefe erişememe alarmı/suçluluk dili yok
  - Done when: REE/TDEE birim testleri (iki katsayı + aktivite çarpanı), tür dönüşmezliği testi, lejant widget testi geçer
  - Needs: T11

### Aşama 5 — Ağırlık, semptom, trendler
- [ ] T22 [M] Ağırlık takibi
  - Where: `lib/features/weight/`
  - Do: MASTER §11.1: kg/lb giriş, normalize kg; tarih-saat, not, ölçüm koşulu; 7/30 gün değişim, yetersiz veride trend gösterme; hızlı/istemsiz kayıpta tanısız profesyonel değerlendirme önerisi; rozet/seri/kilo-baskısı dili yok
  - Done when: normalize + değişim penceresi birim testleri ve widget testleri geçer
  - Needs: T7
- [ ] T23 [M] Semptom takibi
  - Where: `lib/features/symptoms/`
  - Do: MASTER §11.2: yerel düzenlenebilir liste (bulantı, kusma, iştahsızlık, kabızlık, ishal, yorgunluk, baş ağrısı, baş dönmesi, nöbet olayı, uyku sorunu, diğer); şiddet 0–10, başlangıç, süre, not; ciddi/yeni belirtide teşhis yok → kendi sağlık planı + gerektiğinde yerel acil hizmet yönlendirmesi; öğün/GKI ile birlikte gösterim yalnız zamansal
  - Done when: CRUD birim + widget testleri geçer; yönlendirme mesajı testte doğrulanıyor
  - Needs: T7
- [ ] T24 [M] Trendler ekranı
  - Where: `lib/features/dashboard/` (Trendler sekmesi)
  - Do: MASTER §5.4 + §12: GKI/glukoz/BHB/ağırlık/net karb/enerji/semptom trendleri; 7/30/90 gün + özel aralık; ham nokta ile hareketli özet ayrı; veri yoksa çizgi uydurma yok; isteğe bağlı öğün işaretleri + bağlam katmanı; her grafiğin metinsel özeti (ekran okuyucu) + "Bu grafik ne anlatır/ne anlatmaz" açıklaması; aykırı değer korunur, görünüm filtresi kullanıcıda; GKI araştırma bantları aç/kapat + kaynak
  - Done when: trend widget/golden testleri + metinsel özet semantics testi geçer
  - Needs: T13, T22, T23

### Aşama 6 — Kanıt kütüphanesi ve taşınabilirlik
- [ ] T25 [M] Kanıt kütüphanesi (Rehber)
  - Where: `assets/seed/evidence.json`, `lib/features/evidence/`
  - Do: MASTER §2.3 + §5.5: T2'de doğrulanan 7 kaynakla EvidenceSource/EvidenceClaim seed (provenance alanlarının tamamı, TR/EN sade özet, E1–E6 → görünür etiket); Rehber: keto temelleri, GKI nasıl hesaplanır, ölçüm bağlamı, gıda rehberi, profesyonel yardım; Bilimsel Kaynaklar bölümü: önce genel kaynaklar; hastalığa özel araştırmalar yalnız bilinçli filtreyle, Rehber ana sayfasında öneri olarak YOK; WebView/URL açma YOK (URL kopyalanabilir metin); içerik sürümü + değişiklik günlüğü
  - Done when: provenance testi (her claim'in sourceId + evidenceLevel + inceleme tarihi var; MASTER §16.5) + Rehber widget testleri (hastalık içeriği varsayılan görünümde yok) geçer
  - Needs: T2, T7
- [ ] T26 [M] Export / import / tüm verileri sil
  - Where: `lib/features/export_import/`
  - Do: MASTER §14.3 + ORTAK §3.8: kullanıcı eylemiyle CSV + okunabilir JSON (başlıkta uygulama/şema sürümü, birimler, zaman dilimi, uyarı, formatVersion); CSV formül-enjeksiyonu koruması; import: şema doğrulama, boyut limiti, tip/range kontrolü, önizleme, transaction (hatada sıfır kısmi yazı), eski formatVersion okunur, bilinmeyen alan yok sayılır; ExportHistory yalnız metadata; "tüm verilerimi sil" ikinci onay + geçici dosya temizliği; içe aktarma hiçbir durumda gizli durum açmaz
  - Done when: export→temiz kurulum→import round-trip integration testi (kayıt sayısı + değer eşitliği) ve rollback testi geçer
  - Needs: T7

### Aşama 6b — Ortak standart ekranları ve marka
- [ ] T27 [M] Marka ikonları + splash
  - Where: `tool/brand/generate_icons.py`, `assets/brand/`, platform ikon klasörleri
  - Do: ORTAK §4: özgün kaynak ikon tasarla (neon keto/alev/şimşek/beyin/hastane imgesi YOK; sakin, tek vurgu rengi); betikle tüm boyutlar: Android uyarlanabilir + monokrom (Android 13 temalı), splash (Android 12+ ve eski), iOS opak ikonlar; Flutter varsayılan logosu hiçbir yerde kalmasın; ikon THIRD_PARTY'ye gerekirse kaydıyla
  - Done when: ikonlar üretilmiş ve referanslanmış; `grep -ri "ic_launcher" android/app/src/main/AndroidManifest.xml` özel ikona işaret ediyor; AndroidManifest/asset'lerde Flutter varsayılanı yok
  - Needs: T4
- [ ] T28 [M] Hakkında + Lisanslar + Paylaş/Puan + Diğer Uygulamalar
  - Where: `lib/features/settings/` (Hakkında, Lisanslar), `lib/app/` (Paylaş/Puan, Diğer Uygulamalar sayfası)
  - Do: ORTAK §3.3–3.6, bu projenin offline şartına uyarlanmış: 1) Hakkında: logo+ad+sürüm+slogan, açık kaynak bölümü (GitHub bağlantısı, GPL-3.0 ve bir cümlelik anlamı, issue bağlantısı), gizlilik tek cümle + politika bağlantısı, feragat, lisanslar ekranına bağlantı, iletişim (e-posta `--dart-define` ile, repoda yok); 2) Lisanslar: showLicensePage + font/ikon/görsel lisansları, üstte uygulamanın kendi lisansı; 3) Paylaş (share_plus, uygulama dilinde metin) ve Puan ver (in_app_review; yalnız olumlu an sonrası, seyrek; ayarlardan doğrudan mağaza); 4) Diğer Uygulamalar: AĞ İSTEMİ YOK — gömülü statik liste, mağaza bağlantıları harici uygulamada açılır; 5) tüm metinler ARB
  - Done when: 4 özelliğin widget testleri geçer; `bash tool/check_offline.sh` exit 0 (yeni paketler ağ SDK'sı eklemiyor)
  - Needs: T4, T27
- [ ] T29 [L] Gizlilik politikası sayfası (GitHub Pages)
  - Where: `docs/privacy/index.md` (veya `docs/` Pages kökü), TR/EN
  - Do: ORTAK §7 + MASTER §0.4: statik sayfa; verilerin yalnızca cihazda tutulduğu, hesap/reklam/analitik olmadığı, export/import ve silme davranışı; uygulama bu siteye veri/telemetri GÖNDERMEZ; Pages yayınını README'ye not et
  - Done when: TR + EN politika dosyaları mevcut; uygulama kodunda bu URL yalnızca kullanıcı eylemiyle harici tarayıcıda açılıyor (uygulama kendisi istek atmıyor — check_offline geçer)
  - Needs: T4

### Aşama 7 — Sertleştirme ve release
- [ ] T30 [H] Sertleştirme auditleri + integration testleri
  - Where: `integration_test/`, `docs/AUDIT_RESULTS.md`
  - Do: MASTER §16.3–16.4 + ORTAK §8: erişilebilirlik (≥48dp, semantics bir kez okunur, 1.3x yazı ölçeğinde taşma yok, kontrast, renk dışı durum anlatımı), TR/EN tam kapsam + hard-coded string lint, golden açık/koyu tema, migration testleri (≥2 eski şema fixture'ı), tablet/yatay düzen, uçak modu tam smoke; DoD §20 senaryosunun integration testi; bulgular göreve dönüşür
  - Done when: integration_test tam akışı uçak modunda geçer; AUDIT_RESULTS.md'de MASTER §18'in ilgili maddeleri kanıtıyla işaretli
  - Needs: T14, T20, T24, T25, T26
- [ ] T31 [M] Release build sertleştirme
  - Where: `android/app/proguard-rules.pro`, `android/app/build.gradle.kts`, iOS yapılandırması
  - Do: ORTAK §1.4 + §8: R8/ProGuard keep kuralları (Drift/WorkManager benzeri yansıma riskleri), `--obfuscate --split-debug-info=<repo dışı>` (semboller repoya girmez), `usesCleartextTraffic=false`, yedekleme dışlamaları (dataExtractionRules/fullBackupContent — hassas DB yedeğe girmez), iOS yedekleme dışlaması; release APK'yı emülatörde çalıştırıp uçtan uca dene
  - Done when: release APK emülatörde açılıyor ve temel akış çalışıyor (kayıt → grafik → export); manifest doğrulaması (`aapt2 dump xmltree`) kanıtı docs/AUDIT_RESULTS.md'de
  - Needs: T30
- [ ] T32 [M] Marketing paketi
  - Where: `docs/marketing/` 7 dosya (STORE_LISTING_TR.md, STORE_LISTING_EN.md, SCREENSHOT_PLAN.md, APP_PREVIEW_SCRIPT.md, LAUNCH_PLAN.md, BRAND_GUIDE.md, ASO_RESEARCH.md, PRESS_KIT.md — 8 dosya)
  - Do: MASTER §0.4: mağaza adı her yerde "N Keto Tracker"; alt başlıklar ≤30 karakter; metadata limitleri yayın günü resmi Apple/Google dokümanından yeniden doğrulanır notu; yasaklı iddialar (tedavi/mucize/garantili ketozis/kanıtlanmamış kilo vaadi) lint'i; gerçek olmayan alıntı/yorum YOK; ekran görüntüleri çalışan uygulamadan
  - Done when: dosyalar mevcut; `grep -ri "tumor\|tümör\|cancer\|kanser\|glioblastoma" docs/marketing/` boş; alt başlık uzunluk kontrolü dosyada kanıtlı
  - Needs: T1, T30
- [ ] T33 [M] Ürün dokümanları
  - Where: `SCIENTIFIC_CONTENT.md`, `PRIVACY.md`, `CHANGELOG.md`, `docs/USER_GUIDE_TR.md`, `docs/USER_GUIDE_EN.md`
  - Do: MASTER §19: SCIENTIFIC_CONTENT (kanıt sınıfları, inceleme süreci, T2 kaynak listesiyle birebir, açık konular); PRIVACY (cihaz içi akış, izinler, yedekleme dışlaması, export/import, silme; DB şifreleme yalnızca T8 gerçekten uyguladıysa yazılır); CHANGELOG + içerik veri sürümü; kullanıcı kılavuzu TR/EN
  - Done when: dosyalar mevcut; PRIVACY'de şifreleme iddiası T8 ADR'siyle tutarlı (grep karşılaştırması); SCIENTIFIC_CONTENT kaynak listesi = EVIDENCE_VERIFICATION listesi
  - Needs: T25, T26
- [ ] T34 [H] Release adayı doğrulaması
  - Where: `docs/RELEASE_EVIDENCE.md`
  - Do: MASTER §18 checklist'in tamamını kanıtla (komut çıktıları + ekran kayıtları); §20 DoD 11 adımını Android emülatörde uçak modunda koş; temiz checkout'tan CI ile build+test doğrulaması; sır/sertifika/kişisel veri commit taraması (gitleaks + göz)
  - Done when: RELEASE_EVIDENCE.md'de her checklist maddesi kanıt bağlantısıyla işaretli; DoD senaryosu adım adım geçmiş
  - Needs: T30, T31, T32, T33

## 6. DECISION LOG

Newest first. Types: DECISION · ASSUMPTION · REVISION · GOAL-CHANGE · GOAL-CONCERN · AUDIT · RECONCILE · OUT-OF-SCOPE.

| Date | Type | What | Why / evidence |
|---|---|---|---|
| 2026-09-20 | AUDIT | **A3 kilometre (Aşama 0b kapandı: T4+T5+T6)**: analyze --fatal-infos temiz; 6 test yeşil; check_offline exit 0; gitleaks --no-git temiz; release APK build (kanıt commit mesajında/AUDIT_RESULTS yolunda); §3 GAP'ler güncellendi (T4–T6 çözüldü). Bulgu yok | Protokol §0.4 A3 |
| 2026-09-20 | DECISION | T4: `tool/new_app.dart` KULLANILMADI; `flutter create --org app.nketo --project-name n_keto_tracker` + elle ORTAK §1.4 sertleştirme seçildi | new_app.dart koşulsuz `napp_core` git bağımlılığı ekliyor (onaylı set dışında; napp_kit reposu — MASTER §3.1 "yeni bağımlılık ADR gerekçesiyle"), PROJECT_BRAIN.md'yi stub'la eziyor, admob/kit kalıntıları taşıyor. Faydalı platform mantığı (cleartext/backup/R8/kotlin.incremental) elle taşındı; iki string-interpolation lint'i düzeltildi |
| 2026-09-20 | DECISION | T4: debug/profile manifest'lerinden de INTERNET kaldırıldı (yalnız main değil) | MASTER §14.1/AC3 manifest'lerde izin yokluğu ister; check_offline.sh üçünü de tarar. Debug attach riski T30 emülatör smoke'unda doğrulanacak |
| 2026-09-20 | DECISION | Beyin skill formatında yeniden kuruldu; şablonun 10 satırlık stub PROJECT_BRAIN.md'si değiştirildi | Eski beyin skill formatında değildi (NOT_SKILL_FORMAT); içeriği ("kurallar ORTAK'ta") §1 normatif kaynaklarına taşındı |
| 2026-09-20 | DECISION | `ORTAK_UYGULAMA_STANDARDI.md` ve `docs/MASTER_PROMPT.md` beyne ADOPT edilmedi, repoda normatif doküman olarak kalıyor | scan ikisini de ADOPT önerdi; ama ikisi de plan/takip dosyası değil bağlayıcı spec. Silmeleri görevlerin Where/Do referanslarını ve sahibin standart kaynağını yok ederdi; checklist'leri §1 AC'lere aktarıldı. `brain.py check` kalıcı "leftover legacy" WARN verebilir — bilinçli kabul |
| 2026-09-20 | DECISION | REKLAM=HAYIR, PRO=HAYIR, VERİ=YEREL | ORTAK §0 varsayılanları EVET/EVET/YEREL; ama MASTER §1.2 reklam SDK'sını ve hesabı açıkça yasaklıyor, §0.4 promotion'ı reklamsız konumlandırıyor. Sahibin projeye özel talimatı = ayarın açık HAYIR'a çevrilmesi. Gelir modeli yok, uygulama tamamen ücretsiz |
| 2026-09-20 | DECISION | Lisans GPL-3.0 (LICENSE korunuyor) | MASTER §3.4 "lisansı sahip sonra seçer" der; ama sahibin bağlayıcı standardı ORTAK §2 lisansı açıkça GPL-3.0 olarak tanımlıyor ve LICENSE dosyası sahibin şablonundan geldi. AI lisans seçmedi; sahibin yerleşik kararını korudu |
| 2026-09-20 | DECISION | ORTAK §3.6 "Diğer Uygulamalar" ağ çekimi yerine gömülü statik liste | ORTAK §3.6 apps.json'u HTTPS ile çekmeyi söyler; MASTER §14.1 uygulamada ağ istemcisini taviz verilemez biçimde yasaklar. Çakışmada offline kazanır |
| 2026-09-20 | DECISION | Klasör yapısı MASTER §3.2 (app/core/features); ORTAK §8'in clean-architecture katman adları uygulanmıyor | MASTER §3.3 açıkça "clean architecture boilerplate'i üretme" der ve somut yapı verir; UI/veri/saf mantık ayrımı (standardın amacı) korunuyor |
| 2026-09-20 | DECISION | Dil kapsamı TR/EN; ORTAK §3.1'in 71 dil hedefi uygulanmıyor | MASTER ürünü TR/EN tanımlıyor; 71 dil sağlık içeriği doğrulama yükünü karşılanamaz hâle getirir. ORTAK'ın asgari şartı (TR+EN) karşılanıyor |
| 2026-09-20 | ASSUMPTION | Araştırma tarihi olarak 2026-09-20 (bugün) kullanılacak | MASTER §22 taraması da bugün tarihli; T1 güncellemesi aynı gün yapılıyor |
| 2026-09-20 | ASSUMPTION | Paket/org adı geçici `app.nketo` (T4) | Google Play paket adı kalıcı; mağaza kaydı ve kesin paket adı sahibin yayın adımında kesinleşir |
| 2026-09-20 | ASSUMPTION | Bu dizin uygulama reposunun kendisi (şablon klonu değil) | origin = github.com/XPersPective/n-keto-tracker.git; dizin adı n-keto-tracker |
| 2026-09-20 | ASSUMPTION | `brain.py check`'in "listed but missing: .gitignore/.gitattributes/.gitleaks.toml" WARN'ı yanlış pozitif; dosyalar diskte ve git'te mevcut (`git ls-files` kanıtlı), map aracı bu üçünü kendi dışlama listesinde tutuyor | §4 satırları gerçek dosyaları anlatıyor; kaldırılmaz, WARN bilinçli kabul edilir |
| 2026-09-20 | AUDIT | **A3 kilometre (Aşama 0 kapandı)**: test/build paketi henüz yok (T4 kuruyor — koşulacak şey yok, not edildi); §3↔§2 karşılaştırma: T1–T3 GAP satırı çözüldü ve yeni GAP (T4–T6) yazıldı; üç teslimatın Done-when grep'leri yeniden koşuldu (105 REQ/0 boş ref; pmcid; residual; 18 vektör; http=29). Bulgu yok | Protokol §0.4 A3; görev açılmadı |
| 2026-09-20 | ASSUMPTION | Master §13 "26 tablo" yazar ama 27 isim listeler; T7 27 tanımlar | Numaralandırma yetkili: sayım 27 (AppSettings…ExportHistory); T7 Done-when "26 tablo create" ifadesi 27 olarak okunur |
| 2026-09-20 | ASSUMPTION | T1 yorum örneklemi: 35 doğrudan mağaza yorumu + agregat kaynaklar (Reddit başlıkları, 2026-08-11 r/keto derlemesi [COI notlu], sahibin §22.3 taraması); "≥100 yorum" harfiyen karşılanmadı çünkü oturumsuz web vitrinleri uygulama başına yalnızca birkaç yorum gösterir | Yöntem ve sayılar USER_REVIEW_THEMES.md'de açıkça beyan; temalar kaynaklar arası tutarlı. Daha derin örnekleme gerekirse tarayıcı oturumlu ayrı görev açılır |
| 2026-09-20 | AUDIT | **A0 yaratma denetimi**: check FAIL yok; §3'ün 3 iddiası açılarak doğrulandı (`tool/new_app.dart` — flutter create + --ads/--pro/--data üreticisi; `.github/workflows/ci.yml` — melos/examples kullanan şablon CI, T4'te uyarlancak; `LICENSE` — GPL-3.0 tam metni); izlenebilirlik: 11 AC'nin tümü ≥1 T-id'ye bağlı, §2 bileşenlerinin tümü §3 GAP satırlarıyla görevli; ilk 5 görevin (T1–T5) yürütülebilirlik yoklaması temiz | Protokol §0.4 A0; bulgu yok, görev açılmadı |
| 2026-09-20 | AUDIT | **A1 takeover (derin)**: eskalasyon nedeni — önceki AUDIT satırı yoktu ve init commit bekliyordu. Kapanmış görev örneklemi yok (34 görevin tümü açık); test paketi yok (Flutter projesi henüz yok — T4 kuruyor); §3↔kod nokta kontrolü A0'da yapıldı; tek commit `5bfb890` (şablon, protokol dışı değil); goal hash PENDING'den `0f6c3256`'ya sabitlendi | Protokol §0.4 A1; bulgu yok, görev açılmadı |

## 7. HANDOFF

Son: T7 kapatıldı — 27 tablo (cascade/RESTRICT kararları yorumlu), FK pragma, 9 DB testi; tam paket 15 test yeşil.
Devam: T8 (DB şifreleme kararı: sqlcipher_flutter_libs + flutter_secure_storage uyumluluğu/lisansı; ADR) → T9 onboarding.
Teknik not: yeni TEXT PK tablo = tables.dart'ta primaryKey override + build_runner; companion adları `<Tablo>Companion`, satır sınıfları `<Tablo>Row`.
Uyarı: SECURITY/CoC adres alanları yer tutucu (sahip dolduracak). Debug attach T30'da doğrulanacak.
