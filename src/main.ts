// SPDX-License-Identifier: AGPL-3.0-or-later
// SPDX-FileCopyrightText: 2025 hyperpolymath
//
// AffineScript Playground - Main Entry Point
// Demonstrates affine type semantics for WebAssembly

/**
 * AffineScript Playground
 *
 * This playground demonstrates affine type semantics - types that can be used
 * at most once. This is useful for:
 * - Resource management (file handles, network connections)
 * - Memory safety without garbage collection
 * - WebAssembly linear memory safety
 */

// Affine type wrapper - simulates use-at-most-once semantics
class AffineResource<T> {
  private consumed = false;
  private readonly resourceValue: T;

  constructor(value: T) {
    this.resourceValue = value;
  }

  /**
   * Consume the resource. Can only be called once.
   * Affine semantics: use at most once (0 or 1 times)
   */
  consume(): T {
    if (this.consumed) {
      throw new Error('Affine type violation: resource already consumed');
    }
    this.consumed = true;
    return this.resourceValue;
  }

  /**
   * Check if resource has been consumed
   */
  isConsumed(): boolean {
    return this.consumed;
  }

  /**
   * Affine types can be dropped without use (unlike linear types)
   */
  drop(): void {
    if (!this.consumed) {
      console.log('Resource dropped without use (affine allows this)');
      this.consumed = true;
    }
  }
}

// Example: WASM memory handle with affine semantics
interface WasmMemoryHandle {
  readonly ptr: number;
  readonly size: number;
}

function allocateWasmMemory(size: number): AffineResource<WasmMemoryHandle> {
  const handle: WasmMemoryHandle = {
    ptr: Math.floor(Math.random() * 0xFFFF), // Simulated pointer
    size,
  };
  console.log(`Allocated WASM memory at 0x${handle.ptr.toString(16)}, size: ${size}`);
  return new AffineResource(handle);
}

function useWasmMemory(resource: AffineResource<WasmMemoryHandle>): void {
  const handle = resource.consume();
  console.log(`Using WASM memory at 0x${handle.ptr.toString(16)}`);
  // Memory is now consumed - cannot be used again
}

// Main demonstration
function demonstrateAffineTypes(): void {
  console.log('=== AffineScript Playground ===\n');
  console.log('Demonstrating affine type semantics:\n');

  // Example 1: Proper affine usage
  console.log('1. Proper usage (use once):');
  const mem1 = allocateWasmMemory(1024);
  useWasmMemory(mem1);
  console.log(`   Resource consumed: ${mem1.isConsumed()}\n`);

  // Example 2: Affine allows dropping without use
  console.log('2. Drop without use (affine allows this):');
  const mem2 = allocateWasmMemory(512);
  mem2.drop();
  console.log(`   Resource consumed: ${mem2.isConsumed()}\n`);

  // Example 3: Attempting double use (will throw)
  console.log('3. Double use attempt (will throw):');
  const mem3 = allocateWasmMemory(256);
  try {
    mem3.consume();
    mem3.consume(); // This will throw
  } catch (error) {
    console.log(`   Error: ${(error as Error).message}\n`);
  }

  console.log('=== Demo Complete ===');
}

// Run if executed directly
if (import.meta.main) {
  demonstrateAffineTypes();
}

export { AffineResource, allocateWasmMemory, useWasmMemory, demonstrateAffineTypes };
