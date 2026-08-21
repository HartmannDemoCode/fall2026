---
title: "Miners"
description: "Thread exercise"
weight: 11
draft: false
---


## Self-Study Exercise: Gold Miner Race  

*(Threads, Executors, Tasks, Futures)*

## Goal

You will build a small concurrent simulation where several miners work at the same time to collect gold.  
Each miner repeatedly “strikes” and finds a random amount of gold.  
The **first miner to fill their bucket wins**, and the race ends.

You will build this **step by step**.  

You are **not expected to finish all steps** but see how far you can get.

---

## Rules of the World

- There are several miners (e.g. 5–10)
- Each miner works independently
- Mining takes time
- Gold is collected gradually
- The first miner to reach the target wins

---

## STEP 0 — Setup (required)

1. Create a fixed thread pool using `ExecutorService`
   - Pool size: 3 threads
2. Decide:
   - Number of miners
   - Bucket capacity (e.g. 100 gold)

You do **not** start mining yet.

---

## STEP 1 — Runnable miners (basic concurrency)

### Task

Implement miners as `Runnable`.

Each miner should:

- Loop a fixed number of times (e.g. 10 strikes)
- Sleep for a random time (e.g. 200–700 ms)
- Generate a random gold amount (e.g. 1–10)
- Print something like:
Miner 3 struck and found 7 gold

### Requirements

- Submit miners using `ExecutorService.execute(...)`
- Do **not** create threads manually
- Shut down the executor so the program terminates

### Done when

- Output from different miners is interleaved
- Program exits cleanly

---

## STEP 2 — Callable miners (return results, no shared state)

In this step you will change miners from `Runnable` to `Callable`.

Each miner now:

- Keeps track of its **own** gold
- Stops when its bucket is full
- Returns a result object when finished

No shared state is required.

---

### Task

Convert each miner to a `Callable<MinerResult>`.

Inside the `call()` method, each miner should:

1. Initialize **local variables**:
   - `totalGold = 0`
   - `strikes = 0`
   - record a start time

2. While `totalGold < BUCKET_CAPACITY`:
   - Sleep for a random amount of time (e.g. 200–700 ms)
   - Generate a random gold amount (e.g. 1–10)
   - Add the gold to `totalGold`
   - Increment `strikes`
   - Print a progress line, for example:

     ```
     Miner 3 struck and found 6 gold (total=42)
     ```

3. When the bucket is full:
   - Record an end time
   - Return a `MinerResult` containing:
     - Miner ID
     - Total gold
     - Number of strikes
     - Total duration

---

### Requirements

- Submit miners using `ExecutorService.submit(...)`
- Store the returned `Future<MinerResult>` objects
- Do **not** use shared variables to store gold totals
- Do **not** use `synchronized` or atomic variables

---

### After submission

Once all miners have been submitted:

1. Iterate over the `Future<MinerResult>` objects
2. Call `future.get()` to retrieve each result
3. Print a summary for each miner

Example:
Miner 5 finished with 102 gold after 17 strikes (took 4123 ms)

---

### Done when

- Each miner returns its own result
- Final results are printed using `Future.get()`
- No shared state is required to compute results

---

### Task

Convert miners from `Runnable` to `Callable<MinerResult>`.

A miner should now:

- Keep striking **until their bucket is full**
- Count:
  - Total gold collected
  - Number of strikes
- Return a result object containing:
  - Miner ID
  - Total gold
  - Number of strikes

### Requirements

- Submit miners using `executor.submit(...)`
- Store the returned `Future<MinerResult>`
- After **all miners finish**, print a summary

Example output:
Miner 4 finished with 66 gold after 10 strikes

### Done when

- Results are returned via `Future.get()`
- No shared variables are needed to read final results

---

## STEP 3 — First miner wins (optional)

### Task

Change the rules:

- The **first miner to finish wins**
- You should **not wait for all miners**

### Requirements

- Use `CompletionService`
- Retrieve completed miners using `take()`
- As soon as one miner finishes:
  - Declare them the winner

Example:

Winner: Miner 7 with 100 gold

---

## STEP 4 — Cancel losing miners (optional)

### Task

When a winner is found:

- Stop all other miners

### Requirements

- Call `cancel(true)` on remaining `Future`s
- Miners must:
  - Handle interruption
  - Stop quickly and cleanly

### Done when

- Losers stop shortly after a winner is declared
- No extra mining output appears after cancellation

 **Optional**

---

## STEP 5 — Progress announcer (optional extension)

### Task

Add a background announcer.

- Implement as a `Runnable`
- Every 500 ms, print current standings
- Stop announcer when the race ends

Example:

Progress: Miner 1=34, Miner 2=61, Miner 3=48

---

## Final Note

Concurrency is about **coordination**, not speed.  
Correct behavior matters more than finishing fast.

Good luck, and don’t panic if things behave unexpectedly — that’s the point.
