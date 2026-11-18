import assert from 'node:assert/strict';
import { test } from 'node:test';
import { handler } from '../index.mjs';

test('renders a Lambda response with request details', async () => {
  const response = await handler({
    requestContext: { http: { method: 'GET' } },
    rawPath: '/health',
    headers: { 'user-agent': 'workspace-check' },
  });

  assert.equal(response.statusCode, 200);
  assert.match(response.headers['Content-Type'], /^text\/html/);
  assert.match(response.body, /Method: GET/);
  assert.match(response.body, /Path: \/health/);
  assert.match(response.body, /User Agent: workspace-check/);
  assert.doesNotMatch(response.body, /\{\{(?:METHOD|PATH|USER_AGENT|TIMESTAMP)\}\}/);
});

test('escapes untrusted request values before rendering HTML', async () => {
  const response = await handler({
    requestContext: { http: { method: 'GET' } },
    rawPath: '/<script>alert(1)</script>',
    headers: { 'user-agent': '<img src=x onerror=alert(1)>' },
  });

  assert.match(response.body, /&lt;script&gt;alert\(1\)&lt;\/script&gt;/);
  assert.match(response.body, /&lt;img src=x onerror=alert\(1\)&gt;/);
  assert.doesNotMatch(response.body, /<script>alert\(1\)<\/script>/);
});
