---
title: "Routing"
description: "How does the React Router work"
weight: 10
draft: false
---

## Frontend routing with React Router 6 and 7

React Router enables "client side routing". React Router is currently released as version **7.9.6** (Nov 25 2025). Look at the [documentation here](https://reactrouter.com/start/declarative/installation). 

## So what is a router in a SPA

In traditional websites, the browser requests a document from a web server, downloads and evaluates CSS and TypeScript assets, and renders the HTML sent from the server. When the user clicks a link, it starts the process all over again for a new page.

Client side routing allows your app to update the URL from a link click without making another request for another document from the server. Instead, your app can immediately render some new UI and make data requests with fetch to update the page with new information.

This enables faster user experiences because the browser doesn't need to request an entirely new document or re-evaluate CSS and TypeScript assets for the next page. It also enables more dynamic user experiences with things like animation.

And having the URL update with each page makes it possible for users to share links to specific pages of your app, or to use the browser's back and forward buttons to navigate between pages.
[Source: Feature Overview](https://reactrouter.com/start/declarative/routing)

## Examples

You can typically place your router in either `main.jsx` or in the `App.jsx`. It's up to you. This is how you can do it in `main.jsx`.

## `main.jsx`

```typescriptx
import "./index.css";

import ReactDOM from "react-dom/client";
import { BrowserRouter, Routes, Route } from "react-router";
import App from "./app";
import { Home, About, AuthLayout, Login, Register, ConcertsHome, City, Trending, Categories, NotFound, ProtectedRoute, LocationDisplay } from "./components/smallComponents";

const root = document.getElementById("root");

ReactDOM.createRoot(root).render(
  <BrowserRouter>
    <Routes>
      {/* Parent route see Outlet in App component */}
      <Route path="/" element={<App />}>
      {/* Nested child routes with index route */}
        <Route index element={<Home />} />
        <Route path="about" element={<About />} />
        {/* Layout route (no shared path) for auth related pages */}
        <Route element={<AuthLayout />}>
          <Route path="login" element={<Login />} />
          <Route path="register" element={<Register />} />
        </Route>
        {/* Route prefixes (route with no element) */}
        <Route path="concerts">
          <Route index element={<ConcertsHome />} />
        {/* Dynamic route segment */}
          <Route path=":city" element={<City />} />
          {/* Static route under the "concerts" prefix */}
          <Route path="trending" element={<Trending />} />
        </Route>
        {/* Optional segments: mantains both /en/categories and /categories. Rather than having two separate routes, we use a single route with an optional parameter */}
        <Route path=":lang?/categories" element={<Categories />} />
        {/* Protected routes */}
        <Route path="secretstuff" element={
          <ProtectedRoute>
            <h1>Super Secret Stuff Only for Authenticated Users!</h1>
          </ProtectedRoute>
        } />
        {/* Default route (404) */}
        <Route path="*" element={<NotFound />} />
      </Route>
    </Routes>
  </BrowserRouter>
);

```

See the full example [here](https://github.com/HartmannDemoCode/react_router_demo_2025).

### Attaching the router to the DOM

### Nested routes

In above example, the App component will be rendered when the URL matches `/` or any of its children. The way to achieve this is by using the `Outlet` component.

App.jsx:
```typescriptx
<>
  <div>
    <Header />
  </div>
  <h1>Router example </h1>
  <div className="card">
    <Outlet />
  </div>
</>
```

### Url parameters and navigation

Here we can see how we can use the react router hooks `useParams` and `useNavigate` to get the url parameters and navigate to a new url.

- `smallComponents.js`:

```typescriptx
import { Outlet, useNavigate, useParams } from "react-router";
...
const NotFound = () => {
  const params = useParams();
  // SPLATS. params["*"] will contain the remaining URL after files/
  const filePath = params["*"];
    return (
      <>
        <h1>404 - Page Not Found for route: {filePath}</h1>
      </>
    );
}; 
const ProtectedRoute = ({ children }) => {
  // dummy authentication check
  const { user } = {user:null}; //{user: {username: "testuser"}}; //useAuth(); // however you store authentication
  const navigate = useNavigate();

  if (!user) {
    // replace the current entry in the browser’s history instead of adding a new one.
    navigate("/login", { replace: true });  
  }

  return children;
} 
```

### Links

The last thing we need to do is to add links to the urls we want to navigate to. We can do this by using the `NavLink` component.

```typescriptx
import { NavLink, Link } from "react-router";

export default function Header() {
  return (
    <nav className="header">
      {/* NavLink makes it easy to show active states */}
      <li><NavLink
          to="/"
          className={({ isActive }) => (isActive ? "active" : "")}
        > Home </NavLink> </li>
      <li> <NavLink
          to="/about"
          className={({ isActive }) => (isActive ? "active" : "")}
        > About </NavLink> </li>
      <li> <NavLink
          to="/login"
          className={({ isActive }) => (isActive ? "active" : "")}
        > Login </NavLink> </li>
      <li> <NavLink
          to="/register"
          className={({ isActive }) => (isActive ? "active" : "")}
        > Register </NavLink> </li>
      <li> <NavLink
        <NavLink
          to="/concerts"
          className={({ isActive }) => (isActive ? "active" : "")}
        > Concerts Home </NavLink> </li>
    </nav>
  );
}
```

### Styling the Header Component

We can create a `Header.css` file and import it into the `Header.js` component.

```css
/* Header.css */
.header {
    background-color: black;
    color: white;
    display: flex;
    justify-content: space-between;
    align-items: center;
    /* padding: 10px 10px; */
    width: 100%;
  }
  
  .logo {
    font-size: 1.5rem; /* Adjust the font size as needed */
  padding: 1.5em;
  }
  
  .nav-menu {
    display: flex;
  }
  
  .nav-menu a {
    text-decoration: none;
    color: white;
    margin-right: 20px; /* Adjust the spacing between menu items */
  }
  
  .nav-menu a.active {
    font-weight: bold; /* Style for the active link */
    color: red
  }
  
```
