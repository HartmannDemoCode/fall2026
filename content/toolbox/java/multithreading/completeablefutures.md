---
title: "CompletableFuture"
description: "CompletableFuture overview"
weight: 5
draft: false
geekdocCollapseSection: false
---

A `CompletableFuture` is a modern replacement for `Future` that supports **non-blocking, asynchronous programming**. It can be completed manually or asynchronously, and you can attach callbacks (`thenApply`, `thenAccept`, etc.), chain tasks, or combine multiple futures.

---

## Basic Example

```java
import java.util.concurrent.CompletableFuture;

public class CompletableFutureExample {
    public static void main(String[] args) {
        CompletableFuture.supplyAsync(() -> {
            System.out.println("Fetching data...");
            return "Hello";
        }).thenApply(data -> data + " World") // transform result
          .thenAccept(result -> System.out.println("Result: " + result)); // consume result

        // Prevent exit before async finishes
        try { Thread.sleep(500); } catch (InterruptedException ignored) {}
    }
}
```

---

## Key Methods

* `supplyAsync(Supplier)` → run async and return result.
* `runAsync(Runnable)` → run async with no result.
* `thenApply(fn)` → transform result.
* `thenAccept(consumer)` → consume result (no return).
* `thenCombine(future, fn)` → combine results of two futures.
* `allOf(...)`, `anyOf(...)` → wait for multiple futures.
* `exceptionally(fn)` → recover from error.

---

## Pros

* **Non-blocking**: allows callback-based async workflows.
* **Composable**: chain transformations or combine multiple futures.
* **Error handling**: declarative exception recovery.
* Can still block if needed (`get()` or `join()`).

## Cons

* More complex API; steeper learning curve.
* Debugging async chains can be tricky.
* Risk of thread explosion if used with blocking I/O (best with non-blocking tasks).

---

## Chaining Example

```java
import java.util.concurrent.CompletableFuture;

public class CompletableFutureChain {
    public static void main(String[] args) {
        CompletableFuture.supplyAsync(() -> "42")
                .thenApply(Integer::parseInt)
                .thenApply(n -> n * 2)
                .thenAccept(result -> System.out.println("Result: " + result));

        try { Thread.sleep(500); } catch (InterruptedException ignored) {}
    }
}
```

---

## Combining Multiple Futures

```java
import java.util.concurrent.CompletableFuture;

public class CompletableFutureCombine {
    public static void main(String[] args) {
        CompletableFuture<Integer> future1 = CompletableFuture.supplyAsync(() -> 10);
        CompletableFuture<Integer> future2 = CompletableFuture.supplyAsync(() -> 20);

        future1.thenCombine(future2, (a, b) -> a + b)
               .thenAccept(sum -> System.out.println("Sum = " + sum));

        try { Thread.sleep(500); } catch (InterruptedException ignored) {}
    }
}
```

---

## Waiting for Multiple Futures

```java
import java.util.concurrent.CompletableFuture;

public class CompletableFutureAllOf {
    public static void main(String[] args) {
        CompletableFuture<String> f1 = CompletableFuture.supplyAsync(() -> "A");
        CompletableFuture<String> f2 = CompletableFuture.supplyAsync(() -> "B");
        CompletableFuture<String> f3 = CompletableFuture.supplyAsync(() -> "C");

        CompletableFuture.allOf(f1, f2, f3)
                .thenRun(() -> System.out.println("All done!"));

        try { Thread.sleep(500); } catch (InterruptedException ignored) {}
    }
}
```

---

## Exception Handling

```java
import java.util.concurrent.CompletableFuture;

public class CompletableFutureError {
    public static void main(String[] args) {
        CompletableFuture.supplyAsync(() -> {
            if (true) throw new RuntimeException("Oops!");
            return "Hello";
        }).exceptionally(ex -> {
            System.out.println("Recovered from: " + ex.getMessage());
            return "Fallback value";
        }).thenAccept(System.out::println);

        try { Thread.sleep(500); } catch (InterruptedException ignored) {}
    }
}
```

---

## Best Practices

* For **CPU-bound** work, use the default `ForkJoinPool`.
* For **blocking I/O** work, provide a custom `Executor` (thread pool).
* Always handle exceptions with `exceptionally` or `handle`.
* Use `join()` in pipelines when you don’t want checked exceptions; use `get()` when you want explicit exception handling.
