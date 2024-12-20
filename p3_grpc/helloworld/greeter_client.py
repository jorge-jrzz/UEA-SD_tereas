# Copyright 2015 gRPC authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
"""The Python implementation of the GRPC helloworld.Greeter client."""

from __future__ import print_function

import logging

import grpc
import helloworld_pb2
import helloworld_pb2_grpc


def run():
    # NOTE(gRPC Python Team): .close() is possible on a channel and should be
    # used in circumstances in which the with statement does not fit the needs
    # of the code.
    print("Will try to greet world ...")

    date = {'day': 1, 'month': 1, 'year': 2020}
    days_to_sum = 65

    with grpc.insecure_channel('localhost:50051') as channel:
        stub = helloworld_pb2_grpc.GreeterStub(channel)
        response = stub.SayHello(helloworld_pb2.HelloRequest(name='you'))
        print("Greeter client received: " + response.message)
        response = stub.SayHelloAgain(helloworld_pb2.HelloRequest(name='you'))
        print("Greeter client received: " + response.message)
        
        # Servicios de manipulación de fechas
        response = stub.GetNextDay(helloworld_pb2.NextDayRequest(day=date['day'], month=date['month'], year=date['year']))
        print(f"Fecha actual: {date['day']}/{date['month']}/{date['year']}")
        print(f"Fecha siguiente: {response.day}/{response.month}/{response.year}")

        response = stub.SumDaysDate(helloworld_pb2.SumDaysRequest(day=date['day'], month=date['month'], year=date['year'], days=days_to_sum))
        print("-" * 40)
        print(f"Fecha actual: {date['day']}/{date['month']}/{date['year']}")
        print(f"Sumando {days_to_sum} días: {response.day}/{response.month}/{response.year}")


if __name__ == "__main__":
    logging.basicConfig()
    run()
