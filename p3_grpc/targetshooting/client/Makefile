# Archivos IDL
PROTO_DIR = proto
PROTO_FILE = $(PROTO_DIR)/shooting.proto
GEN_FILES = shooting.pb.dart shooting.pbenum.dart shooting.pbgrpc.dart shooting.pbjson.dart
GEN_DIR = lib/src/generated

# Regla para actualizar el codigo generado por gRPC
grpc:
	protoc --dart_out=grpc:lib/src/generated -$(PROTO_DIR) $(PROTO_FILE)

# Regla para eliminar archivos generados por gRPC
clean:
	rm -f $(GEN_DIR)/*.dart
