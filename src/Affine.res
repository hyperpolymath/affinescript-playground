// SPDX-License-Identifier: AGPL-3.0-or-later
// SPDX-FileCopyrightText: 2025 hyperpolymath
//
// AffineScript Playground - ReScript Affine Type Module
// Demonstrates affine type semantics in ReScript

/**
 * Affine types: Resources that can be used at most once
 * - Can be used 0 times (dropped)
 * - Can be used 1 time (consumed)
 * - Cannot be used more than once
 */

// Affine resource state
type affineState = Unconsumed | Consumed

// Affine resource wrapper
type affineResource<'a> = {
  mutable state: affineState,
  value: 'a,
}

// Create a new affine resource
let makeAffineResource = (value: 'a): affineResource<'a> => {
  {state: Unconsumed, value}
}

// Consume the resource (returns Some(value) or None if already consumed)
let consumeAffineResource = (resource: affineResource<'a>): option<'a> => {
  switch resource.state {
  | Unconsumed =>
    resource.state = Consumed
    Some(resource.value)
  | Consumed => None
  }
}

// Check if resource is consumed
let isConsumedAffineResource = (resource: affineResource<'a>): bool => {
  resource.state == Consumed
}

// Drop the resource without use (affine allows this)
let dropAffineResource = (resource: affineResource<'a>): unit => {
  resource.state = Consumed
}

// WASM memory handle type
type wasmMemoryHandle = {
  ptr: int,
  size: int,
}

// Allocate WASM memory with affine semantics
let allocateWasmMemoryAffine = (size: int): affineResource<wasmMemoryHandle> => {
  let ptr = Js.Math.random_int(0, 0xFFFF)
  Js.log(`Allocated WASM memory at 0x${Int.toString(ptr, ~radix=16)}, size: ${Int.toString(size)}`)
  makeAffineResource({ptr, size})
}

// Use WASM memory
let useWasmMemoryAffine = (resource: affineResource<wasmMemoryHandle>): unit => {
  switch consumeAffineResource(resource) {
  | Some(handle) =>
    Js.log(`Using WASM memory at 0x${Int.toString(handle.ptr, ~radix=16)}`)
  | None =>
    Js.log("Error: Affine type violation - resource already consumed")
  }
}

// Demonstration
let demonstrateAffineTypesRes = (): unit => {
  Js.log("=== AffineScript Playground (ReScript) ===\n")
  Js.log("Demonstrating affine type semantics:\n")

  // Example 1: Proper usage
  Js.log("1. Proper usage (use once):")
  let mem1 = allocateWasmMemoryAffine(1024)
  useWasmMemoryAffine(mem1)
  Js.log(`   Resource consumed: ${Bool.toString(isConsumedAffineResource(mem1))}\n`)

  // Example 2: Drop without use
  Js.log("2. Drop without use (affine allows this):")
  let mem2 = allocateWasmMemoryAffine(512)
  dropAffineResource(mem2)
  Js.log(`   Resource consumed: ${Bool.toString(isConsumedAffineResource(mem2))}\n`)

  // Example 3: Attempting double use
  Js.log("3. Double use attempt:")
  let mem3 = allocateWasmMemoryAffine(256)
  useWasmMemoryAffine(mem3)
  useWasmMemoryAffine(mem3) // Will log error message
  Js.log("")

  Js.log("=== Demo Complete ===")
}
