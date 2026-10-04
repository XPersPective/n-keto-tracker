// N Keto Tracker — satın alma doğrulama servisi (ADR-PB-012 / PB-015).
//
// Tek görev: istemcinin gönderdiği Google Play purchaseToken'ını Play
// Developer API ile doğrulamak. Sağlık verisi ASLA kabul edilmez: gövde
// yalnız {packageName, productId, purchaseToken} alanlarına izin verir.
// Bağımlılık yok (Node >= 20: fetch, crypto, http).
import { createServer } from 'node:http';
import { createSign } from 'node:crypto';
import { readFileSync } from 'node:fs';

const API = 'https://androidpublisher.googleapis.com/androidpublisher/v3';
const TOKEN_URL = 'https://oauth2.googleapis.com/token';
const SCOPE = 'https://www.googleapis.com/auth/androidpublisher';
const FIELD = /^[A-Za-z0-9._\-]{1,512}$/;

const b64url = (b) => Buffer.from(b).toString('base64url');

/** Servis hesabı JSON'undan (dosya yolu ya da JSON metni) erişim jetonu üretir. */
export function makeTokenProvider(saJson, fetchFn = fetch, now = Date.now) {
  const sa = JSON.parse(saJson);
  let cached = null;
  return async () => {
    if (cached && cached.exp - 60_000 > now()) return cached.token;
    const iat = Math.floor(now() / 1000);
    const head = b64url(JSON.stringify({ alg: 'RS256', typ: 'JWT' }));
    const claim = b64url(
      JSON.stringify({ iss: sa.client_email, scope: SCOPE, aud: TOKEN_URL, iat, exp: iat + 3600 }),
    );
    const sig = createSign('RSA-SHA256').update(`${head}.${claim}`).sign(sa.private_key, 'base64url');
    const res = await fetchFn(TOKEN_URL, {
      method: 'POST',
      headers: { 'content-type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({
        grant_type: 'urn:ietf:params:oauth:grant-type:jwt-bearer',
        assertion: `${head}.${claim}.${sig}`,
      }),
    });
    if (!res.ok) throw new Error(`token ${res.status}`);
    const j = await res.json();
    cached = { token: j.access_token, exp: now() + j.expires_in * 1000 };
    return cached.token;
  };
}

/** Play'de satın alma geçerli mi? purchaseState 0 = satın alındı. */
export async function verifyPurchase({ packageName, productId, purchaseToken }, getToken, fetchFn = fetch) {
  const token = await getToken();
  const url = `${API}/applications/${packageName}/purchases/products/${productId}/tokens/${purchaseToken}`;
  const res = await fetchFn(url, { headers: { authorization: `Bearer ${token}` } });
  if (res.status === 404 || res.status === 410 || res.status === 400) return { valid: false };
  if (!res.ok) throw new Error(`play ${res.status}`);
  const p = await res.json();
  if (p.purchaseState !== 0) return { valid: false };
  if (p.acknowledgementState === 0) {
    // Onaylanmamış satın alma 3 gün içinde iade edilir; sunucu da onaylar (idempotent).
    await fetchFn(`${url}:acknowledge`, {
      method: 'POST',
      headers: { authorization: `Bearer ${token}`, 'content-type': 'application/json' },
      body: '{}',
    });
  }
  return { valid: true };
}

/** Gövdeyi doğrular; beklenmeyen alan/biçim → null. */
export function parseBody(raw, { packageName, productId }) {
  let b;
  try {
    b = JSON.parse(raw);
  } catch {
    return null;
  }
  if (!b || typeof b !== 'object' || Array.isArray(b)) return null;
  const keys = Object.keys(b).sort().join(',');
  if (keys !== 'packageName,productId,purchaseToken') return null;
  for (const k of Object.keys(b)) if (typeof b[k] !== 'string' || !FIELD.test(b[k])) return null;
  if (b.packageName !== packageName || b.productId !== productId) return null;
  return b;
}

export function makeHandler({ packageName, productId, getToken, fetchFn = fetch, limit = 30, now = Date.now }) {
  const hits = new Map(); // ip → [zaman damgaları]; ponytail: bellekte, çok örnekli dağıtımda Redis
  return async (req, res) => {
    const send = (code, obj) => {
      res.writeHead(code, { 'content-type': 'application/json' });
      res.end(JSON.stringify(obj));
    };
    if (req.method === 'GET' && req.url === '/healthz') return send(200, { ok: true });
    if (req.method !== 'POST' || req.url !== '/v1/verify-premium') return send(404, { error: 'not_found' });

    const ip = req.socket.remoteAddress ?? '?';
    const t = now();
    const recent = (hits.get(ip) ?? []).filter((x) => t - x < 60_000);
    recent.push(t);
    hits.set(ip, recent);
    if (recent.length > limit) return send(429, { error: 'rate_limited' });

    let raw = '';
    for await (const chunk of req) {
      raw += chunk;
      if (raw.length > 4096) return send(413, { error: 'too_large' });
    }
    const body = parseBody(raw, { packageName, productId });
    if (!body) return send(400, { error: 'bad_request' });
    try {
      return send(200, await verifyPurchase(body, getToken, fetchFn));
    } catch {
      // Jeton/ödeme verisi loglanmaz.
      return send(502, { error: 'upstream' });
    }
  };
}

if (import.meta.url === `file://${process.argv[1].replace(/\\/g, '/')}` || process.argv[1]?.endsWith('server.js')) {
  const { PACKAGE_NAME, PREMIUM_PRODUCT_ID, GOOGLE_SERVICE_ACCOUNT_FILE, PORT = '8080' } = process.env;
  if (!PACKAGE_NAME || !PREMIUM_PRODUCT_ID || !GOOGLE_SERVICE_ACCOUNT_FILE) {
    console.error('PACKAGE_NAME, PREMIUM_PRODUCT_ID, GOOGLE_SERVICE_ACCOUNT_FILE gerekli (.env.example).');
    process.exit(1);
  }
  const getToken = makeTokenProvider(readFileSync(GOOGLE_SERVICE_ACCOUNT_FILE, 'utf8'));
  createServer(makeHandler({ packageName: PACKAGE_NAME, productId: PREMIUM_PRODUCT_ID, getToken })).listen(
    Number(PORT),
    () => console.log(`verify service :${PORT}`),
  );
}
