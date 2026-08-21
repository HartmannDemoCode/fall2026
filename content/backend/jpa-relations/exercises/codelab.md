---
title: CodeLab
description: JPA part 2 CodeLab Exercise
weight: 3
draft: false
---

This CodeLab exercise is designed to help you practice the concepts you have learned on the first day of JPA part 2. You will be working on a series of tasks that involve Java Persistence API, with Entities and DAOs.

![Codelab](/images/common/codelab.png)
{.fourth-right}

## Exercise Overview

![codelab_school_exercise](../codelab-school-exercise.drawio.png)

## Instructions

### 1. Team up with a buddy

### 2. Remember to mark your attendance in Moodle (for getting study points)

### 3. Set up the development environment

1. Create a new Maven project getting ready for JPA with Hibernate. Use the [JPA setup in IntelliJ](/toolbox/java/orm/jpa-setup) guide to help you - or use your own starter project / template.
2. Make sure your `.gitignore` file is set up correctly and then initialize a new Git repository in your project folder. Add and commit your files.

### 3. Connecting to the database

1. Each member should create a database in your docker environment with postgres called `university`.
2. Set up `config.properties` with the database name, so Hibernate can connect to the database.
3. Also, you might want to connect to the database with IntelliJ's database tool window to see the tables that Hibernate creates.

### 4. The assignment

You are going to create a simple application for a university. The application should be able to manage students, courses and teachers. This time around we are going to add relationships between the entities. The relationships can be seen in the class diagram above.
You need to implement the entities and DAO methods. Make sure to use the correct annotations for the relationships and try to understand how the relationships work.

**Remember to test the DAO methods as you go along. It's fine to use the Main class for ad-hoc testing**

Ask yourself the following questions before you start implementing the relationships:

- What are the relationship between the entities?
- Which one should be the owning side of the relationship and what does that mean?
- Should the relationship be unidirectional or bidirectional?
- What cascade type should be used or should we use them at all? What are the implications?
- Should we use fetch type eager or lazy and why?

### 5. Identify tasks, break them down in small steps

The following tasks are suggestions. You can add more tasks as you go along. Read through the list, and get going.

1. Create an **Enum** for the Course class as shown in the diagram and add the correct annotations to the Course class.
2. Create a **Teacher** entity class as shown in the diagram.
3. Create a **Student** entity class as shown in the diagram.
4. Create a **Course** entity class as shown in the diagram.
5. Add the relations between the entities as shown in the diagram.
      - a) a student can attend one course
      - b) a course can have many students
      - c) course can have only one teacher
      - d) a teacher can teach many courses
6. Create a generic DAO interface with CRUD methods. Call it `IDAO`. CRUD would be `create`, `getAll`, `getById`, `update`, and `delete`.
7. Implement a CourseDAO class that implements the `IDAO` interface.
8. Implement a TeacherDAO class that implements the `IDAO` interface.
9. Implement a StudentDAO class that implements the `IDAO` interface.

10. Implement some tests for the DAO classes to make sure that they work. Either in the Main class or in a unit test class. 
11. Create a populator class that populates the database with some data. You can use this data to test your DAO methods and JPQL queries.
12. Implement some JPQL queries to get data from the database. Be creative and try to get data from the database in different ways:

      - a) Get all students that are attending a specific course
      - b) Get the course that a specific student is attending
      - c) Get all courses that a specific teacher is teaching
      - d) Get all students that are attending a course that a specific teacher is teaching
      - e) Get all teachers that are teaching a course that is running in the current semester.
      - f) Get all teachers that have ever taught a specific course.
