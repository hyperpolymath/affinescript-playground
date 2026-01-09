// SPDX-License-Identifier: AGPL-3.0-or-later
// SPDX-FileCopyrightText: 2025 hyperpolymath
//
// Example: Affine Types for Resource Management

import { AffineResource } from '../src/run.js';

/**
 * Example: File Handle with Affine Semantics
 *
 * Affine types ensure file handles are:
 * - Opened once
 * - Used at most once for operations
 * - Properly closed (or safely dropped)
 */

/**
 * @typedef {Object} FileHandle
 * @property {number} fd - File descriptor
 * @property {string} path - File path
 * @property {'read' | 'write'} mode - File mode
 */

/**
 * Open a file with affine semantics
 * @param {string} path - File path to open
 * @param {'read' | 'write'} mode - File mode
 * @returns {AffineResource} Affine resource wrapping the file handle
 */
function openFileAffine(path, mode) {
  const handle = {
    fd: Math.floor(Math.random() * 1000),
    path,
    mode,
  };
  console.log(`Opened file: ${path} (fd=${handle.fd}, mode=${mode})`);
  return new AffineResource(handle);
}

/**
 * Read from a file (consumes the resource)
 * @param {AffineResource} resource - Affine file resource
 * @returns {string} File contents
 */
function readFile(resource) {
  const handle = resource.consume();
  if (handle.mode !== 'read') {
    throw new Error('File not opened for reading');
  }
  console.log(`Reading from fd=${handle.fd}`);
  return `Contents of ${handle.path}`;
}

/**
 * Write to a file (consumes the resource)
 * @param {AffineResource} resource - Affine file resource
 * @param {string} data - Data to write
 */
function writeFile(resource, data) {
  const handle = resource.consume();
  if (handle.mode !== 'write') {
    throw new Error('File not opened for writing');
  }
  console.log(`Writing to fd=${handle.fd}: ${data}`);
}

// Demonstrate file handling with affine types
console.log('=== Affine File Handle Example ===\n');

// Reading a file
const readHandle = openFileAffine('/tmp/test.txt', 'read');
const contents = readFile(readHandle);
console.log(`File contents: ${contents}\n`);

// Writing to a file
const writeHandle = openFileAffine('/tmp/output.txt', 'write');
writeFile(writeHandle, 'Hello, AffineScript!');
console.log('');

// Demonstrating drop (file not used but safely released)
const unusedHandle = openFileAffine('/tmp/unused.txt', 'read');
unusedHandle.drop();
console.log('Unused handle safely dropped\n');

console.log('=== Example Complete ===');
