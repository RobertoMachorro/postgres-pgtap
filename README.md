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

## Images

Both images are published to `ghcr.io/robertomachorro/postgres-pgtap`:

| Variant | Dockerfile | Tag |
| --- | --- | --- |
| Standard (official `postgres` base) | `Dockerfile` | `latest` |
| CloudNative-PG | `Dockerfile.cnpg` | `latest-cnpg` |

Each image is rebuilt only when its own Dockerfile changes (or on a `v*.*.*` release tag, or manually via "Run workflow").

## CloudNative-PG

Point your CNPG `Cluster` at the `-cnpg` image:

```yaml
apiVersion: postgresql.cnpg.io/v1
kind: Cluster
metadata:
  name: pgtap
spec:
  instances: 1
  imageName: ghcr.io/robertomachorro/postgres-pgtap:latest-cnpg
  storage:
    size: 1Gi
```

Then enable the extension the same way:

```sql
CREATE EXTENSION pgtap;
```
