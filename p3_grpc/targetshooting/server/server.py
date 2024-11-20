from concurrent import futures
import logging
from random import randint

import grpc
import shooting_pb2
import shooting_pb2_grpc


class Shooting(shooting_pb2_grpc.ShootingServicer):
    def DimeCentroDiana(self, request, context):
        return shooting_pb2.CentroReply(distance=randint(20, 100))


def serve():
    port = "50051"
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    shooting_pb2_grpc.add_ShootingServicer_to_server(Shooting(), server)
    server.add_insecure_port("[::]:" + port)
    server.start()
    print("Server started, listening on " + port)
    server.wait_for_termination()


if __name__ == "__main__":
    logging.basicConfig()
    serve()
