AVRO_SRC_DIR := api/avro
PROTO_SRC_DIR := api/proto
GEN_AVRO_DIR := gen/go/avro
GEN_PROTO_DIR := gen/go/proto

PROTOC_GEN_GO_VERSION=v1.30.0
PROTOC_GEN_GO_GRPC_VERSION=v1.3.0

PROTOC_INCLUDE_DIRS=\
	-I$(PROTO_SRC_DIR)

PROTO_FILES=$(shell find $(PROTO_SRC_DIR) -name '*.proto')


proto:
	protoc $(PROTOC_INCLUDE_DIRS) \
	       --go_out=$(GEN_PROTO_DIR) --go_opt=paths=source_relative \
	       --go-grpc_out=$(GEN_PROTO_DIR) --go-grpc_opt=paths=source_relative \
	       $(PROTO_FILES) \
	       --experimental_allow_proto3_optional

avro:
	mkdir -p $(GEN_AVRO_DIR)/user
	gogen-avro $(GEN_AVRO_DIR)/user $(AVRO_SRC_DIR)/user/user_created.avsc
	gogen-avro $(GEN_AVRO_DIR)/user $(AVRO_SRC_DIR)/user/user_email_changed.avsc
	gogen-avro $(GEN_AVRO_DIR)/user $(AVRO_SRC_DIR)/user/user_password_reset.avsc

generate: avro proto