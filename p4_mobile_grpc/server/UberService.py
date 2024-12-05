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
        print("🚗🛠️ Server initialized with 10 cars!")

    def GetServiceInfo(self, request, context):
        self.available_cars = sum(car.is_available() for car in self.cars)
        print(f"📊 Service Info Requested: Available Cars={self.available_cars}, Total Trips={self.total_trips}, Earnings=${self.earnings:.2f}")
        return ride_service_pb2.ServiceInfo(
            available_cars=self.available_cars,
            total_trips=self.total_trips,
            earnings=self.earnings,
        )

    def RequestRide(self, request, context):
        print("🚕 Ride Request Received!")
        available_car = next((car for car in self.cars if car.is_available()), None)
        if available_car:
            available_car.set_availability(False)
            self.total_trips += 1
            self.earnings += 25.00  # Simulated ride cost
            ride_time = random.randint(0, 5)
            print(f"✅ Ride Confirmed: Plate={available_car.get_plate()}, Estimated Time={ride_time} minutes")
            return ride_service_pb2.RideResponse(
                success=True,
                message="Ride confirmed!",
                plate=str(available_car.get_plate()),
                estimated_time=f"{ride_time}",
            )
        else:
            print("❌ No cars available!")
            return ride_service_pb2.RideResponse(
                success=False,
                message="No cars available!",
                plate="",
                estimated_time="0",
            )
        
    def EndRide(self, request, context):
        print(f"🛑 End Ride Request Received: Plate={request.plate}")
        car = next((car for car in self.cars if car.get_plate() == int(request.plate)), None)
        if car:
            car.set_availability(True)
            print(f"✅ Ride Ended: Plate={request.plate}")
            return ride_service_pb2.EndRideResponse(
                success=True,
                message="Ride ended successfully!",
            )
        else:
            print(f"❌ End Ride Failed: Car with Plate={request.plate} not found")
            return ride_service_pb2.EndRideResponse(
                success=False,
                message="Car not found!",
            )