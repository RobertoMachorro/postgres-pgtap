# postgres-pgtap
A developer version of Postgres that allows testing via pgTap.

## Setup

Run the image (Docker, Kubernetes, etc).

```
docker run -d -e POSTGRES_PASSWORD=..... -p 5432:5432 postgres-pgtap:latest
```

Log into your database, and add the extension as follows, once the image is deployed.

```sql
CREATE EXTENSION pgtap;
```
