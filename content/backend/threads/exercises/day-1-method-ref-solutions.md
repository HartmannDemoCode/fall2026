---
title: "Method References Solutions"
description: "Method References  exercises solutions"
weight: 5
draft: true
---

## Exercise 1: Print with `System.out::println`

```java
List<String> names = List.of("Anna", "Bob", "Alice");
names.forEach(System.out::println);
```

---

## Exercise 2: Static method reference

```java
List<Integer> numbers = Arrays.asList(1, 2, 3, 4);
List<String> hex = numbers.stream()
                          .map(Integer::toHexString)
                          .collect(Collectors.toList());
System.out.println(hex); // [1, 2, 3, 4]
```

---

## Exercise 3: Instance method reference

```java
List<String> words = List.of("apple", "banana", "kiwi");
List<String> upper = words.stream()
                          .map(String::toUpperCase)
                          .collect(Collectors.toList());
System.out.println(upper); // [APPLE, BANANA, KIWI]
```

---

## Exercise 4: Reference to a constructor

```java
List<String> names = List.of("Alice", "Bob");
List<Person> persons = names.stream()
                            .map(Person::new)
                            .collect(Collectors.toList());
System.out.println(persons); // [Alice, Bob]
```

---

## Exercise 5: Sort with method reference

```java
List<String> words = Arrays.asList("pear", "apple", "banana");
words.sort(String::compareToIgnoreCase);
System.out.println(words); // [apple, banana, pear]
```

---
