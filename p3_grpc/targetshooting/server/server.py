import math
from random import randint
from concurrent import futures
import logging

import grpc
import shooting_pb2
import shooting_pb2_grpc


class Shooting(shooting_pb2_grpc.ShootingServicer):
    
    user_shoots = []
    target_center = randint(20, 100)

    @staticmethod
    def _calculate_distance(v, t):
        g = 9.81
        
        # Validar que el ángulo esté dentro del rango permitido
        if t < 0 or t > math.pi / 2:
            raise ValueError("El ángulo t debe estar entre 0 y π/2 radianes. (0° - 90°)")
        
        # Calcular distancia
        d = (v ** 2) * math.sin(2 * t) / g
        return d

    def DimeCentroDiana(self, request, context):
        return shooting_pb2.CentroReply(distance=self.target_center)
    
    def DisparaCannon(self, request, context):
        try:
            speed = request.speed
            angle = math.radians(request.angle)
            distance = self._calculate_distance(speed, angle)
        except Exception as e:
            raise Exception(f"Calculation error: {e}")
        shoot_distance = self.target_center - distance
        self.user_shoots.append({'username': request.username, 'distance': shoot_distance})
        is_winner = True if abs(shoot_distance) <= 1 else False
        return shooting_pb2.DisparaReply(shoot_distance=shoot_distance, is_winner=is_winner)
    
    def MejorDisparo(self, request, context):
        if len(self.user_shoots) == 0:
            return shooting_pb2.BestShotReply(username="No hay disparos")
        else:
            best_shot = min(self.user_shoots, key=lambda x: abs(x['distance']))
            return shooting_pb2.BestShotReply(username=best_shot['username'])


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
