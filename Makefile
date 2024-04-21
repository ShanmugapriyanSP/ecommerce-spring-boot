
keycloak:
	kc.bat start-dev --http-port=8090

zipkin:
	docker run -d -p 9411:9411 openzipkin/zipkin:latest

export-keycloak:
	kc.bat export --dir realms