//
//  Generated code. Do not modify.
//  source: ride_service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'ride_service.pb.dart' as $0;

export 'ride_service.pb.dart';

@$pb.GrpcServiceName('ride.RideService')
class RideServiceClient extends $grpc.Client {
  static final _$getServiceInfo = $grpc.ClientMethod<$0.EmptyRequest, $0.ServiceInfo>(
      '/ride.RideService/GetServiceInfo',
      ($0.EmptyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ServiceInfo.fromBuffer(value));
  static final _$requestRide = $grpc.ClientMethod<$0.RideRequest, $0.RideResponse>(
      '/ride.RideService/RequestRide',
      ($0.RideRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.RideResponse.fromBuffer(value));
  static final _$endRide = $grpc.ClientMethod<$0.EndRideRequest, $0.EndRideResponse>(
      '/ride.RideService/EndRide',
      ($0.EndRideRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.EndRideResponse.fromBuffer(value));

  RideServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.ServiceInfo> getServiceInfo($0.EmptyRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getServiceInfo, request, options: options);
  }

  $grpc.ResponseFuture<$0.RideResponse> requestRide($0.RideRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestRide, request, options: options);
  }

  $grpc.ResponseFuture<$0.EndRideResponse> endRide($0.EndRideRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$endRide, request, options: options);
  }
}

@$pb.GrpcServiceName('ride.RideService')
abstract class RideServiceBase extends $grpc.Service {
  $core.String get $name => 'ride.RideService';

  RideServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.EmptyRequest, $0.ServiceInfo>(
        'GetServiceInfo',
        getServiceInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.EmptyRequest.fromBuffer(value),
        ($0.ServiceInfo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RideRequest, $0.RideResponse>(
        'RequestRide',
        requestRide_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RideRequest.fromBuffer(value),
        ($0.RideResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.EndRideRequest, $0.EndRideResponse>(
        'EndRide',
        endRide_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.EndRideRequest.fromBuffer(value),
        ($0.EndRideResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.ServiceInfo> getServiceInfo_Pre($grpc.ServiceCall call, $async.Future<$0.EmptyRequest> request) async {
    return getServiceInfo(call, await request);
  }

  $async.Future<$0.RideResponse> requestRide_Pre($grpc.ServiceCall call, $async.Future<$0.RideRequest> request) async {
    return requestRide(call, await request);
  }

  $async.Future<$0.EndRideResponse> endRide_Pre($grpc.ServiceCall call, $async.Future<$0.EndRideRequest> request) async {
    return endRide(call, await request);
  }

  $async.Future<$0.ServiceInfo> getServiceInfo($grpc.ServiceCall call, $0.EmptyRequest request);
  $async.Future<$0.RideResponse> requestRide($grpc.ServiceCall call, $0.RideRequest request);
  $async.Future<$0.EndRideResponse> endRide($grpc.ServiceCall call, $0.EndRideRequest request);
}
