.PHONY: create-token

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

restart-dashboard:
	kubectl -n kubernetes-dashboard rollout restart deployment

create-token:
	kubectl -n kubernetes-dashboard create token admin-user > temp_token.txt

# ----------------------------------------------------------------------------------------------
# Infra & Microservices
create-config:
	kubectl -n $(NAMESPACE) create configmap prometheus-config --from-file=prometheus/prometheus.yml
	kubectl -n $(NAMESPACE) create configmap keycloak-config --from-file=realms/ecommerce-realm.json

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

# --------------------------------------------------------------------------------------------------------------------
# K8s Port Forwarding

dashboard-forward-port:
	kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard-kong-proxy 8443:443

keycloak-forward-port:
	kubectl -n $(NAMESPACE) port-forward keycloak-584579b69b-n44hd 8080:8080

product-forward-port:
	kubectl -n $(NAMESPACE) port-forward product-service-cc899d97b-f6p2q 9194:8080

order-forward-port:
	kubectl -n $(NAMESPACE) port-forward order-service-6bccb5d57b-zv59r 9193:8080

inventory-forward-port:
	kubectl -n $(NAMESPACE) port-forward inventory-service-6b55785cd9-mxf84 9191:8080
