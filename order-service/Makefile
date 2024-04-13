
mysql:
	docker run -d \
      --name mysql-container \
      -p 3333:3306 \
      -e MYSQL_ROOT_PASSWORD=mysql \
      -v $(PWD)/data:/var/lib/mysql \
      mysql

create:
	docker exec -it <container_id> mysql -u root -p mysql -e "CREATE DATABASE order_service;"
