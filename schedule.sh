#! /bin/bash

declare -A images
images[${#images[@]}]="gcr.io/spark-operator/spark-operator:latest"
images[${#images[@]}]="gcr.io/buildpacks/gcp/run:latest"
images[${#images[@]}]="gcr.io/buildpacks/builder:latest"
images[${#images[@]}]="gcr.io/kaniko-project/executor:latest"
images[${#images[@]}]="gcr.io/kaniko-project/executor:debug"

docker login --username=$DOCKER_USERNAME --password $DOCKER_PASSWORD

for from in "${images[@]}"
do
    to="$DOCKER_USERNAME/`echo "$from" | sed 's|gcr\.io/||g' | sed 's|.*k8s\.io/||g' | sed 's|/|-|g'`"
    docker pull $from
    docker tag $from $to
    docker push $to
done