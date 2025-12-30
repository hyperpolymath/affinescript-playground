// SPDX-License-Identifier: AGPL-3.0-or-later
// SPDX-FileCopyrightText: 2025 hyperpolymath
//
// Tests for Affine Type Implementation

import { assertEquals, assertThrows } from '@std/assert';
import { AffineResource, allocateWasmMemory } from '../src/main.ts';

Deno.test('AffineResource - can consume once', () => {
  const resource = new AffineResource(42);
  const value = resource.consume();
  assertEquals(value, 42);
  assertEquals(resource.isConsumed(), true);
});

Deno.test('AffineResource - throws on double consume', () => {
  const resource = new AffineResource('test');
  resource.consume();
  assertThrows(
    () => resource.consume(),
    Error,
    'Affine type violation: resource already consumed'
  );
});

Deno.test('AffineResource - can drop without use (affine semantics)', () => {
  const resource = new AffineResource({ data: 'test' });
  assertEquals(resource.isConsumed(), false);
  resource.drop();
  assertEquals(resource.isConsumed(), true);
});

Deno.test('AffineResource - drop is idempotent', () => {
  const resource = new AffineResource(100);
  resource.drop();
  resource.drop(); // Should not throw
  assertEquals(resource.isConsumed(), true);
});

Deno.test('AffineResource - cannot consume after drop', () => {
  const resource = new AffineResource('dropped');
  resource.drop();
  assertThrows(
    () => resource.consume(),
    Error,
    'Affine type violation: resource already consumed'
  );
});

Deno.test('allocateWasmMemory - creates valid resource', () => {
  const resource = allocateWasmMemory(1024);
  assertEquals(resource.isConsumed(), false);
  const handle = resource.consume();
  assertEquals(handle.size, 1024);
  assertEquals(typeof handle.ptr, 'number');
});

Deno.test('allocateWasmMemory - resource is properly affine', () => {
  const resource = allocateWasmMemory(512);
  resource.consume();
  assertThrows(
    () => resource.consume(),
    Error,
    'Affine type violation'
  );
});
