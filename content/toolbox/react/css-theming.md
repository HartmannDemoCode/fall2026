---
title: "CSS Theming"
description: "Light and dark theming with CSS Modules in React"
weight: 15
draft: false
---

## 📚 Light/Dark Mode with CSS Modules

This tutorial teaches you how to:

1. Build a light/dark mode toggle using `useState` and CSS Modules
2. Understand and solve prop drilling using React Context
3. Add and use a global CSS file in a React project
4. Understand how `useContext` works internally
5. Use CSS variables and `body` class for scalable theming

---

## ✅ Part 1: Light/Dark Mode using CSS Modules and `useState`

### 1. Project Setup

```bash
npm create vite@latest theme-toggle-demo --template react
cd theme-toggle-demo
npm install
npm run dev
```

### 2. Folder Structure

```plaintext
src/
├── App.jsx
├── App.module.css
├── ThemeToggle.jsx
├── ThemeToggle.module.css
```

### 3. `App.module.css`

```css
.app {
  font-family: sans-serif;
  padding: 2rem;
  min-height: 100vh;
  transition: background-color 0.3s, color 0.3s;
}

.card {
  background-color: var(--card-bg);
  padding: 1rem;
  border-radius: 6px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}
```

### 4. `ThemeToggle.module.css`

```css
.button {
  padding: 0.5rem 1rem;
  border: 2px solid currentColor;
  background: transparent;
  color: inherit;
  border-radius: 4px;
  cursor: pointer;
  font-size: 1rem;
}
```

### 5. `ThemeToggle.jsx`

```typescriptx
import styles from './ThemeToggle.module.css';

export default function ThemeToggle({ theme, toggleTheme }) {
  return (
    <button className={styles.button} onClick={toggleTheme}>
      Switch to {theme === 'light' ? 'Dark' : 'Light'} Mode
    </button>
  );
}
```

### 6. `App.jsx` (with CSS variables)

```typescriptx
import { useState, useEffect } from 'react';
import styles from './App.module.css';
import ThemeToggle from './ThemeToggle';

function App() {
  const [theme, setTheme] = useState('light');

  const toggleTheme = () => {
    setTheme((prev) => (prev === 'light' ? 'dark' : 'light'));
  };

  useEffect(() => {
    document.body.className = theme;
  }, [theme]);

  return (
    <div className={styles.app}>
      <h1>Hello React</h1>
      <p>This app uses CSS variables for a scalable theme system.</p>
      <ThemeToggle theme={theme} toggleTheme={toggleTheme} />
      <div className={styles.card}>Themed content box</div>
    </div>
  );
}

export default App;
```

---

## ➕ Bonus: Adding a Global CSS File

Include a global CSS file for base styles (like vars, fonts, resets, or utility classes).

### 1. Create `src/global.css`

```css
:root {
  --bg: #ffffff;
  --fg: #000000;
  --card-bg: #f9f9f9;
}

body.dark {
  --bg: #1e1e1e;
  --fg: #f5f5f5;
  --card-bg: #2a2a2a;
}

body {
  margin: 0;
  font-family: system-ui, sans-serif;
  background-color: var(--bg);
  color: var(--fg);
  transition: background-color 0.3s, color 0.3s;
}
```

### 2. Import it once in your entry point (usually `main.jsx` or `main.tsx`)

```typescriptx
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import './global.css';

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
```

This global stylesheet will apply to your whole app and supports scalable theming using CSS variables.

---

## ⚠️ Problem: Prop Drilling

What if you need the `theme` in many nested components? Passing props through many layers becomes messy.

```typescriptx
<App>
  <Header theme={theme} />
    <Navbar theme={theme} />
      <UserMenu theme={theme} />
```

This is called **prop drilling**.

---

## 🔧 Part 2: Solving Prop Drilling with `useContext`

### 1. Create a context file `ThemeContext.jsx`

```typescriptx
{% raw %}
import { createContext, useContext, useState, useEffect } from 'react';

const ThemeContext = createContext();

export function ThemeProvider({ children }) {
  const [theme, setTheme] = useState('light');
  const toggleTheme = () => {
    setTheme((prev) => (prev === 'light' ? 'dark' : 'light'));
  };

  useEffect(() => {
    document.body.className = theme;
  }, [theme]);

  return (
    <ThemeContext.Provider value={{ theme, toggleTheme }}>
      {children}
    </ThemeContext.Provider>
  );
}

export function useTheme() {
  return useContext(ThemeContext);
}
{% endraw %}
```

**What is `useTheme()`?**

This is a **custom React hook**. A custom hook is just a TypeScript function that:

- Starts with the word `use`
- Calls built-in React hooks (like `useContext`, `useState`, etc.)

In this case, `useTheme()` is a convenience function that wraps `useContext(ThemeContext)` so that any component can simply write:

```typescript
const { theme, toggleTheme } = useTheme();
```

instead of repeating:

```typescript
const { theme, toggleTheme } = useContext(ThemeContext);
```

This improves readability and keeps your components clean.

### 2. Wrap your app in `ThemeProvider`

Edit `main.jsx`:

```typescriptx
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import { ThemeProvider } from './ThemeContext';
import './global.css';

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <ThemeProvider>
      <App />
    </ThemeProvider>
  </React.StrictMode>
);
```

### 3. Use context in `App.jsx`

```typescriptx
import styles from './App.module.css';
import ThemeToggle from './ThemeToggle';
import { useTheme } from './ThemeContext';

function App() {

  return (
    <div className={styles.app}>
      <h1>Hello React</h1>
      <ThemeToggle />
      <div className={styles.card}>Themed content box</div>
    </div>
  );
}

export default App;
```

### 4. Update `ThemeToggle.jsx`

```typescriptx
import styles from './ThemeToggle.module.css';
import { useTheme } from './ThemeContext';

export default function ThemeToggle() {
  const { theme, toggleTheme } = useTheme();

  return (
    <button className={styles.button} onClick={toggleTheme}>
      Switch to {theme === 'light' ? 'Dark' : 'Light'} Mode
    </button>
  );
}
```

---

## 🤔 How `useContext` Works

When you create a context with `createContext()`, you're telling React: *"I want to be able to share this value with any component in the tree without passing it through props manually."*

1. `ThemeContext.Provider` makes the value available to all components inside it.
2. `useContext(ThemeContext)` allows a child component to access that value directly.

So this:

```typescriptx
{% raw %}
<ThemeContext.Provider value={{ theme, toggleTheme }}>
  <App />
</ThemeContext.Provider>
{% endraw %}
```

Makes the `theme` and `toggleTheme` available anywhere inside `<App />` using:

```typescriptx
const { theme, toggleTheme } = useContext(ThemeContext);
```

This solves the prop drilling problem because you don't need to pass `theme` through every component manually.

---

## 🚀 Summary

- CSS Modules keep styles **scoped** to each component.
- `useState` can toggle themes simply, but prop drilling becomes an issue.
- `useContext` is a clean and scalable way to share state across the app without manually passing props.
- A global CSS file can be used for general layout or browser reset styles.
- CSS variables combined with a `body` class make it easy to handle many theme-based style rules.
- `useContext` works by giving components direct access to shared values defined by a Provider.
