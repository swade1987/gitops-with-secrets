SHELL = /bin/sh
UNAME := $(shell uname -s)
KUBESEAL_VERSION = v0.12.1

init:
ifeq ($(UNAME),Darwin)
	wget https://github.com/bitnami-labs/sealed-secrets/releases/download/${KUBESEAL_VERSION}/kubeseal-darwin-amd64
	wget https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_darwin_amd64
	sudo install -m 755 kubeseal-darwin-amd64 /usr/local/bin/kubeseal
	sudo install -m 755 yq_darwin_amd64 /usr/local/bin/yq
	rm -f kubeseal-darwin-amd64 yq_darwin_amd64
endif
ifeq ($(UNAME),Linux)
	wget https://github.com/bitnami-labs/sealed-secrets/releases/download/${KUBESEAL_VERSION}/kubeseal-linux-amd64
	wget https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64
	sudo install -m 755 kubeseal-linux-amd64 /usr/local/bin/kubeseal
	sudo install -m 755 yq_linux_amd64 /usr/local/bin/yq
	rm  -f kubeseal-linux-amd64 yq_linux_amd64
endif

cluster:
	k3d create cluster --workers 4 --name gitops

destroy:
	k3d delete --name="gitops"

install-flux:
	./scripts/flux-init.sh

get-public-key:
	kubeseal --fetch-cert > keys/dev.crt

seal-%:
	./scripts/seal-secrets.sh $*

clean-%:
	rm local*/$*/*.yaml

clean:
	rm local*/*/*.yaml
