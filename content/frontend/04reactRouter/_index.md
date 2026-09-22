---
title: 04 React Router
description: React Router for building better SPAs with url routing.
weight: 4
draft: false
geekdocCollapseSection: true
---

## React part III: Routing, Security, and Deployment

- [Learning objectives for the week](learning-objectives)

Topics covered in this week are:
1. Routing
2. Security
3. Deployment

## Monday

Online reviews in groups

De næste mandage kan I skiftes til at vise noget frem. Vi regner bestemt ikke med at alle kan nå at vise noget frem på den halve time vi har, men så kan vi rotere næste gang. Det er jo også en slags træning til den eksamensform vi har i Front-end.

Find nogle gode eksempler frem (du selv har lavet), hvor du kan fortælle lidt om:

- Hvad er en React Component?
- Fortælt hvad fordelene er ved React i stedet for vanilla Javascript og DOM programmering
- Forklar hvad useState – og hvad det bruges til i React
- Forklar hvad useEffect er – og hvad det bruges til i React
- Hvad er props?
- Forklar hvordan CRUD fungerer i Javascript og React
- Forklar forskellen på controlled og un-controlled components i React. Fordele og ulemper ved hver af dem.

## Tuesday (class)

### Prepare for the class

- Orient yourself in this documentation:

1. [React Router Documentation - The Declarative Mode](https://reactrouter.com/start/declarative/installation)
2. [React routing examples](https://reactrouter.com/start/declarative/routing)
2. [Navigation](https://reactrouter.com/start/declarative/navigating)

### In-class activity
1. [Go through the examples](https://github.com/HartmannDemoCode/react_router_demo_2025) corresponding to the documentation above together in class.
2. Look at the JSON-Server that we will use in the codelab on Wednesday: [JsonServer](/toolbox/react/json-server)
3. [Clone the project and implement todos](https://github.com/HartmannDemoCode/routingX.git)
3. [React Router book exercise](exercises/routing-in-react)

## Wednesday (CodeLab)
1. [Codelab Exercise (Bornholmer Tours)](exercises/codelab)

## Thursday (class)
1. [Backend code repo]( https://github.com/HartmannDemoCode/SecurityDemo)
  - Create a new database: securitydemo
  - Change credentials in HibernateConfig from dev:ax2 to postgres:postgres
2. [Frontend security](exercises/frontend-security)
  - [apiFacade example](https://gist.github.com/Thomas-Hartmann/82bbcfafbc368a0d7bed0e204281f10f)

## Friday (exercise day)
- Add routing to your portfolio project. You can use the React Router documentation and examples to help you with this. You can also look at the code exercises we have done during the week for inspiration on how to implement routing in your project.
- Try to implement some or many of the features we have covered on routing in a single page application. 
- Add security features to your project, with login and JWT tokens, protected routes, and role based endpoints. 