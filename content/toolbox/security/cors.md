---
title: "CORS headers"
description: "Adding Cors headers to your API"
weight: 2
draft: false
---
# CORS headers

Cross-Origin Resource Sharing (CORS). These are great ressources:

- [CORS on Mozilla.org](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS)
- [CORS Explained In Under 4 minutes](https://www.youtube.com/watch?v=BibYiuLjpFM)

## Preparing your Javalin API for CORS

The Cross-Origin Resource Sharing (CORS)standard works by adding new HTTP headers that let servers describe which origins are permitted to read that information from a web browser. To make our lives easier on 3rd semester, we allow generiously access to our API's. Keep in mind, that CORS only is of consideration for browser based clients. Any other server can request our apis, any time. So CORS headers are only a means to make life more secure for people using a typescript frontend aplication that utilizes our endpoints made in Javalin.

## Setting up CORS headers

In your Javalin project, add these two methods to your `Application.config` in Javalin.create(config -> { ... }):

```java
config.bundledPlugins.enableCors(cors ->
        cors.addRule(rule -> {
            rule.anyHost();
        })
    );
config.bundledPlugins.enableHttpAllowedMethodsOnRoutes();
```

To test the cors response headers with rest assured, you can do something like this:

```java
given()
    .header("Origin", http://localhost:3000) // there must be a value here to trigger CORS handling
    .when()
    .get("/your-endpoint")
    .then()
    .log().all()
    .header("Access-Control-Allow-Origin", anyOf(equalTo("*"), equalTo(origin)))
    .statusCode(200);
```

That's it. Now your API should be CORS hassle free.

Make sure you understand how it works.
