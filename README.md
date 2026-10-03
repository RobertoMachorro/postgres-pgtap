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

CNPG derives the PostgreSQL major version from the `imageName` tag, which `latest-cnpg` doesn't carry. Declare it through an `ImageCatalog` and reference that from the `Cluster`:

```yaml
apiVersion: postgresql.cnpg.io/v1
kind: ImageCatalog
metadata:
  name: postgres-pgtap
spec:
  images:
    - major: 18
      image: ghcr.io/robertomachorro/postgres-pgtap:latest-cnpg
---
apiVersion: postgresql.cnpg.io/v1
kind: Cluster
metadata:
  name: pgtap
spec:
  instances: 1
  imageCatalogRef:
    apiGroup: postgresql.cnpg.io
    kind: ImageCatalog
    name: postgres-pgtap
    major: 18
  storage:
    size: 1Gi
```

Then enable the extension the same way:

```sql
CREATE EXTENSION pgtap;
```
