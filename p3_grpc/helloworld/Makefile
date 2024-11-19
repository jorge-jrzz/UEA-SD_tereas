# Archivos IDL
PROTO_DIR = ./proto
PROTO_FILE = $(PROTO_DIR)/helloworld.proto
GEN_FILES = helloworld_pb2.py helloworld_pb2_grpc.py

# Regla para actualizar el codigo generado por gRPC
grpc:
	python -m grpc_tools.protoc -I$(PROTO_DIR) --python_out=. --grpc_python_out=. $(PROTO_FILE)

# Regla para eliminar archivos generados por gRPC
clean:
	rm -f $(GEN_FILES)
