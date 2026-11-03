---
title: 07 Custom hooks
description: "Custom hooks in React"
weight: 7
draft: false
geekdocCollapseSection: true
---

## React Custom hooks

- [Learning objectives for the week](learning-objectives)

Topics covered in this week are:
- Custom hooks in React.
  - Why custom hooks are useful in React.
  - How to create a custom hook in React.
  - How to use a custom hook in a React component.

### Prepare for the class

- [Video: React custom hooks ](https://www.youtube.com/watch?v=6ThXsUwLWvc)
- [React Hooks](https://react.dev/learn/reusing-logic-with-custom-hooks)
- [Code example](https://github.com/HartmannDemoCode/errorHandlingDemo/blob/main/src/hooks/useAuth.js)

### In-class exercises

This exercise is intentionally very guided. Follow each step in order.

Goal: add authentication to an existing React project by using a custom `useAuth` hook, modeled after the code example in:
- [Code example](https://github.com/HartmannDemoCode/errorHandlingDemo/blob/main/src/hooks/useAuth.js)

The hook in the example exposes this interface:

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

Use the same names in this exercise so everyone can follow the same structure.

#### Part 1 - Understand what already exists in your project

1. Open your existing project (the one from earlier weeks).
2. Find where routing is configured (`main.jsx`, `App.jsx`, or similar).
3. Find where login currently happens.
4. Find where token storage currently happens (`localStorage`, `sessionStorage`, or nowhere).
5. Write down answers to these questions before coding:
   - Do we already have login/logout API functions?
   - Are we already storing a token?
   - Where should authenticated user state live?

Checkpoint:
- You can point to the file that currently handles login.

#### Part 2 - Create or verify API facade functions

Create or confirm these functions in your API layer:
- `login(username, password)`
- `logout()`
- `loggedIn()`
- `getData()` for a protected endpoint

Expected behavior:
- `login` sends credentials and stores token in `localStorage` as `jwtToken`.
- `logout` removes `jwtToken`.
- `loggedIn` returns `true` if token exists, else `false`.
- `getData` calls a protected endpoint with `Authorization: Bearer <token>`.

Suggested shape:

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

#### Part 3 - Create the `useAuth` hook file

Create `src/hooks/useAuth.js` and implement this exact structure:

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

Checkpoint:
- Hook compiles with no import errors.
- Hook returns all 8 values.

#### Part 4 - Integrate hook in `App` and pass through `Outlet`

In your top-level `App` component:
- import the hook
- call it once: `const auth = useAuth();`
- pass `auth` via `Outlet` context

Use this pattern:

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

If your app already has other values in outlet context (for example `errorMessage`), keep them and add `auth`.

Checkpoint:
- Child pages can access `auth` via `useOutletContext()`.

#### Part 5 - Build an AuthDemo component for existing apps

Create a component that consumes the hook from outlet context and handles both states:
- logged out: show login form
- logged in: show user info, logout button, protected data

Use this skeleton:

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
- Wrong credentials show an error message.
- Correct credentials switch UI from form to protected content.

#### Part 6 - Add header integration in existing layout

In header or navbar:
- show `Guest` when not logged in
- show username when logged in

Simple example:

```jsx
function Header({ user }) {
  return <div>Logged in as: {user?.username || "Guest"}</div>;
}
```

Use `auth.user` from `App` and pass into header.

Checkpoint:
- Header updates immediately after login/logout.

#### Part 7 - Test checklist students must complete

Each group must demonstrate all items:

1. Start logged out: login form is visible.
2. Submit wrong credentials: friendly error is shown.
3. Submit correct credentials: token is saved in localStorage.
4. After login: protected data appears.
5. Click logout: token is removed and form returns.
6. Refresh page while token exists: app still treats user as authenticated.
7. Trigger protected request with invalid token: friendly error is shown.

#### Part 8 - Common mistakes and how to fix them

1. `isAuthenticated` is always false:
   - Check token key name (`jwtToken`) is the same everywhere.

2. Login works but UI does not update:
   - Confirm `setUser({ username })` runs after successful login.

3. Protected data never loads:
   - Confirm `Authorization` header includes `Bearer ${token}`.

4. Errors only shown in console:
   - Ensure you store error in state and render it in JSX.

5. Hook cannot be imported:
   - Verify import path to `apiFacade` from `useAuth.js`.

#### Part 9 - Optional extension (for fast groups)

1. Replace placeholder user (`{ username: "demo" }`) by decoding username from token payload.
2. Add a route guard component that redirects to login page if not authenticated.
3. Persist and restore protected data after refresh.


#### Look in the toolbox for inspiration and reference:
