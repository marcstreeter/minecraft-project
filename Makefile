KUBE_CONTEXT=local
NAMESPACE=yicraft
.PHONY: label up check-server check-proxy

check-curl:
	@which curl > /dev/null || (echo "curl is not installed, in what world do you live in?"; exit 1)

check-jq:
	@which jq > /dev/null || (echo "jq is not installed, use 'brew install jq' to proceed."; exit 1)

with_ctx:
	@kubectl config use-context $(KUBE_CONTEXT)

with_ns: with_ctx
	@if echo "$(shell kubectl get ns -o=name --no-headers)" | grep -q $(NAMESPACE); then \
		echo "Namespace '$(NAMESPACE)' exists."; \
	else \
		echo "Namespace '$(NAMESPACE)' does not exist."; \
		exit 1; \
	fi

label: with_ctx
	@for node in k3sruth k3sluke k3sjane k3snena k3sjose; do \
		kubectl label nodes $$node pow=hi; \
	done

up: with_ns
	kubectl -n $(NAMESPACE) apply -f kubernetes/

down: with_ns
	kubectl -n $(NAMESPACE) delete -f kubernetes/

check-server: check-jq check-curl
	@curl -s https://api.papermc.io/v2/projects/paper/ \
	| jq '.versions | .[-3:]' \
	| jq  --raw-output '.[]' \
	| xargs -I {} curl -s "https://api.papermc.io/v2/projects/paper/versions/{}/builds/" \
	| jq --raw-output '.builds | max_by(.build) | .downloads.application.name'

check-proxy: check-jq check-curl
	@curl -s https://api.papermc.io/v2/projects/waterfall/ \
	| jq '.versions | .[-3:]' \
	| jq  --raw-output '.[]' \
	| xargs -I {} curl -s "https://api.papermc.io/v2/projects/waterfall/versions/{}/builds/" \
	| jq --raw-output '.builds | max_by(.build) | .downloads.application.name'

check-docker: check-jq check-curl
	@echo "you need to figure out how to use this url: https://hub.docker.com/v2/repositories/library/eclipse-temurin/tags/?page_size=25&page=1&name=jdk&ordering"