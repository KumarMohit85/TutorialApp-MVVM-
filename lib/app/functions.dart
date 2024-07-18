import 'dart:io';

import 'package:_tut_app/domain/model/model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

Future<DeviceInfo> getDeviceDetails() async {
  String name = "unknown";
  String identifier = "unknown";
  String version = "unknown";

  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  try {
    if (Platform.isAndroid) {
      //return android device info

      var build = await deviceInfoPlugin.androidInfo;
      name = build.brand + " " + build.model;
      identifier = build.id.toString();
      version = build.version.codename;
    } else if (Platform.isIOS) {
      // return ios device info
      var build = await deviceInfoPlugin.iosInfo;
      name = build.name + " " + build.model;
      identifier = build.identifierForVendor.toString();
      version = build.systemVersion;
    }
  } on PlatformException {
    //return default data
    return DeviceInfo(name, identifier, version);
  }
  return DeviceInfo(name, identifier, version);
}
