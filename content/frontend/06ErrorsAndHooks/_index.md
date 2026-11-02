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

### In-class exersises

1. Clone the error demo project from [GitHub](https://github.com/HartmannDemoCode/errorHandlingDemo)
2. Demo: Go through the different scenarios (the buttons) and see how the different types of errors are handled in a React application.
3. Student work: Implement error handling from status code 400 and 500 in the jwtDemo app from last week. 
  - The error should be displayed in a user-friendly way in the UI.
4. Student work: Implement error handling for the login form in the jwtDemo app from last week. 
  - The error should be displayed in a user-friendly way in the UI.
5. Implement error handling for render errors
6. Impolement error handling for global js errors (e.g. network errors, event handlers, etc.) 
7. Demo: Go through the useAuth example
8. Student work: Implement a custom hook for handling authentication in the jwtDemo app from last week. 
  - The hook should handle login, logout, and token refresh functionality.
  - The hook should also handle errors and display user-friendly error messages in the UI.
  - The hook should also enable showing the logged in user in a header component.

#### Look in the toolbox for inspiration and reference:

- [Error handling in React](/toolbox/react/error-handling)


