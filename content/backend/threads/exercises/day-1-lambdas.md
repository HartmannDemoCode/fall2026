---
title: "Lamdas"
description: "Lamda and Streams exercises"
weight: 1
draft: false
---

## Day 1 – First Steps with Lambdas

## **1. Getting Started with Lambdas**

### Exercise 1: Your First Lambda

Replace the anonymous class with a lambda expression:

```java
public class Main {
    public static void main(String[] args) {
        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                System.out.println("Hello, world!");
            }
        };
        runnable.run();
    }
}
```

✅ Goal: Replace the `new Runnable() { ... }` with a lambda.
💡 Hint: A lambda has the form `() -> { ... }`.

---

### Exercise 2: Lambda with One Parameter

Create a lambda that prints a given string:

```java
@FunctionalInterface
interface Printer {
    void print(String message);
}

public class Main {
    public static void main(String[] args) {
        Printer printer = ...; // Write the lambda here
        printer.print("hello");
    }
}
```

✅ Goal: Replace `...` with a lambda that prints the message.
💡 Hint: The lambda has one parameter → `(msg) -> ...`.

---

### Exercise 3: Lambda with a Calculation

Write a lambda that adds two numbers together:

```java
@FunctionalInterface
interface Adder {
    int add(int a, int b);
}

public class Main {
    public static void main(String[] args) {
        Adder adder = ...; // Write the lambda here
        System.out.println(adder.add(5, 3)); // Should print 8
    }
}
```

✅ Goal: Replace `...` with a lambda that sums the two numbers.

---

## **2. Built-in Functional Interfaces**

Now let’s use some of Java’s built-in functional interfaces.

### Exercise 4: Using Consumer

Create a lambda that prints each name in a list:

```java
import java.util.function.Consumer;
import java.util.Arrays;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> names = Arrays.asList("Alice", "Bob", "Charlie");

        Consumer<String> printer = ...; // Write the lambda here

        names.forEach(printer);
    }
}
```

✅ Goal: Replace `...` with a lambda that prints the name.

---

### Exercise 5: Using Function

Create a lambda that doubles an integer:

```java
import java.util.function.Function;

public class Main {
    public static void main(String[] args) {
        Function<Integer, Integer> doubler = ...; // Write the lambda here
        System.out.println(doubler.apply(5)); // Should print 10
    }
}
```

---

### Exercise 6: Using Predicate

Write a lambda that checks if a number is even:

```java
import java.util.function.Predicate;

public class Main {
    public static void main(String[] args) {
        Predicate<Integer> isEven = ...; // Write the lambda here
        System.out.println(isEven.test(4)); // true
        System.out.println(isEven.test(5)); // false
    }
}
```

---

## **3. Small Practical Example**

### Exercise 7: Sorting with Lambdas

Sort a list of words by their lengths:

```java
import java.util.Arrays;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        List<String> words = Arrays.asList("apple", "banana", "kiwi", "cherry");

        words.sort(...); // Write the lambda here

        System.out.println(words); // Should print [kiwi, apple, banana, cherry]
    }
}
```

---
