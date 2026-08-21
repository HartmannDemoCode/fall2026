---
title: "Callable"
description: "Callable overview"
weight: 2
draft: false
geekdocCollapseSection: false
---

Unlike `Runnable`, a `Callable<V>` can **return a result** and **throw checked exceptions**. It is useful when you need to compute something in a separate thread and retrieve the result later.

```java
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.FutureTask;

public class CallableExample {
    public static void main(String[] args) throws ExecutionException, InterruptedException {
        Callable<Integer> task = () -> {
            System.out.println("Calculating sum in: " + Thread.currentThread().getName());
            return java.util.stream.IntStream.rangeClosed(1, 10).sum();
        };

        FutureTask<Integer> futureTask = new FutureTask<>(task);
        new Thread(futureTask).start();

        // Blocks until result is ready
        Integer result = futureTask.get();
        System.out.println("Sum result: " + result);
    }
}
```
