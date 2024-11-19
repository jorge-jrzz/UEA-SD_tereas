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
"""The Python implementation of the GRPC helloworld.Greeter server."""

from datetime import datetime, timedelta
from concurrent import futures
import logging

import grpc
import helloworld_pb2
import helloworld_pb2_grpc


class Greeter(helloworld_pb2_grpc.GreeterServicer):
    def SayHello(self, request, context):
        return helloworld_pb2.HelloReply(message="Hello, %s!" % request.name)
    
    def SayHelloAgain(self, request, context):
        return helloworld_pb2.HelloReply(message=f"Hello again, {request.name}!")
    
    def GetNextDay(self, request, context):
        date = datetime(year=request.year, month=request.month, day=request.day)
        next_day = date + timedelta(days=1)
        return helloworld_pb2.NextDayReply(day=next_day.day, month=next_day.month, year=next_day.year)
    
    def SumDaysDate(self, request, context):
        current_date = {'day': request.day, 'month': request.month, 'year': request.year}
        for _ in range(request.days):
            next_date = self.GetNextDay(
                helloworld_pb2.NextDayRequest(
                    day=current_date['day'], 
                    month=current_date['month'], 
                    year=current_date['year']
                ), 
                context)
            current_date = {'day': next_date.day, 'month': next_date.month, 'year': next_date.year}
        return helloworld_pb2.NextDayReply(day=next_date.day, month=next_date.month, year=next_date.year)


def serve():
    port = "50051"
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    helloworld_pb2_grpc.add_GreeterServicer_to_server(Greeter(), server)
    server.add_insecure_port("[::]:" + port)
    server.start()
    print("Server started, listening on " + port)
    server.wait_for_termination()


if __name__ == "__main__":
    logging.basicConfig()
    serve()
