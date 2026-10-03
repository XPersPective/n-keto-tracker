# PB-011 — Plan satır etiketleri okunur tarif başlığı

## Status

IN_PROGRESS

## Objective

Plan sayfası satırları ham "slot-0 · 1.0" benzeri etiket gösteriyordu;
tarif başlığı okunur etiket olarak görüntülenecek (emülatör DoD
yürüyüşünde bulundu).

## Dependencies

None.

## Affected Areas

- `lib/features/meal_plans/plan_page.dart` (_load + satır alt başlığı)

## Acceptance Criteria

- Plan satır alt başlığı "Tarif başlığı · öğün · porsiyon" biçiminde;
  kayıt eksikse kısa id'ye düşer.
- flutter analyze temiz, flutter test yeşil.

## Verification

Risk: LOW

Required: analyze + targeted test + emülatörde plan üretimi görünümü.

## Architecture Impact

NO

## Decision Boundary

None.
