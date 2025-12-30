// SPDX-License-Identifier: AGPL-3.0-or-later
// SPDX-FileCopyrightText: 2025 hyperpolymath
//
// Example: WebAssembly Interop with Affine Types

import { AffineResource } from '../src/main.ts';

/**
 * Example: WebAssembly Memory Management with Affine Semantics
 *
 * Demonstrates how affine types can ensure safe WASM memory management:
 * - Memory buffers are used at most once
 * - No use-after-free vulnerabilities
 * - Clear ownership semantics
 */

interface WasmBuffer {
  readonly memory: Uint8Array;
  readonly offset: number;
  readonly length: number;
}

// Simulated WASM memory allocation
function wasmAlloc(size: number): AffineResource<WasmBuffer> {
  const buffer: WasmBuffer = {
    memory: new Uint8Array(size),
    offset: 0,
    length: size,
  };
  console.log(`WASM: Allocated ${size} bytes`);
  return new AffineResource(buffer);
}

// Write to WASM buffer (consumes ownership)
function wasmWrite(resource: AffineResource<WasmBuffer>, data: Uint8Array): void {
  const buffer = resource.consume();
  buffer.memory.set(data);
  console.log(`WASM: Wrote ${data.length} bytes to buffer`);
}

// Read from WASM buffer and return copy (consumes ownership)
function wasmRead(resource: AffineResource<WasmBuffer>): Uint8Array {
  const buffer = resource.consume();
  const copy = new Uint8Array(buffer.memory);
  console.log(`WASM: Read ${buffer.length} bytes from buffer`);
  return copy;
}

// Transfer ownership to another buffer
function wasmTransfer(
  source: AffineResource<WasmBuffer>,
  dest: AffineResource<WasmBuffer>
): void {
  const src = source.consume();
  const dst = dest.consume();
  dst.memory.set(src.memory);
  console.log(`WASM: Transferred ${src.length} bytes`);
}

// Demonstrate WASM interop
console.log('=== WASM Affine Memory Example ===\n');

// Example 1: Write to buffer
console.log('1. Allocate and write:');
const buf1 = wasmAlloc(16);
wasmWrite(buf1, new Uint8Array([1, 2, 3, 4, 5]));
console.log('');

// Example 2: Read from buffer
console.log('2. Allocate and read:');
const buf2 = wasmAlloc(8);
const data = wasmRead(buf2);
console.log(`   Read data: [${Array.from(data).join(', ')}]\n`);

// Example 3: Transfer between buffers
console.log('3. Transfer between buffers:');
const srcBuf = wasmAlloc(4);
const dstBuf = wasmAlloc(4);
// First write to source
const tempSrc = wasmAlloc(4);
wasmWrite(tempSrc, new Uint8Array([10, 20, 30, 40]));
wasmTransfer(srcBuf, dstBuf);
console.log('');

// Example 4: Demonstrating safety
console.log('4. Attempting use after consumption:');
const buf3 = wasmAlloc(4);
wasmRead(buf3);
try {
  wasmRead(buf3); // This will throw!
} catch (e) {
  console.log(`   Error caught: ${(e as Error).message}`);
}
console.log('');

console.log('=== Example Complete ===');
