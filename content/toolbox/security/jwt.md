---
title: "JWT token authentication and authorization"
description: "How to use JWT tokens for authentication and authorization in frontend applications"
weight: 3
draft: false
---

# JWT in React: principles and a practical guide

This article is for students who already know React components, state, event handlers, and how to call a REST API with `fetch`. All implementation examples are frontend JavaScript. An existing API must provide login and protected data.

## Part 1: The overall principles

### 1. What problem are we solving?

A React application can show a login form, but submitting that form does not automatically authenticate later requests. Each request to a protected API needs a credential that the API can check.

One common solution is an **access token**: the API issues it after successful login, and React sends it with subsequent requests. The access token can use the JSON Web Token (JWT) format.

Distinguish these concepts:

| Concept | Question it answers | Example |
| --- | --- | --- |
| Authentication | Who are you? | The API checks a username and password. |
| Authorization | What may you do? | The API checks whether you may delete a book. |
| JWT | How are claims represented? | A token contains a subject and expiration time. |
| Bearer token | How is the credential used? | A request presents the token in its Authorization header. |

JWT is a token format, rather than a complete login system. APIs can use other token formats, and JWTs can serve purposes beyond access tokens.

### 2. The request flow

1. The user enters credentials in React.
2. React sends them to the API's login endpoint over HTTPS.
3. The API checks the credentials and returns an access token.
4. React retains the token and updates the interface.
5. For a protected request, React adds `Authorization: Bearer <token>`.
6. The API validates the token and checks permission for the requested operation.
7. React displays the result or handles an error.

The password is used for login; it should not be retained in application storage or sent with every data request. A bearer token must also be treated as a credential: someone who obtains it may be able to use it.

### 3. What is inside a JWT?

A typical **signed JWT** has three Base64URL-encoded parts separated by dots:

```text
header.payload.signature
```

The header describes the token and signing algorithm. The payload contains claims. The signature protects the integrity of the signed content. JWT also supports encrypted forms; this article uses signed tokens.

An illustrative decoded payload is:

```json
{
  "sub": "42",
  "username": "alice",
  "roles": ["user"],
  "iss": "https://api.example.com",
  "aud": "books-api",
  "exp": 1900000000
}
```

| Claim | Meaning |
| --- | --- |
| `sub` | Subject, usually a user identifier. |
| `iss` | Issuer of the token. |
| `aud` | Intended recipient or audience. |
| `exp` | Expiration time, in seconds since the Unix epoch. |
| `username`, `roles` | Application-specific claims; names and shapes depend on the API. |

The JSON above is explanatory data, not a usable access token. A signed JWT's payload is readable; encoding does not provide confidentiality. Passwords and secrets do not belong in it. See [RFC 7519](https://www.rfc-editor.org/rfc/rfc7519.html).

### 4. Decoding is different from validation

React may decode a token to display a username, adjust navigation, or check when the interface should ask the user to log in again.

**Decoding does not establish that the token is authentic.** The API must validate the signature, allowed algorithm, issuer, audience, and relevant time claims, then authorize the operation. React must never contain a signing secret or private signing key.

A user can change frontend code or call the API directly. Consequently, hiding an Admin button or redirecting away from a page improves the interface, but provides no protection for API data. The API must enforce permissions, including access to individual resources. See [OWASP REST Security](https://cheatsheetseries.owasp.org/cheatsheets/REST_Security_Cheat_Sheet.html).

### 5. Where should the frontend keep the token?

Storage is an architectural choice with tradeoffs:

| Approach | Reload behavior | Main consideration |
| --- | --- | --- |
| React state / memory | Token is lost on a full reload. | No persistent browser copy, but running malicious JavaScript can still act as the user. |
| `sessionStorage` | Survives reloads within a tab's session. | Readable by JavaScript, including injected scripts. |
| `localStorage` | Persists across browser sessions. | Readable by JavaScript; stolen credentials may remain useful after the page closes. |
| `HttpOnly` cookie | Depends on cookie and session settings. | JavaScript cannot read it; the API must set it, and cookie-based authentication needs CSRF defenses. |

This example holds the access token **in memory**. Students will log in again after reloading the page. This keeps the bearer-token flow visible without teaching persistent JavaScript-readable storage as the default. OWASP specifically advises against storing session identifiers in local storage. See [OWASP HTML5 Security](https://cheatsheetseries.owasp.org/cheatsheets/HTML5_Security_Cheat_Sheet.html).

Another architecture uses a backend-for-frontend and an HttpOnly session cookie. React then calls that backend without handling a JWT directly. It requires server support and is a different implementation from the example below.

### 6. Expiration, renewal, and logout

Access tokens normally have a limited lifetime. After expiration, a user must authenticate again or use an API-supported renewal flow.

A refresh token is a separate credential used to obtain another access token. It need not itself be a JWT. Renewal requires an agreed API contract, secure storage, and handling for revoked or expired refresh credentials. Our example deliberately uses login again rather than implementing refresh.

Removing a token from React logs the user out of this interface. It does **not** invalidate copies elsewhere. Immediate invalidation requires server-side support; otherwise a copied access token can remain usable until expiration. JWT-based systems may still keep server state for refresh sessions, revocation, or permission checks.

## Part 2: Short React examples

These examples use **React and the browser's built-in `fetch` only**. No router, JWT package, or other dependency is needed. React does not need to decode the JWT to send it to the API.

The snippets build one `App` component. Put the functions from steps 3–5 inside the component, before its `return`, and replace the placeholder return with step 6.

### 1. Assume an existing API

| Endpoint | Request | Successful response |
| --- | --- | --- |
| `POST /api/auth/login` | JSON with `username` and `password`. | `{ "accessToken": "..." }` |
| `GET /api/books` | An Authorization header containing the token. | `[{ "id": 1, "title": "Effective Java" }]` |

The example uses same-origin `/api` URLs. Your existing development setup must forward those requests to the API. If you use a separate API origin instead, the API must allow the frontend origin and Authorization header through CORS. Use HTTPS outside local development.

### 2. Keep the token in React state

```jsx
import { useState } from "react";

export default function App() {
  const [token, setToken] = useState(null);
  const [books, setBooks] = useState([]);
  const [error, setError] = useState("");

  // Add login, loadBooks, and logout here.

  return <h1>Book application</h1>; // Replace with step 6.
}
```

A token is a string. Keeping it in state lets React update the screen when the user logs in or out. A full page reload clears it.

### 3. Log in and save the token

```jsx
async function login(event) {
  event.preventDefault();
  setError("");
  const form = event.currentTarget;
  const values = new FormData(form);

  try {
    const response = await fetch("/api/auth/login", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(Object.fromEntries(values)),
    });
    if (!response.ok) throw new Error("Login failed.");

    const data = await response.json();
    if (!data.accessToken) throw new Error("No token received.");
    setToken(data.accessToken);
  } catch (error) {
    setError(error.message);
  } finally {
    form.reset();
  }
}
```

`FormData` reads the named inputs in the form. The API receives the credentials as JSON. After a successful response, React saves `accessToken`. Resetting the form clears the password input.

### 4. Send the token with a protected request

```jsx
async function loadBooks() {
  setError("");
  try {
    const response = await fetch("/api/books", {
      headers: { Authorization: `Bearer ${token}` },
    });

    if (response.status === 401) {
      logout();
      throw new Error("Please log in again.");
    }
    if (response.status === 403) {
      throw new Error("You do not have permission to view these books.");
    }
    if (!response.ok) throw new Error("Could not load books.");

    setBooks(await response.json());
  } catch (error) {
    setError(error.message);
  }
}
```

The key line is:

```js
headers: { Authorization: `Bearer ${token}` }
```

For this API contract, `401` means the credentials are missing, invalid, or expired; React clears the session. `403` means the user lacks permission, so React shows an error and keeps the token.

`fetch` does not throw just because the response has an HTTP error status. That is why we check the status and `response.ok` ourselves. Network errors are caught by the same `catch` block.

### 5. Log out

```jsx
function logout() {
  setToken(null);
  setBooks([]);
  setError("");
}
```

Clear both the token and protected data. This ends the local login state; it does not revoke a token held elsewhere.

### 6. Choose what to display

Replace the placeholder return in step 2 with:

```jsx
return (
  <main>
    <h1>Book application</h1>
    {!token ? (
      <form onSubmit={login}>
        <input name="username" aria-label="Username"
          autoComplete="username" placeholder="Username" required />
        <input name="password" aria-label="Password" type="password"
          autoComplete="current-password" placeholder="Password" required />
        <button>Log in</button>
      </form>
    ) : (
      <>
        <button onClick={loadBooks}>Load books</button>
        <button onClick={logout}>Log out</button>
        <ul>
          {books.map(book => <li key={book.id}>{book.title}</li>)}
        </ul>
      </>
    )}
    {error && <p role="alert">{error}</p>}
  </main>
);
```

`!token` displays the login form. A stored token displays the books controls. This is only a choice about what React renders: the API must still validate every protected request.

### What happens when the token expires?

This simple example relies on the API to reject expired tokens. On the next protected request, the API returns `401`, React clears the token, and the login form reappears. There is no automatic expiration timer or refresh-token flow.

The snippets focus on the JWT request flow. A fuller application should also disable controls while requests are pending and cancel or ignore outstanding requests on logout, so a late response cannot restore protected data after logout.

## Part 3: Classroom checks

Use disposable classroom credentials to inspect the requests in the browser's Network panel. Avoid sharing live tokens.

| Action | Expected behavior |
| --- | --- |
| Open the application. | The login form appears. |
| Submit incorrect credentials. | An error appears. |
| Log in successfully. | The books controls appear. |
| Click Load books. | The request includes `Authorization: Bearer ...`. |
| Receive `401` from the books endpoint. | The token and books are cleared; the login form appears. |
| Receive `403` from the books endpoint. | A permission error appears; the user stays logged in. |
| Reload the page. | The token is lost; the login form appears. |
| Log out after loading has finished. | The token and books are cleared. |
| Call the API without a token using another HTTP client. | The API rejects access independently of React. |

Questions to discuss:

1. Why does hiding the Load books button not protect API data?
2. Why does React not need to decode the token to use it?
3. What is the difference between authentication and authorization?
4. Why does removing a token from React not invalidate a stolen copy?
5. What changes would be needed to keep users logged in across reloads?

## Further reading

- [RFC 7519 — JSON Web Token](https://www.rfc-editor.org/rfc/rfc7519.html): token structure and claims.
- [OWASP REST Security Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/REST_Security_Cheat_Sheet.html): API-side validation and access control.
- [OWASP HTML5 Security Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/HTML5_Security_Cheat_Sheet.html): browser storage considerations.
