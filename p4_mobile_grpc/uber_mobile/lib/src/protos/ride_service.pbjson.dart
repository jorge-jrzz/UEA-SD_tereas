//
//  Generated code. Do not modify.
//  source: ride_service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use emptyRequestDescriptor instead')
const EmptyRequest$json = {
  '1': 'EmptyRequest',
};

/// Descriptor for `EmptyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyRequestDescriptor = $convert.base64Decode(
    'CgxFbXB0eVJlcXVlc3Q=');

@$core.Deprecated('Use serviceInfoDescriptor instead')
const ServiceInfo$json = {
  '1': 'ServiceInfo',
  '2': [
    {'1': 'available_cars', '3': 1, '4': 1, '5': 5, '10': 'availableCars'},
    {'1': 'total_trips', '3': 2, '4': 1, '5': 5, '10': 'totalTrips'},
    {'1': 'earnings', '3': 3, '4': 1, '5': 2, '10': 'earnings'},
  ],
};

/// Descriptor for `ServiceInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serviceInfoDescriptor = $convert.base64Decode(
    'CgtTZXJ2aWNlSW5mbxIlCg5hdmFpbGFibGVfY2FycxgBIAEoBVINYXZhaWxhYmxlQ2FycxIfCg'
    't0b3RhbF90cmlwcxgCIAEoBVIKdG90YWxUcmlwcxIaCghlYXJuaW5ncxgDIAEoAlIIZWFybmlu'
    'Z3M=');

@$core.Deprecated('Use rideRequestDescriptor instead')
const RideRequest$json = {
  '1': 'RideRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'ride_type', '3': 2, '4': 1, '5': 9, '10': 'rideType'},
    {'1': 'pickup_location', '3': 3, '4': 1, '5': 9, '10': 'pickupLocation'},
    {'1': 'dropoff_location', '3': 4, '4': 1, '5': 9, '10': 'dropoffLocation'},
  ],
};

/// Descriptor for `RideRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rideRequestDescriptor = $convert.base64Decode(
    'CgtSaWRlUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSGwoJcmlkZV90eXBlGAIgAS'
    'gJUghyaWRlVHlwZRInCg9waWNrdXBfbG9jYXRpb24YAyABKAlSDnBpY2t1cExvY2F0aW9uEikK'
    'EGRyb3BvZmZfbG9jYXRpb24YBCABKAlSD2Ryb3BvZmZMb2NhdGlvbg==');

@$core.Deprecated('Use rideResponseDescriptor instead')
const RideResponse$json = {
  '1': 'RideResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'plate', '3': 3, '4': 1, '5': 9, '10': 'plate'},
    {'1': 'estimated_time', '3': 4, '4': 1, '5': 9, '10': 'estimatedTime'},
  ],
};

/// Descriptor for `RideResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rideResponseDescriptor = $convert.base64Decode(
    'CgxSaWRlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgAS'
    'gJUgdtZXNzYWdlEhQKBXBsYXRlGAMgASgJUgVwbGF0ZRIlCg5lc3RpbWF0ZWRfdGltZRgEIAEo'
    'CVINZXN0aW1hdGVkVGltZQ==');

@$core.Deprecated('Use endRideRequestDescriptor instead')
const EndRideRequest$json = {
  '1': 'EndRideRequest',
  '2': [
    {'1': 'plate', '3': 1, '4': 1, '5': 9, '10': 'plate'},
  ],
};

/// Descriptor for `EndRideRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List endRideRequestDescriptor = $convert.base64Decode(
    'Cg5FbmRSaWRlUmVxdWVzdBIUCgVwbGF0ZRgBIAEoCVIFcGxhdGU=');

@$core.Deprecated('Use endRideResponseDescriptor instead')
const EndRideResponse$json = {
  '1': 'EndRideResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `EndRideResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List endRideResponseDescriptor = $convert.base64Decode(
    'Cg9FbmRSaWRlUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGA'
    'IgASgJUgdtZXNzYWdl');

