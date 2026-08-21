---
title: Rubric for Portfolio Exam
description: Portfolio project
weight: 1
draft: true
---

# Topic-Based Exam Assessment Rubric

This rubric assesses the student project against the core backend topics covered during the semester.

## Suggested assessment scale

Use the institutional grading scale as required. The descriptors below can be mapped to local grades.

* `Excellent`: Confident, correct, and well-integrated use of the topic
* `Good`: Competent use of the topic with minor weaknesses
* `Adequate`: Basic or partial use of the topic, but with important gaps
* `Insufficient`: Missing, incorrect, or very weak use of the topic

## Assessment criteria

| Topic | Weight | Excellent | Good | Adequate | Insufficient |
| --- | ---: | --- | --- | --- | --- |
| Java + Maven project structure | 10% | The project is well-organized, builds reliably, and follows a clean Maven structure. Packages, dependencies, modules, and naming are coherent and support maintainability. | The project structure is generally sound and Maven is used correctly, with only minor issues in organization or dependency management. | The project builds, but structure is inconsistent, confusing, or only partly aligned with good Maven and Java practices. | The project structure is weak or broken. Maven usage is unclear, unreliable, or shows major misunderstandings. |
| REST API & endpoints | 15% | The API is clearly designed, consistent, and appropriate to the domain. Endpoints, HTTP methods, request/response handling, and status codes are used correctly and coherently. | The API works well overall and demonstrates reasonable endpoint design, with only minor inconsistencies or omissions. | The API is partly functional, but endpoint design, conventions, or response handling are inconsistent or limited. | The API is incomplete, confusing, or incorrectly designed, with major problems in endpoint behavior or HTTP usage. |
| JPA / database persistence | 15% | Persistence is implemented correctly with sensible entity design, mappings, relationships, and repository usage. Database interaction is reliable and aligned with the application needs. | JPA is used correctly in most areas, though some mappings, relationships, or persistence design decisions may be simplistic or uneven. | Basic persistence is present, but entity design or database handling is fragile, limited, or partly incorrect. | Persistence is missing, broken, or demonstrates major misunderstanding of JPA concepts. |
| External API integration | 10% | External services are integrated in a robust and relevant way. The integration is well-structured, clearly justified, and handled reliably within the application design. | External API integration works and is relevant, though robustness, abstraction, or error handling may be limited. | An external API is used at a basic level, but the integration is shallow, brittle, or weakly connected to the rest of the system. | External API integration is missing, non-functional, or poorly understood. |
| Validation & error handling | 10% | Input validation and error handling are systematic and appropriate. The application responds predictably and communicates errors clearly. Invalid states are handled professionally. | Validation and error handling are present in the main areas, with reasonable behavior but some inconsistencies or missing edge cases. | Some validation and error handling exist, but coverage is incomplete or behavior is inconsistent. | Validation and error handling are largely missing or unreliable, leading to unclear or unsafe behavior. |
| Integration tests | 10% | Integration tests cover important application behavior and increase confidence in correctness. Tests are meaningful, maintainable, and aligned with key backend functionality. | Integration tests are present and useful for core flows, though coverage or depth may be limited. | Some integration testing exists, but it is narrow, fragile, or insufficient for the main functionality. | Integration tests are missing, minimal, or not useful as evidence of system correctness. |
| JWT-based authentication & authorization | 15% | Authentication and authorization are implemented correctly and used appropriately to protect the system. JWT handling, access control, and role-based behavior are coherent and secure for the project scope. | JWT-based security is functional and mostly correct, with only minor weaknesses in setup, access rules, or completeness. | Basic authentication or authorization exists, but implementation is incomplete, simplistic, or inconsistently applied. | Security is missing, broken, or demonstrates major misunderstanding of authentication and authorization concepts. |
| Configuration & environment variables | 5% | Configuration is well-managed and separated appropriately across environments. Sensitive values are externalized and environment handling is clear and professional. | Configuration is mostly handled correctly, with only small issues in clarity, separation, or practice. | Some environment-based configuration exists, but management is inconsistent or only partly externalized. | Configuration handling is weak, hard-coded, or unsuitable for realistic deployment. |
| Deployment | 10% | The application is deployable in a credible and repeatable way. Deployment setup is documented and demonstrates readiness beyond local development. | Deployment is functional and documented at a basic level, though some parts may be manual or underdeveloped. | Some deployment effort is visible, but it is incomplete, fragile, or unclear. | Deployment is missing or not credible as part of the finished backend project. |

## Minimum expectations for passing

To pass, the student should demonstrate:

* a working backend project with a valid Java and Maven structure
* a functional REST API with persistence
* meaningful use of several semester topics beyond the absolute basics
* at least basic handling of validation, testing, security, configuration, and deployment
* evidence that the technical elements are understood and integrated into one coherent system

Weakness in a single advanced area does not automatically mean failure, but major gaps across several core topics should result in a failing assessment.

## Guidance for use

This rubric is intended for topic-specific technical assessment. It works best when combined with broader evaluation of:

* development over time
* reflection and learning
* repository professionalism

A student does not need a perfect implementation in every category. The key question is whether the project demonstrates credible backend competence across the semester topics at an appropriate level.
