---
title: WebSockets
description: What WebSockets are and how to use them in Javalin 7
weight: 5
draft: false
---

![Javalin Logo](../images/javalinlogo.svg)
{.fourth-right}

## What are WebSockets?

A WebSocket is a protocol for two-way communication between a client and a server over one long-lived connection.

With normal HTTP, the browser sends a request and the server sends back a response. After that, the connection is finished.

With WebSockets, the client first makes a normal HTTP request, and if the server accepts it, the connection is **upgraded** to a WebSocket connection. From that point both sides can send messages whenever they want.

That makes WebSockets useful for features where data changes live, for example:

- chat systems
- multiplayer games
- live dashboards
- notifications
- collaborative editors

## HTTP vs WebSockets

Use normal HTTP when:

- the client asks for data once in a while
- you are doing CRUD operations
- the communication follows a clear request/response pattern

Use WebSockets when:

- the server must push data to the client immediately
- many small updates happen all the time
- the client and server both need to send messages continuously

WebSockets do not replace REST APIs. In many applications you use both:

- REST for login, CRUD, and fetching initial data
- WebSockets for live updates after the page has loaded

## How WebSockets work in Javalin 7

In Javalin 7, WebSocket endpoints are registered with `config.routes.ws(...)`.

You usually define handlers for the most important events:

- `onConnect`: a client connected
- `onMessage`: the server received a text message
- `onClose`: the connection closed
- `onError`: something failed

Javalin's WebSocket context also gives access to request data from the upgrade request, such as:

- `ctx.pathParam(...)`
- `ctx.queryParam(...)`
- `ctx.header(...)`
- `ctx.sessionAttribute(...)`

This is practical if you want the client to join a room like `/ws/chat/{room}` or if you want to read a token from the upgrade request.

## Simple example in Javalin 7

This example creates a small chat-style endpoint where clients connect to a room and every message is broadcast to everyone in that room.

```java
package app;

import io.javalin.Javalin;
import io.javalin.websocket.WsContext;

import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

public class Main {

    private static final ConcurrentHashMap<String, Set<WsContext>> rooms = new ConcurrentHashMap<>();

    public static void main(String[] args) {
        Javalin app = Javalin.create(config -> {
            config.routes.wsBeforeUpgrade("/ws/chat/*", ctx -> {
                String username = ctx.queryParam("username");
                if (username == null || username.isBlank()) {
                    ctx.status(400).result("username is required");
                }
            });

            config.routes.ws("/ws/chat/{room}", ws -> {
                ws.onConnect(ctx -> {
                    String room = ctx.pathParam("room");
                    rooms.computeIfAbsent(room, ignored -> ConcurrentHashMap.newKeySet()).add(ctx);
                    broadcast(room, "Server", ctx.queryParam("username") + " joined the room");
                });

                ws.onMessage(ctx -> {
                    String room = ctx.pathParam("room");
                    String username = ctx.queryParam("username");
                    broadcast(room, username, ctx.message());
                });

                ws.onClose(ctx -> {
                    String room = ctx.pathParam("room");
                    removeClient(room, ctx);
                    broadcast(room, "Server", ctx.queryParam("username") + " left the room");
                });

                ws.onError(ctx -> {
                    System.out.println("WebSocket error: " + ctx.error());
                });
            });
        }).start(7070);
    }

    private static void broadcast(String room, String sender, String message) {
        Set<WsContext> clients = rooms.get(room);
        if (clients == null) {
            return;
        }
        String payload = sender + ": " + message;
        clients.forEach(client -> client.send(payload));
    }

    private static void removeClient(String room, WsContext ctx) {
        Set<WsContext> clients = rooms.get(room);
        if (clients == null) {
            return;
        }
        clients.remove(ctx);
        if (clients.isEmpty()) {
            rooms.remove(room);
        }
    }
}
```

## What happens in the example?

1. A browser connects to `/ws/chat/general?username=Anna`.
2. Javalin upgrades the HTTP request to a WebSocket connection.
3. `onConnect` runs and the user is added to the `general` room.
4. When the browser sends a message, `onMessage` runs.
5. The server broadcasts the message to all clients in the same room.
6. When the user disconnects, `onClose` removes the client from the room.

## Why use `ConcurrentHashMap` and concurrent sets?

WebSocket connections are handled concurrently. That means multiple users can connect and send messages at nearly the same time.

If you store connected clients in a normal `HashMap` or `HashSet`, you risk race conditions and runtime errors. `ConcurrentHashMap` and `ConcurrentHashMap.newKeySet()` are safer choices for shared WebSocket state.

## A very small browser client

The Java backend is only half of the solution. The browser also needs to open a WebSocket connection.

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>WebSocket Demo</title>
</head>
<body>
    <input id="messageInput" placeholder="Write a message">
    <button id="sendButton">Send</button>
    <ul id="messages"></ul>

    <script>
        const socket = new WebSocket("ws://localhost:7070/ws/chat/general?username=Anna");
        const messages = document.getElementById("messages");

        socket.onmessage = event => {
            const li = document.createElement("li");
            li.textContent = event.data;
            messages.appendChild(li);
        };

        document.getElementById("sendButton").addEventListener("click", () => {
            const input = document.getElementById("messageInput");
            socket.send(input.value);
            input.value = "";
        });
    </script>
</body>
</html>
```

Notice the `ws://` URL. If your site runs with HTTPS, the WebSocket URL should normally be `wss://`.

## Sending JSON instead of plain text

You are not limited to raw strings. Javalin can deserialize incoming JSON with `ctx.messageAsClass(...)`, and it can serialize Java objects with `ctx.send(...)`.

```java
public record ChatMessage(String sender, String text) {}

config.routes.ws("/ws/json-chat", ws -> {
    ws.onMessage(ctx -> {
        ChatMessage incoming = ctx.messageAsClass(ChatMessage.class);
        ChatMessage outgoing = new ChatMessage(incoming.sender(), incoming.text());
        ctx.send(outgoing);
    });
});
```

This is often a better design than sending text like `"Anna: hello"`, because JSON is easier to validate and extend.

## Protecting a WebSocket endpoint

Javalin 7 provides `config.routes.wsBeforeUpgrade(...)`.

This runs **before** the protocol is upgraded, while the request is still a normal HTTP request. That makes it a good place to:

- check login state
- validate query parameters
- reject anonymous users
- stop invalid upgrade requests early

Example:

```java
config.routes.wsBeforeUpgrade("/ws/private/*", ctx -> {
    if (ctx.sessionAttribute("current_user") == null) {
        ctx.status(401).result("Login required");
    }
});
```

## Practical advice for students

- Keep your REST endpoints. WebSockets are usually an addition, not a replacement.
- Start with one endpoint and simple text messages before moving to JSON.
- Be careful with shared state. Many users can be connected at the same time.
- Remove disconnected clients in `onClose`.
- Think about authentication before exposing private channels.
- Consider pinging long-lived connections if clients stay connected for a long time.

## Summary

WebSockets give you a persistent two-way connection between browser and server. In Javalin 7 you define WebSocket routes with `config.routes.ws(...)`, handle events such as `onConnect` and `onMessage`, and can validate the upgrade request with `config.routes.wsBeforeUpgrade(...)`.

Use them when your application needs live communication. For normal CRUD and request/response work, REST is still the simpler choice.

## References

- [Javalin documentation](https://javalin.io/documentation)
- [MDN WebSocket API](https://developer.mozilla.org/en-US/docs/Web/API/WebSocket)
