---
title: "Streams API Basics"
description: "Stream API exercises"
weight: 2
draft: false
---
## Day 1

## 1) Warm-up: From List to Stream

### Exercise 1: Print all items

Use a stream and `forEach` to print every name.

```java
import java.util.List;

public class Main {
  public static void main(String[] args) {
    List<String> names = List.of("Anna", "Bob", "Alice", "Mark");
    // TODO: print each name using stream + forEach
  }
}
```

**Goal:** Replace a classic loop with `names.stream().forEach(...)`.

---

## 2) First Transformations with `map`

### Exercise 2: Uppercase all names

Use `map` to convert each name to uppercase, then print them.

```java
import java.util.List;

public class Main {
  public static void main(String[] args) {
    List<String> names = List.of("Anna", "Bob", "Alice", "Mark");
    // TODO: stream -> map toUpperCase -> forEach print
    // Expected: ANNA, BOB, ALICE, MARK (each on its own line)
  }
}
```

### Exercise 3: Name lengths

Create a `List<Integer>` of the lengths of each name using `map` + `collect`.

```java
import java.util.List;
import java.util.stream.Collectors;

public class Main {
  public static void main(String[] args) {
    List<String> names = List.of("Kiwi", "Banana", "Pear");
    // TODO: List<Integer> lengths = names.stream()....collect(Collectors.toList());
    // Example result: [4, 6, 4]
  }
}
```

---

## 3) Filtering with `filter`

### Exercise 4: Names starting with A

Filter names that start with "A", then print them.

```java
import java.util.List;

public class Main {
  public static void main(String[] args) {
    List<String> names = List.of("Anna", "Bob", "Alice", "Mark", "Amy");
    // TODO: filter names starting with "A" -> forEach print
    // Expected: Anna, Alice, Amy
  }
}
```

### Exercise 5: Keep short names (≤ 4 chars)

```java
import java.util.List;

public class Main {
  public static void main(String[] args) {
    List<String> names = List.of("Tom", "Jenny", "Lia", "Chris", "Bo");
    // TODO: filter names length <= 4 -> collect to List -> print the list
    // Example result: [Tom, Lia, Bo]
  }
}
```

---

## 4) Combine `filter` + `map`

### Exercise 6: Even numbers doubled

From a list of integers, keep only the even ones and then double them.

```java
import java.util.List;
import java.util.stream.Collectors;

public class Main {
  public static void main(String[] args) {
    List<Integer> numbers = List.of(1, 2, 3, 4, 5, 6);
    // TODO: filter even -> map n*2 -> collect -> print
    // Expected: [4, 8, 12]
  }
}
```

### Exercise 7: Words longer than 3, uppercased

```java
import java.util.List;
import java.util.stream.Collectors;

public class Main {
  public static void main(String[] args) {
    List<String> words = List.of("a", "map", "stream", "java", "lambda");
    // TODO: filter length > 3 -> map toUpperCase -> collect -> print
    // Example result: [STREAM, JAVA, LAMBDA]
  }
}
```

---

## 5) Collecting, Sorting, Distinct

### Exercise 8: Sort by length (with streams)

Use `sorted` on the stream to sort words by length (shortest → longest).

```java
import java.util.List;
import java.util.Comparator;
import java.util.stream.Collectors;

public class Main {
  public static void main(String[] args) {
    List<String> words = List.of("apple", "banana", "kiwi", "cherry");
    // TODO: words.stream().sorted( ... ).collect(toList()) -> print
    // Expected: [kiwi, apple, banana, cherry]
  }
}
```

### Exercise 9: Remove duplicates then sort alphabetically

Use `distinct()` and `sorted()`.

```java
import java.util.List;
import java.util.stream.Collectors;

public class Main {
  public static void main(String[] args) {
    List<String> items = List.of("tea", "coffee", "tea", "juice", "coffee", "water");
    // TODO: distinct -> sorted (natural order) -> collect -> print
    // Expected: [coffee, juice, tea, water]
  }
}
```

---

## 6) Small Aggregations

### Exercise 10: Sum of squares

Square each number with `mapToInt` and compute the sum with `sum()`.

```java
import java.util.List;

public class Main {
  public static void main(String[] args) {
    List<Integer> numbers = List.of(1, 2, 3, 4, 5);
    // TODO: numbers.stream().mapToInt(n -> n * n).sum()
    // Expected: 55
  }
}
```

### Exercise 11: Count names containing ‘a’ (case-insensitive)

```java
import java.util.List;

public class Main {
  public static void main(String[] args) {
    List<String> names = List.of("Anna", "Bob", "ALICE", "Tom");
    // TODO: filter names containing 'a'/'A' -> count
    // Expected: 2 (Anna, ALICE)
  }
}
```

---

## 7) A Tiny Taste of `limit`/`skip` (optional)

### Exercise 12 (Optional): First three long names

Take names length ≥ 5, uppercase them, sort alphabetically, and keep only the first three.

```java
import java.util.List;
import java.util.stream.Collectors;

public class Main {
  public static void main(String[] args) {
    List<String> names = List.of("Anna", "Robert", "Christopher", "Alice", "Mark", "Jennifer");
    // TODO: filter len>=5 -> map toUpperCase -> sorted -> limit(3) -> collect -> print
    // Example result: [ALICE, JENNIFER, ROBERT]
  }
}
```

---

### Tips & Hints (quick reference)

* Create a stream: `list.stream()`
* Side-effect printing: `.forEach(System.out::println)`
* Transform each element: `.map(x -> ...)`
* Filter elements: `.filter(x -> condition)`
* Collect into a list: `.collect(Collectors.toList())`
* Sort: `.sorted()` or `.sorted(Comparator.comparingInt(...))`
* Remove duplicates: `.distinct()`
* Numbers: `.mapToInt(...)`, then `.sum()`, `.average()`, etc.

---
