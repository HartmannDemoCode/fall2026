---
title: "JPA setup in IntelliJ"
description: "How to setup JPA in IntelliJ"
weight: 2
draft: false
---

## Technologies

- Maven
- Java 17
- JPA
- Hibernate (implementation of JPA)
- PostgresSQL

## How-to

### 1. Open IntelliJ and create a new project

### 2. Select Maven and Java 17 or higher

### 3. In advanced settings, add groupId

### 4. Click finish

![Setup](../images/intellij-new-project-dialogue.png)

### 5. Overwrite the `pom.xml` file with the following content

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>app</groupId>
    <artifactId>delphi</artifactId>
    <version>1.0-SNAPSHOT</version>

    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <lombok.version>1.18.42</lombok.version>
        <hibernate-version>7.2.3.Final</hibernate-version>
        <junit.version>6.0.2</junit.version>
        <postgres.version>42.7.7</postgres.version>
        <testcontainers.version>2.0.3</testcontainers.version>
        <logback-classic>1.5.27</logback-classic>
        <org.slf4j>2.0.17</org.slf4j>
        <hamcrest>3.0</hamcrest>
    </properties>

    <dependencies>

        <!--  DB    -->
        <dependency>
            <groupId>org.postgresql</groupId>
            <artifactId>postgresql</artifactId>
            <version>${postgres.version}</version>
        </dependency>
        <dependency>
            <groupId>org.hibernate.orm</groupId>
            <artifactId>hibernate-core</artifactId>
            <version>${hibernate-version}</version>
        </dependency>

        <dependency>
            <groupId>org.hibernate.orm</groupId>
            <artifactId>hibernate-hikaricp</artifactId>
            <version>${hibernate-version}</version>
        </dependency>

        <!--  LOMBOK    -->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <version>${lombok.version}</version>
            <scope>provided</scope>
        </dependency>

        <!--  TESTING      -->
        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter-api</artifactId>
            <version>${junit.version}</version>
            <scope>test</scope>
        </dependency>

        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter-engine</artifactId>
            <version>${junit.version}</version>
            <scope>test</scope>
        </dependency>

        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter-params</artifactId>
            <version>${junit.version}</version>
            <scope>test</scope>
        </dependency>
        
        <dependency>
            <groupId>org.hamcrest</groupId>
            <artifactId>hamcrest</artifactId>
            <version>${hamcrest}</version>
            <scope>test</scope>
        </dependency>
        
        <dependency>
            <groupId>org.testcontainers</groupId>
            <artifactId>testcontainers</artifactId>
            <version>${testcontainers.version}</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.testcontainers</groupId>
            <artifactId>testcontainers-postgresql</artifactId>
            <version>${testcontainers.version}</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.testcontainers</groupId>
            <artifactId>testcontainers-jdbc</artifactId>
            <version>${testcontainers.version}</version>
        </dependency>
        <dependency>
            <groupId>org.testcontainers</groupId>
            <artifactId>testcontainers-junit-jupiter</artifactId>
            <version>${testcontainers.version}</version>
            <scope>test</scope>
        </dependency>

        <!--  Logging   -->

        <dependency>
            <groupId>ch.qos.logback</groupId>
            <artifactId>logback-classic</artifactId>
            <version>${logback-classic}</version>
        </dependency>
        <dependency>
            <groupId>org.slf4j</groupId>
            <artifactId>slf4j-api</artifactId>
            <version>${org.slf4j}</version>
        </dependency>
    </dependencies>

</project>
```

### 6. Create a package called `app.config` and add these four classes

    - `EntityRegistry`
    - `HibernateBaseProperties`
    - `HibernateConfig`
    - `HibernateEmfBuilder`

There they go:

**EntityRegistry.java**

```java
package app.config;

import app.entities.Study;
import org.hibernate.cfg.Configuration;

final class EntityRegistry {

    private EntityRegistry() {}

    static void registerEntities(Configuration configuration) {
        configuration.addAnnotatedClass(Study.class);
        // TODO: Add more entities here...
    }
}
```

**HibernateBaseProperties.java**

```java
package app.config;

import java.util.Properties;

final class HibernateBaseProperties {

    private HibernateBaseProperties() {}

    static Properties createBase() {
        Properties props = new Properties();
        props.put("hibernate.connection.driver_class", "org.postgresql.Driver");
        props.put("hibernate.current_session_context_class", "thread");
        props.put("hibernate.show_sql", "false");
        props.put("hibernate.format_sql", "false");
        props.put("hibernate.use_sql_comments", "false");
        props.put("hibernate.hikari.maximumPoolSize", "10");
        props.put("hibernate.hikari.minimumIdle", "2");
        props.put("hibernate.hikari.connectionTimeout", "20000");
        return props;
    }
}
```

**HibernateConfig.java**

```java
package app.config;

import app.utils.Utils;
import jakarta.persistence.EntityManagerFactory;

import java.util.Properties;

public final class HibernateConfig {

    private static volatile EntityManagerFactory emf;

    private HibernateConfig() {}

    public static EntityManagerFactory getEntityManagerFactory() {
        if (emf == null) {
            synchronized (HibernateConfig.class) {
                if (emf == null) {
                    emf = HibernateEmfBuilder.build(buildProps());
                }
            }
        }
        return emf;
    }

    private static Properties buildProps() {
        Properties props = HibernateBaseProperties.createBase();

        // Teaching-friendly default - change to update in production
        props.put("hibernate.hbm2ddl.auto", "create");

        if (System.getenv("DEPLOYED") != null) {
            setDeployedProperties(props);
        } else {
            setDevProperties(props);
        }
        return props;
    }

    private static void setDeployedProperties(Properties props) {
        String dbName = System.getenv("DB_NAME");
        props.setProperty("hibernate.connection.url", System.getenv("CONNECTION_STR") + dbName);
        props.setProperty("hibernate.connection.username", System.getenv("DB_USERNAME"));
        props.setProperty("hibernate.connection.password", System.getenv("DB_PASSWORD"));
    }

    private static void setDevProperties(Properties props) {
        String dbName = Utils.getPropertyValue("DB_NAME", "config.properties");
        String username = Utils.getPropertyValue("DB_USERNAME", "config.properties");
        String password = Utils.getPropertyValue("DB_PASSWORD", "config.properties");

        props.put("hibernate.connection.url", "jdbc:postgresql://localhost:5432/" + dbName);
        props.put("hibernate.connection.username", username);
        props.put("hibernate.connection.password", password);
    }
}
```

**HibernateEmfBuilder.java**

```java
package app.config;

import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;

import jakarta.persistence.EntityManagerFactory;
import java.util.Properties;

// This class is just a factory that converts properties into an EntityManagerFactory

final class HibernateEmfBuilder {

    private HibernateEmfBuilder() {}

    static EntityManagerFactory build(Properties props) {
        try {
            Configuration configuration = new Configuration();
            configuration.setProperties(props);

            // Register entities to make Hibernate aware
            EntityRegistry.registerEntities(configuration);

            ServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder()
                    .applySettings(configuration.getProperties())
                    .build();

            // Make JPA compliant version of Hibernates sf
            SessionFactory sf = configuration.buildSessionFactory(serviceRegistry);
            return sf.unwrap(EntityManagerFactory.class);

        } catch (Throwable ex) {
            System.err.println("Initial SessionFactory creation failed: " + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }
}
```

### 7. Add a package called `app.utils` and one called `app.exceptions`

Create this custom exception to have a more specific exception type for our app:

**ApiException.java**

```java
package app.exceptions;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ApiException extends RuntimeException {
    private int code;
    private static final Logger logger = LoggerFactory.getLogger(ApiException.class);

    public ApiException(int code, String msg){
        super(msg);
        this.code = code;
        logger.error("ApiException (code={}): {}", code, msg);
    }
    public int getCode(){
        return code;
    }
}
```

**Utils.java**

Add this utility class to read properties from a file. This is used in the HibernateConfig to read DB connection values in dev:

```java
    package app.utils;

    import app.exceptions.ApiException;

    import java.io.IOException;
    import java.io.InputStream;
    import java.util.Properties;

    public class Utils {

        public static String getPropertyValue(String propName, String resourceName)  {
            try (InputStream is = Utils.class.getClassLoader().getResourceAsStream(resourceName)) {
                Properties prop = new Properties();
                prop.load(is);

                String value = prop.getProperty(propName);
                if (value != null) {
                    return value.trim();  // Trim whitespace
                } else {
                    throw new ApiException(500, String.format("Property %s not found in %s", propName, resourceName));
                }
            } catch (IOException ex) {
                throw new ApiException(500, String.format("Could not read property %s.", propName));
            }
        }
    }
```

### 8. In the `resource` folder, add a configuration called: `config.properties'

```plaintext
DB_NAME=name_of_your_db
DB_USERNAME=postgres
DB_PASSWORD=postgres
```

### 9. Add a proper .gitignore file

- [https://gist.github.com/jonbertelsen/48bfceee0efa71eacc2c87773aa0d4d7](https://gist.github.com/jonbertelsen/48bfceee0efa71eacc2c87773aa0d4d7)

### 10. Create a database in Postgres with the same name as in the config.properties file

That's it! You should now have a working JPA/Hibernate setup. Now it's time to create your first entity and DAO to see how to work with the database with JPA. Check out the tutorial for that: [JPA/Hibernate Micro-Series](../jpa-setup-tutorial).

### 11. Limit the log chatter from Hibernate by adding a `logback.xml` file to the `resources` folder with this content

Hibernate is very verbose in its logging, so we will set the log level to `WARN` for Hibernate and Testcontainers to reduce the noise in the console. You can adjust the log levels as needed for debugging purposes.

```xml
<configuration>

    <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>%msg%n</pattern>
        </encoder>
    </appender>

    <!-- Default level for everything -->
    <root level="INFO">
        <appender-ref ref="STDOUT"/>
    </root>

    <!-- Silence noisy frameworks -->
    <logger name="org.hibernate" level="WARN"/>
    <logger name="org.testcontainers" level="WARN"/>
    <logger name="com.github.dockerjava" level="WARN"/>

</configuration>
```
