# Testing an API with REST Client in VS Code

REST Client lets you send HTTP requests and inspect responses inside VS Code. Save your requests in a `.http` file so you can repeat them while developing your API and React application.

## 1. Install the extension

1. Open VS Code and select **Extensions** in the sidebar.
2. Search for **REST Client** by **Huachao Mao**. The extension identifier is `humao.rest-client`.
3. Click **Install**.
4. Open your project folder.

[REST Client extension](https://marketplace.visualstudio.com/items?itemName=humao.rest-client)

## 2. Create your first `.http` file

Create `requests.http` in your project. Paste this request, adjusting the address to match your running API:

```http
GET http://localhost:7070/api/books
Accept: application/json
```

Start the API, then click **Send Request** above the request. Inspect the status, headers, and response body in the response panel.

You can also place the cursor inside the request and use:

| Platform | Send request |
| --- | --- |
| Windows / Linux | `Ctrl+Alt+R` |
| macOS | `Cmd+Alt+R` |

A protected books endpoint may return `401` here because no token was supplied.

## 3. Understand the request structure

```http
POST https://security.hartmanndemo.dk/api/auth/login
Content-Type: application/json
Accept: application/json

{
  "username": "alice",
  "password": "classroom-password"
}
```

- The first line contains the HTTP method and URL.
- Headers follow, one per line.
- A **blank line** separates the headers from the body.
- The body contains the data you send, here as JSON.

`Content-Type` describes the request body. `Accept` describes the response format you would like. A GET request usually has no body.

## 4. Add variables and multiple requests

Define file variables with `@name = value` and reference them with `{{name}}`. Separate requests using `###`:

```http
@baseUrl = http://localhost:7070/api

### Get all books
GET {{baseUrl}}/books
Accept: application/json

### Get one book
GET {{baseUrl}}/books/1
Accept: application/json
```

Each request has its own **Send Request** link. Sending one does not automatically execute the others.

## 5. Log in and reuse a JWT

Copy this complete example into `requests.http`. It assumes the same API contract as the React examples: login returns JSON containing `accessToken`, and protected requests use a bearer token.

```http
@baseUrl = http://localhost:7070/api

### 1. Log in first
# @name login
POST {{baseUrl}}/auth/login
Content-Type: application/json
Accept: application/json

{
  "username": "alice",
  "password": "classroom-password"
}

### 2. Read books using the token from the login response
GET {{baseUrl}}/books
Accept: application/json
Authorization: Bearer {{login.response.body.$.accessToken}}

### 3. Try the same endpoint without a token
GET {{baseUrl}}/books
Accept: application/json
```

Change the port, paths, and example credentials to match your classroom API.

1. Send the **login** request and check that it succeeds.
2. Confirm the response contains `accessToken`.
3. Send the second request to read books.
4. Send the third request to compare the result without authorization.

The response reference works as follows:

| Part | Meaning |
| --- | --- |
| `# @name login` | Gives the first request a name. |
| `login.response.body` | Refers to that request's latest response body. |
| `$.accessToken` | Selects the `accessToken` property from the JSON. |
| `Bearer` | Authentication scheme followed by a space and the token. |

For example, this response matches the reference above:

```json
{ "accessToken": "eyJ..." }
```

If your API returns `token` instead, use `{{login.response.body.$.token}}`. Run login manually before the dependent request. Run it again when the token expires; REST Client does not renew this JWT automatically.

## 6. Send JSON to a protected endpoint

If your API supports creating books, append this request. It will create data when sent:

```http
### Create a book
POST {{baseUrl}}/books
Content-Type: application/json
Accept: application/json
Authorization: Bearer {{login.response.body.$.accessToken}}

{
  "title": "Effective Java",
  "author": "Joshua Bloch"
}
```

The API determines the required fields and permissions. A successful creation commonly returns `201 Created`.

## 7. Read the result and troubleshoot

| Result | What to check |
| --- | --- |
| `200 OK` | Inspect the returned data. |
| `201 Created` | Check the newly created resource. |
| `400 Bad Request` | Check the JSON syntax and required fields. |
| `401 Unauthorized` | Log in again; check the token field and bearer header. |
| `403 Forbidden` | Check whether the account has the required permission. |
| `404 Not Found` | Check the URL, API prefix, and resource ID. |
| `415 Unsupported Media Type` | Check `Content-Type: application/json`. |
| Connection refused | Start the API and check its host and port. |

If **Send Request** is missing, check that the file ends in `.http`, the extension is enabled, and the editor language mode is **HTTP**.

If a response variable is unresolved, send login first and check its actual JSON response. REST Client can otherwise send the unresolved reference literally.

## 8. Connect this to React

REST Client sends the same method, URL, headers, and JSON body that your React `fetch` call sends. It helps you check the API independently of the interface.

REST Client is outside the browser's CORS enforcement. A successful request here does not prove that the API's CORS configuration permits requests from React.

Use disposable classroom credentials in shared examples. Keep real passwords and tokens out of version control and screenshots. Sending login here does not log your React application in; each client has its own state.

## Documentation

- [REST Client documentation](https://github.com/Huachao/vscode-restclient#readme): request syntax, file variables, and named response references.
- [VS Code extension installation](https://code.visualstudio.com/docs/configure/extensions/extension-marketplace).
