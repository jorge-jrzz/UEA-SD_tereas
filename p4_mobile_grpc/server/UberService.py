
import grpc
from protos import ride_service_pb2
from protos import ride_service_pb2_grpc
import random
class UberService(ride_service_pb2_grpc.RideServiceServicer):
    def __init__(self):
        self.service_info = {
            "available_cars": 10,
            "total_trips": 120,
            "earnings": 1500.75,
        }

    def GetServiceInfo(self, request, context):
        return ride_service_pb2.ServiceInfo(
            available_cars=self.service_info["available_cars"],
            total_trips=self.service_info["total_trips"],
            earnings=self.service_info["earnings"],
        )

    def RequestRide(self, request, context):
        if self.service_info["available_cars"] > 0:
            self.service_info["available_cars"] -= 1
            self.service_info["total_trips"] += 1
            self.service_info["earnings"] += 25.00  # Simulated ride cost
            ride_time = random.randint(0, 5)
            return ride_service_pb2.RideResponse(
                success=True,
                message="Ride confirmed!",
                estimated_time=f"{ride_time}"
            )
        else:
            return ride_service_pb2.RideResponse(
                success=False,
                message="No cars available!",
                estimated_time="N/A"
            )
