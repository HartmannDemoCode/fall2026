---
title: useAuth in an Existing Project (Beginner Guide)
description: A very beginner-friendly, step-by-step exercise for adding a useAuth hook to an existing React project.
weight: 3
draft: false
---

# React Custom Hooks Exercise (Very Beginner Friendly)

## Title
Use `useAuth` in an existing project

## Why this exercise?
This exercise teaches a real-world pattern:
- Authentication logic can become messy when spread across many components.
- A custom hook lets us keep that logic in one place.
- Components become simpler and easier to read.

You will follow a very guided path based on this code example:
- [Code example](https://github.com/HartmannDemoCode/errorHandlingDemo/blob/main/src/hooks/useAuth.js)

---

## Learning goals
By the end of this exercise, you can:
1. Explain what `useAuth` is in simple words.
2. Create and use a custom authentication hook.
3. Connect login/logout/token flow to React state.
4. Pass auth state to child pages with `Outlet` context.
5. Show different UI for logged-in and logged-out users.

---

## Time estimate
- 50 to 80 minutes (slow pace with testing)

---

## Setup
Use your existing project from earlier weeks.

Make sure the app runs:

```bash
npm install
npm run dev
```

---

## The target hook interface
Use this exact structure so everyone in class follows the same naming:

```js
{
  user,
  protectedData,
  loading,
  error,
  isAuthenticated,
  signIn,
  signOut,
  fetchProtectedData,
}
```

---

## Part 1 - Understand your current project before coding

1. Open your existing app.
2. Find where routes are configured (`main.jsx`, `App.jsx`, or similar).
3. Find where login currently happens.
4. Find where token is stored (`localStorage` or somewhere else).
5. Write quick answers:
   - Do we already have API methods for login/logout?
   - Are we already storing a token?
   - Which component should own auth state?

Checkpoint:
- You can point to the file that currently handles login.

---

## Part 2 - Create or verify API functions

Create (or verify) these functions in your API layer:
- `login(username, password)`
- `logout()`
- `loggedIn()`
- `getData()` for a protected endpoint

Expected behavior:
- `login` sends credentials and stores token as `jwtToken` in `localStorage`.
- `logout` removes token.
- `loggedIn` checks if token exists.
- `getData` calls protected endpoint with `Authorization: Bearer <token>`.

Starter example:

```js
async function login(username, password) {
  const response = await fetch(API_URL + "/auth/login", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ username, password }),
  });

  if (!response.ok) {
    throw new Error("Invalid username or password");
  }

  const data = await response.json();
  localStorage.setItem("jwtToken", data.token);
}

function logout() {
  localStorage.removeItem("jwtToken");
}

function loggedIn() {
  return localStorage.getItem("jwtToken") !== null;
}
```

Checkpoint:
- Login stores token.
- Logout removes token.

---

## Part 3 - Create the hook file

Create file:
- `src/hooks/useAuth.js`

Paste this full version first, then read it slowly:

```jsx
import { useCallback, useState } from "react";
import { login, logout, loggedIn, getData } from "../../apiFacade";

export function useAuth() {
  const [user, setUser] = useState(() => {
    const token = localStorage.getItem("jwtToken");
    return token ? { username: "demo" } : null;
  });
  const [protectedData, setProtectedData] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const signIn = useCallback(async (username, password) => {
    setLoading(true);
    setError(null);
    setProtectedData(null);

    try {
      await login(username, password);

      const token = localStorage.getItem("jwtToken");
      if (!token) throw new Error("Login succeeded but no token was returned.");

      setUser({ username });
      const data = await getData();
      setProtectedData(data);
      return true;
    } catch (err) {
      const message = err?.error?.message || err?.message || "Login failed";
      setError(message);
      setUser(null);
      return false;
    } finally {
      setLoading(false);
    }
  }, []);

  const signOut = useCallback(() => {
    logout();
    setUser(null);
    setError(null);
    setProtectedData(null);
  }, []);

  const fetchProtectedData = useCallback(async () => {
    setLoading(true);
    setError(null);

    try {
      const data = await getData();
      setProtectedData(data);
      return data;
    } catch (err) {
      const message = err?.error?.message || err?.error || "You are not authorized";
      setError(message);
      return null;
    } finally {
      setLoading(false);
    }
  }, []);

  return {
    user,
    protectedData,
    loading,
    error,
    isAuthenticated: loggedIn(),
    signIn,
    signOut,
    fetchProtectedData,
  };
}
```

Stop and explain:
- Hook owns auth state (`user`, `loading`, `error`).
- Hook owns auth actions (`signIn`, `signOut`).
- Components should call these actions, not duplicate auth logic.

Checkpoint:
- File compiles with no import errors.

---

## Part 4 - Use the hook in App and pass via Outlet context

In your `App` component:
1. Import `useAuth`.
2. Call it once: `const auth = useAuth();`
3. Pass `auth` through `Outlet context`.

Example:

```jsx
import { Outlet } from "react-router";
import { useAuth } from "../hooks/useAuth";

function App() {
  const auth = useAuth();

  return (
    <div>
      <Outlet context={{ auth }} />
    </div>
  );
}
```

If your app already passes other values in outlet context, keep them and add `auth`.

Checkpoint:
- Child routes can read `auth` with `useOutletContext()`.

---

## Part 5 - Build a beginner Auth Demo page

Create a page/component that consumes the auth hook from outlet context.

Requirements:
- If logged out: show login form
- If logged in: show username, logout button, protected data
- Always show error message when `error` has value

Starter code:

```jsx
import { useEffect } from "react";
import { useOutletContext } from "react-router";

export default function AuthDemoPage() {
  const { auth } = useOutletContext();

  const {
    user,
    signIn,
    signOut,
    fetchProtectedData,
    protectedData,
    error,
    loading,
    isAuthenticated,
  } = auth;

  useEffect(() => {
    if (isAuthenticated && !protectedData) {
      fetchProtectedData();
    }
  }, [isAuthenticated, protectedData, fetchProtectedData]);

  const handleLogin = async (event) => {
    event.preventDefault();
    const formData = new FormData(event.currentTarget);
    const username = formData.get("username");
    const password = formData.get("password");
    await signIn(username, password);
  };

  return (
    <div>
      <h3>Auth Hook Demo</h3>

      {isAuthenticated ? (
        <div>
          <p>Logged in as {user?.username}</p>
          <button type="button" onClick={signOut}>Log out</button>

          {loading ? (
            <p>Loading protected data...</p>
          ) : protectedData ? (
            <pre>{JSON.stringify(protectedData, null, 2)}</pre>
          ) : (
            <p>No protected data available.</p>
          )}
        </div>
      ) : (
        <form onSubmit={handleLogin}>
          <input name="username" placeholder="Username" />
          <input name="password" type="password" placeholder="Password" />
          <button type="submit" disabled={loading}>
            {loading ? "Logging in..." : "Log in"}
          </button>
        </form>
      )}

      {error && <p style={{ color: "crimson" }}>{error}</p>}
    </div>
  );
}
```

Checkpoint:
- Wrong credentials show error.
- Correct credentials switch UI to logged-in state.

---

## Part 6 - Show auth state in header

In header/navbar:
- show Guest if no user
- show username when logged in

Example:

```jsx
function Header({ user }) {
  return <div>Logged in as: {user?.username || "Guest"}</div>;
}
```

Checkpoint:
- Header updates right after login/logout.

---

## Part 7 - Manual testing checklist

Each group must demonstrate all 7:
1. Logged out state shows login form.
2. Wrong login shows friendly error.
3. Correct login stores token in localStorage.
4. After login, protected endpoint data appears.
5. Logout removes token and returns to form.
6. Refresh with token still set keeps user authenticated.
7. Invalid token gives controlled error message.

---

## Common beginner mistakes (debug guide)

1. `isAuthenticated` always false
   - Check token key name is exactly `jwtToken` everywhere.

2. Login succeeds but UI does not change
   - Check `setUser({ username })` runs in `signIn` success path.

3. Protected request fails every time
   - Check `Authorization` header includes `Bearer ${token}`.

4. Error only in console, not UI
   - Make sure error is stored in state and rendered in JSX.

5. Import error in hook
   - Verify path to API facade in `useAuth.js`.

---

## Fast teacher script (talk track)

1. We move auth logic out of components and into one custom hook.
2. Components should call actions like `signIn` and `signOut`.
3. Hook returns state + actions for reuse.
4. This keeps code cleaner and easier to maintain.

---

## Optional extension (for fast groups)

1. Replace placeholder user (`{ username: "demo" }`) by reading username from token payload.
2. Add route guard to redirect unauthenticated users.
3. Persist and restore `protectedData` after refresh.
