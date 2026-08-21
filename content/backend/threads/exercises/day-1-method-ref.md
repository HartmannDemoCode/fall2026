---
title: "Method References"
description: "Method References exercises"
weight: 4
draft: false
---

Method references are a shorthand for simple lambdas.
Instead of writing

```java
list.forEach(x -> System.out.println(x));
```

we can write

```java
list.forEach(System.out::println);
```

---

## Exercise 1: Print with `System.out::println`

Print all names using a method reference instead of a lambda.

```java
import java.util.List;

public class Main {
  public static void main(String[] args) {
    List<String> names = List.of("Anna", "Bob", "Alice");
    // TODO: print all names using System.out::println
  }
}
```

---

## Exercise 2: Static method reference

Use a method reference to call a static method.

```java
import java.util.Arrays;
import java.util.List;

public class Main {
  public static void main(String[] args) {
    List<Integer> numbers = Arrays.asList(1, 2, 3, 4);
    // TODO: use map and Integer::toHexString to convert to hex
    // Expected: [1, 2, 3, 4] -> ["1", "2", "3", "4"]
  }
}
```

---

## Exercise 3: Instance method reference

Use an instance method reference to convert strings to uppercase.

```java
import java.util.List;
import java.util.stream.Collectors;

public class Main {
  public static void main(String[] args) {
    List<String> words = List.of("apple", "banana", "kiwi");
    // TODO: map each word with String::toUpperCase
    // Expected: [APPLE, BANANA, KIWI]
  }
}
```

---

## Exercise 4: Reference to a constructor

Create objects using a constructor reference.

```java
import java.util.List;
import java.util.stream.Collectors;

class Person {
  String name;
  Person(String name) { this.name = name; }
  public String toString() { return name; }
}

public class Main {
  public static void main(String[] args) {
    List<String> names = List.of("Alice", "Bob");
    // TODO: map each name to new Person(name) using Person::new
    // Expected: [Alice, Bob]
  }
}
```

---

## Exercise 5: Sort with method reference

Sort words alphabetically using a method reference instead of a lambda.

```java
import java.util.Arrays;
import java.util.List;

public class Main {
  public static void main(String[] args) {
    List<String> words = Arrays.asList("pear", "apple", "banana");
    // TODO: sort using String::compareToIgnoreCase
    // Expected: [apple, banana, pear]
  }
}
```

---
