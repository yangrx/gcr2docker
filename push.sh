#! /bin/bash

declare -A images
images[${#images[@]}]="gcr.io/spark-operator/spark:v3.1.1"
images[${#images[@]}]="registry.k8s.io/sig-storage/csi-provisioner:v2.2.2"
images[${#images[@]}]="registry.k8s.io/sig-storage/livenessprobe:v2.5.0"
images[${#images[@]}]="registry.k8s.io/sig-storage/nfsplugin:v3.1.0"
images[${#images[@]}]="registry.k8s.io/sig-storage/csi-node-driver-registrar:v2.4.0"

docker login --username=$DOCKER_USERNAME --password $DOCKER_PASSWORD

for from in "${images[@]}"
do
    to="$DOCKER_USERNAME/`echo "$from" | sed 's|gcr\.io/||g' | sed 's|.*k8s\.io/||g' | sed 's|/|-|g'`"
    docker pull $from
    docker tag $from $to
    docker push $to
done