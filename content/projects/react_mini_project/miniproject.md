# React mini project: Book manager

**Duration:** Two weeks, weeks 41 and 43  
**Routing:** React Router 7, declarative mode

## Assignment

Build a React single-page application for managing a personal book collection. Users must be able to add, view, edit, delete, and mark books as read or unread. Organise the application into pages using React Router, nested routes, and shared state through outlet context.

The navigation bar belongs in `App` and must remain visible on every page. Route changes replace the content below the navigation bar.

Use React state for the book collection, props for reusable components, and hooks for state, routing, and persistence. A backend is not required.

## Learning objectives

By completing the project, you should be able to:

- Define static, dynamic, index, and nested routes.
- Build shared layouts using `Outlet`.
- Navigate using `Link`, `NavLink`, and `useNavigate`.
- Read route parameters with `useParams`.
- Share state and update functions through `Outlet context` and `useOutletContext`.
- Update state immutably and reuse a form through props.
- Persist state using `localStorage` and `useEffect`.

## Required pages

| URL | Component | Purpose |
| --- | --- | --- |
| `/` | Redirect | Redirect to `/books`. |
| `/books` | `BooksPage` | Display all books. |
| `/books/create` | `CreateBookPage` | Create a book. |
| `/books/:id` | `BookDetailsPage` | Display one book and its read status. |
| `/books/:id/edit` | `EditBookPage` | Edit the selected book. |
| Any unmatched URL | `NotFoundPage` | Show a page-not-found message. |

Use `/books/:id/edit` rather than `/books/edit`: the ID identifies which book to edit. For example, `/books/b1/edit` edits the book whose ID is `b1`.

## Step 1: Create the project and book model

Create a React project with Vite, or extend your existing project. Examples below use JavaScript; TypeScript is also acceptable.

Install React Router 7:

```bash
npm install react-router@7
```

Import routing components and hooks from `react-router`.

Represent each book with these fields:

```js
{
  id: "b1",
  title: "The Hobbit",
  author: "J. R. R. Tolkien",
  isRead: false
}
```

Use string IDs throughout the application. Generate a unique ID when creating a book, for example with `crypto.randomUUID()`. Keep the same ID when editing. Do not use array indexes as IDs or React keys.

Start with two or three sample books.

## Step 2: Define the nested routes

Create placeholder page components first so you can verify routing before implementing the book features.

Use this route structure in `main.jsx`. Add imports for your own components and retain your project's CSS import.

```jsx
import { createRoot } from "react-dom/client";
import { BrowserRouter, Navigate, Route, Routes } from "react-router";
// Import App, BooksLayout, and all page components here.

createRoot(document.getElementById("root")).render(
  <BrowserRouter>
    <Routes>
      <Route path="/" element={<App />}>
        <Route index element={<Navigate to="/books" replace />} />

        <Route path="books" element={<BooksLayout />}>
          <Route index element={<BooksPage />} />
          <Route path="create" element={<CreateBookPage />} />
          <Route path=":id" element={<BookDetailsPage />} />
          <Route path=":id/edit" element={<EditBookPage />} />
        </Route>

        <Route path="*" element={<NotFoundPage />} />
      </Route>
    </Routes>
  </BrowserRouter>
);
```

Child paths are relative to their parent. The index route under `books` renders at `/books`; it does not add a URL segment.

**Checkpoint:** Every required URL displays its placeholder page, and `/` redirects to `/books`.

## Step 3: Add the permanent navigation bar in App

Make `App` the shared layout and the owner of the book collection. Render a navigation bar above its outlet.

Your `App` should have this structure:

```jsx
import { NavLink, Outlet } from "react-router";

export default function App() {
  // Create books state here.
  // Implement addBook, updateBook, deleteBook, and toggleRead here.

  return (
    <>
      <header>
        <nav aria-label="Main navigation">
          <NavLink to="/books" end>Books</NavLink>
          <NavLink to="/books/create">Add book</NavLink>
        </nav>
      </header>

      <main>
        <Outlet
          context={{ books, addBook, updateBook, deleteBook, toggleRead }}
        />
      </main>
    </>
  );
}
```

This is scaffolding: implement the state and functions before using it.

Style the active navigation link. The `end` prop makes the Books link active only at `/books`.

Use `Link` or `NavLink` for internal page navigation. Use buttons for actions such as deleting a book or toggling its read status.

**Checkpoint:** The navigation bar remains visible on the list, detail, create, edit, and not-found pages. Navigating between pages preserves the book collection.

## Step 4: Pass state through the nested layout

Create a `BooksLayout` that adds a shared heading and renders the selected book page:

```jsx
import { Outlet, useOutletContext } from "react-router";

export default function BooksLayout() {
  const bookContext = useOutletContext();

  return (
    <section>
      <h1>My book collection</h1>
      <Outlet context={bookContext} />
    </section>
  );
}
```

`BooksLayout` receives the context from App's outlet and forwards it through its own outlet. Keep this forwarding: the book pages read the context provided by their nearest parent outlet.

In a page component, access only the values you need:

```jsx
const { books, deleteBook, toggleRead } = useOutletContext();
```

Implement these functions in `App`:

| Function | Required behaviour |
| --- | --- |
| `addBook({ title, author })` | Add a book with a unique ID and `isRead: false`; return its ID. |
| `updateBook(id, { title, author })` | Update title and author while preserving ID and read status. |
| `deleteBook(id)` | Remove the book with this ID. |
| `toggleRead(id)` | Toggle the selected book's `isRead` value. |

Use functional state updates when deriving the next state from the previous state. Use `map`, `filter`, and object/array spreading instead of mutating the existing collection.

Use outlet context in routed page components. Pass ordinary props to reusable components such as `BookList`, `BookItem`, and `BookForm`.

**Checkpoint:** Explain the data flow from `App` through `BooksLayout` to a page, and from the page to a reusable component.

## Step 5: Implement the book list at /books

In `BooksPage`:

1. Read the books and relevant update functions through `useOutletContext`.
2. Render a separate `BookList` component and pass data and callbacks as props.
3. Display each book's title, author, and read/unread status.
4. Link each title to `/books/:id`.
5. Add an Edit link to `/books/:id/edit`.
6. Add buttons to delete a book and toggle its read status.
7. Show a useful empty-state message when there are no books.

Example links inside a `BookItem`:

```jsx
<Link to={`/books/${book.id}`}>{book.title}</Link>
<Link to={`/books/${book.id}/edit`}>Edit</Link>
```

**Checkpoint:** Deleting or toggling a book updates the list immediately.

## Step 6: Implement book details at /books/:id

In `BookDetailsPage`:

1. Read `id` using `useParams`.
2. Read the collection using `useOutletContext`.
3. Find the matching book.
4. Display its title, author, and read status.
5. Provide an Edit link, a read/unread button, and a Back to books link.

Start with:

```jsx
const { id } = useParams();
const { books } = useOutletContext();
const book = books.find((book) => book.id === id);
```

If the book does not exist, render a “Book not found” message and a link to `/books`. Do not access its properties before checking that it exists.

An unknown book ID is different from an unmatched route: `/books/missing-id` matches the details route, but its book may not exist.

**Checkpoint:** A valid ID displays the correct book; an unknown ID shows a helpful message without crashing.

## Step 7: Implement creation at /books/create

Create a reusable `BookForm` with controlled inputs for title and author. Its props should include initial values, a submit callback, and a cancel callback.

In `CreateBookPage`:

1. Read `addBook` from outlet context.
2. Render `BookForm` with empty initial values.
3. Reject empty or whitespace-only title/author values and show feedback.
4. Prevent the browser's default form submission.
5. On successful submission, add the book and navigate to its detail page.
6. On Cancel, navigate to `/books` without creating a book.

Use `useNavigate` after a successful action:

```jsx
const navigate = useNavigate();

function handleCreate(values) {
  const id = addBook(values);
  navigate(`/books/${id}`);
}
```

**Checkpoint:** Creating a book opens its details, and it appears in the list.

## Step 8: Implement editing at /books/:id/edit

In `EditBookPage`:

1. Read the ID from the URL.
2. Find the book through outlet context.
3. Handle a missing book before rendering the form.
4. Reuse `BookForm`, prefilled with the existing title and author.
5. On Save, call `updateBook` and navigate to `/books/:id`.
6. On Cancel, return to the details page without changing the collection.

Keep unsaved input values inside `BookForm`. Do not update the shared collection on every keystroke.

If the form initialises local state from its initial values, make sure that editing a different book loads that book's values. One option is to render the form with `key={book.id}`.

**Checkpoint:** Save changes the book's title and author while retaining its ID and read status. Cancel leaves the book unchanged.

## Step 9: Add persistence and handle errors

Persist the collection in `localStorage`:

1. Initialise App's state from stored books using a lazy state initialiser.
2. Use sample books when no stored collection exists.
3. Preserve a saved empty array: deleting all books must not restore the samples after refresh.
4. Use `useEffect` to save the collection whenever it changes.
5. Handle invalid stored JSON without crashing.

Do not use an effect to find a book by ID; calculate that from the current collection during rendering.

Implement `NotFoundPage` with a link back to `/books`.

**Checkpoint:** Create a book, refresh its detail URL, and verify that the book still exists. Delete every book and refresh to verify that the collection stays empty.

## Suggested milestones

| Week | Deliverable |
| --- | --- |
| 41 | Nested route setup, permanent navigation, outlet context, list and detail pages, delete and read/unread actions. |
| 43 | Reusable create/edit form, validation, persistence, error handling, styling, verification, and README. |

## Acceptance checklist

- [ ] All required routes work.
- [ ] App's navigation remains visible on every page.
- [ ] App and BooksLayout both render an outlet.
- [ ] BooksLayout forwards outlet context to its child pages.
- [ ] The collection has one source of truth in App.
- [ ] Routed pages use `useOutletContext`; reusable components use props.
- [ ] Users can add, view, edit, delete, and toggle books.
- [ ] Creating and saving an edit navigate to the correct details page.
- [ ] Cancel does not change the collection.
- [ ] Unknown URLs and missing books show helpful messages.
- [ ] Books survive refresh, including an empty collection.
- [ ] Browser Back and Forward work as expected.
- [ ] Inputs have labels, validation feedback is visible, and the layout works on mobile and desktop.


## Optional extensions

- Search by title or author and filter by read status.
- Store search/filter settings in URL query parameters using `useSearchParams`.
- Add meaningful interaction tests for creation, editing, and missing books.
- Add a backend API and loading/error feedback.

## Documentation

- [React Router 7: Declarative routing](https://reactrouter.com/7.9.6/start/declarative/routing)
- [React Router 7: useOutletContext](https://reactrouter.com/7.9.6/api/hooks/useOutletContext)

If you deploy the application, configure the host to serve the SPA entry page for client routes so directly opening or refreshing `/books/:id` works.
