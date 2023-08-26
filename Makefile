KUBE_CONTEXT=local
NAMESPACE=yicraft
.PHONY: label up

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