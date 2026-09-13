This is a starter repo for https://se-education.org/guides/tutorials/javaFx.html

## Build in Docker

This project includes a Docker container with Java 25 and JavaFX 25 installed. The compose setup mounts the entire project at `/workspace` inside the container.

Build everything:

```bash
docker compose run --rm java25-javafx
```

Run any Gradle task inside the same container:

```bash
docker compose run --rm java25-javafx ./gradlew test
docker compose run --rm java25-javafx ./gradlew shadowJar
```

Open an interactive shell with the project attached:

```bash
docker compose run --rm java25-javafx bash
```
