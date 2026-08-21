---
title: "Executor"
description: "Executor overview"
weight: 3
draft: false
geekdocCollapseSection: false
---

The **Executor** framework decouples *task submission* from *thread management*. Instead of creating threads manually, you submit `Runnable`/`Callable` tasks to an `ExecutorService` (a managed thread pool). This improves performance (thread reuse), control (sizing, queueing), and code clarity.

## Why use a thread pool?

* **Reuse**: Avoids the overhead of constantly creating/destroying threads.
* **Control**: Limit concurrency (e.g., max 4 threads), queue excess tasks.
* **Composition**: Works seamlessly with `Future`/`Callable` and scheduling.

> Always shut down your pool with `shutdown()` (and optionally `awaitTermination`) to release resources.

---

## Common Executor Implementations

### 1) newSingleThreadExecutor()

**What**: One background thread; tasks run sequentially.
**Use when**: You need ordering and isolation (e.g., serialize writes).

**Pros**

* Simple mental model: FIFO, one-at-a-time.
* No race conditions between tasks.

**Cons**

* No parallelism; a slow task blocks all others.

```java
import java.util.concurrent.*;

public class SingleThreadExecutorDemo {
    public static void main(String[] args) {
        ExecutorService executor = Executors.newSingleThreadExecutor();
        try {
            for (int i = 1; i <= 3; i++) {
                int id = i;
                executor.submit(() -> System.out.println("Task " + id + " by " + Thread.currentThread().getName()));
            }
        } finally {
            executor.shutdown();
        }
    }
}
```

---

### 2) newFixedThreadPool(n)

**What**: Pool with a fixed number of threads, backed by an unbounded queue.
**Use when**: CPU-bound or mixed workloads where you want *bounded* parallelism.

**Pros**

* Stable, predictable concurrency level.
* Good default for many server tasks.

**Cons**

* Unbounded queue can grow and increase latency/memory if producers are faster than consumers.

```java
import java.util.concurrent.*;
import java.util.stream.IntStream;

public class FixedThreadPoolDemo {
    public static void main(String[] args) {
        ExecutorService pool = Executors.newFixedThreadPool(2); // e.g., 2 workers
        try {
            IntStream.rangeClosed(1, 5).forEach(i ->
                pool.submit(() -> {
                    System.out.println("Work " + i + " on " + Thread.currentThread().getName());
                    try { Thread.sleep(300); } catch (InterruptedException ignored) {}
                })
            );
        } finally {
            pool.shutdown();
        }
    }
}
```

---

### 3) newCachedThreadPool()

**What**: Expands as needed, reusing idle threads; idle threads die after 60s.
**Use when**: Many short-lived, bursty, non-blocking tasks.

**Pros**

* Handles bursts without queuing delays.
* Reuses threads aggressively.

**Cons**

* Can grow very large → risk of resource exhaustion under heavy load.

```java
import java.util.concurrent.*;

public class CachedThreadPoolDemo {
    public static void main(String[] args) {
        ExecutorService pool = Executors.newCachedThreadPool();
        try {
            for (int i = 0; i < 20; i++) {
                pool.submit(() -> {
                    System.out.println("Task on " + Thread.currentThread().getName());
                });
            }
        } finally {
            pool.shutdown();
        }
    }
}
```

---

### 4) newScheduledThreadPool(n)

**What**: Schedule tasks with delays or at fixed rate.
**Use when**: Timers, heartbeats, periodic refresh.

**Pros**

* Robust replacement for `Timer/TimerTask`.
* Supports fixed rate (`scheduleAtFixedRate`) and fixed delay (`scheduleWithFixedDelay`).

**Cons**

* Requires careful error handling; unhandled exceptions can cancel a repeating task.

```java
import java.util.concurrent.*;

public class ScheduledPoolDemo {
    public static void main(String[] args) {
        ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);

        scheduler.scheduleAtFixedRate(
            () -> System.out.println("Tick: " + System.currentTimeMillis()),
            0, 1, java.util.concurrent.TimeUnit.SECONDS
        );

        // Demo: stop after ~3.5s
        scheduler.schedule(() -> scheduler.shutdown(), 3500, java.util.concurrent.TimeUnit.MILLISECONDS);
    }
}
```

---

### 5) newWorkStealingPool()

**What**: Creates a `ForkJoinPool` using available processors; tasks are split into small units that idle threads can “steal”.
**Use when**: Many small, CPU-bound tasks; divide-and-conquer algorithms.

**Pros**

* Great utilization for fine-grained tasks.
* Often faster for parallel recursive work.

**Cons**

* Less intuitive behavior; debugging can be trickier.

```java
import java.util.concurrent.*;
import java.util.stream.IntStream;

public class WorkStealingDemo {
    public static void main(String[] args) {
        ExecutorService pool = Executors.newWorkStealingPool(); // size ~= CPU cores
        // Note: Work-stealing uses daemon threads; prevent early exit.
        CountDownLatch latch = new CountDownLatch(10);

        IntStream.range(0, 10).forEach(i ->
            pool.submit(() -> {
                System.out.println("Unit " + i + " on " + Thread.currentThread().getName());
                latch.countDown();
            })
        );

        try { latch.await(); } catch (InterruptedException ignored) {}
        pool.shutdown();
    }
}
```

---

### 6) Custom ThreadPoolExecutor

For **full control** (bounded queue, rejection policy, thread naming), build it directly.

**Pros**

* Choose queue type & capacity, rejection behavior, thread factory, etc.
* Prevent unbounded memory growth with a bounded queue.

**Cons**

* More configuration; easier to misconfigure.

```java
import java.util.concurrent.*;

public class CustomThreadPoolExecutorDemo {
    public static void main(String[] args) {
        int core = 2, max = 4;
        BlockingQueue<Runnable> queue = new ArrayBlockingQueue<>(100);

        ThreadFactory namedFactory = r -> {
            Thread t = new Thread(r);
            t.setName("app-worker-" + t.getId());
            t.setDaemon(false);
            return t;
        };

        RejectedExecutionHandler rejectHandler = new ThreadPoolExecutor.CallerRunsPolicy(); // Backpressure

        ThreadPoolExecutor pool = new ThreadPoolExecutor(
            core, max, 60, TimeUnit.SECONDS, queue, namedFactory, rejectHandler
        );

        try {
            for (int i = 0; i < 1000; i++) {
                int id = i;
                pool.submit(() -> System.out.println("Job " + id + " on " + Thread.currentThread().getName()));
            }
        } finally {
            pool.shutdown();
        }
    }
}
```

> Tip: For **blocking I/O** tasks, you often need more threads than CPU cores. For **CPU-bound** tasks, size near `Runtime.getRuntime().availableProcessors()`.

---

## (Optional) Virtual Threads (Java 21+)

If/when you move beyond Java 17, **virtual threads** offer massive concurrency with a simple API:

```java
// Requires Java 21+
try (var executor = Executors.newVirtualThreadPerTaskExecutor()) {
    executor.submit(() -> {
        // cheap “thread”
        System.out.println("Hello from virtual thread: " + Thread.currentThread());
    });
}
```

**Pros**: Huge concurrency for blocking I/O, simpler design (each task = one thread).
**Cons**: Requires Java 21+, some libraries may need tuning.

---

## Best Practices & Pitfalls

* **Always shut down**: `shutdown()` then `awaitTermination(...)`. Use `shutdownNow()` for hard stops.
* **Bound your queues** for backpressure; avoid unbounded growth with `newFixedThreadPool` if producers can outrun consumers.
* **Avoid deadlocks**: Don’t submit to a pool and then `get()` inside the same pool if all threads are busy waiting on each other.
* **Handle exceptions**: Wrap tasks; for `ScheduledExecutorService`, catch inside the task to avoid silent cancellation.
* **Name threads** (custom `ThreadFactory`) for easier debugging and logging.
* **Match pool size to workload**: CPU-bound ≈ cores; blocking I/O > cores.

---

## Minimal Template with Proper Shutdown

```java
import java.util.concurrent.*;

public class ExecutorTemplate {
    public static void main(String[] args) {
        ExecutorService executor = Executors.newFixedThreadPool(4);
        try {
            executor.submit(() -> System.out.println("Do work"));
            // submit more tasks...
        } finally {
            executor.shutdown();
            try {
                if (!executor.awaitTermination(5, TimeUnit.SECONDS)) {
                    executor.shutdownNow();
                }
            } catch (InterruptedException e) {
                executor.shutdownNow();
                Thread.currentThread().interrupt();
            }
        }
    }
}
```

---

### See Also

* [Runnable](../runnable)
* [Callable](../callable)
* [Future](../future)
* [CompletableFuture](../completablefuture)
