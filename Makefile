image_name ?= telegram-bot-api
image_tag ?= $(shell date +%Y%m%d)
source_repo ?= https://github.com/Dedrimer/telegram-bot-api.git
source_ref ?= master

.PHONY: build
build:
	docker build -t $(image_name):$(image_tag) \
		--build-arg TELEGRAM_BOT_API_REPOSITORY=$(source_repo) \
		--build-arg TELEGRAM_BOT_API_REF=$(source_ref) \
		--build-arg nproc=$(shell nproc) .
	docker tag $(image_name):$(image_tag) $(image_name):latest

.PHONY: publish
publish:
	docker push $(image_name):$(image_tag)
	docker push $(image_name):latest

.PHONY: release
release: update build publish
