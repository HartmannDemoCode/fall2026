---
title: "Runnable"
description: "Runnable overview"
weight: 1
draft: false
geekdocCollapseSection: false
---

A `Runnable` in Java represents a **task that can be executed concurrently**. It is a functional interface with a single `run()` method that does not return a result. You typically use it to perform background operations such as printing logs, updating caches, or running periodic tasks.

```java
public class RunnableExample {
    public static void main(String[] args) {
        // A Runnable defined with a lambda
        Runnable task = () -> {
            System.out.println("Running in thread: " + Thread.currentThread().getName());
        };

        // Run the task in a separate thread
        Thread thread = new Thread(task);
        thread.start();

        System.out.println("Main thread: " + Thread.currentThread().getName());
    }
}
```
