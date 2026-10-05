import test from 'node:test';
import assert from 'node:assert/strict';
import { createServer } from 'node:http';
import { generateKeyPairSync } from 'node:crypto';
import { makeHandler, makeTokenProvider, parseBody, verifyPurchase } from './server.js';

const cfg = { packageName: 'com.crazypenguin.nketotracker', productId: 'com.crazypenguin.nketotracker.pro_lifetime' };
const good = JSON.stringify({ ...cfg, purchaseToken: 'abc.DEF-123' });

test('parseBody: yalnız üç alan, doğru paket/ürün', () => {
  assert.ok(parseBody(good, cfg));
  assert.equal(parseBody('{', cfg), null);
  assert.equal(parseBody(JSON.stringify({ ...cfg, purchaseToken: 'x', glucose: 5 }), cfg), null); // sağlık verisi reddedilir
  assert.equal(parseBody(JSON.stringify({ ...cfg, packageName: 'evil', purchaseToken: 'x' }), cfg), null);
  assert.equal(parseBody(JSON.stringify({ ...cfg, purchaseToken: 'a b' }), cfg), null);
});

test('verifyPurchase: satın alındı → valid + onay; iade → invalid', async () => {
  const calls = [];
  const f = async (url, init) => {
    calls.push([init?.method ?? 'GET', url.endsWith(':acknowledge')]);
    return { ok: true, status: 200, json: async () => ({ purchaseState: 0, acknowledgementState: 0 }) };
  };
  assert.deepEqual(await verifyPurchase(JSON.parse(good), async () => 't', f), { valid: true });
  assert.deepEqual(calls, [['GET', false], ['POST', true]]);
  const refunded = async () => ({ ok: true, status: 200, json: async () => ({ purchaseState: 1 }) });
  assert.deepEqual(await verifyPurchase(JSON.parse(good), async () => 't', refunded), { valid: false });
  const gone = async () => ({ ok: false, status: 410 });
  assert.deepEqual(await verifyPurchase(JSON.parse(good), async () => 't', gone), { valid: false });
});

test('token provider: JWT imzalar ve önbelleğe alır', async () => {
  const { privateKey } = generateKeyPairSync('rsa', { modulusLength: 2048 });
  const sa = JSON.stringify({
    client_email: 'x@y.iam',
    private_key: privateKey.export({ type: 'pkcs8', format: 'pem' }),
  });
  let n = 0;
  const f = async () => (n++, { ok: true, json: async () => ({ access_token: 'tok', expires_in: 3600 }) });
  const get = makeTokenProvider(sa, f);
  assert.equal(await get(), 'tok');
  assert.equal(await get(), 'tok');
  assert.equal(n, 1);
});

test('HTTP: 200 / 400 / 404 / 429', async () => {
  const handler = makeHandler({
    ...cfg,
    getToken: async () => 't',
    fetchFn: async () => ({ ok: true, status: 200, json: async () => ({ purchaseState: 0, acknowledgementState: 1 }) }),
    limit: 2,
  });
  const srv = createServer(handler).listen(0);
  const base = `http://127.0.0.1:${srv.address().port}`;
  const post = (body) => fetch(`${base}/v1/verify-premium`, { method: 'POST', body });
  try {
    assert.equal((await fetch(`${base}/healthz`)).status, 200);
    assert.equal((await fetch(`${base}/nope`)).status, 404);
    const ok = await post(good);
    assert.equal(ok.status, 200);
    assert.deepEqual(await ok.json(), { valid: true });
    assert.equal((await post('{}')).status, 400);
    assert.equal((await post(good)).status, 429);
  } finally {
    srv.close();
  }
});
