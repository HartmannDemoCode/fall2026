---
title: CodeLab
description: Rest Intro Codelab
weight: 3
draft: false
---

# Poem API exchange

![Codelab](/images/common/codelab.png)
{.fourth-right}

This CodeLab exercise is designed to help you practice RESTful API concepts. Feel free to work together in teams and exchange your APIs with other teams to test and learn from each other.

## 0. Sign up for the CodeLab in Moodle

## 1. The assignment

You are going to build a brilliant API for exchanging poems. The API should be able to handle CRUD operations for poems.
Just to get our feet wet with REST APIs and Javalin.

![Haiku classic](../images/haiku.jpg)
{.fourth-right}

## 2. Decide on which poem style you want to share through your api?

Pick your favourite style: Haiku, Limerick, Senryu, Tanka, Sonnet, Villanelle, Acrostic, Elegy, Ode, Ghazal, Sestina,
Pantoum, Terza Rima, Triolet, Rondel, Rondeau, Villanelle, Ballad, Epic, Free verse, Lyric, Narrative, Prose, Rhymed
verse, Blank verse, Concrete, Found, Light, Visual, etc.

## 3. Get the data ready

Collect 5-10 smashing poems in your favourite style and save them in a text file for later

## 4. Set up the development environment / start code and Git

Set up your development environment and start coding. You can use the code from the previous exercises as a starting point. Commit your regularly.

## 5. Connect a database and create an Entity + DTO for the poems

1. Create a database in your docker environment with postgres called `poems`.
2. Set up the Hibernate to connect to the database.
3. Create a Poem entity. You decide which fields you want to have in the Poem entity.
4. Create a PoemDTO class. The PoemDTO class should have a constructor that takes a Poem entity as a parameter and creates a PoemDTO object from it.

## 6. Let's get started

Each team will create a RESTful API for poems. The poems should be stored in a database. Ideally, the API should be able
to handle all CRUD operations for poems. But we begin simple with the `/poem` endpoint. The API should be able to
handle the following routes representing a poem resource:

| Method | Endpoint   | Comment                                 |
|--------|------------|-----------------------------------------|
| GET    | /poem      | Returns all poems from the database     |
| GET    | /poem/{id} | Returns a specific poem based on the id |
| POST   | /poem      | Creates a new poem                      |
| PUT    | /poem/{id} | Updates an existing poem                |
| DELETE | /poem/{id} | Deletes an existing poem                |

When the first endpoint `poem` (get all poems) is ready, you will try to create a `.http` file to test the endpoint.
The http file should be able to test the endpoint and return the result in a json format.

## 7. Exchanging poems with your friends

This might not work due to network limitations - but let's find out.

The idea is to exchange your API with your friends and test each other's APIs.
First, try to do it from a http-file.

Sharing the IP address and port of your API with your friends. They can then test your API by sending http requests to your API. You can also test their API by sending http requests to their API. If it doesn't work, you can create a hotspot on your phone and connect to it with your laptop and share the IP address of your laptop with your friends. This way you can test each other's APIs on the same network.

So if the other team has IP address `10.132.12.13`, Jetty Port 7070, and they
have the endpoint `/poem`, you should be able to test their API by typing `http://10.132.12.13:7070/poem` in your
browser - or from a `.http` file. NB!

## 8. Implement all the CRUD operations

Make sure that all CRUD operations are working as expected. You should be able to create, read, update and delete poems from your own API.

## 9. Build a joint API (optional)

The idea is now to share poems with your friends and collect their poems and add them with yours in a new endpoint
called `/poem/friends`. This endpoint should return all poems from your friends' API and your API together. This will
take some fetching, DTO conversion and merging of the two APIs in a joint DTO.
