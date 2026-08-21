---
title: CodeLab
description: "CodeLab exercise designed to practice Java Streams, Java Time API and Lambdas."
weight: 8
draft: false
---

This CodeLab exercise is designed to help you practice the concepts you have learned in the Java Deep Dive I module on day-1. You will be working on a series of tasks that involve Java Streams, Java Time API, and Lambdas. You will also practice using Git and Github. Make an effort to use Git on the command line as much as possible (Git Bash / Terminal) to get more comfortable with it. Check Git help in the bottom of this page for more information.

## Instructions

![Codelab](/images/common/codelab.png)
{.fourth-right}

### 1. Team up

1. Team up in pairs so you can learn from each other.
2. Remember to tick your [attendance in Moodle](https://cphbusiness.mrooms.net/mod/attendance/manage.php?id=815691)

### 2. Setup the development environment

1. Fork [Flight data Repo](https://github.com/dat3Cph/flightapp) into your own Github account. The **Flight data Repo** is a simple application that reads a CSV file with flight data and calculates the total flight time for each airline. If you don't want to fork the repo, then download a ZIP file of the repo and extract it locally.
2. Open the project in IntelliJ IDEA
3. Make sure that the project builds and runs without errors. If you have issues, make sure that all Maven dependencies are downloaded and that the project SDK is set to Java 17.

### 3. Get aqainted with the code

1. Run the application (find the Main class in `FlightReader`) and see how it works
2. Look at the code and understand how it works. How does the duration of the flights get calculated and more? You might want to
know more about the [Lombok library](/toolbox/java/deepdive/lombok) and how it is used in the code to simplify getters, setters etc.
3. Look at the `json` file and discuss the structure of the data with your team
4. Make sure that the data in the `json` file correlates with the data printed in the console
5. Find the unit-test and run it.
6. See if you can understand the test and what it is testing. Could it be improved?

### 4. Identify tasks, break them down and prioritize

Inspiration for first round tasks:

1. Add a new feature (e.g. calculate the **total flight time** for a specifc airline. For example, calculate the total flight time for all flights operated by Lufthansa)

### 5. Start working on the tasks (round 1)

1. Create a branch off the `main` branch for each task. Call it something like `round-1`
2. Work on the tasks and help each other.

### 6. Merge the code

1. Merge the `round-1` branch into the main branch:
   - On the `round-1` branch: add the changes to the staging area, then you commit the changes
   - Checkout the main branch and merge the `round-1` branch into it.
2. Remove the `round-1` branch
3. Add, commit, and push the changes from `main` to the remote repository
4. Check that the remote repository is up to date

### 7. Repeat

1. Identify the next tasks (get inspiration from the list below)
2. Repeat steps 5-7 for the next tasks

## Inspiration for tasks

1. Add a new feature (e.g. calculate the **average flight time** for a specific airline. For example, calculate the average flight time for all flights operated by Lufthansa)
2. Add a new feature (make a list of flights that are operated between two specific airports. For example, all flights between Fukuoka and Haneda Airport)
3. Add a new feature (make a list of flights that leaves before a specific time in the day/night. For example, all flights that leave before 01:00)
4. Add a new feature (calculate the average flight time for each airline)
5. Add a new feature (make a list of all flights sorted by arrival time)
6. Add a new feature (calculate the total flight time for each airline)
7. Add a new feature (make a list of all flights sorted by duration)
8. Refactor the code where needed. Make sure that the code is clean and easy to read.

## How to use git in the terminal for round-1

### Create a branch and switch to it

```bash
    git branch round-1
    git switch round-1
```

### Add the changes to the staging area and commit the changes

```bash
    git add .
    git commit -m "Add feature to calculate the total flight time for a specific airline"
```

### Merge the `round-1` branch into the `main` branch

```bash
    git switch main
    git merge round-1
```

### Remove the `round-1` branch (no longer needed)

```bash
    git branch -d round-1
```

### Push the changes to the remote repository

```bash
    git push
```
