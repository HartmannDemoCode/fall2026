---
title: "JPA setup tutorial"
description: "Video tutorial on how to setup JPA in IntelliJ and create tests"
weight: 3
draft: true
---

## JPA/Hibernate Micro-Series

---

The goal of this micro-series is to show how to set up JPA with Hibernate in a simple Java project, and how to write integration tests for the DAO layer using Testcontainers. We will cover the basics of JPA configuration, entity mapping, CRUD operations, and testing best practices.

Source code for the tutorial can be found in this [Delphi Demo Repo](https://github.com/jonbertelsen/delphi), which you can use as a reference while following along with the videos. You will also be able to copy/paste code snippets from this page to speed up your setup.

## Video 1 — Project setup + why JPA

**Goal:** Get to know what JPA is and how use Hibernate, and get the project compiling.

**Flow:**

1. Show the end result (CRUD running in `Main.java`) and set expectations.
2. Create the project skeleton in IntelliJ by using the [jpa-setup](../jpa-setup) page as a guide.
3. Paste `pom.xml` and consider the purpose of each dependency group.
4. Run a quick build.

**Summary:**

- JPA is the API, Hibernate is the implementation.
- JDBC driver + Hibernate core + HikariCP for pooling.
- Lombok to reduce boilerplate in entities.

---

## Video 3 — What is an entity? Config flow: properties + EMF

**Goal:** See how Hibernate is configured and where connection values live.

**Flow:**

1. Look at `config.properties`.
2. What is the EMF lifecycle? Why is it expensive to create?
3. Consider dev vs deployed config logic.

---



## Video 4 — DAO pattern + create/read

**Goal:** First successful read and write with JPA and understand the basics of the EntityManager.

**Flow:**

1. Generic DAO interface `IDAO<T, I>`.
2. Build `StudyDAO.create()` and `getById()`.
3. Understand `EntityManager` and transactions.

**Generic DAO interface code snippet:**

```java
package app.daos;

import java.util.List;

public interface IDAO<T, I> {
    T create(T t);
    T getById(I id);
    List<T> getAll();
    T update(T t);
    boolean delete(I id);
}
```

**Notes to consider:**

- `persist()` vs `find()`.
- What “managed entity” means.

---

## Video 5 — Error handling: custom ApiException

**Goal:** Introducing a minimal custom exception and when it is used.

**Flow:**

1. Look at `ApiException`.
2. Consider why we want to use a custom exception.
3. Code/message usage (HTTP-like codes for clarity).
4. Consider where it is thrown in DAOs later.

---

## Video 6 — update/delete + polish

**Goal:** Complete CRUD and basic best practices.

**Flow:**

1. Implement `update()` and `delete()`.
2. Add simple validation (null checks).
3. Add rollback handling and show a failing case.

**Notes to consider:**

- Why we guard against `null` ids.
- Why rollback is important when errors happen mid-transaction.

---

## Video 7 — Integration tests with Testcontainers (7–8 min)

**Goal:** How to test the DAO end-to-end with a real database.

**Flow:**

1. What is the purpose of integration tests for DAOs?
2. Paste `HibernateTestConfig` that have configuration for Testcontainers JDBC URL.
3. Paste `StudyTestPopulator` and consider how it seeds data and returns IDs.
4. Build `StudyDAOTest` structure and how it uses the populator + test config.

**Paste snippet: `src/test/java/app/config/HibernateTestConfig.java`**

```java
package app.config;

import jakarta.persistence.EntityManagerFactory;

import java.util.Properties;

public final class HibernateTestConfig {

    private static volatile EntityManagerFactory emf;

    private HibernateTestConfig() {}

    public static EntityManagerFactory getEntityManagerFactory() {
        if (emf == null) {
            synchronized (HibernateTestConfig.class) {
                if (emf == null) {
                    emf = HibernateEmfBuilder.build(buildProps());
                }
            }
        }
        return emf;
    }

    private static Properties buildProps() {
        Properties props = HibernateBaseProperties.createBase();

        // Testcontainers JDBC driver
        props.put("hibernate.connection.driver_class", "org.testcontainers.jdbc.ContainerDatabaseDriver");
        props.put("hibernate.connection.url", "jdbc:tc:postgresql:16.2:///test_db");

        props.put("hibernate.archive.autodetection", "hbm,class");
        props.put("hibernate.hbm2ddl.auto", "create-drop");

        return props;
    }
}
```

**Paste snippet: `src/test/java/app/testutils/StudyTestPopulator.java`**

```java
package app.testutils;

import app.entities.Study;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceException;

import java.time.LocalDate;
import java.util.LinkedHashMap;
import java.util.Map;

public final class StudyTestPopulator {

    private StudyTestPopulator() {}

    public static Map<String, Study> populate(EntityManagerFactory emf) {
        try (EntityManager em = emf.createEntityManager()) {

            em.getTransaction().begin();
            LocalDate baseDate = LocalDate.of(2028,2,1);
            Study study1 = new Study("Intro to JPA", 101, baseDate.plusDays(1));
            Study study2 = new Study("Hibernate Basics", 102, baseDate.plusDays(2));
            Study study3 = new Study("Entity Manager Deep Dive", 103, baseDate.plusDays(3));

                try {
                    em.createNativeQuery("TRUNCATE TABLE study RESTART IDENTITY CASCADE").executeUpdate();
                    em.persist(study1);
                    em.persist(study2);
                    em.persist(study3);
                    em.flush();
                } catch (PersistenceException e) {
                    if (em.getTransaction().isActive()) em.getTransaction().rollback();
                    throw e;
                }
            em.getTransaction().commit();

            Map<String, Study> seeded = new LinkedHashMap<>();
            seeded.put("study1", study1);
            seeded.put("study2", study2);
            seeded.put("study3", study3);
            return seeded;
        }
    }
}
```

OBS! The `TRUNCATE` statement is used to clear the table before seeding new data, ensuring that each test starts with a clean slate. The `RESTART IDENTITY` option resets the auto-incrementing primary key, so we can predict the IDs of the seeded entities. You can add more tables to clear separated with commas if needed. For instance:

```java
em.createNativeQuery("TRUNCATE TABLE study, users, roles RESTART IDENTITY CASCADE").executeUpdate();
```

**Paste snippet: `src/test/java/app/daos/StudyDAOTest.java` (structure only)**

```java
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
class StudyDAOTest {
    private final EntityManagerFactory emf = HibernateTestConfig.getEntityManagerFactory();
    private StudyDAO studyDAO;
    private Map<String, Study> seeded;

    @BeforeEach
    void beforeEach() {
        seeded = StudyTestPopulator.populate(emf);
        studyDAO = new StudyDAO(emf);
    }

    @AfterAll
    void shutdown() {
        emf.close();
    }

     @Test
    void create() {
        Study study = new Study("JPA Testing", 200, LocalDate.now().plusDays(5));

        Study created = studyDAO.create(study);

        assertThat(created.getId(), notNullValue());
        Study fetched = studyDAO.getById(created.getId());
        assertThat(fetched.getTitle(), is("JPA Testing"));
        assertThat(fetched.getTeacherId(), is(200));
    }

     // Further tests: getById, getAll, update, delete, and negatives ....
}
```

**Integration test summary:**

- Testcontainers gives a real Postgres instance, not an in-memory fake.
- Each test starts with known data so assertions are stable.
- We return seeded entities so tests can reuse generated IDs.
- We also make negative tests to make sure our exception handling works

---

## Final Recap

- JPA is a spec / standard; Hibernate is the implementation.
- EntityManagerFactory is created once; EntityManager per unit of work.
- Entities map classes to tables; DAOs isolate persistence logic.
- Validation + rollback make the app safer and easier to debug.
- Integration tests with Testcontainers verify the DAO against a real database.
