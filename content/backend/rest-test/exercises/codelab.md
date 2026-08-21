---
title: CodeLab
description: Rest Intro Codelab
layout: default
weight: 4
draft: false
---
![Codelab](/images/common/codelab.png)
{.fourth-right}

This CodeLab exercise is designed to help you practice testing RESTful APIs. You will help each other testing DAO methods and endpoints.

## 1. Sign up on Moodle

## 2. Clone exercise Poems API repository

Clone the following repository to your local machine (just the architecture branch):

```bash
git clone --branch architecture --single-branch git@github.com:jonbertelsen/poems.git
```

## 3. Check the readme file

## 4. Create a database if you don't have it already

The project uses a database called "poems". Also, make sure to have a config.properties file in the src/main/resources folder with the following content:

```properties
DB_NAME=poems
DB_USERNAME=postgres
DB_PASSWORD=postgres
```

## 5. Run the Javalin server

Run the Javalin server inside IntelliJ and make sure it starts without any errors. The server should be running on port 7070.

## 6. Test the endpoints

Use the provided .http file to test the endpoints. Begin by posting some poems to the API and then try to retrieve them. Make sure to test all the endpoints and check the responses.

## 7. Refactor the code

The project is on its way. The programmer has not made a clear separation of concerns with the DTO and the Entity. We suggest you check the code and try to refactor it to have a better separation of concerns. One idea is to create a new package called "mappers" and move the dto to entity and entity to dto mapping logic there. By doing that, you will move the conversion logic out of the dto and entity classes and into a separate class that is responsible for mapping between the two. This will make the code cleaner and easier to maintain. Also, you will be able to change the dto to a record without having to worry about the mapping logic being mixed in with the dto class.

Also, consider to make the DAO methods have entities as parameters and return types instead of DTOs. This will make the DAO layer more focused on the database operations and less concerned with the data transfer objects. Also the DAO test will be easier to write since you can work with the entities directly without having to worry about the mapping logic.

If you are up for it, you can also create a service layer that sits between the controller and the DAO. The service layer can be responsible for handling the business logic of the application, such as validating input, handling exceptions, and coordinating between the controller and the DAO. This will further separate concerns and make the code more modular and easier to maintain.

## 8. Test the DAO methods

After refactoring the code, you should also test the DAO methods to ensure that they are working correctly. You can use Test Containers, JUnit and Hamcrest matchers to write unit tests for the DAO methods. Make sure to test both successful and unsuccessful scenarios (e.g., valid input, invalid input, edge cases).

Get inspiration for the test setup, populating the database with test data, and test cases [from this example](https://github.com/jonbertelsen/delphi/tree/main/src/test/java/app)

## 9. Test the endpoints with restassured

After testing the DAO methods, you should also test the endpoints with Rest Assured to ensure that they are working correctly. You can use Rest Assured to send requests to the API and verify the responses with Hamcrest matchers. Make sure to test both successful and unsuccessful scenarios (e.g., valid input, invalid input, edge cases).

Get inspiration for the test setup, populating the database with test data, and test cases [from this example](https://github.com/jonbertelsen/hund/blob/main/src/test/java/app/routes/RoutesTest.java)
