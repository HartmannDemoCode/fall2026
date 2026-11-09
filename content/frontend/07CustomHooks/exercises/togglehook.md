---
title: Simple Toggle Hook
description: A very beginner-friendly exercise to create a custom hook in React.
weight: 1
draft: false
---

# React Custom Hooks Exercise (Very Beginner Friendly)

## Title
Build your first custom hook: `useToggle`

## Why this hook?
This is the **smallest useful custom hook** because it solves a real problem:
- We often need to show/hide something in the UI.
- We repeat the same state code over and over.
- `useToggle` lets us reuse that logic anywhere.

This hook is tiny, but teaches the full custom-hook idea.

---

## Learning goals
By the end of this exercise, you can:
1. Explain what a custom hook is in simple words.
2. Create a hook in its own file.
3. Use `useState` inside a custom hook.
4. Return values/functions from a hook.
5. Use the hook in a component.

---

## Time estimate
- 25 to 40 minutes (slow pace, with explanation)

---

## setup
- Start a new project or use an existing one.
- Make sure project runs:

```bash
npm install
npm run dev
```

Open the app in the browser.

---

## The simple problem
We want a button that can:
- Show details
- Hide details

Without a custom hook, every component would write similar state code again.

We will make a reusable hook:

```txt
const [isOpen, toggle, open, close] = useToggle(false)
```

---

## Step 0 - Explain custom hooks in one sentence
A custom hook is **just a JavaScript function** that:
- starts with `use` so React knows it is a hook
- uses React hooks inside
- returns reusable logic

---

## Step 1 - Create the hook file
Create this file:

- `src/hooks/useToggle.js`

Add this starter code (if you get stuck, see the final code at the bottom):

```js
import { useState } from "react";

export function useToggle(initialValue = false) {
  // state
  //1.  Make a useState variable to hold the open/closed state

  // actions
  //2. Make a toggle function to flip the state
  //3. Make an open function to set state to true
  //4. Make a close function to set state to false

  // what other components can use
  return [isOpen, toggle, open, close];
}
```

### Stop and explain
- `initialValue = false` means default is closed.
- `prev => !prev` flips true/false.
- returning an array is a pattern similar to `useState`.

---

## Step 2 - Use the hook in a component (If you get stuck, see the final code at the bottom)
Pick a simple component to test. For class clarity, create a tiny demo component.

Create file:

- `src/assets/components/ToggleHookDemo.jsx`

Paste:

```jsx
import { useToggle } from "../../hooks/useToggle";

export default function ToggleHookDemo() {
  // state
  //1. Call the hook and get the state + functions

  return (
    <div style={{ marginTop: "1rem", padding: "1rem", border: "1px solid #ddd" }}>
      <h3>useToggle Demo</h3>

  // buttons
  //2. Add buttons to call toggle, open, close
  
  // display
  //3. Show a message based on isOpen state (Conditional rendering) that renders either "Details are now visible." or "Details are hidden."
    </div>
  );
}
```

## Step 3 - Render the demo component
Import and render it in any page where students can see it quickly.

Example (in a page or app component):

```jsx
import ToggleHookDemo from "./assets/components/ToggleHookDemo";

// inside JSX
<ToggleHookDemo />
```

Save and test in browser.

---

## Step 4 - Manual testing checklist
1. `Toggle` changes hidden/visible each click.
2. `Open` always makes it visible.
3. `Close` always hides it.
4. Refresh page resets to `false` (hidden).

If all pass, the custom hook works.

---

## Step 5 - Explaination

- `useToggle` is just a function.
- It uses `useState` internally. (Whichis why it must start with `use`.)
- Every component that calls it gets its own state.
- The hook lets us reuse logic, not UI.

- Rule of thumb: **Hooks share behavior, components render UI.**

---

## Step 6 - Mini refactor challenge (2 to 5 min)
- Change behavior:

```js
const [isOpen, toggle, open, close] = useToggle(true)
```

Question:
- What changes in the UI on first render?

---

## Step 7 - One optional improvement 
Return an object instead of array, so naming is clearer:

```js
return { isOpen, toggle, open, close };
```

Then use it as:

```js
const { isOpen, toggle, open, close } = useToggle(false);
```

- What is the difference?
---

## Common beginner mistakes (debug guide)
1. **Hook name does not start with `use`**
   - Must be `useToggle`, not `toggleHook`.
2. **Using hook outside component**
   - Hooks must be called inside React components (or other hooks).
3. **Forgetting export/import**
   - Check `export function useToggle...` and correct import path.
4. **Mutating state directly**
   - Never do `isOpen = true`; must use `setIsOpen(...)`.

---

## Fast teacher script (talk track)
You can say this while coding:

1. "We repeat show/hide state often."
2. "Let’s move that logic into a custom hook."
3. "The hook returns state + helper functions."
4. "Now any component can reuse this logic with one line."

---

## Final code (reference answer)

### `src/hooks/useToggle.js`

```js
import { useState } from "react";

export function useToggle(initialValue = false) {
  const [isOpen, setIsOpen] = useState(initialValue);

  const toggle = () => setIsOpen((prev) => !prev);
  const open = () => setIsOpen(true);
  const close = () => setIsOpen(false);

  return [isOpen, toggle, open, close];
}
```

### `src/assets/components/ToggleHookDemo.jsx`

```jsx
import { useToggle } from "../../hooks/useToggle";

export default function ToggleHookDemo() {
  const [isOpen, toggle, open, close] = useToggle(false);

  return (
    <div style={{ marginTop: "1rem", padding: "1rem", border: "1px solid #ddd" }}>
      <h3>useToggle Demo</h3>

      <button type="button" onClick={toggle}>Toggle</button>
      <button type="button" onClick={open} style={{ marginLeft: "0.5rem" }}>Open</button>
      <button type="button" onClick={close} style={{ marginLeft: "0.5rem" }}>Close</button>

      {isOpen ? (
        <p style={{ marginTop: "1rem" }}>Details are now visible.</p>
      ) : (
        <p style={{ marginTop: "1rem" }}>Details are hidden.</p>
      )}
    </div>
  );
}
```

---

## Extension ideas 
1. `useInput` hook (value + onChange + reset)
2. `useCounter` hook (count + increment/decrement/reset)
3. `useLocalStorage` hook (persist state after refresh)
