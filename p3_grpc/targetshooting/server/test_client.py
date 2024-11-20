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


if __name__ == "__main__":
    logging.basicConfig()
    run()
