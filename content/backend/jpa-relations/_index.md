---
date: 2025-07-03T22:58:12+02:00
draft: false
title: "03 JPA Relations"
weight: 3
geekdocCollapseSection: true
---

- [Learning objectives](learning-objectives)

## Monday

- Friday exercise review. Prepare a short presentation of your solution to the Friday exercise.
- Agree among the team members who should present their solution.

## Tuesday (class)

### Prepare for class

#### Reading

- [One-To-One](https://www.logicbig.com/tutorials/java-ee-tutorial/jpa/one-to-one.html)
- [Many-To-One](https://www.logicbig.com/tutorials/java-ee-tutorial/jpa/many-to-one.html)
- [One-To-Many](https://www.logicbig.com/tutorials/java-ee-tutorial/jpa/one-to-many.html)

#### Video

- [JPA relations first 3 videos](https://cphbusiness.cloud.panopto.eu/Panopto/Pages/Sessions/List.aspx#folderID=%226c569295-f604-4241-89e8-b06900ed8d21%22). In the video about 1:1 relations Jon refers to an IntelliJ template that a student has made. The template contains a projects setup with HibernateConfig and pom.xml ready made. Fast food for the people ;-) However, the link given in the video is not active anymore. But use [these instructions instead](/toolbox/ides/intellij/custom-templates#example-template-for-jpa), use the one we have done in class - or start from scratch with this [JPA project setup](/toolbox/java/orm/jpa-setup).

- [Source Code for the above Video](https://github.com/jonbertelsen/dolphin_spring2025)

### Exercise (in class)

- [Dolphin Notes Exercise](exercises/dolphin)
- [Recycling Exercise](exercises/recycling) - extra

## Wednesday (CodeLab)

- [CodeLab exercises on JPA](exercises/codelab)

## Thursday (class)

### Prepare for class

#### Video

- [JPA relations video 4+5 about many-to-many](https://cphbusiness.cloud.panopto.eu/Panopto/Pages/Sessions/List.aspx#folderID=%226c569295-f604-4241-89e8-b06900ed8d21%22)
- [Source Code for the above Video](https://github.com/jonbertelsen/dolphin_fall2023)

#### Reading

- [Many-To-Many](https://www.logicbig.com/tutorials/java-ee-tutorial/jpa/many-to-many.html)

### Exercise (in class)

- [Order System](exercises/order-system)

## Friday (portfolio dev day)

- Continue working on your portfolio project. Add JPA relations to your project. Use java interfaces to declare the DAO methods that you will need for CRUD operations and for the JPQL queries that you will need for your project. Implement the DAO methods and test them as you go along.
- Remember to keep the relationships as simple as possible and be conservative with the use of cascade types. You can always add more cascade types later on if you need them. Also, think about whether you need bi-directional relationships or if unidirectional relationships are enough for your use case. Remember that you can always add more relationships later on if you need them.
- Implement some JPQL queries to get data from the database. Be creative and try to get data from the database in different ways. You can use the JPQL queries to get data by joining different entities together.
- Setup Unit tests for you DAO interfaces.