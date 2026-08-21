---
title: Dog API Test
description: Rest Assured test for Dog API
weight: 6
draft: false
---

![Meditative dog](/backend/rest-intro/exercises/images/meditative-dog.gif)
{.half-right}

[Last weeks Dog API](/backend/rest-intro/exercises/dogs-api) was a good start, but now we need to take it to the next level in terms of quality assurance. We will use Rest Assured, JUnit 6, and Hamcrest matchers to test all the finished endpoints.

## Part I: Setting up the project (getting ready for testing)

Based on your code from last week (Dog API), you should now add integration tests to the project. You should use Rest Assured, JUnit 6, and Hamcrest matchers to test all the finished endpoints.

If you don't have a running version of the Dog API, you can use the following code as a starting point:

- [Dog API on GitHub](https://github.com/jonbertelsen/hund)

## Part II: Integration Testing of the endpoints (API methods)

1. Start by creating a new test class in your project (of the controller class).
2. Add the necessary dependencies to your `pom.xml` file. See the [Hint](#hint-dependencies-for-rest-assured-and-hamcrest) section below for the required dependencies.
3. Setup the test class with a `@BeforeAll` method that starts the Javalin server before running the tests. Remember to stop the server after the tests are done. Also, you need to make sure that the database is running in a test container.
4. Create a Class with methods for populate the "database" with test data before running the tests. You can use the `@BeforeEach` annotation to run this method before each test. Also, remember to clean up the "database" after each test.
5. Create a test method for each of the endpoints in your Dog API. Make sure to test both successful and unsuccessful scenarios (e.g., valid input, invalid input, edge cases).

6. Use Rest Assured to send requests to the API and verify the responses with Hamcrest matchers.
7. Good luck!

## Hint: Dependencies for Rest Assured and Hamcrest

To perform **REST Assured** tests with **Hamcrest** matchers, you will need to include the appropriate dependencies in your `pom.xml`. REST Assured allows you to test RESTful APIs, and Hamcrest matchers can be used to validate responses.

### Required Dependencies

1. **REST Assured**: For sending HTTP requests and receiving responses.
2. **Hamcrest**: For making assertions with matchers.
3. **JUnit 6**: For running the tests (if you're using JUnit 6).

### Maven Dependencies

Here are the necessary dependencies to carry out REST Assured tests with Hamcrest:

#### 1. **REST Assured** Dependency

```xml
<dependency>
    <groupId>io.rest-assured</groupId>
    <artifactId>rest-assured</artifactId>
    <version>6.6.0</version> <!-- Use the latest version available -->
    <scope>test</scope>
</dependency>
```

#### 2. **Hamcrest** Dependency

Hamcrest is often bundled with REST Assured, but if you need to use specific Hamcrest matchers, it's a good practice to include it explicitly:

```xml
<dependency>
    <groupId>org.hamcrest</groupId>
    <artifactId>hamcrest</artifactId>
    <version>2.3</version>
    <scope>test</scope>
</dependency>
```

#### 3. **JUnit 6** Dependency (for tests)

```xml
<dependency>
    <groupId>org.junit.jupiter</groupId>
    <artifactId>junit-jupiter-api</artifactId>
    <version>6.0.3</version>
    <scope>test</scope>
</dependency>
<dependency>
    <groupId>org.junit.jupiter</groupId>
    <artifactId>junit-jupiter-engine</artifactId>
    <version>6.0.3</version>
    <scope>test</scope>
</dependency>
```

#### Optional: **REST Assured JSON Path** (for parsing JSON responses)

If your API responses are JSON, you can add this for easier handling of JSON payloads:

```xml
<dependency>
    <groupId>io.rest-assured</groupId>
    <artifactId>json-path</artifactId>
    <version>6.6.0</version>
    <scope>test</scope>
</dependency>
```

### Complete `pom.xml` Example

```xml
<dependencies>
    <!-- REST Assured for API testing -->
    <dependency>
        <groupId>io.rest-assured</groupId>
        <artifactId>rest-assured</artifactId>
        <version>6.6.0</version>
        <scope>test</scope>
    </dependency>

    <!-- Hamcrest for matchers -->
    <dependency>
        <groupId>org.hamcrest</groupId>
        <artifactId>hamcrest</artifactId>
        <version>2.3</version>
        <scope>test</scope>
    </dependency>

    <!-- JUnit 6 API for writing test cases -->
    <dependency>
        <groupId>org.junit.jupiter</groupId>
        <artifactId>junit-jupiter-api</artifactId>
        <version>6.0.3</version>
        <scope>test</scope>
    </dependency>

    <!-- JUnit 6 Engine for running tests -->
    <dependency>
        <groupId>org.junit.jupiter</groupId>
        <artifactId>junit-jupiter-engine</artifactId>
        <version>6.0.3</version>
        <scope>test</scope>
    </dependency>

    <!-- Optional: REST Assured JSON Path for handling JSON responses -->
    <dependency>
        <groupId>io.rest-assured</groupId>
        <artifactId>json-path</artifactId>
        <version>6.6.0</version>
        <scope>test</scope>
    </dependency>
</dependencies>
```

### Example of REST Assured Test with Hamcrest

Here’s a simple example using REST Assured with Hamcrest matchers to verify an API response:

```java
import io.restassured.RestAssured;
import io.restassured.response.Response;
import org.junit.jupiter.api.Test;
import static io.restassured.RestAssured.*;
import static org.hamcrest.Matchers.*;

public class ApiTest {

    @Test
    public void testGetUser() {
        // Define base URI
        RestAssured.baseURI = "https://jsonplaceholder.typicode.com";

        // Perform GET request and validate response using Hamcrest matchers
        given()
            .when()
            .get("/users/1")
            .then()
            .statusCode(200)
            .body("name", is("Leanne Graham"))
            .body("email", containsString("leanne"));
    }
}
```

### Summary of Required Dependencies

- **REST Assured**: For interacting with REST APIs.
- **Hamcrest**: For matcher-based assertions.
- **JUnit 6**: For running your tests.
- **JSON Path** (Optional): For working with JSON responses.

These dependencies allow you to write and run REST API tests with Hamcrest matchers, ensuring the validity of the responses from APIs.
