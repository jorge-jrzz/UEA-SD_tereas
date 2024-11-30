
import grpc
from protos import ride_service_pb2
from protos import ride_service_pb2_grpc

class RideServiceServicer(ride_service_pb2_grpc.RideServiceServicer):
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
            return ride_service_pb2.RideResponse(
                success=True,
                message="Ride confirmed!",
                estimated_time="5 minutes"
            )
        else:
            return ride_service_pb2.RideResponse(
                success=False,
                message="No cars available!",
                estimated_time="N/A"
            )
