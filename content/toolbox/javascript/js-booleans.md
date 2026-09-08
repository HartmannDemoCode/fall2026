---
title: "Booleans"
description: "How the falsy and truthy values work in TypeScript"
weight: 11
draft: false
---
## Falsy and Truthy Values in TypeScript

Understanding **truthy** and **falsy** values in TypeScript is essential because TypeScript uses implicit type coercion when evaluating expressions in a boolean context. Here’s a deeper dive with examples.

## Falsy Values

Falsy values are values that evaluate to `false` in a boolean context. There are only a few of these in TypeScript, and they are:

1. **`false`** – The boolean `false`.

   ```typescript
   if (false) console.log("This will not run");
   ```

2. **`0`** – The number zero (also `-0`).

   ```typescript
   if (0) console.log("This will not run");
   ```

3. **`""`** – An empty string (`''` or `""` or even a template literal ``````).

   ```typescript
   if ("") console.log("This will not run");
   ```

4. **`null`** – Represents the intentional absence of any object value.

   ```typescript
   if (null) console.log("This will not run");
   ```

5. **`undefined`** – Indicates a variable that has been declared but not assigned a value.

   ```typescript
   if (undefined) console.log("This will not run");
   ```

6. **`NaN`** – Not-a-Number, often the result of invalid math operations.

   ```typescript
   if (NaN) console.log("This will not run");
   ```

### Example

Here's a simple example of falsy values in action:

```typescript
let values = [false, 0, "", null, undefined, NaN];

values.forEach(value => {
  if (!value) {
    console.log(`${value} is falsy`);
  }
});
```

## Truthy Values

Any value that is **not falsy** is considered truthy. This includes all non-zero numbers, non-empty strings, objects, arrays, and even the `true` boolean value.

Some common truthy values:

1. **Non-zero numbers** (both positive and negative):

   ```typescript
   if (1) console.log("This will run");
   if (-1) console.log("This will also run");
   ```

2. **Non-empty strings**:

   ```typescript
   if ("Hello") console.log("This will run");
   if ("false") console.log("Even this string will run");
   ```

3. **Objects** (including arrays, functions, and other objects):

   ```typescript
   if ({}) console.log("This will run");
   if ([]) console.log("This will also run");
   ```

4. **`true`** – The boolean `true`.

   ```typescript
   if (true) console.log("This will run");
   ```

### Example

Here's a simple example of truthy values in action:

```typescript
let values = [1, -1, "Hello", {}, [], true];

values.forEach(value => {
  if (value) {
    console.log(`${value} is truthy`);
  }
});
```

## Usage in Conditions

TypeScript allows us to use these implicit truthy/falsy values in conditions, which is handy for quickly checking if a variable is set or has content.

### Example: Checking if a variable has a value

```typescript
let name = "Alice";
if (name) {
  console.log("Name is set");  // This will run because "Alice" is truthy.
}

let emptyName = "";
if (!emptyName) {
  console.log("Name is empty");  // This will run because "" is falsy.
}
```

## Why It Matters

Understanding truthy and falsy values helps write concise and readable code, particularly when performing conditional checks without explicit `== true` or `== false`. However, be cautious with implicit conversions, as they can sometimes lead to unexpected results if not properly understood.
