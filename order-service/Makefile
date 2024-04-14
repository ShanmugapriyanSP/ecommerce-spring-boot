
start-mysql:
	docker run -d \
      --name mysql-container \
      -p 3333:3306 \
      -e MYSQL_ROOT_PASSWORD=mysql \
      -v $(PWD)/data:/var/lib/mysql \
      mysql

stop:
	docker stop mysql-container

stop-mysql: stop
	docker rm mysql-container

