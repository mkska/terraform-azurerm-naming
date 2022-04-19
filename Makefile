.POSIX:

.PHONY: all
all: build format validate

.PHONY: install
install:
	command -v terraform >/dev/null 2>&1 || GO111MODULE="on" go get github.com/hashicorp/terraform@v1.1.8
	command -v terraform-docs >/dev/null 2>&1 || GO111MODULE="on" go get github.com/segmentio/terraform-docs@v0.16.0
	command -v tfsec >/dev/null 2>&1 || GO111MODULE="on" go get github.com/aquasecurity/tfsec/cmd/tfsec@v1.18.0
	command -v tflint >/dev/null 2>&1 || GO111MODULE="on" go get github.com/terraform-linters/tflint@v0.35.0

.PHONY: build
build: install generate

.PHONY: generate
generate:
	go run main.go

.PHONY: format
format:
	terraform fmt

.PHONY: validate
validate:
	terraform fmt --check
	terraform validate -no-color
	tflint --no-color