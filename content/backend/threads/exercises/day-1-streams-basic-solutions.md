---
title: "Streams API Basics - Solutions"
description: "Solutions for the Streams API Basics exercises"
weight: 3
draft: true
---


Below are concise solutions for each exercise. Each snippet is intended to live **inside `public static void main(String[] args)`** unless otherwise noted. Add imports as needed:

```java
import java.util.*;
import java.util.stream.*;
import java.util.Comparator;
import java.util.stream.Collectors;
```

---

## Exercise 1: Print all items

```java
List<String> names = List.of("Anna", "Bob", "Alice", "Mark");
names.stream().forEach(System.out::println);
```

---

## Exercise 2: Uppercase all names

```java
List<String> names = List.of("Anna", "Bob", "Alice", "Mark");
names.stream()
     .map(String::toUpperCase)
     .forEach(System.out::println);
```

---

## Exercise 3: Name lengths

```java
List<String> names = List.of("Kiwi", "Banana", "Pear");
List<Integer> lengths = names.stream()
                             .map(String::length)
                             .collect(Collectors.toList());
System.out.println(lengths); // [4, 6, 4]
```

---

## Exercise 4: Names starting with A

```java
List<String> names = List.of("Anna", "Bob", "Alice", "Mark", "Amy");
names.stream()
     .filter(n -> n.startsWith("A"))
     .forEach(System.out::println); // Anna, Alice, Amy
```

---

## Exercise 5: Keep short names (≤ 4 chars)

```java
List<String> names = List.of("Tom", "Jenny", "Lia", "Chris", "Bo");
List<String> shortOnes = names.stream()
                              .filter(n -> n.length() <= 4)
                              .collect(Collectors.toList());
System.out.println(shortOnes); // [Tom, Lia, Bo]
```

---

## Exercise 6: Even numbers doubled

```java
List<Integer> numbers = List.of(1, 2, 3, 4, 5, 6);
List<Integer> evensDoubled = numbers.stream()
                                    .filter(n -> n % 2 == 0)
                                    .map(n -> n * 2)
                                    .collect(Collectors.toList());
System.out.println(evensDoubled); // [4, 8, 12]
```

---

## Exercise 7: Words longer than 3, uppercased

```java
List<String> words = List.of("a", "map", "stream", "java", "lambda");
List<String> result = words.stream()
                           .filter(w -> w.length() > 3)
                           .map(String::toUpperCase)
                           .collect(Collectors.toList());
System.out.println(result); // [STREAM, JAVA, LAMBDA]
```

---

## Exercise 8: Sort by length (shortest → longest)

```java
List<String> words = List.of("apple", "banana", "kiwi", "cherry");
List<String> sorted = words.stream()
                           .sorted(Comparator.comparingInt(String::length))
                           .collect(Collectors.toList());
System.out.println(sorted); // [kiwi, apple, banana, cherry]
```

---

## Exercise 9: Remove duplicates then sort alphabetically

```java
List<String> items = List.of("tea", "coffee", "tea", "juice", "coffee", "water");
List<String> uniqueSorted = items.stream()
                                 .distinct()
                                 .sorted() // natural (alphabetical) order
                                 .collect(Collectors.toList());
System.out.println(uniqueSorted); // [coffee, juice, tea, water]
```

---

## Exercise 10: Sum of squares

```java
List<Integer> numbers = List.of(1, 2, 3, 4, 5);
int sumOfSquares = numbers.stream()
                          .mapToInt(n -> n * n)
                          .sum();
System.out.println(sumOfSquares); // 55
```

---

## Exercise 11: Count names containing 'a' (case-insensitive)

```java
List<String> names = List.of("Anna", "Bob", "ALICE", "Tom");
long count = names.stream()
                  .filter(n -> n.toLowerCase().contains("a"))
                  .count();
System.out.println(count); // 2
```

---

## Exercise 12 (Optional): First three long names

```java
List<String> names = List.of("Anna", "Robert", "Christopher", "Alice", "Mark", "Jennifer");
List<String> top3 = names.stream()
                         .filter(n -> n.length() >= 5)
                         .map(String::toUpperCase)
                         .sorted()
                         .limit(3)
                         .collect(Collectors.toList());
System.out.println(top3); // e.g., [ALICE, JENNIFER, ROBERT]
```
