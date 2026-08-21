# Oversigt over læringsmål til backend-eksamen

### Programmeringsfærdigheder i java, såsom:
1. Basale Java-koncepter: variabler, datatyper, kontrolstrukturer, metoder og klasser.
2. Objektorienteret programmering: SOLID-principper og design patterns.
3. Fejlhåndtering: undtagelser og fejlhåndteringsteknikker
4. Java Collections Framework: List, Set, Map og deres anvendelser.
5. Java Streams API: funktionel programmering og data manipulation.
6. Arkitektur og strukturering af kode: pakker, moduler og organisering af projekter.

### JSON and DTOs

1. Understand what a DTO is and how it is used
2. Understand what JSON is and how it is used
3. Understand how to use Jackson or Gson to convert between JSON and DTOs
4. Understand how to use DTOs to represent complex data structures

### Fetching data from an API

1. Understand how to fetch data from an API
2. Understand how to use the HttpClient class to fetch data from an API
3. Understand how to use the ObjectMapper class to convert JSON to DTOs
4. Understand how to use DTOs to represent complex data structures

### Threads

1. Understand how to use threads to perform multiple tasks concurrently
2. Understand how to use threads in java
3. Understand the Executor framework
4. Know the purpose of Runnable and Callable interfaces plus Future

### GitHub Actions and Docker Image Deployment

1. Understand the role of continuous integration and continuous deployment (CI/CD) in modern software development.
2. Practise how to set up a GitHub repository and configure version control for your project.
3. Explore the basic concepts of Docker and containerization for creating consistent development environments.
4. Master the process of creating Docker images for Java applications, specifically JAR files.
5. Gain proficiency in using DockerHub for hosting and sharing Docker images.
6. Understand the advantages of using GitHub Actions for automating the CI/CD pipeline.
7. Learn how to define and configure CI/CD workflows in GitHub Actions YAML files.
8. Implement automated builds and tests for Java applications in GitHub Actions.
9. Explore the process of deploying a Docker image to DockerHub as part of a CI/CD pipeline.
10. Learn how to deploy a Docker container to a remote server by pulling the image from DockerHub.

### Rest endpoint testing with jwt

1. Understand the importance of testing RESTful APIs to ensure their functionality and security.
2. Re-Explore the basic concepts of RESTful API testing using Rest Assured, JUnit 5, and Hamcrest matchers.
3. Learn to set up a test environment for RESTful APIs using test containers, Rest Assured, JUnit 5, and Hamcrest.
4. Learn to create a user registration endpoint that stores user data in a database and hashes the password.
5. Learn to invoke a JWT token from the login endpoint and use it to authenticate requests to secured endpoints.
6. Master the process of writing test cases for RESTful APIs using Rest Assured and JUnit 5

### JPA Basics

1. Be able to create a simple Maven project with JUnit 5, Hibernate, PostgresSQL and JPA.
	- Create a PostgresSQL server and a database with help of Docker.
	- How to configure Hibernate to establish a database connection.
	- Run the project in a main and a test method and verify that the connection is working in pgAdmin
2. Hibernate and JPA
	- Be able to explain the difference between Hibernate and JPA.
	- Describe the key components of the JPA architecture and their relationships.
3. JPA entities and annotations
	- Be able to use and understand the basic annotations of JPA in classes, properties and methods.
	- Apply JPA annotations to map Java classes to database tables.
	- Be able to explain and demonstrate the use of the annotations @Entity, @Table, @Id, @GeneratedValue, @Column
4. EntityManager and EntityManagerFactory
	- Differentiate between the responsibilities of EntityManager and EntityManagerFactory in the context of JPA.
	- Be able to explain the lifecycle management of the EntityManager.
	- When is an entity in a transient, managed, detached or removed state?
	- Explain the difference between the methods persist and merge and when to use them.
5. Database transactions with help of JPA, Hibernate, JDBC, PostgresSQL.
	- Be able to explain and demonstrate how to use the EntityManager to perform CRUD operations like create, read, update and delete.
6. JPQL (Java Persistence Query Language) Part 1
	- Be able to explain the purpose of JPQL and how it differs from SQL.
	- Be able to write JPQL queries using the SELECT, FROM, WHERE and ORDER BY clauses.
	- Be able to write JPQL queries using aggregate functions COUNT, SUM and MIN.
7. JPQL (Java Persistence Query Language) Part 2
	- Be able to explain and demonstrate Named Queries.
	- Be able to explain the difference between TypedQuery vs Query in JPA.
	- Be able to write JPQL queries using aggregate functions MAX, AVG and DISTINCT.
8. JPA entities and annotations
	- Be able to explain and demonstrate JPA lifecycle annotations like @PrePersist, @PostPersist, @PreUpdate, @PostUpdate, @PreRemove, @PostRemove, @PostLoad.
9. Data Access Object (DAO) Architecture
	- Be able to explain and demonstrate the benefits of using a DAO architecture for separating database access logic from business logic.
10. Be able to explain and implement the Singleton design pattern.
11. Date and Time
	- Explain how Java Date and Time API integrates with JPA for managing date and time-related data.
	- Demonstrate the different types of date and time data using JPA annotations.
12. Lombok
	- Be able to explain the purpose of Lombok and how it reduces boilerplate code in Java entities.
	- Explain and demonstrate how to add a private constructor to a class with Lombok.
	- Explain and demonstrate Lombok @Data, @AllArgConstructor, @RequiredArgsConstructor and @Builder annotations.

### JPA Part 2

1. JPQL Query types
   - Be able to explain the purpose of JPQL and how it differs from SQL.
   - What is the difference between `TypedQuery` and `Query` and when to use them.
   - Be able to demonstrate and explain how to use `NamedQueries`.
   - Be able to demonstrate `native queries` and explain the purpose.
2. JPQL result types
   - Be able to explain the difference between the methods `getResultList` and `getSingleResult`.
   - Be able to explain the difference between the methods `setFirstResult` and `setMaxResults`.
   - Be able to explain `getFirstResult` and `getMaxResults` methods.
3. JPA relations between entities (1)
   - Be able to explain and demonstrate the use of the annotations `@OneToOne`, `@OneToMany`, `@ManyToOne`.
4. JPA relations between entities (2)
   - Be able to explain the concepts `identifying` and `non-identifying` relationships.
   - Be able to explain and show the difference between `uni-directional` and `bi-directional` relationships.
   - Explain the use of `@MapsId` annotation.
5. JPA annotations.
   - explain and demonstrate the use of `Enumerated` annotation to map Java enum types to database columns.
   - explain and demonstrate the use of `Temporal` annotation to map Java Date and Calendar types to database columns.
   - explain the use of `@Transient` annotation.
6. JPQL
   - Be able to explain the difference between the methods `setParameter` and `setParameters`.
   - Be able to explain the difference between the methods `executeUpdate` and `executeQuery`.
   - Be able to explain the methods `isBound`.
7. Cascading and data fetching.
   - explain and demonstrate the difference between `FetchType.EAGER` and `FetchType.LAZY`.
   - explain and demonstrate the difference between `CascadeType.ALL` and `CascadeType.PERSIST`.
   - explain and demonstrate the difference between `orphanRemoval=true` and `orphanRemoval=false`.
8. Be able to explain and demonstrate JPA relation `@ManyToMany`.
   - explain the `@ManyToMany` annotation.
   - explain and demonstrate the difference between `owning` and `inverse` side of a relationship.
   - explain and demonstrate the `@JoinColumn` annotation to specify the foreign key column name.
9. DTO projections in JPQL
   - Explain what an DTO is
   - Explain and demonstrate the use of DTO projections in JPQL queries

### Restful web services with Javalin

1. **Routing and Endpoints:** Learn how to define routes and endpoints in Javalin to map HTTP requests to specific handlers or controllers.
2. **Middleware(Http filters):** Explore the concept of middleware in Javalin and how it can be used to add common functionality (e.g.,logging, authentication) to your web application.
3. **Request and Response Handling:** Master the techniques for processing and manipulating incoming requests and outgoing responses in Javalin, including parsing and rendering data.
4. **Context Object in Javalin:** Understand the Javalin `Context` object and how it provides access to information about the current HTTP request and response, including parameters, headers, and the request body.
5. **Route Handlers:** Learn how to define and implement route handlers in Javalin to handle specific HTTP endpoints, including how to use the `ctx` parameter to interact with the request and response.
6. **Exception Handling:** Explore the techniques for handling exceptions in Javalin, including how to use exception handlers to gracefully handle errors and return appropriate HTTP responses.
7. **Routing in Javalin:** Master the concept of routing in Javalin, including how to define routes for different HTTP methods (GET, POST, etc.) and map them to specific route handlers.
8. **Path Parameters:** Understand how to use path parameters in Javalin routes to capture dynamic parts of URLs and pass them as parameters to route handlers, enabling flexible and dynamic routing.

### Http

1. **HTTP Methods Understanding**: Explain the fundamental HTTP methods (GET, POST, PUT, DELETE) and their primary purposes in web development, including how they map to CRUD (Create, Read, Update, Delete) operations.
2. **HTTP Status Codes Mastery**: Familiarize yourself with common HTTP status codes (e.g., 200 OK, 404 Not Found, 500 Internal Server Error) and their meanings. Understand when and how to use these status codes in HTTP responses.
3. **Handling HTTP Methods**: Learn how to define and handle various HTTP methods in web applications, including routing requests to specific handlers based on the method used.
4. **Effective Status Code Usage**: Gain proficiency in selecting and returning appropriate HTTP status codes in your web application based on the success or failure of the request, ensuring clear and meaningful communication between the client and server.

### REST

1. **Define REST**: Explain the principles and concepts of Representational State Transfer (REST) in web services.
2. **HTTP Methods:** Describe the various HTTP methods (GET, POST, PUT, DELETE) used in RESTful APIs and their corresponding CRUD operations.
3. **Resource Identification:** Understand how to identify and structure resources using URIs in RESTful design.
4. **Statelessness:** Explain the importance of statelessness in REST and how it simplifies interactions between clients and servers.
5. **Status Codes:** Learn about common HTTP status codes (e.g., 200, 404, 500) and their meanings in RESTful API responses.

### Testing with Rest Assured

- Be able to explain and demonstrate how one can test RESTful API's with Rest Assured.
- Write basic API tests to verify endpoints' CRUD functionality and response status codes.
- Demonstrate how to use a variety of Hamcrest matchers to write expressive assertions in Rest Assured tests.
- Explore and demonstrate techniques for handling authentication and authorization in Rest Assured tests.

### JWT (JSON Web Tokens)

- Explain the concept of JWT (JSON Web Tokens) and its role in securing RESTful web services.
- Show how to generate JWTs for user authentication and authorization.
- Explore and explain the components of a JWT, including the header, payload, and signature.
- Show how to implement JWT-based authentication and authorization in a Javalin application.
- Demonstrate how to secure REST endpoints using JWTs to control access to resources.
- Optional: Show how to handle token expiration and token refresh mechanisms for long-lived sessions.

### Password Hashing

- Explain why password hashing is important in securing user credentialsd, and how it works.
- Implement password hashing and salt generation in a Javalin application using bcrypt.
- Develop user registration and authentication mechanisms with secure password handling.
- Demonstrate how to handle password change and reset procedures securely.
- Identify and mitigate common password-related vulnerabilities, such as brute force attacks and rainbow table attacks.

### Rest Assured

- Be able to explain and demonstrate how one can test RESTful API's with Rest Assured.
- Write basic API tests to verify endpoints' CRUD functionality and response status codes.
- Demonstrate how to use a variety of Hamcrest matchers to write expressive assertions in Rest Assured tests.
- Explore and demonstrate techniques for handling authentication and authorization in Rest Assured tests.

### JWT (JSON Web Tokens)

- Explain the concept of JWT (JSON Web Tokens) and its role in securing RESTful web services.
- Show how to generate JWTs for user authentication and authorization.
- Explore and explain the components of a JWT, including the header, payload, and signature.
- Show how to implement JWT-based authentication and authorization in a Javalin application.
- Demonstrate how to secure REST endpoints using JWTs to control access to resources.
- Optional: Show how to handle token expiration and token refresh mechanisms for long-lived sessions.

### Password Hashing

- Explain why password hashing is important in securing user credentialsd, and how it works.
- Implement password hashing and salt generation in a Javalin application using bcrypt.
- Develop user registration and authentication mechanisms with secure password handling.
- Demonstrate how to handle password change and reset procedures securely.
- Identify and mitigate common password-related vulnerabilities, such as brute force attacks and rainbow table attacks.

## Læringsmål for Trådprogrammering i Java

### Efter denne uge er det målet at du

1. forklare forskellen på processer og tråde
2. implementere samtidige opgaver med `Runnable` og `Callable`
3. anvende `ExecutorService` til at køre flere tasks parallelt
4. hente resultater med `Future`
5. lukke en executor korrekt
6. identificere simple race conditions og anvende `AtomicInteger` eller `synchronized`
