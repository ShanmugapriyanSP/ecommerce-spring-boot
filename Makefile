NAMESPACE = ecommerce

# -----------------------------------------------------------------------------
# services for local run
keycloak:
	kc.bat start-dev --http-port=8090

zipkin:
	docker run -d -p 9411:9411 openzipkin/zipkin:latest

export-keycloak:
	kc.bat export --dir realms

# ------------------------------------------------------------------------------
# Kube Dashboard
start-kube-dashboard:
	helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard

dashboard-get-pods:
	kubectl -n kubernetes-dashboard get pods

dashboard-forward-port:
	kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard-kong-proxy 8443:443

restart-dashboard:
	kubectl -n kubernetes-dashboard rollout restart deployment

create-token:
	kubectl -n kubernetes-dashboard create token admin-user

# ----------------------------------------------------------------------------------------------
# Infra & Microservices
deploy-infra:
	kubectl -n $(NAMESPACE) apply --recursive -f ./k8s/infrastructure

delete-infra:
	kubectl -n $(NAMESPACE) delete --recursive -f ./k8s/infrastructure

deploy-microservices:
	kubectl -n $(NAMESPACE) apply --recursive -f ./k8s/services

delete-microservices:
	kubectl -n $(NAMESPACE) delete --recursive -f ./k8s/services

get-pods:
	kubectl -n $(NAMESPACE) get pods

