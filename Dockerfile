ARG nimVersion
FROM nimlang/nim:${nimVersion}
VOLUME /app
WORKDIR /app
RUN apt-get update && apt-get install -y upx
