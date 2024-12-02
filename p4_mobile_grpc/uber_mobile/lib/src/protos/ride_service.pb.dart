//
//  Generated code. Do not modify.
//  source: ride_service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Mensajes
class EmptyRequest extends $pb.GeneratedMessage {
  factory EmptyRequest() => create();
  EmptyRequest._() : super();
  factory EmptyRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EmptyRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EmptyRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'ride'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EmptyRequest clone() => EmptyRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EmptyRequest copyWith(void Function(EmptyRequest) updates) => super.copyWith((message) => updates(message as EmptyRequest)) as EmptyRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EmptyRequest create() => EmptyRequest._();
  EmptyRequest createEmptyInstance() => create();
  static $pb.PbList<EmptyRequest> createRepeated() => $pb.PbList<EmptyRequest>();
  @$core.pragma('dart2js:noInline')
  static EmptyRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EmptyRequest>(create);
  static EmptyRequest? _defaultInstance;
}

class ServiceInfo extends $pb.GeneratedMessage {
  factory ServiceInfo({
    $core.int? availableCars,
    $core.int? totalTrips,
    $core.double? earnings,
  }) {
    final $result = create();
    if (availableCars != null) {
      $result.availableCars = availableCars;
    }
    if (totalTrips != null) {
      $result.totalTrips = totalTrips;
    }
    if (earnings != null) {
      $result.earnings = earnings;
    }
    return $result;
  }
  ServiceInfo._() : super();
  factory ServiceInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ServiceInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ServiceInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'ride'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'availableCars', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalTrips', $pb.PbFieldType.O3)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'earnings', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ServiceInfo clone() => ServiceInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ServiceInfo copyWith(void Function(ServiceInfo) updates) => super.copyWith((message) => updates(message as ServiceInfo)) as ServiceInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ServiceInfo create() => ServiceInfo._();
  ServiceInfo createEmptyInstance() => create();
  static $pb.PbList<ServiceInfo> createRepeated() => $pb.PbList<ServiceInfo>();
  @$core.pragma('dart2js:noInline')
  static ServiceInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ServiceInfo>(create);
  static ServiceInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get availableCars => $_getIZ(0);
  @$pb.TagNumber(1)
  set availableCars($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAvailableCars() => $_has(0);
  @$pb.TagNumber(1)
  void clearAvailableCars() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalTrips => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalTrips($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalTrips() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalTrips() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get earnings => $_getN(2);
  @$pb.TagNumber(3)
  set earnings($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEarnings() => $_has(2);
  @$pb.TagNumber(3)
  void clearEarnings() => clearField(3);
}

class RideRequest extends $pb.GeneratedMessage {
  factory RideRequest({
    $core.String? userId,
    $core.String? rideType,
    $core.String? pickupLocation,
    $core.String? dropoffLocation,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (rideType != null) {
      $result.rideType = rideType;
    }
    if (pickupLocation != null) {
      $result.pickupLocation = pickupLocation;
    }
    if (dropoffLocation != null) {
      $result.dropoffLocation = dropoffLocation;
    }
    return $result;
  }
  RideRequest._() : super();
  factory RideRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RideRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RideRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'ride'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'rideType')
    ..aOS(3, _omitFieldNames ? '' : 'pickupLocation')
    ..aOS(4, _omitFieldNames ? '' : 'dropoffLocation')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RideRequest clone() => RideRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RideRequest copyWith(void Function(RideRequest) updates) => super.copyWith((message) => updates(message as RideRequest)) as RideRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RideRequest create() => RideRequest._();
  RideRequest createEmptyInstance() => create();
  static $pb.PbList<RideRequest> createRepeated() => $pb.PbList<RideRequest>();
  @$core.pragma('dart2js:noInline')
  static RideRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RideRequest>(create);
  static RideRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get rideType => $_getSZ(1);
  @$pb.TagNumber(2)
  set rideType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRideType() => $_has(1);
  @$pb.TagNumber(2)
  void clearRideType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get pickupLocation => $_getSZ(2);
  @$pb.TagNumber(3)
  set pickupLocation($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPickupLocation() => $_has(2);
  @$pb.TagNumber(3)
  void clearPickupLocation() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get dropoffLocation => $_getSZ(3);
  @$pb.TagNumber(4)
  set dropoffLocation($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDropoffLocation() => $_has(3);
  @$pb.TagNumber(4)
  void clearDropoffLocation() => clearField(4);
}

class RideResponse extends $pb.GeneratedMessage {
  factory RideResponse({
    $core.bool? success,
    $core.String? message,
    $core.String? plate,
    $core.String? estimatedTime,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (plate != null) {
      $result.plate = plate;
    }
    if (estimatedTime != null) {
      $result.estimatedTime = estimatedTime;
    }
    return $result;
  }
  RideResponse._() : super();
  factory RideResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RideResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RideResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'ride'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOS(3, _omitFieldNames ? '' : 'plate')
    ..aOS(4, _omitFieldNames ? '' : 'estimatedTime')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RideResponse clone() => RideResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RideResponse copyWith(void Function(RideResponse) updates) => super.copyWith((message) => updates(message as RideResponse)) as RideResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RideResponse create() => RideResponse._();
  RideResponse createEmptyInstance() => create();
  static $pb.PbList<RideResponse> createRepeated() => $pb.PbList<RideResponse>();
  @$core.pragma('dart2js:noInline')
  static RideResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RideResponse>(create);
  static RideResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get plate => $_getSZ(2);
  @$pb.TagNumber(3)
  set plate($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPlate() => $_has(2);
  @$pb.TagNumber(3)
  void clearPlate() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get estimatedTime => $_getSZ(3);
  @$pb.TagNumber(4)
  set estimatedTime($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasEstimatedTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearEstimatedTime() => clearField(4);
}

class EndRideRequest extends $pb.GeneratedMessage {
  factory EndRideRequest({
    $core.String? plate,
  }) {
    final $result = create();
    if (plate != null) {
      $result.plate = plate;
    }
    return $result;
  }
  EndRideRequest._() : super();
  factory EndRideRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EndRideRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EndRideRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'ride'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'plate')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EndRideRequest clone() => EndRideRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EndRideRequest copyWith(void Function(EndRideRequest) updates) => super.copyWith((message) => updates(message as EndRideRequest)) as EndRideRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EndRideRequest create() => EndRideRequest._();
  EndRideRequest createEmptyInstance() => create();
  static $pb.PbList<EndRideRequest> createRepeated() => $pb.PbList<EndRideRequest>();
  @$core.pragma('dart2js:noInline')
  static EndRideRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EndRideRequest>(create);
  static EndRideRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get plate => $_getSZ(0);
  @$pb.TagNumber(1)
  set plate($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlate() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlate() => clearField(1);
}

class EndRideResponse extends $pb.GeneratedMessage {
  factory EndRideResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  EndRideResponse._() : super();
  factory EndRideResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EndRideResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EndRideResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'ride'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EndRideResponse clone() => EndRideResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EndRideResponse copyWith(void Function(EndRideResponse) updates) => super.copyWith((message) => updates(message as EndRideResponse)) as EndRideResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EndRideResponse create() => EndRideResponse._();
  EndRideResponse createEmptyInstance() => create();
  static $pb.PbList<EndRideResponse> createRepeated() => $pb.PbList<EndRideResponse>();
  @$core.pragma('dart2js:noInline')
  static EndRideResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EndRideResponse>(create);
  static EndRideResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
