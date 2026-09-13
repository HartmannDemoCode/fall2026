---
title: 01 JS and React I
description: "JavaScript and React basics"
weight: 1
draft: false
geekdocCollapseSection: true
---
## Javascript and React Intro

[Learning objectives for the week](learning-objectives)

Topics covered in this week are:

1. JavaScript as a programming language
2. JavaScript in a browser
3. SPA (Single Page Application)
4. React intro

![Logos](images/logos.jpeg)

We are going to learn Javascript basics and DOM manipulation on the first day of teaching. Since you all know Java, you will see that Javascript is a bit different. But don't worry, we will guide you through the differences and similarities.

The browser can be used as the excution environment for Javascript, but you can also also exexute Javascript from the command line using Node.js. We will use both environments in this course.

In the browser, Javascript can be used to manipulate the DOM (Document Object Model) of a webpage. In this way we can create dynamic web pages and do all kind of cool stuff. Everything you probably wanted to do on the 2nd semester. Now it's time to do it!

So that's why we start with Javascript and DOM manipulation. Later in the week we will introduce React, a library for building user interfaces. React is a Javascript library, so it's important to understand Javascript first. And we will learn more and more Javascript as we go along.

## Monday

Prepare for the week. No classes or reviews today.

## Tuesday (class)

### Prepare for the class

As a Java developer, you will benefit from jumping right into the differences between Java and Javascript. So read this article for a crash start:

- [Java vs JavaScript: What's the Difference?](https://learnxinyminutes.com/docs/javascript/)

Also, you need to get familiar with Javascript documentation. Here are some links to get you started. Check it out and try to understand the basics:

- [MDN Web Docs - the official source](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
- [JavaScript.info - great overview](https://javascript.info/)

Read these parts of the **Javascript.info** topics:

- [Javascript Datatypes](https://javascript.info/types)
- [DOM](https://javascript.info/dom-nodes)
- [Debugging Javascript](https://javascript.info/debugging-chrome)

Below are some great tutorials to watch on the sideline. You don't need to watch these from start to end, but they are great to have as a reference, and to look up specific language constructs. BUT - at least **see the DOM manipulation videos**. They are the fundamental building blocks for understanding the rest of the frontend course.

- [Javascript DOM part 1 (39:00)](https://www.youtube.com/watch?v=0ik6X4DJKCc)
- [Javascript DOM part 2 (21:20)](https://www.youtube.com/watch?v=mPd2aJXCZ2g)
- [JavaScript Basics (3:26:42)](https://www.youtube.com/watch?v=PkZNo7MFNFg)

**Setting up your development environment**

1. [Install Node.js (LTS version)](https://nodejs.org/en/)
2. [Install Visual Studio Code](https://code.visualstudio.com/)
3. [Install Live Server extension in Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer)
4. [Install ESLint extension in Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)
5. [Install Prettier extension in Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)
6. More optional extensions for JavaScript and React development in Visual Studio Code:

| Extension Identifier | Purpose |
|---|---|
| bradlc.vscode-tailwindcss | Tailwind CSS IntelliSense (class name completions for HTML/JSX) |
| dbaeumer.vscode-eslint | ESLint integration for JavaScript and TypeScript linting |
| dsznajder.es7-react-js-snippets | ES7 / React code snippets and shortcuts |
| ecmel.vscode-html-css | HTML and CSS tooling (class name completion, hints) |
| esbenp.prettier-vscode | Prettier code formatter integration (JS/TS/JSON/HTML) |
| formulahendry.auto-close-tag | Automatically close HTML/XML/JSX tags while typing |
| formulahendry.auto-rename-tag | Auto rename matching HTML/XML/JSX tags |
| jonkwheeler.styled-components-snippets | Snippets for styled-components (React CSS-in-JS) |
| kamikillerto.vscode-colorize | Inline color previews for color codes in source files |
| ms-vscode.vscode-typescript-next | Preview features and improvements for TypeScript support |
| pkief.material-icon-theme | Material icon theme for clearer file-type visuals in the editor |
| ritwickdey.liveserver | Live Server to serve and auto-reload static HTML/JS during development |
| vscodevim.vim | Vim emulation (modal editing, keybindings) for the editor |
| wix.vscode-import-cost | Shows bundle-size cost of imported packages inline (JS/TS) |

### In-class exercises


**Main Exercises**

1. [Exercise 1: Getting comfortable with arrays, filter, map, and forEach](exercises/js-basics)
2. [Exercise 2: JS, DOM Manipulation and Events](exercises/js-dom-basics)

**Part III: Bonus exercises (JS training)**

1. [Exercise 1: Arrow function in JavaScript](exercises/js-arrow-function)
2. [Exercise 2: Destructuring in JavaScript](exercises/js-destructuring)
3. [Exercise 3: Spread Operator in JavaScript](exercises/js-spread-operator)
4. [Exercise 4: Rest Parameter Syntax in JavaScript](exercises/js-rest-syntax)

## Wednesday (CodeLab)

- [Exercises](exercises/codelab)

## Thursday (class)

### Prepare for the class

#### Orient yourself in this documentation:

1. [Creating your first component](https://react.dev/learn/your-first-component)
2. [Importing and Exporting Components](https://react.dev/learn/importing-and-exporting-components)

#### Look in the toolbox for inspiration and reference:

1. [Starting a new react project with Vite](/toolbox/react/vite)
2. [Spread operator in JS](/toolbox/javascript/js-spread-operator)
3. [Destructuring in JS](/toolbox/javascript/js-destructuring)
4. [Functional Components](/toolbox/react/functional-components)
5. [Props](/toolbox/react/props)
6. [UseState](/toolbox/react/usestate)
7. [UseEffect](/toolbox/react/useeffect)
8. [Fetch (GET) in JS](/toolbox/javascript/js-fetch)
9. [Fetching (GET) in React](https://react.dev/reference/react/useEffect#fetching-data-with-effects)

### In-class exercises

1. [Exercise 1: Import/export + spread, and destructuring](exercises/react-import-export)
2. [Exercise 2: Composing Components and Props](exercises/react-props)
3. [Exercise 3: Fetching from an API in React](exercises/react-fetch)

## Friday Exercise

- Start planning your frontend application for your portfolio project. Use a tool like figma or pen and paper to sketch out the UI and the components you will need. 
- Based on this [article](https://react.dev/learn/thinking-in-react) start thinking about how you will break down your UI into components, and which user interactions should be posible in your application. The interactions we will add later.
