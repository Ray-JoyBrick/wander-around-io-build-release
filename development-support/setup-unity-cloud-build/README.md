# Overivew

## Develop Support

### Unity Cloud Build

專案確定是會用Unity Cloud Build進行，故在專案開始時就可以設定基本的專案資料，並於設定改變時進行更新。

### Unity Remote Config

開發Unity專案時如果用到Unity Remote Config，則會有二個地方需要進行修正。

- Unity Project
- Remote

最好的方式是利用json或是yaml檔將config的key-value記錄下來，並且利用script或是docker進行Remote更新。

其實不只是Unity Remote Config，這樣的想法一樣是可以套用到Firebase Remote Config上。

## Script to Call

```sh
apiKey=$(cat "./secret-info/credentials/unity-cloud-build/api-key.txt") \
    && orgid="apprenticegc" \
    && curl \
        -X GET \
        -H "Authorization: Basic $apiKey" \
        https://build-api.cloud.unity3d.com/api/v1/orgs/$orgid/billingplan

curl
  -X GET
  -H "Content-Type: application/json"
  -H "Authorization: Basic [YOUR API KEY]"
  https://build-api.cloud.unity3d.com/api/v1/orgs/{orgid}/projects/{projectid}/buildtargets/{buildtargetid}/auditlog
```

Create project using the following

```sh
time DOCKER_BUILDKIT=1 docker image build -t setup-ucb:latest --no-cache --build-arg API_KEY="$(cat './secret-info/credentials/unity-cloud-build/api-key.txt')" --build-arg ORG_ID="apprenticegc" --build-arg JSON_FILE_PATH="create-project-build-release.json" -f ./development-support/setup-unity-cloud-build/Dockerfile-create-project .

docker container run -it setup-ucb /bin/sh
```

```sh
time DOCKER_BUILDKIT=1 docker image build -t setup-ucb:latest --no-cache --build-arg API_KEY="$(cat './secret-info/credentials/unity-cloud-build/api-key.txt')" --build-arg ORG_ID="apprenticegc" --build-arg JSON_FILE_PATH="create-project-build-asset.json" -f ./development-support/setup-unity-cloud-build/Dockerfile-create-project .

docker container run -it setup-ucb /bin/sh
```

Create build target

```sh
time DOCKER_BUILDKIT=1 docker image build -t setup-ucb:latest --no-cache --build-arg API_KEY="$(cat './secret-info/credentials/unity-cloud-build/api-key.txt')" --build-arg ORG_ID="apprenticegc" --build-arg PROJECT_ID="0ffad09b-fd57-48c9-ba9c-76114728b094" --build-arg JSON_FILE_PATH="create-build-release-build-target.json" -f ./development-support/setup-unity-cloud-build/Dockerfile-create-build-target .

docker container run -it setup-ucb /bin/sh
```
