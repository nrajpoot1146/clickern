import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

class DeviceInfo {
  String? deviceName;
  String? deviceVersion;
  String? identifier;
  DeviceInfo({
    this.deviceName,
    this.deviceVersion,
    this.identifier,
  });

  DeviceInfo copyWith({
    String? deviceName,
    String? deviceVersion,
    String? identifier,
  }) {
    return DeviceInfo(
      deviceName: deviceName ?? this.deviceName,
      deviceVersion: deviceVersion ?? this.deviceVersion,
      identifier: identifier ?? this.identifier,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'deviceName': deviceName,
      'deviceVersion': deviceVersion,
      'identifier': identifier,
    };
  }

  factory DeviceInfo.fromMap(Map<String, dynamic> map) {
    return DeviceInfo(
      deviceName: map['deviceName'],
      deviceVersion: map['deviceVersion'],
      identifier: map['identifier'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceInfo.fromJson(String source) =>
      DeviceInfo.fromMap(json.decode(source));

  @override
  String toString() =>
      'DeviceInfo(deviceName: $deviceName, deviceVersion: $deviceVersion, identifier: $identifier)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DeviceInfo &&
        other.deviceName == deviceName &&
        other.deviceVersion == deviceVersion &&
        other.identifier == identifier;
  }

  @override
  int get hashCode =>
      deviceName.hashCode ^ deviceVersion.hashCode ^ identifier.hashCode;
}

class CommonLibFunction {
  static Future<DeviceInfo> getDeviceDetails() async {
    // Map<String, String> deviceInfo = new HashMap();
    DeviceInfo deviceInfo = DeviceInfo();
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceInfo.deviceName = build.model;
        deviceInfo.deviceVersion = build.version.toString();
        deviceInfo.identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceInfo.deviceName = data.name;
        deviceInfo.deviceVersion = data.systemVersion;
        deviceInfo.identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      if (kDebugMode) {
        print('Failed to get platform version');
      }
    }

//if (!mounted) return;
    // deviceInfo['deviceName'] = deviceName!;
    // deviceInfo['deviceVersion'] = deviceVersion!;
    // deviceInfo['identifier'] = identifier!;
    return deviceInfo;
  }
}
