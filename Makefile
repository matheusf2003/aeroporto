all:
	docker compose up --build -d rabbitmq
	sleep 5
	docker compose up --build

down:
	docker compose down -v
