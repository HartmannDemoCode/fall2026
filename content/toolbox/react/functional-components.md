---
title: "Functional Components"
description: "Functional components in React"
weight: 13
draft: false
---

![Codelab](../images/reactlogo.png)
{.half-right}

In React, a **functional component** is a type of component defined as a JavaScript function. It accepts props as an argument and returns JSX, which describes what should be rendered to the DOM. Functional components are simpler, more concise, and have become the standard way to write components in React, especially with the introduction of **React Hooks**, which allow functional components to manage state and lifecycle methods.

## Defining a Functional Component

A functional component is a plain JavaScript function that returns JSX, without the need to extend from `React.Component`. 

### Example

```react
import React from 'react';

function Greeting(props) {
  return <h1>Hello, {props.name}!</h1>;
}

export default Greeting;
```

Or, using an arrow function:

```react
import React from 'react';

const Greeting = (props) => {
  return <h1>Hello, {props.name}!</h1>;
};

export default Greeting;
```

In this example:

- `Greeting` is a functional component that receives `props` as an argument.
- It returns JSX (`<h1>Hello, {props.name}!</h1>`), which will display a greeting based on the `name` prop.
