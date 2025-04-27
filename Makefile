PROTO_DIR=proto
OUT_DIR=gen/go

PROTOC_GEN_GO_VERSION=v1.30.0
PROTOC_GEN_GO_GRPC_VERSION=v1.3.0

PROTOC_INCLUDE_DIRS=\
	-I$(PROTO_DIR)

PROTO_FILES=$(shell find $(PROTO_DIR) -name '*.proto')

all: proto

proto:
	protoc $(PROTOC_INCLUDE_DIRS) \
	       --go_out=$(OUT_DIR) --go_opt=paths=source_relative \
	       --go-grpc_out=$(OUT_DIR) --go-grpc_opt=paths=source_relative \
	       $(PROTO_FILES) \
	       --experimental_allow_proto3_optional

.PHONY: all proto
