# Generated by the gRPC Python protocol compiler plugin. DO NOT EDIT!
"""Client and server classes corresponding to protobuf-defined services."""
import grpc

from protos import ride_service_pb2 as protos_dot_ride__service__pb2


class RideServiceStub(object):
    """Missing associated documentation comment in .proto file."""

    def __init__(self, channel):
        """Constructor.

        Args:
            channel: A grpc.Channel.
        """
        self.GetServiceInfo = channel.unary_unary(
                '/ride.RideService/GetServiceInfo',
                request_serializer=protos_dot_ride__service__pb2.EmptyRequest.SerializeToString,
                response_deserializer=protos_dot_ride__service__pb2.ServiceInfo.FromString,
                )
        self.RequestRide = channel.unary_unary(
                '/ride.RideService/RequestRide',
                request_serializer=protos_dot_ride__service__pb2.RideRequest.SerializeToString,
                response_deserializer=protos_dot_ride__service__pb2.RideResponse.FromString,
                )
        self.EndRide = channel.unary_unary(
                '/ride.RideService/EndRide',
                request_serializer=protos_dot_ride__service__pb2.EndRideRequest.SerializeToString,
                response_deserializer=protos_dot_ride__service__pb2.EndRideResponse.FromString,
                )


class RideServiceServicer(object):
    """Missing associated documentation comment in .proto file."""

    def GetServiceInfo(self, request, context):
        """Obtiene información del servicio
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def RequestRide(self, request, context):
        """Solicitar un viaje
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def EndRide(self, request, context):
        """Finalizar un viaje
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')


def add_RideServiceServicer_to_server(servicer, server):
    rpc_method_handlers = {
            'GetServiceInfo': grpc.unary_unary_rpc_method_handler(
                    servicer.GetServiceInfo,
                    request_deserializer=protos_dot_ride__service__pb2.EmptyRequest.FromString,
                    response_serializer=protos_dot_ride__service__pb2.ServiceInfo.SerializeToString,
            ),
            'RequestRide': grpc.unary_unary_rpc_method_handler(
                    servicer.RequestRide,
                    request_deserializer=protos_dot_ride__service__pb2.RideRequest.FromString,
                    response_serializer=protos_dot_ride__service__pb2.RideResponse.SerializeToString,
            ),
            'EndRide': grpc.unary_unary_rpc_method_handler(
                    servicer.EndRide,
                    request_deserializer=protos_dot_ride__service__pb2.EndRideRequest.FromString,
                    response_serializer=protos_dot_ride__service__pb2.EndRideResponse.SerializeToString,
            ),
    }
    generic_handler = grpc.method_handlers_generic_handler(
            'ride.RideService', rpc_method_handlers)
    server.add_generic_rpc_handlers((generic_handler,))


 # This class is part of an EXPERIMENTAL API.
class RideService(object):
    """Missing associated documentation comment in .proto file."""

    @staticmethod
    def GetServiceInfo(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/ride.RideService/GetServiceInfo',
            protos_dot_ride__service__pb2.EmptyRequest.SerializeToString,
            protos_dot_ride__service__pb2.ServiceInfo.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def RequestRide(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/ride.RideService/RequestRide',
            protos_dot_ride__service__pb2.RideRequest.SerializeToString,
            protos_dot_ride__service__pb2.RideResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def EndRide(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/ride.RideService/EndRide',
            protos_dot_ride__service__pb2.EndRideRequest.SerializeToString,
            protos_dot_ride__service__pb2.EndRideResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)
