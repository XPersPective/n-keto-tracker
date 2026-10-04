# Satın alma doğrulama servisi

Tek uç nokta: `POST /v1/verify-premium` — gövde yalnız
`{packageName, productId, purchaseToken}`; sağlık verisi kabul edilmez (400).
Yanıt `{valid: boolean}`. Sağlık: `GET /healthz`.

```bash
npm test                      # 4 test, bağımlılık yok (Node >= 20)
docker build -t n-keto-verify .
docker run --env-file .env -v ./sa.json:/run/secrets/play-service-account.json:ro -p 8080:8080 n-keto-verify
```

Uygulama derlemesi: `--dart-define=PREMIUM_VERIFY_URL=https://<host>/v1/verify-premium`.
URL boşsa istemci yalnız Play Billing'e güvenir (satın alma yine geçerlidir).
Barındırma ve Google servis hesabı kullanıcı adımıdır (ADR-PB-012).
