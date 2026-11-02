---
title: 06 React and Error handling + JWT security
description: "React and Error handling + JWT security for building a secure SPA."
weight: 6
draft: false
geekdocCollapseSection: true
---

## Implementing error handling.

- [Learning objectives for the week](learning-objectives)

Topics covered in this week are:
1. Error handling in React applications.
  - Different types of errors in React applications.
  - Implementing error boundaries to catch and handle errors in React components.
  - Displaying user-friendly error messages and fallback UI when errors occur.
2. React Hooks for managing state and side effects in functional components.
  - Using the `useState` hook to manage component state.
  - Using the `useEffect` hook to handle side effects such as data fetching and subscriptions.
  - Creating custom hooks to encapsulate reusable logic and improve code organization.
  - Using the `useContext` hook to access and manage global state.

### Prepare for the class

Orient yourself in this documentation:
- [Video: React error handling 10:31](https://www.youtube.com/watch?v=OQQAv8t3bfc)
- [React Hooks](https://react.dev/reference/react)
- [Toolbox: Error handling in React](/toolbox/react/error-handling)

### In-class exercises

Start from the JWT app you built last week. Work in pairs or small groups and complete the exercises in order. Do not skip ahead. The purpose of this lesson is to make your app behave well when something goes wrong, not just to make it work when everything is fine.

Important: if you are unsure what to do, use this rule:
- If a request is running, show a loading state.
- If the request fails, show a clear error message.
- If the request succeeds, update the UI.
- If a component crashes, show a fallback message instead of breaking the whole page.

1. Review the error demo in class first
   - Clone the demo project from [GitHub](https://github.com/HartmannDemoCode/errorHandlingDemo).
   - Run the app and press the different buttons.
   - As a group, answer these questions:
     - What is a runtime error?
     - What is a network error?
     - What is a render error?
     - Why is an error boundary useful?
   - Write a short explanation in plain English for each one. This should be done before writing any code in your own app.

2. Find the weak spots in your JWT app
   - Open your JWT app from last week.
   - Search for all `fetch` calls and custom API helper functions.
   - Write down every request in the app, for example:
     - login
     - fetch user data
     - fetch protected resource
     - create item
     - update item
     - delete item
   - For every request, ask: "What should happen if the server returns 400, 401, 403, 404, or 500?" and "What if the network is down?"
   - Make a list of every failed state you want to handle.
     - E.g. login fails, get user data fails, etc.
     - For each failed state, write down what the user should see in the UI. This is your error handling plan.

3. Add a standard loading/error pattern to your components
   - For every component that loads data, add these states:
     - `loading`
     - `error`
     - `data`
   - Use a pattern like this:

```jsx
const [data, setData] = useState([]);
const [loading, setLoading] = useState(true);
const [error, setError] = useState(null);

useEffect(() => {
  const loadData = async () => {
    setLoading(true);
    setError(null);

    try {
      const response = await fetch("/api/example");

      if (!response.ok) {
        throw new Error("Could not load data");
      }

      const result = await response.json();
      setData(result);
    } catch (err) {
      setError("The data could not be loaded. Please try again.");
    } finally {
      setLoading(false);
    }
  };

  loadData();
}, []);
```

   - Then in the JSX, show the UI in a very clear way:

```jsx
if (loading) return <p>Loading...</p>;
if (error) return <p className="error">{error}</p>;
return <div>{data.map(item => <p key={item.id}>{item.name}</p>)}</div>;
```

   - This is the pattern you should repeat for all data-fetching components.

4. Implement HTTP status handling in the same way as the demo.
   - In your fetch logic, always check `response.ok`.
   - If the response is not ok, do not just do `console.log()`. Instead, convert the status code into a message the user understands.
   - Use a small mapping like this:

```jsx
if (!response.ok) {
  if (response.status === 400) {
    throw new Error("The data is invalid. Please check your input.");
  }

  if (response.status === 401 || response.status === 403) {
    throw new Error("You are not authorized. Please log in again.");
  }

  if (response.status === 404) {
    throw new Error("The requested item was not found.");
  }

  if (response.status >= 500) {
    throw new Error("The server is unavailable. Please try again later.");
  }
}
```

   - For network failures, catch the error and show a message such as:
     - "Could not connect to the server. Check your internet connection."
     - These happens when the fetch promise rejects, for example if the user is offline.
     ```jsx
    try {
      const response = await fetch("/api/example");
    } catch (err) {
      setError("Could not connect to the server. Check your internet connection.");
    }
    ```
5. Add user-friendly error handling to the login form
   - Open the login form and make it handle the following states:
     - empty username or password
     - incorrect credentials
     - server error
     - network failure
     - loading state
   - Start with a simple state setup:


```jsx
const [username, setUsername] = useState("");
const [password, setPassword] = useState("");
const [error, setError] = useState("");
const [loading, setLoading] = useState(false);
```

- Then implement the submit handler step by step:

```jsx
const handleLogin = async (e) => {
  e.preventDefault();

  if (!username || !password) {
    setError("Please enter both username and password.");
    return;
  }

  setLoading(true);
  setError("");

  try {
    const response = await fetch("/api/login", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ username, password })
    });

    if (!response.ok) {
      throw new Error("Incorrect username or password");
    }

    const data = await response.json();
    localStorage.setItem("token", data.token);
    // update the UI to show that the user is logged in
  } catch (err) {
    setError(err.message || "Login failed. Please try again.");
  } finally {
    setLoading(false);
  }
};
```

   - In the JSX, add the following behavior:
     - disable the button while loading
     - display the error under the form
     - show text like "Logging in..." while waiting

6. Make the app resilient when one component fails
   - import the "react-error-boundary" library and wrap your components in an `ErrorBoundary`.
   - Wrap the main content or the parts of the app that are most likely to fail.
   - Test it by deliberately creating a component that throws an error, then confirm that the boundary shows the fallback UI instead of crashing the whole app.

7. Handle global JavaScript errors
   - This is not the same as API errors.
   - These happen when something unexpected breaks in JavaScript, for example:
     - an event handler throws
     - an unhandled promise rejects
     - a missing variable is used
   - Add listeners like this:

```jsx
useEffect(() => {
  const handleError = (event) => {
    console.error("Global error:", event.error);
    setGlobalError("Something unexpected happened. Please refresh the page.");
  };

  const handleUnhandledRejection = (event) => {
    console.error("Unhandled promise rejection:", event.reason);
    setGlobalError("A request failed unexpectedly. Please try again.");
  };

  window.addEventListener("error", handleError);
  window.addEventListener("unhandledrejection", handleUnhandledRejection);

  return () => {
    window.removeEventListener("error", handleError);
    window.removeEventListener("unhandledrejection", handleUnhandledRejection);
  };
}, []);
```

   - Show a banner or alert at the top of the page when this happens.
   - This makes the app user-friendly even when something unexpected occurs.

8. Add a header that changes depending on login state
   - Create or update a header component.
   - If the user is logged in, show something like:
     - "Logged in as Alice"
     - plus a logout button
   - If the user is not logged in, show:
     - "Guest" or a login link
   - Example:

```jsx
<header>
  {user ? (
    <>
      <span>Logged in as {user.username}</span>
      <button onClick={logout}>Logout</button>
    </>
  ) : (
    <span>Guest</span>
  )}
</header>
```

   - Make sure the header updates immediately after successful login or logout.

9. Check your work against this final checklist
   - Login form shows a friendly message when credentials are wrong.
   - Missing input is validated before sending the request.
   - Loading text disables the button during requests.
   - Error messages are displayed in the UI, not only in the console.
   - A fetch error does not crash the app.
   - A render error is handled by the error boundary.
   - A global JS error shows a friendly message to the user.
   - Header updates with the correct user state.
   - The app feels stable even when something fails.


#### Look in the toolbox for inspiration and reference:

- [Error handling in React](/toolbox/react/error-handling)


