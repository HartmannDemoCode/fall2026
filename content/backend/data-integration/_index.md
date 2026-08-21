---
title: 04 Data Integration
description: Overview of data integration topics
weight: 4
draft: false
geekdocCollapseSection: true
---

- [Learning objectives for the week](learning-objectives)

Topics covered in this week are:

1. Java Executor Service
2. Java Futures and Callables
3. Json
4. DTO
5. Fetching data from an API

## Monday

Online review on the Friday assignment:

- What did you solve?
- Show your code an run it in IntelliJ
- Think about what you could have done differently
- What did you learn?
- Questions for the review team

For the rest of the day: Prepare for the week. Watch the videos and read the articles.

## Tuesday (class)

### Prepare for the class

Watch this video:

- [What is a REST API? (9:11)](https://youtu.be/lsMQRaeKNDk?si=hi35_BWNJNM8e4LY)

Skim through these inhouse articles:

1. [What is an URI?](/toolbox/dataintegration/uri)
2. [What is JSON?](/toolbox/dataintegration//json)
3. [What is a DTO?](/toolbox/designpatterns/dto)
4. [JSON and DTO conversions](/toolbox/dataintegration/dto-conversion)
5. [What is a REST API?](/toolbox/dataintegration/rest-api)
6. [What is Jackson?](/toolbox/dataintegration/jackson)
7. [Fetching json from an API](/toolbox/dataintegration/httpclient)

### In-class exercises

1. [Activity Logger Exercise](exercises/activity-logger-part1)

Extras (if you want to practice more):

1. [DTO Exercise](exercises/dto-exercise)
2. [JSON Exercise](exercises/json-exercise)

## Wednesday (CodeLab)

Time to code!

- [Codelab / Movie TMDB API Exercise](exercises/codelab)

## Thursday (class)

### Prepare for the class

Watch these videos:

- [Java ExecutorService Part: 1 (20:55)](https://www.youtube.com/watch?v=Nb85yJ1fPXM)  
- [Java ExecutorService Part: 2 (21:31)](https://www.youtube.com/watch?v=MB_qCXBSgK0)

Read this tutorial:

- [Java ExecutorService tutorial](https://www.baeldung.com/java-executor-service-tutorial)

These in-house articles are great for todays class:

- [Multi threading in Java](/toolbox/java/multithreading)

### In-class exercises

- [Callables and Executor Example](exercises/executor-callables)
- [Threaded Fetches from Joke API's](exercises/thread-jokes)

### Slides

- [Java Executor Service](docs/ThreadsFuturesCallables.pdf)

## Friday (exercise day)

- For the Friday exercise, you will be working on your portfolio project. You should use the knowledge you have gained this week to fetch data from an API and integrate it into your project. You can choose any API you like, but make sure it is relevant to your project and that you can fetch data from it using Java.
- You should also use the Java Executor Service to fetch data from the API in a separate thread, so that your application remains responsive while waiting for the data to be fetched.
- Make sure to document your code and reflect on the problems you solved and the choices you made in your weekly log. This will help you prepare for the Monday review, where you will present your work and discuss it with your peers and instructor.