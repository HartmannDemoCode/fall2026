---
title: JWT part 1
description: Creating the security persistence layer
weight: 8
draft: false
---

[Part 2 for thursday](/toolbox/security/api-security)

## Introduction
- Take a look at [this version](https://gist.githubusercontent.com/Thomas-Hartmann/859a4066a1f7d63047cbf4f60ef134a6/raw/46859d2002dd33b0e7559f81c6efeac17befc747/ApplicationCofig.java) of an ApplicationConfig file.
- Discuss in small groups how it works and what it does
### Use it
- Create a new javalin project or a new branch in an existing javalin project.
- Replace existing ApplicationConfig file with the one above.
- Implement route and controller in order to do the following:
    - GET /msg/hello  // returns a json response:  {“msg”:”Hello to you!”}
    - POST /msg/hello   // returns a json response with the name that was send in the request body: {“msg”:”Hello <name>”} 
- HINT: You will need to comment out some part of the ApplicationConfig file to make it work, because we have not created the security layer yet. You can uncomment the security part when you have created the security layer in part 2 of this exercise.

## Part 1 Create the SecurityDAO
1. Create a User and Role model class. The User must implement these methods:

```java
public interface ISecurityUser {
    Set<String>  getRolesAsStrings();
    boolean verifyPassword(String pw);
    void addRole(Role role);
    void removeRole(String role);
}
```
- plus a constructor that hashes the password using bcrypt.

2. Create a SecurityDAO interface with the following methods:

```java
public interface ISecurityDAO {
    User getVerifiedUser(String username, String password) throws ValidationException; // used for login
    User createUser(String username, String password); // used for register
    Role createRole(String role);
    User addUserRole(String username, String role);
}
```
3. Create a UserDAO implementation that implements the above interface and uses JPA to persist the users and roles in the database.