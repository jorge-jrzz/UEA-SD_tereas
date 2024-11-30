from UberEntity import Uber
import grpc
from protos import ride_service_pb2
from protos import ride_service_pb2_grpc
import random
class UberService(ride_service_pb2_grpc.RideServiceServicer):
    def __init__(self):
        # Init all cars available
        self.cars = [Uber(i, True) for i in range(0, 10)]
        self.available_cars = 0  
        self.total_trips = 0
        self.earnings = 0.0

    def GetServiceInfo(self, request, context):
        self.available_cars = sum(car.is_available() for car in self.cars)
        return ride_service_pb2.ServiceInfo(
            available_cars=self.available_cars,
            total_trips=self.total_trips,
            earnings=self.earnings,
        )

    def RequestRide(self, request, context):
        available_car = next((car for car in self.cars if car.is_available()), None)
        if available_car:
            available_car.set_availability(False)
            self.total_trips += 1
            self.earnings += 25.00  # Simulated ride cost
            ride_time = random.randint(0, 5)
            return ride_service_pb2.RideResponse(
                success=True,
                message="Ride confirmed!",
                plate=str(available_car.get_plate()),
                estimated_time=f"{ride_time}",
            )
        else:
            return ride_service_pb2.RideResponse(
                success=False,
                message="No cars available!",
                plate="",
                estimated_time="0",
            )
        
    def EndRide(self, request, context):
        car = next((car for car in self.cars if car.get_plate() == int(request.plate)), None)
        if car:
            car.set_availability(True)
            return ride_service_pb2.EndRideResponse(
                success=True,
                message="Ride ended successfully!",
            )
        else:
            return ride_service_pb2.EndRideResponse(
                success=False,
                message="Car not found!",
            )
        '''
        if self.available_cars >= 0:
            self.available_cars -= 1
            self.total_trips += 1
            self.earnings += 25.00  # Simulated ride cost
            ride_time = random.randint(0, 5)
            current_plate = str(self.cars[0].get_plate())
            return ride_service_pb2.RideResponse(
                success=True,
                message="Ride confirmed!",
                plate=current_plate,
                estimated_time=f"{ride_time}"
            )
        else:
            return ride_service_pb2.RideResponse(
                success=False,
                message="No cars available!",
                estimated_time="0"
            )
        '''
        '''
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
        '''
