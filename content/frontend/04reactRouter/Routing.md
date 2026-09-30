---
title: Routing examples
description: "Examples of routing with React Router 7 in declarative mode"
weight: 5
draft: false
---

# Frontend routing with React Router 7

React Router enables **client-side routing**.

In traditional websites, the browser requests an HTML document from a web server, downloads CSS and JavaScript assets, and renders the page. When the user follows a link to another page, the browser requests another document.

Client-side routing allows a React Single Page Application (SPA) to update the URL and render a different component without loading another HTML document. Components can still make data requests with `fetch`, for example to a REST API.

Users can share links to individual pages and use the browser's back and forward buttons to navigate between them.

## Declarative mode

This example uses React Router 7 in **declarative mode**:

- `BrowserRouter` connects routing to the browser's address bar and history.
- `Routes` and `Route` define which components match a URL.
- `Outlet` renders the matching child route inside its parent component.
- `Link`, `NavLink`, and `useNavigate` provide navigation.
- `useParams` reads dynamic URL parameters.

The original `createBrowserRouter` and `RouterProvider` setup uses **Data Mode**, which is also available in React Router 7. Choosing declarative mode changes the setup, rather than simply changing the version number. Route loaders, actions, and router-managed error boundaries are Data/Framework Mode features; in declarative mode, components handle their own data fetching and errors.

## Installation

In an existing React project, install version 7 explicitly:

```bash
npm install react-router@7
```

All router imports below come from `react-router`. The `react-router-dom` package remains available in version 7 for compatibility with older applications, but these examples use the version 7 package directly. Once other imports have also been migrated, you can remove the old dependency:

```bash
npm uninstall react-router-dom
```

The examples assume a standard React project with a bundler such as Vite and an HTML element with `id="root"`. Files containing JSX use the `.jsx` extension.

## Examples

### Defining routes

Create `src/AppRoutes.jsx`:

```jsx
import { Route, Routes } from "react-router";
import App from "./App.jsx";
import Photos from "./Photos.jsx";
import Photo from "./Photo.jsx";
import NotFound from "./NotFound.jsx";

export default function AppRoutes() {
  return (
    <Routes>
      <Route path="/" element={<App />}>
        <Route index element={<h1>Home</h1>} />
        <Route path="photos" element={<Photos />}>
          <Route path=":id" element={<Photo />} />
        </Route>
        <Route path="articles" element={<h1>Articles</h1>} />
        <Route path="*" element={<NotFound />} />
      </Route>
    </Routes>
  );
}
```

`App` provides the layout for every route in this example. Child paths are relative to their parent: `photos` and `:id` combine to match `/photos/:id`.

| URL | Components rendered |
| --- | --- |
| `/` | `App` with the Home heading in its outlet |
| `/photos` | `App` with `Photos` in its outlet |
| `/photos/1` | `App` with `Photos`, and `Photo` in the Photos outlet |
| `/articles` | `App` with the Articles heading in its outlet |
| An unmatched URL | `App` with `NotFound` in its outlet |

An **index route** renders at its parent's URL when no child path is selected. The `*` route provides a page for unmatched URLs.

### Attaching the router to the DOM

In `src/main.jsx`, wrap the route configuration in `BrowserRouter`:

```jsx
import React from "react";
import ReactDOM from "react-dom/client";
import { BrowserRouter } from "react-router";
import AppRoutes from "./AppRoutes.jsx";

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <BrowserRouter>
      <AppRoutes />
    </BrowserRouter>
  </React.StrictMode>
);
```

Use one `BrowserRouter` around the application. Components that use router hooks or navigation links must be rendered inside it.

### Nested routes

In `src/App.jsx`, use `Outlet` to display the matching child route:

```jsx
import { Outlet } from "react-router";
import Header from "./Header.jsx";

export default function App() {
  return (
    <>
      <Header />
      <h1>Router example</h1>
      <main className="card">
        <Outlet />
      </main>
    </>
  );
}
```

The header remains visible when navigating between pages. At `/photos/1`, the `App` outlet renders `Photos`, and the `Photos` outlet renders `Photo`.

### URL parameters and navigation

In `src/Photos.jsx`, display links to the individual photos and an outlet for the selected photo:

```jsx
import { Link, Outlet } from "react-router";
import photoFacade from "./photoFacade.js";

export default function Photos() {
  return (
    <>
      <h2>Photos</h2>
      <div>
        {photoFacade.getAll().map((photo) => (
          <Link key={photo.id} to={`/photos/${photo.id}`}>
            <img
              src={photo.url}
              alt={photo.name}
              style={{ width: 300, margin: 6 }}
            />
          </Link>
        ))}
      </div>
      <Outlet />
    </>
  );
}
```

`Link` navigates without reloading the document and supports normal browser link behavior, such as opening a link in a new tab.

In `src/Photo.jsx`, read the `:id` parameter with `useParams`:

```jsx
import { useParams } from "react-router";
import photoFacade from "./photoFacade.js";

export default function Photo() {
  const { id } = useParams();
  const photoId = Number(id);
  const photo = Number.isInteger(photoId)
    ? photoFacade.getPhoto(photoId)
    : undefined;

  if (!photo) {
    return <p>Photo not found.</p>;
  }

  return (
    <section>
      <h3>{photo.name}</h3>
      <img src={photo.url} alt={photo.name} style={{ maxWidth: "100%" }} />
    </section>
  );
}
```

At `/photos/1`, `useParams()` returns an `id` of `"1"`. URL parameters are strings, so convert the value before comparing it with the numeric IDs in the facade.

The lookup is synchronous, so this example derives the photo directly from `id`. It does not need state or an effect. If you later fetch a photo from an API inside `useEffect`, include `id` in the dependency array so that navigation to a different photo triggers a new request.

`/photos/999` matches the `:id` route even if photo 999 does not exist. The `Photo` component handles that case; the wildcard route only handles URLs that do not match a route.

### Programmatic navigation with useNavigate

Use `Link` or `NavLink` for normal navigation. Use `useNavigate` when navigation should happen as part of application logic, such as after a successful save:

```jsx
import { useNavigate } from "react-router";

export default function SavePhotoButton({ savePhoto }) {
  const navigate = useNavigate();

  async function handleSave() {
    try {
      await savePhoto();
      navigate("/photos");
    } catch {
      window.alert("Could not save the photo. Please try again.");
    }
  }

  return <button onClick={handleSave}>Save photo</button>;
}
```

This is an additional example: a parent component supplies the `savePhoto` function, and the button must be rendered inside `BrowserRouter`. It is not needed for the read-only photo gallery above.

`navigate("/photos")` updates the route without reloading the document. It is **not equivalent** to assigning `window.location.href`, which causes a document navigation.

### Getting the data

Keep the photo data in `src/photoFacade.js`:

```js
const photos = [
  {
    id: 1,
    name: "small goats",
    url: "https://www.worldvision.org/wp-content/uploads/2020/09/D485-1090-047_Web_Optimized.jpg",
  },
  {
    id: 2,
    name: "child with goat",
    url: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b2/Hausziege_04.jpg/1920px-Hausziege_04.jpg",
  },
  {
    id: 3,
    name: "mountain goat",
    url: "https://upload.wikimedia.org/wikipedia/commons/3/31/Goats_butting_heads_in_Germany.jpg",
  },
];

export default {
  getPhoto: (id) => photos.find((photo) => photo.id === id),
  getAll: () => photos,
};
```

These methods return local data immediately. Data fetching from your backend can be added separately inside components or a custom hook.

### Links

Use `NavLink` for navigation items that need an active style.

Create `src/Header.jsx`:

```jsx
import { NavLink } from "react-router";
import "./Header.css";

export default function Header() {
  const linkClass = ({ isActive }) => (isActive ? "active" : "");

  return (
    <header className="header">
      <div className="logo">Your Logo</div>
      <nav className="nav-menu">
        <NavLink to="/" end className={linkClass}>
          Home
        </NavLink>
        <NavLink to="/photos" className={linkClass}>
          Photos
        </NavLink>
        <NavLink to="/articles" className={linkClass}>
          Articles
        </NavLink>
      </nav>
    </header>
  );
}
```

Use `end` for an exact end-of-path match, rather than the old `exact` prop. For example, adding `end` to the Photos link would make it active at `/photos` only. Without `end`, it also stays active at `/photos/1`. The root link (`to="/"`) is a special case: it only matches the root URL, even without `end`.

### Styling the Header component

Create `src/Header.css`:

```css
.header {
  background-color: black;
  color: white;
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
}

.logo {
  font-size: 1.5rem;
  padding: 1.5em;
}

.nav-menu {
  display: flex;
}

.nav-menu a {
  text-decoration: none;
  color: white;
  margin-right: 20px;
}

.nav-menu a.active {
  font-weight: bold;
  color: red;
}
```

### Unmatched routes

Create `src/NotFound.jsx` for the wildcard route:

```jsx
import { Link } from "react-router";

export default function NotFound() {
  return (
    <section>
      <h2>Page not found</h2>
      <Link to="/">Go to the home page</Link>
    </section>
  );
}
```

This replaces the unmatched-page role of the original `errorElement`. A wildcard route does not catch JavaScript rendering errors. Use a React error boundary if you need to handle those in declarative mode.

### Opening or refreshing a nested URL

Following a `Link` is client-side navigation, but opening `/photos/1` directly or refreshing it sends a document request to the server. Configure the frontend host to serve the SPA's `index.html` for frontend routes. Keep backend API endpoints and static assets outside this fallback.

## References

These links use the version 7 documentation:

- [Installation — Declarative Mode](https://reactrouter.com/7.18.4/start/declarative/installation)
- [Routing — Declarative Mode](https://reactrouter.com/7.18.4/start/declarative/routing)
- [Navigating — Declarative Mode](https://reactrouter.com/7.9.4/start/declarative/navigating)
- [NavLink API](https://reactrouter.com/7.18.4/api/components/NavLink)
- [react-router-dom compatibility package](https://api.reactrouter.com/v7/modules/react-router-dom.html)
