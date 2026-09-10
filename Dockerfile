FROM postgres:18

RUN apt-get update && apt-get install -y --no-install-recommends \
      build-essential git ca-certificates \
    && git clone --depth 1 --branch v1.3.3 https://github.com/theory/pgtap.git /tmp/pgtap \
    && cd /tmp/pgtap && make && make install \
    && apt-get purge -y --auto-remove build-essential git \
    && rm -rf /tmp/pgtap /var/lib/apt/lists/*
