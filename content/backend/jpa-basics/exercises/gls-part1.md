---
title: GLS Part 1
description: gls exercise part 1
weight: 10
draft: false
---

## Exercise: GLS Parcel Tracking System - Part 1

![](../images/glsbear.png)
{.half-right }

### Scenario

GLS (Global Logistics Services) wants to develop a parcel tracking system to manage the delivery of parcels. As part of the initial phase, they need to create a basic system using Java, JPA, and JPQL to manage parcel information.

### Requirements

1. Create an entity named "Parcel" using Lombok to manage parcel information. The "Parcel" entity should have the following attributes:
    - ID (auto-generated primary key)
    - Tracking number (String)
    - Sender name (String)
    - Receiver name (String)
    - Delivery status (Enum: PENDING, IN_TRANSIT, DELIVERED)
    - Updated (LocalDateTime) for last time the parcel was updated

2. Create a DAO (Data Access Object) class named "ParcelDAO" to perform CRUD operations on the "Parcel" entity using JPA.

3. Implement methods in the "ParcelDAO" to perform the following operations:
    - Persist a new parcel
    - Retrieve a parcel by its tracking number
    - Retrieve all parcels in the system
    - Update the delivery status of a parcel
    - Remove a parcel from the system

4. Define pre-update and pre-persist life cycle methods in the "Parcel" entity to update the last updated timestamp automatically.

5. Write integration tests for the DAO methods to ensure they work correctly. Use test containers.

6. Use Maven for project management.

### Hints

- Use Jakarta Persistence (JPA) annotations to map the entity attributes to database columns.
- Implement JPQL queries for retrieving s based on certain criteria, such as tracking number or delivery status.

### UML sketch

{{<mermaid>}}
classDiagram
  direction LR

  class Parcel {
    - Integer id
    - String trackingNumber
    - String senderName
    - String receiverName
    - DeliveryStatus deliveryStatus
    - LocalDateTime updated
    - void prePersist()
    - void preUpdate()
  }

  class DeliveryStatus {
    PENDING
    IN_TRANSIT
    DELIVERED
  }

  class ParcelDAO {
    - EntityManagerFactory emf
    + Parcel create(Parcel parcel)
    + Parcel findByTrackingNumber(String trackingNumber)
    + List~Parcel~ findAll()
    + Parcel updateStatus(String trackingNumber, DeliveryStatus newStatus)
    + boolean deleteByTrackingNumber(String trackingNumber)
    + List~Parcel~ findByStatus(DeliveryStatus status)
  }

   class Main {
    - EntityManagerFactory emf
    + void main(String[] args)
  }

  %% Relationships
  ParcelDAO ..> Parcel : manages
  ParcelDAO ..> DeliveryStatus : uses
  Main --> ParcelDAO : uses
  Parcel --> DeliveryStatus : has

  note for DeliveryStatus "Enumeration in code (Java enum)"

{{</mermaid>}}

### JUnit / Integration test example

On 3rd semester we will create integration tests for DAO methods. It's a bad idea to run tests on the production database itself. To
avoid that, we use a new Docker container with Postgresql. It called a "test container". We have made a [DAO integration test tutorial in the Toolbox](/toolbox/test/dao-test).

### Expected Outcome

This exercise should provide a solid foundation for understanding JPA (ORM) and JPQL in the context of building a  tracking system. Also, you will get your first introduction to integration testing. Next week - in part 2, you will be introduced to more complex relationships between entities to further enhance the system.
