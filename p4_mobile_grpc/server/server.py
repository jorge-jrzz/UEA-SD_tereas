from UberService import UberService

from protos import ride_service_pb2
from protos import ride_service_pb2_grpc
from concurrent import futures
import grpc

def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    ride_service_pb2_grpc.add_RideServiceServicer_to_server(RideServiceServicer(), server)
    server.add_insecure_port("[::]:50051")
    print("Server is running on port 50051...")
    server.start()
    server.wait_for_termination()

if __name__ == "__main__":
    serve()
