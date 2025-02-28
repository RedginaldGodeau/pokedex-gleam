ifneq (,$(wildcard ./.env.local))
	include $(wildcard ./.env.local)
	export
endif

ENV_FILE := $(wildcard .env)
LOCAL_ENV_FILE := $(ENV_FILE:%=%.local)
DOCKER_COMPOSE := docker compose

run: $(LOCAL_ENV_FILE)
	@$(DOCKER_COMPOSE) -f docker-compose.yml --env-file .env.local up || true

.PHONY: build
build: $(LOCAL_ENV_FILE)
	@$(DOCKER_COMPOSE) -f docker-compose.yml up --build

down:
	@$(DOCKER_COMPOSE) -f docker-compose.yml down -v

gen-sql: $(LOCAL_ENV_FILE)
	@$(DOCKER_COMPOSE) -f docker-compose.yml --env-file .env.local exec backend gleam run -m squirrel

env: $(LOCAL_ENV_FILE)
	@$(DOCKER_COMPOSE) -f docker-compose.yml --env-file .env.local exec backend env