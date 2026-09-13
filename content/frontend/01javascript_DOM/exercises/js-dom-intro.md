---
title: JavaScript DOM Intro (Cars)
description: Exercises for Frontend Week I
weight: 3
draft: false
---

# Exercise: DOM Intro with Cars List and Form

**Make this exercise in Visual Studio Code and run it in the browser. Use vanilla JavaScript only (no frameworks).**

In this exercise, you will build a small UI in two steps:

1. Show a list of cars on the page.
2. Add a form so users can add new cars to the list.

## Learning goals

- Practice selecting DOM elements and updating content.
- Practice rendering arrays to HTML with `map` and `join`.
- Practice handling form submission with `addEventListener`.
- Practice preventing full-page reload with `event.preventDefault()`.

## 1. Starter data

Create a file structure like this:

- `index.html`
- `styles.css`
- `app.js`

Use this starter data in `app.js`:

```javascript
const cars = [
  { id: 1, make: "Ford", model: "Focus", year: 2018 },
  { id: 2, make: "Toyota", model: "Corolla", year: 2020 },
  { id: 3, make: "Volkswagen", model: "Golf", year: 2019 }
];
```

## 2. Build the HTML structure

Create this basic HTML in `index.html`:

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Cars DOM Intro</title>
    <link rel="stylesheet" href="styles.css" />
  </head>
  <body>
    <h1>Cars</h1>

    <ul id="car-list"></ul>

    <h2>Add a new car</h2>
    <form id="car-form">
      <label>
        Make
        <input id="make" name="make" type="text" required />
      </label>

      <label>
        Model
        <input id="model" name="model" type="text" required />
      </label>

      <label>
        Year
        <input id="year" name="year" type="number" min="1886" required />
      </label>

      <button type="submit">Add car</button>
    </form>

    <script src="app.js"></script>
  </body>
</html>
```

## 3. Exercise A: Render the initial list of cars

In `app.js`, implement a function called `renderCars()` that:

1. Selects the list element with id `car-list`.
2. Uses `map` to convert each car object into a `<li>` string.
3. Uses `join("")` to combine the array of strings.
4. Sets `innerHTML` on the list element.

Use this starter:

```javascript
const cars = [
  { id: 1, make: "Ford", model: "Focus", year: 2018 },
  { id: 2, make: "Toyota", model: "Corolla", year: 2020 },
  { id: 3, make: "Volkswagen", model: "Golf", year: 2019 }
];

function renderCars() {
  // TODO: Select #car-list
  // TODO: Map cars to <li>...</li>
  // TODO: Insert with innerHTML
}

renderCars();
```

## 4. Exercise B: Add a new car with a form

Still in `app.js`, add an event listener to the form with id `car-form`.

When the form is submitted:

1. Call `event.preventDefault()`.
2. Read values from `#make`, `#model`, and `#year`.
3. Create a new car object with a unique `id`.
4. Add the object to the `cars` array.
5. Call `renderCars()` again.
6. Reset the form.

Use this starter:

```javascript
const form = document.getElementById("car-form");

form.addEventListener("submit", function (event) {
  event.preventDefault();

  // TODO: Read input values
  // TODO: Build new car object
  // TODO: Push to cars array
  // TODO: Re-render list
  // TODO: Reset form
});
```

## 5. Optional styling

Add simple styles in `styles.css` to make it easier to read:

```css
body {
  font-family: sans-serif;
  max-width: 640px;
  margin: 2rem auto;
  padding: 0 1rem;
}

ul {
  padding-left: 1.2rem;
}

form {
  display: grid;
  gap: 0.75rem;
}

label {
  display: grid;
  gap: 0.25rem;
}

button {
  width: fit-content;
}
```

## 6. Stretch goals

1. Validate that `year` is a number before adding.
2. Add a delete button next to each car.
3. Sort the list by year (newest first).
