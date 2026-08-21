---
title: "Futures"
description: "Futures overview"
weight: 4
draft: false
geekdocCollapseSection: false
---

A `Future<V>` represents the result of an **asynchronous computation**. When you submit a `Callable` to an `ExecutorService`, you get back a `Future` object. You can use it to check if the task is done, cancel it, or block until the result is available.

---

## Basic Example

```java
import java.util.concurrent.*;

public class FutureExample {
    public static void main(String[] args) throws ExecutionException, InterruptedException {
        ExecutorService executor = Executors.newSingleThreadExecutor();

        Future<Long> future = executor.submit(() -> {
            System.out.println("Computing factorial in " + Thread.currentThread().getName());
            return java.util.stream.LongStream.rangeClosed(1, 20)
                    .reduce(1, (a, b) -> a * b);
        });

        System.out.println("Main thread is free to work...");

        // Blocks until result is ready
        Long result = future.get();
        System.out.println("Factorial of 20 = " + result);

        executor.shutdown();
    }
}
```

---

## Common Methods

* `get()` – waits (blocks) until the result is available.
* `get(timeout, unit)` – waits up to a maximum time, throws `TimeoutException` if not ready.
* `isDone()` – check if the computation has finished.
* `cancel(boolean mayInterruptIfRunning)` – attempt to cancel the task.

---

## Pros

* Simple API.
* Works with any `ExecutorService`.
* Provides cancellation and timeouts.

## Cons

* **Blocking**: `get()` waits and ties up threads.
* No built-in support for chaining or combining multiple tasks.
* Error handling is clunky (`ExecutionException` wrapping).

---

## Best Practices

* Use `get(timeout, unit)` to avoid infinite blocking.
* Always shut down your `ExecutorService`.
* Don’t use `Future` for complex workflows — use `CompletableFuture` instead.

---

## Example with Timeout

```java
import java.util.concurrent.*;

public class FutureTimeoutExample {
    public static void main(String[] args) {
        ExecutorService executor = Executors.newCachedThreadPool();
        Future<String> future = executor.submit(() -> {
            Thread.sleep(2000); // Simulate delay
            return "Done";
        });

        try {
            // Only wait 1 second
            String result = future.get(1, TimeUnit.SECONDS);
            System.out.println("Result: " + result);
        } catch (TimeoutException e) {
            System.out.println("Task took too long, cancelling...");
            future.cancel(true);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            executor.shutdown();
        }
    }
}
```

### Working with Multiple Futures

When you have multiple tasks, you can collect their `Future`s in a list and wait for all to complete.

This is a classic way to run multiple `Callable` tasks in parallel, collect their `Future`s, and then process results once everything is finished.

Here’s a **teaching-friendly example**:

```java
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.*;

public class FutureListExample {
    public static void main(String[] args) {
        ExecutorService pool = Executors.newFixedThreadPool(3); // 3 worker threads
        List<Future<Integer>> futures = new ArrayList<>();

        try {
            // Submit 5 tasks, each returning a number after simulating work
            for (int i = 1; i <= 5; i++) {
                int taskId = i;
                Future<Integer> future = pool.submit(() -> {
                    System.out.println("Task " + taskId + " running on " + Thread.currentThread().getName());
                    Thread.sleep(500); // simulate some work
                    return taskId * taskId; // return the square
                });
                futures.add(future);
            }

            // Wait until all tasks are done, then retrieve results
            for (Future<Integer> f : futures) {
                try {
                    Integer result = f.get(); // blocks until this result is ready
                    System.out.println("Got result: " + result);
                } catch (ExecutionException e) {
                    System.err.println("Task failed: " + e.getCause());
                }
            }

        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        } finally {
            pool.shutdown();
        }
    }
}
```

---

### 🔎 What happens here?

1. We create a **fixed pool** with 3 worker threads.
2. Submit **5 tasks** (`Callable<Integer>`) that:

   * Print their task ID + thread name.
   * Sleep for 500ms.
   * Return the square of their ID (`i * i`).
3. All returned `Future<Integer>` objects are collected in a list.
4. After submission, we loop through the futures and call `get()`.

   * This blocks until each task finishes.
   * If an exception occurred in a task, it’s wrapped in `ExecutionException`.
5. Finally, the pool is shut down.

---

### Example Output (order may vary)

```
Task 1 running on pool-1-thread-1
Task 2 running on pool-1-thread-2
Task 3 running on pool-1-thread-3
Task 4 running on pool-1-thread-1
Task 5 running on pool-1-thread-2
Got result: 1
Got result: 4
Got result: 9
Got result: 16
Got result: 25
```

Notice:

* Tasks 1–3 start immediately (3 threads available).
* Tasks 4–5 wait until a thread is free.
* Results are printed in **submission order**, not completion order, since we iterate over the `futures` list.

---
