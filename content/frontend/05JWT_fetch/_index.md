---
title: 05 JWT securrity and fetch
description: "React and Async: Fetching data from an API in React for building a SPA with many components."
weight: 5
draft: false
geekdocCollapseSection: true
---

## Securty with JWT

- [Learning objectives for the week](learning-objectives)


### Prepare for the class
#### Watch the following videos:

[Video: Quick Introduction 9:00](https://www.youtube.com/watch?v=Y2H3DXDeS3Q) 

[Video: JWT Authentication Tutorial 27:00](https://www.youtube.com/watch?v=mbsmsi7l3r4)

#### Check out these toolbox article:
[JWT token authentication and authorization](../../toolbox/security/jwt)
[Using rest client to test JWT authentication](../../toolbox/rest/httpfile)

### In-class exersises

1. Open a react project and add an apiFacade.js file to the src folder.
2. Add a config file with the base URL of the API you will be using for authentication and authorization. For example, you can create a file named `config.js` with the following content:

```javascript
const config = {
  API_URL: "https://security.hartmanndemo.dk/api",
  AUTH_LOGIN: "/auth/login"
  USERPROTECTED: "auth/userprotected",
  ADMINPROTECTED: "auth/adminprotected"
};
3. Implement the following functions in the apiFacade.js file:
   - `setToken(token)`: Store the JWT token in local storage.
   - `getToken()`: Retrieve the JWT token from local storage.
   - `loggedIn()`: Check if a user is logged in by verifying if a token exists.
   - `logout()`: Remove the JWT token from local storage.
   - `login(username, password)`: Send a POST request to the login endpoint with the provided username and password, and store the received token using `setToken`.
4. Make a test.http file in the root of the project and add a POST request to this login endpoint: https://security.hartmanndemo.dk/api/auth/login with a valid username and password (admin/pass123 or user/pass123). Send the request and verify that you receive a JWT token in the response. (Note: In vs code you can use the REST Client extension to send the request and view the response.)
5. Make the Login component with the form and the login button. When the user submits the form, call the `apiFacade.login(username, password)` function and handle the response. If the login is successful, store the token and update the application state to reflect that the user is logged in. If the login fails, display an error message to the user.
6. In your React components, use the `apiFacade` functions to handle user authentication and authorization. For example, you can call `apiFacade.login(username, password)` when a user submits a login form, and use `apiFacade.loggedIn()` to conditionally render components based on the user's authentication status.
