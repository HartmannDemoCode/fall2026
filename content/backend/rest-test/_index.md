---
title: 06 Rest & Test
description: Introduction to testing REST APIs in Java
weight: 6
draft: false
geekdocCollapseSection: true
---

- [Learning objectives](learning-objectives)

## Monday

- Reviewing portfolio projects. Today we would like to see your documentation of your API endpoints and far you have come with your implementation.

## Tuesday

### Prepare for class

- [Rest-assured.io (5 min)](http://rest-assured.io/)
- [Short Rest Assured Tutorial, read 1-7 (5 min)](https://www.baeldung.com/rest-assured-tutorial)
- [Hamcrest guide (skim and use for reference 10 min)](https://www.baeldung.com/java-junit-hamcrest-guide)

#### Toolbox

- [Rest-assured overview](/toolbox/test/rest-assured)
- [The Gherkin Syntax](/toolbox/test/gherkin)
- [General Theory about testing](/toolbox/test/testteori)

### Exercises in in class

- [Gherkin Syntax](exercises/gherkin)
- [Hamcrest Matchers](exercises/hamcrest)
- [Testing Dog API](exercises/dog-test)

## Wednesday (CodeLab)

- [Codelab](exercises/codelab)

## Thursday (class) - Websockets & Webhooks

### Prepare for class

Watch these videos to get an introduction to Websockets and Webhooks:

- [Websockets explained (7:14)](https://www.youtube.com/watch?v=dd8cCt9wMh8)
- [Webhooks for beginners (7:32)](https://www.youtube.com/watch?v=bXY7899m6M8)
- [Top 3 things you should know about Webhooks (3:54)](https://www.youtube.com/watch?v=x_jjhcDrISk)

Skim through the following documentation to get an overview of how to implement Websockets in Javalin:

- [Websockets in Javalin](https://javalin.io/documentation#websockets)

### Exercises in class

- [Have a look at these wonderful protocols](protocols)
- [Dice Websocket demo](https://github.com/jonbertelsen/websockets)
  - Clone the repo and run the Websocket server in IntelliJ.
  - Connect two browser windows to `http://localhost:7070` and test the dice game by clicking the "Roll Dice" button. You should see the dice rolls in both windows.
  - Choose one server machine in the class rooom and let the rest of the class connect to that machine's IP address and port.
  - Figure out why it works ;-)
  - Refactor the code to have a better separation of concerns. For example, you could create a separate class for handling the game logic and another class for handling the Websocket communication etc, separate the css to a separate file etc.
  - Begin adding functionality. Like who rolled the dice. Saving the game history to a database, adding a chat functionality etc.

## Friday (exercise day)

- This one is for you to work on your portfolio project. Begin by writing tests for your API endpoints and then implement the endpoints if you haven't already.
