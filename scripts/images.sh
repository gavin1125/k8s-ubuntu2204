#!/bin/bash
repo=registry.aliyuncs.com/google_containers

for name in `kubeadm config images list --kubernetes-version v1.23.3`;
do
    # remove prefix
    src_name=${name#k8s.gcr.io/}
    src_name=${src_name#coredns/}

    sudo docker pull $repo/$src_name

    # rename to fit k8s
    sudo docker tag $repo/$src_name $name
    sudo docker rmi $repo/$src_name
done

# flannel images
#for name in `grep image /vagrant/scripts/flannel.yml |grep -v '#image' | sed 's/image://g' -`;
#do
#    sudo docker pull $name
#done

# check
sudo docker images
