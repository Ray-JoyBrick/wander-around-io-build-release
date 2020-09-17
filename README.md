# Overview

```sh
git config --local user.name "FIRST_NAME LAST_NAME"
git config --local user.email "MY_NAME@example.com"
```

```sh
time DOCKER_BUILDKIT=1 docker image build -t waio-references-to-storage:latest --no-cache --build-arg SERVICE_NAME_KMS="use-kms" --build-arg SERVICE_NAME_STORAGE="use-storage" --build-arg PROJECT_ID="wander-around-io" --build-arg JSON_FILE_KEYFILE_KMS="$(cat ./secret-info/credentials/gcp/keyfile-kms.json)" --build-arg JSON_FILE_KEYFILE_STORAGE="$(cat ./secret-info/credentials/gcp/keyfile-storage.json)" --build-arg GCS_BUCKET="joybrick-wander-around-io-dev" -f ./Docker-references-to-storage .

docker container run -it waio-references-to-storage /bin/sh
```
