---
title: RestAssured and Hamcrest
weight: 3
draft: false
---

## Minioplæg: Test af Javalin endpoints med Rest Assured og Hamcrest

I dag skal vi i gang med at teste vores API-endpoints.
Når vi bygger en backend i Javalin, er det ikke nok bare at starte serveren og klikke lidt rundt. Vi vil gerne kunne kontrollere automatisk, at vores endpoints virker som forventet — også når vi senere ændrer i koden.

Til det bruger vi to biblioteker:

**Rest Assured**
bruges til at sende HTTP-kald i tests, fx `GET`, `POST`, `PUT` og `DELETE`.

**Hamcrest matchers**
bruges til at skrive forventninger på en læsbar måde, fx:

* at statuskoden er `200`
* at et felt i JSON er `"Fido"`
* at en liste har størrelse `3`

---

## Hvorfor er det smart?

Fordelen er, at vi kan teste vores API næsten som en rigtig klient ville bruge den.

Vi kan fx teste:

* returnerer endpointet den rigtige statuskode?
* kommer data tilbage i korrekt JSON-format?
* indeholder svaret de rigtige værdier?
* fejler endpointet korrekt, hvis input er ugyldigt?

Det gør vores kode mere robust og lettere at videreudvikle.

---

## Den grundlæggende idé

En endpoint-test har ofte denne form:

1. Send en HTTP-request
2. Modtag et svar
3. Tjek at svaret matcher det forventede

Eksempel i ord:

> “Når jeg kalder `GET /dogs/1`, forventer jeg status 200 og en hund med navnet `Fido`.”

---

## Eksempel: simpelt GET endpoint i Javalin

Forestil jer et endpoint:

```java
app.get("/dogs/{id}", ctx -> {
    DogDTO dog = new DogDTO(1, "Fido", "DACHSHUND");
    ctx.json(dog);
});
```

Så kan vi skrive en test sådan her:

```java
import io.restassured.RestAssured;
import org.junit.jupiter.api.Test;

import static io.restassured.RestAssured.given;
import static org.hamcrest.Matchers.equalTo;

class DogRoutesTest {

    @Test
    void shouldReturnDogById() {
        given()
            .when()
            .get("/dogs/1")
            .then()
            .statusCode(200)
            .body("id", equalTo(1))
            .body("name", equalTo("Fido"))
            .body("breed", equalTo("DACHSHUND"));
    }
}
```

---

## Hvordan læser man testen?

### `given()`

Her kan vi sætte requesten op.
Fx headers, content type eller body.

### `when()`

Her udfører vi selve HTTP-kaldet.

### `then()`

Her laver vi vores assertions — altså det, vi forventer.

Det gør testen ret læsbar:

* **given** noget
* **when** jeg kalder endpointet
* **then** forventer jeg dette resultat

---

## Hamcrest matchers

Hamcrest gør assertions mere læsbare.

Nogle nyttige matchers:

```java
equalTo(...)
notNullValue()
hasSize(...)
hasItem(...)
containsString(...)
```

Eksempler:

```java
.body("name", equalTo("Fido"))
.body("message", containsString("created"))
.body("dogs", hasSize(3))
.body("dogs.name", hasItem("Fido"))
```

Det er især smart, når man tester JSON-svar.

---

## Test af POST endpoint

Hvis vi har et endpoint der opretter en hund:

```java
app.post("/dogs", ctx -> {
    DogDTO incoming = ctx.bodyAsClass(DogDTO.class);
    ctx.status(201).json(incoming);
});
```

Så kan testen se sådan ud:

```java
import static io.restassured.http.ContentType.JSON;

@Test
void shouldCreateDog() {
    String json = """
        {
          "id": 2,
          "name": "Bella",
          "breed": "BEAGLE"
        }
        """;

    given()
        .contentType(JSON)
        .body(json)
    .when()
        .post("/dogs")
    .then()
        .statusCode(201)
        .body("name", equalTo("Bella"))
        .body("breed", equalTo("BEAGLE"));
}
```

---

## Hvad bør vi typisk teste?

Når I tester endpoints, så tænk i mindst disse tre typer:

### 1. Happy path

Når alt er korrekt.

Eksempel:

* `GET /dogs/1` giver `200`
* returnerer korrekt data

### 2. Fejlscenarier

Når noget går galt.

Eksempel:

* `GET /dogs/999` giver `404`
* `POST /dogs` uden navn giver `400`

### 3. Kanttilfælde

Når input er tomt, mærkeligt eller mangelfuldt.

Eksempel:

* tom request body
* ugyldig enum-værdi
* id der ikke findes

---

## Eksempel på fejltest

```java
@Test
void shouldReturn404WhenDogNotFound() {
    given()
        .when()
        .get("/dogs/999")
        .then()
        .statusCode(404);
}
```

Det er vigtigt at teste fejl også — ikke kun når systemet virker.

---

## Typisk test-setup i Javalin

Ofte gør man noget i stil med dette:

* starter en testserver før hver test eller før alle tests
* peger Rest Assured på serverens base URI og port
* rydder testdata op mellem tests

Fx:

```java
import org.junit.jupiter.api.BeforeAll;
import static io.restassured.RestAssured.baseURI;
import static io.restassured.RestAssured.port;

@BeforeAll
static void setup() {
    baseURI = "http://localhost";
    port = 7070;
}
```

Hvis I laver integrationstests, er det en god idé at bruge en separat testdatabase.

---

## Det vigtigste at forstå

Rest Assured tester ikke jeres metoder direkte.
Det tester jeres **HTTP-lag**.

Det betyder, at testen er tættere på virkeligheden end en almindelig unit test.

I tester fx:

* routing
* request parsing
* JSON serialisering/deserialisering
* statuskoder
* response body

Det er derfor super relevant til Javalin.

---

## Kort opsummering til klassen

**Rest Assured** bruges til at sende HTTP-requests i tests.
**Hamcrest** bruges til at formulere forventninger til svaret.
Sammen gør de det muligt at teste vores Javalin endpoints på en læsbar og realistisk måde.

Målet er ikke bare at se om koden “kører”, men om API’et opfører sig korrekt.

---

## Lille kodeeksempel til tavlen

```java
given()
    .when()
    .get("/dogs/1")
    .then()
    .statusCode(200)
    .body("name", equalTo("Fido"));
```

Det kan forklares som:

> “Når jeg kalder endpointet `/dogs/1`, så forventer jeg status 200 og at navnet er Fido.”

---

## Forslag til afsluttende øvelse

Lad de studerende skrive tests til disse endpoints:

* `GET /dogs` → returnerer liste af hunde
* `GET /dogs/{id}` → returnerer én hund
* `POST /dogs` → opretter en hund
* `GET /dogs/999` → returnerer 404

De skal mindst teste:

* statuskode
* et eller flere JSON-felter
* et fejlscenarie
