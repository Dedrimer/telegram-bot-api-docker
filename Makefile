image_name ?= telegram-bot-api
image_tag ?= $(shell date +%Y%m%d)
source_repo ?= https://github.com/Dedrimer/telegram-bot-api.git
source_ref ?= master
dockerfile ?= Dockerfile.compat
debian_version ?= bookworm-slim
alpine_version ?= 3.21

.PHONY: build
build:
	docker build -f $(dockerfile) -t $(image_name):$(image_tag) \
		--build-arg DEBIAN_VERSION=$(debian_version) \
		--build-arg ALPINE_VERSION=$(alpine_version) \
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
