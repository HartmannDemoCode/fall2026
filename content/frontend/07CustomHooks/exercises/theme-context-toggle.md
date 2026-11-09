---
title: Theme Context Toggle (Dark/Light)
description: A very beginner-friendly exercise to build dark/light mode using React Context and CSS styling.
weight: 2
draft: false
---

# React Context Exercise (Very Beginner Friendly)

## Title
Build dark/light mode with Context: useTheme + ThemeProvider

## Why this exercise?
This exercise teaches an important real-world pattern:
- We want many components to know the current theme (dark or light).
- Passing this value through many props becomes messy.
- Context lets us share theme state globally in a clean way.

You will build a complete beginner version with clear small steps.

---

## Learning goals
By the end of this exercise, you can:
1. Explain Context in simple words.
2. Create a ThemeContext file.
3. Create a ThemeProvider component.
4. Read shared context values with a custom hook.
5. Use CSS variables to style dark/light mode.
6. Build a working toggle button.

---

## Time estimate
- 45 to 70 minutes (slow pace, with explanation and testing)

---

## Setup
Use an existing React project or create a new one.

If needed:

```bash
npm install
npm run dev
```

Open the app in browser.

---

## The simple problem
We want this behavior:
- Click a button to switch between light and dark mode.
- The whole app changes colors.
- Any component can read the current theme.

We will use:
- React Context for shared state
- A custom hook named useTheme
- CSS variables for styling

---

## Step 0 - Explain Context in one sentence
Context is a way to share data between components without sending props through every level.

---

## Step 1 - Create the context file
Create file:
- src/context/ThemeContext.jsx

Paste this starter code:

```jsx
import { createContext, useContext, useState } from "react";

const ThemeContext = createContext(null);

export function ThemeProvider({ children }) {
  const [theme, setTheme] = useState("light");

  const toggleTheme = () => {
    setTheme((prevTheme) => (prevTheme === "light" ? "dark" : "light"));
  };

  const value = {
    theme,
    toggleTheme,
    isDark: theme === "dark",
  };

  return <ThemeContext.Provider value={value}>{children}</ThemeContext.Provider>;
}

export function useTheme() {
  const context = useContext(ThemeContext);

  if (!context) {
    throw new Error("useTheme must be used inside ThemeProvider");
  }

  return context;
}
```

Stop and explain:
- createContext creates the shared container.
- ThemeProvider holds the actual state.
- useTheme is a helper hook so components read context easily.

Checkpoint:
- File is created with no syntax errors.

---

## Step 2 - Wrap your app in ThemeProvider
Open your app entry file (usually src/main.jsx).

Find where App is rendered and wrap App with ThemeProvider.

Example:

```jsx
import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";
import { ThemeProvider } from "./context/ThemeContext";
import "./index.css";

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <ThemeProvider>
      <App />
    </ThemeProvider>
  </React.StrictMode>
);
```

Checkpoint:
- App still loads in browser.
- No import errors.

---

## Step 3 - Create a tiny toggle demo component
Create file:
- src/assets/components/ThemeToggleDemo.jsx

Paste:

```jsx
import { useTheme } from "../../context/ThemeContext";

export default function ThemeToggleDemo() {
  const { theme, toggleTheme, isDark } = useTheme();

  return (
    <section className="theme-demo-card">
      <h3>Theme Toggle Demo</h3>
      <p>Current theme: {theme}</p>

      <button type="button" onClick={toggleTheme} className="theme-toggle-btn">
        {isDark ? "Switch to Light Mode" : "Switch to Dark Mode"}
      </button>

      <p className="theme-hint">
        Tip: click the button and observe the background and text colors.
      </p>
    </section>
  );
}
```

Checkpoint:
- Component compiles.
- No red errors in editor.

---

## Step 4 - Use theme class in App
Open src/App.jsx and use the theme value to set a class on the root container.

Example:

```jsx
import ThemeToggleDemo from "./assets/components/ThemeToggleDemo";
import { useTheme } from "./context/ThemeContext";

export default function App() {
  const { theme } = useTheme();

  return (
    <main className={`app-shell ${theme}`}>
      <h1>Context Theme Exercise</h1>
      <ThemeToggleDemo />
    </main>
  );
}
```

Stop and explain:
- app-shell gives a base layout class.
- light or dark class is added dynamically from context state.

Checkpoint:
- You can print theme in UI and see it change on button click.

---

## Step 5 - Add styling with CSS variables
Open src/index.css (or src/App.css if your project uses that).

Add this CSS:

```css
:root {
  --bg: #f7f7fb;
  --text: #111827;
  --card-bg: #ffffff;
  --card-border: #d1d5db;
  --button-bg: #111827;
  --button-text: #f9fafb;
}

.app-shell {
  min-height: 100vh;
  padding: 2rem;
  background-color: var(--bg);
  color: var(--text);
  transition: background-color 0.25s ease, color 0.25s ease;
}

.theme-demo-card {
  margin-top: 1rem;
  max-width: 520px;
  padding: 1rem;
  border: 1px solid var(--card-border);
  border-radius: 10px;
  background-color: var(--card-bg);
}

.theme-toggle-btn {
  margin-top: 0.5rem;
  padding: 0.6rem 0.9rem;
  border: none;
  border-radius: 8px;
  background-color: var(--button-bg);
  color: var(--button-text);
  cursor: pointer;
  font-weight: 600;
}

.theme-hint {
  margin-top: 0.75rem;
  opacity: 0.85;
}

.app-shell.dark {
  --bg: #111827;
  --text: #f9fafb;
  --card-bg: #1f2937;
  --card-border: #374151;
  --button-bg: #f9fafb;
  --button-text: #111827;
}

.app-shell.light {
  --bg: #f7f7fb;
  --text: #111827;
  --card-bg: #ffffff;
  --card-border: #d1d5db;
  --button-bg: #111827;
  --button-text: #f9fafb;
}
```

Checkpoint:
- Background and text colors change when toggling.
- Card and button colors also update.

---

## Step 6 - Manual testing checklist
1. App starts in light mode.
2. Button text says Switch to Dark Mode in light mode.
3. Clicking button changes to dark mode.
4. Button text changes to Switch to Light Mode in dark mode.
5. Main background and text colors both change.
6. Card and button colors also change.

If all 6 pass, your Context-based theme toggle works.

---

## Step 7 - Explain what just happened
- ThemeProvider owns the shared theme state.
- useTheme gives any component access to that shared state.
- toggleTheme updates one shared value.
- The class on app-shell changes CSS variables.
- CSS variables update many styles at once.

Rule of thumb:
- Context shares state.
- CSS handles visuals.

---

## Common beginner mistakes (debug guide)
1. useTheme error: must be used inside ThemeProvider
   - Cause: App is not wrapped by ThemeProvider.
   - Fix: Wrap App in main.jsx.

2. Button click does nothing
   - Cause: onClick not connected to toggleTheme.
   - Fix: Check button uses onClick={toggleTheme}.

3. Colors never change
   - Cause: Missing className with theme on app shell.
   - Fix: Use className={`app-shell ${theme}`}.

4. Import path error
   - Cause: wrong relative path to ThemeContext.
   - Fix: verify folder names and ../ levels.

5. CSS looks unchanged
   - Cause: styles in wrong file or overridden.
   - Fix: confirm the CSS file is imported.

---

## Final code reference

### src/context/ThemeContext.jsx

```jsx
import { createContext, useContext, useState } from "react";

const ThemeContext = createContext(null);

export function ThemeProvider({ children }) {
  const [theme, setTheme] = useState("light");

  const toggleTheme = () => {
    setTheme((prevTheme) => (prevTheme === "light" ? "dark" : "light"));
  };

  const value = {
    theme,
    toggleTheme,
    isDark: theme === "dark",
  };

  return <ThemeContext.Provider value={value}>{children}</ThemeContext.Provider>;
}

export function useTheme() {
  const context = useContext(ThemeContext);

  if (!context) {
    throw new Error("useTheme must be used inside ThemeProvider");
  }

  return context;
}
```

### src/assets/components/ThemeToggleDemo.jsx

```jsx
import { useTheme } from "../../context/ThemeContext";

export default function ThemeToggleDemo() {
  const { theme, toggleTheme, isDark } = useTheme();

  return (
    <section className="theme-demo-card">
      <h3>Theme Toggle Demo</h3>
      <p>Current theme: {theme}</p>

      <button type="button" onClick={toggleTheme} className="theme-toggle-btn">
        {isDark ? "Switch to Light Mode" : "Switch to Dark Mode"}
      </button>

      <p className="theme-hint">
        Tip: click the button and observe the background and text colors.
      </p>
    </section>
  );
}
```

### src/App.jsx

```jsx
import ThemeToggleDemo from "./assets/components/ThemeToggleDemo";
import { useTheme } from "./context/ThemeContext";

export default function App() {
  const { theme } = useTheme();

  return (
    <main className={`app-shell ${theme}`}>
      <h1>Context Theme Exercise</h1>
      <ThemeToggleDemo />
    </main>
  );
}
```

---

## Extension ideas
1. Save theme in localStorage so it persists after refresh.
2. Add a third theme (for example high-contrast mode).
3. Move the toggle button into a Navbar component and confirm Context still works.
