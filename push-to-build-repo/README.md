# Overview

以下是實際用kms產生此專案加密檔案的步驟，這些都可在GCP的Console裡進行，而檔案可以隨需要上傳或是下載來使用

```sh
# Just check keyring
gcloud kms keyrings list --location global

# Create keyring
gcloud kms keyrings create joybrick-wander-around-io-development --location global

# Create key
gcloud kms keys create access-git-key --location global --keyring joybrick-wander-around-io-development --purpose encryption

gcloud kms keys list --location global --keyring joybrick-wander-around-io-development

# Add permission to key
gcloud kms keys add-iam-policy-binding access-git-key \
  --location global \
  --keyring joybrick-wander-around-io-development \
  --member serviceAccount:use-kms@wander-around-io.iam.gserviceaccount.com \
  --role roles/cloudkms.cryptoKeyEncrypterDecrypter

# Encrypt github ssh key
gcloud kms encrypt --location global \
  --keyring joybrick-wander-around-io-development \
  --key access-git-key \
  --ciphertext-file rayjb_github_rsa.enc \
  --plaintext-file ./rayjb_github_rsa

# Encrypt gitlab ssh key
gcloud kms encrypt --location global \
  --keyring joybrick-wander-around-io-development \
  --key access-git-key \
  --ciphertext-file rayjb_gitlab_rsa.enc \
  --plaintext-file ./rayjb_gitlab_rsa
```

在game-unity目錄下直接執行以下的bash command，可以建置relase版本

```sh
time DOCKER_BUILDKIT=1 docker image build -t waio-push-build-release:latest --no-cache --build-arg SERVICE_NAME_KMS="use-kms" --build-arg SERVICE_NAME_STORAGE="use-storage" --build-arg PROJECT_ID="wander-around-io" --build-arg JSON_FILE_KEYFILE_KMS="$(cat ./secret-info/credentials/gcp/keyfile-kms.json)" --build-arg JSON_FILE_KEYFILE_STORAGE="$(cat ./secret-info/credentials/gcp/keyfile-storage.json)" --build-arg GCS_BUCKET="joybrick-wander-around-io-dev" --build-arg COMMIT_MESSAGE="Commit for build" -f ./push-to-build-repo/Dockerfile-release .

# time DOCKER_BUILDKIT=1 docker image build -t push-build-release:latest --no-cache -f ./push-build-release/Dockerfile .

# Use interactive shell to interact with docker if there is any conflict
docker container run -it waio-push-build-release /bin/sh
```

在game-unity目錄下直接執行以下的bash command，可以建置asset版本

```sh
time DOCKER_BUILDKIT=1 docker image build -t waio-push-build-asset:latest --no-cache --build-arg SERVICE_NAME_KMS="use-kms" --build-arg SERVICE_NAME_STORAGE="use-storage" --build-arg PROJECT_ID="wander-around-io" --build-arg JSON_FILE_KEYFILE_KMS="$(cat ./secret-info/credentials/gcp/keyfile-kms.json)" --build-arg JSON_FILE_KEYFILE_STORAGE="$(cat ./secret-info/credentials/gcp/keyfile-storage.json)" --build-arg GCS_BUCKET="joybrick-wander-around-io-dev" --build-arg COMMIT_MESSAGE="Commit for build" -f ./push-to-build-repo/Dockerfile-asset .

docker container run -it waio-push-build-asset /bin/sh
```
