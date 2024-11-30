import grpc
from protos import ride_service_pb2
from protos import ride_service_pb2_grpc
import time

def run():
    with grpc.insecure_channel("localhost:50051") as channel:
        stub = ride_service_pb2_grpc.RideServiceStub(channel)

        while True:
            print("UBER")
            print("1. Informacion del viaje")
            print("2. Solicitar viaje")
            print("3. Finalizar viaje")
            option = int(input("Selecciona una opcion: "))
            if option == 1:
                # Obtener información del servicio
                response = stub.GetServiceInfo(ride_service_pb2.EmptyRequest())
                print("Service Info:")
                print(f"Available Cars: {response.available_cars}")
                print(f"Total Trips: {response.total_trips}")
                print(f"Earnings: ${response.earnings}")
            elif option == 2:
                # Solicitar un viaje
                ride_request = ride_service_pb2.RideRequest(
                    user_id="12345",
                    ride_type="UBER_X",
                    pickup_location="Location A",
                    dropoff_location="Location B",
                )
                ride_response = stub.RequestRide(ride_request)
                print("\nRide Request Response:")
                print(f"Success: {ride_response.success}")
                print(f"Message: {ride_response.message}")
                print(f"Plate: {ride_response.plate}")
                print(f"Estimated Time: {ride_response.estimated_time}")
                time.sleep(int(ride_response.estimated_time))
                plate = ride_response.plate
                end_request = ride_service_pb2.EndRideRequest(plate=plate)
                end_response = stub.EndRide(end_request)
                print("\nEnd Ride Response:")
                print(f"Success: {end_response.success}")
                print(f"Message: {end_response.message}")

            elif option == 3:
                # Finalizar un viaje
                plate = input("Ingresa la placa del vehículo: ")
                end_request = ride_service_pb2.EndRideRequest(plate=plate)
                end_response = stub.EndRide(end_request)
                print("\nEnd Ride Response:")
                print(f"Success: {end_response.success}")
                print(f"Message: {end_response.message}")

if __name__ == "__main__":
    run()
