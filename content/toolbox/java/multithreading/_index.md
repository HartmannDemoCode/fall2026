---
title: "Multithreading"
description: "Multithreading overview"
weight: 17
draft: false
geekdocCollapseSection: true
---


## Introduction to Multithreading in Java

Modern applications often need to perform many tasks at once: handling user input, processing data, communicating over the network, or updating the UI. If we did everything sequentially in a single thread, the program would quickly feel **slow and unresponsive**.

**Multithreading** allows Java programs to run multiple tasks in parallel by using separate threads of execution. Each thread runs independently, but shares the same memory space, which makes communication easier — but also introduces challenges like synchronization and thread safety.

Java provides a rich set of APIs for multithreaded programming, from low-level `Thread` objects to higher-level abstractions such as `ExecutorService`, `Future`, and `CompletableFuture`.

The five topics you will explore — [Runnable](runnable), [Callable](callable), [Executor](executor), [Future](futures), and [CompletableFuture](completeablefutures) — represent the building blocks for writing concurrent applications in Java.

---

## A Simple Example

Here’s a simple program that runs two tasks at the same time using threads:

```java
public class MultithreadingIntro {
    public static void main(String[] args) {
        // First task
        Runnable task1 = () -> {
            for (int i = 1; i <= 5; i++) {
                System.out.println("Task 1 - Count: " + i);
                try { Thread.sleep(200); } catch (InterruptedException e) {}
            }
        };

        // Second task
        Runnable task2 = () -> {
            for (int i = 1; i <= 5; i++) {
                System.out.println("Task 2 - Count: " + i);
                try { Thread.sleep(300); } catch (InterruptedException e) {}
            }
        };

        // Run tasks in separate threads
        Thread thread1 = new Thread(task1);
        Thread thread2 = new Thread(task2);

        thread1.start();
        thread2.start();

        System.out.println("Main thread is free to do other work...");
    }
}
```

### What’s happening here?

* `thread1` and `thread2` run at the same time, each printing numbers with a delay.
* The **main thread** prints its own message immediately, showing that it’s not blocked by the other work.
* This simple example demonstrates the **core idea of concurrency**: multiple tasks progress independently, improving efficiency and responsiveness.

---

👉 From this foundation, dive into the details of each abstraction:

* [Runnable](runnable) – the simplest task interface.
* [Callable](callable) – tasks that return a result.
* [Executor](executor) – a framework to manage and reuse threads.
* [Future](futures) – a handle to track asynchronous computations.
* [CompletableFuture](completablefutures) – a modern, flexible tool for composing asynchronous workflows.
