from __future__ import print_function

import logging

import grpc
import shooting_pb2
import shooting_pb2_grpc
from google.protobuf.empty_pb2 import Empty


def run():
    print("Hello Human 🗿")
    with grpc.insecure_channel('localhost:50051') as channel:
        stub = shooting_pb2_grpc.ShootingStub(channel)
        response = stub.DimeCentroDiana(Empty())
        print("Distancia random {}".format(response.distance))
        response = stub.DisparaCannon(shooting_pb2.DisparaRequest(username="juanito", angle=45, speed=100))
        print(f"Respuesta: {response.shoot_distance:.2f}")


if __name__ == "__main__":
    logging.basicConfig()
    run()