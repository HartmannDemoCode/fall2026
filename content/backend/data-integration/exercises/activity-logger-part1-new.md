---
title: Activity Logger part 1b
description: Java Deep Dive II Exercise DTO and JSON
weight: 3
draft: false
---

Your task is to create a proof of concept solution for a site where people can log their fitness activities. More precisely for walking, jogging og cycling. Many advanced systems exist on the market today, like Stava, Garmin Connect, Endomondo, Nike+, but for many people these apps are overly complicated. So we go simple.

The idea is that a user can log an exercise activity on a website and then the system will **enrich the data** from two external APIs. Namely with weather info from the current day and a few data about the city in which the exercise took place. See illustration below:

![Activity Logger API](../images/activity-logger-api.png)
{.twothird}

You will be able to build a real solution with a frontend later this semester. But for now we will focus on the backend. In this exercise, we will focus on getting the data from the APIs, storing the data in memory in DTOs. Later we might want to add the data to a database with JPA. But not today.

## The data

All data will be held in an `ActivityDTO`. The `ActivityDTO` will contain / reference a `WeatherInfoDTO` and a `CityInfoDTO`. The content of `WeatherInfoDTO` and `CityInfoDTO` can be obtained from two external APIs. The domain model may look like this:

## Domain model

{{<plantuml>}}
@startuml

title ExcerciseLogger\n

hide circle
hide methods
skinparam nodesep 50
skinparam ranksep 50

Class User {
    name
    age
    weight

}

Class Activity {
    exerciseDate
    exerciseType
    timeOfDay
    duration
    distance
    comment
}

Class CityInfo {
    name
    latitude
    longitude
    google_map_url
    elevation
    postcodes
    municipality
    population
}

Class WeatherInfo {
    temperature_2m
    relative_humidity_2m
    precipitation
    wind_speed_10m
}

User "1" -- "*" Activity : " performs"
WeatherInfo "1" -right "1" Activity : occurs on
Activity "*" -right "1" CityInfo: take place in

note top of WeatherInfo: External API
note top of CityInfo: External API

@enduml

{{</plantuml>}}

## External API-servers to be used in this exercise

We will be using two example APIs to get data from.
Both are free to use and does not require any authentication.

- CityInfo: [https://open-meteo.com/en/docs/geocoding-api](https://open-meteo.com/en/docs/geocoding-api)
- WeatherInfo: [https://open-meteo.com/en/docs](https://open-meteo.com/en/docs)

## Examples on external api-calls

To get info about the city of Roskilde:

- [https://geocoding-api.open-meteo.com/v1/search?name=Roskilde&count=1&language=en&format=json&countryCode=DK](https://geocoding-api.open-meteo.com/v1/search?name=Roskilde&count=1&language=en&format=json&countryCode=DK)

To get the current weather in Roskilde:

- [https://api.open-meteo.com/v1/forecast?latitude=55.64152&longitude=12.08035&current_weather=true](https://api.open-meteo.com/v1/forecast?latitude=55.64152&longitude=12.08035&current_weather=true)

```java
HttpRequest request = HttpRequest
                    .newBuilder()
                    .uri(new URI(encodedURL))
                    .GET()
                    .build();
```

## The exercise

1. Take a close look at the domain model and the external APIs. What data do you need to get from the APIs? What data do you need to store in the `ActivityDTO`?

2. Create a `WeatherInfoDTO` and a `CityInfoDTO` that can hold the data from the external APIs.

3. Create an `ActivityDTO` that can hold the data from the external APIs + extra data that you might want to add.

4. Create a `WeatherService` and a `CityService` that can fetch data from the external APIs and return the data in the form of a `WeatherInfoDTO` and a `CityInfoDTO`. You will need to get the latitude and longitude from the `CityService` to be able to get the weather data from the `WeatherService`.

5. Create a `ActivityService` that can create an `ActivityDTO` and enrich it with data from the `WeatherService` and the `CityService`.

6. Create a integration test that can test the `ActivityService` and the `WeatherService` and the `CityService`.
