import 'dart:io';
import 'dart:ui';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInformation {
  static final _deviceinfoplugin = DeviceInfoPlugin();
  static Future<String> getdeviceinfo() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo info = await _deviceinfoplugin.androidInfo;
      return '${info.manufacturer}-${info.model}';
    } else if (Platform.isIOS) {
      final info = await _deviceinfoplugin.iosInfo;
      return '${info.name}-${info.model}';
    } else {
      throw UnimplementedError();
    }
  }

  static Future<String> getOSdetails() async => Platform.operatingSystem;

  static Future<String> getScreenResolution() async {
    if (Platform.isAndroid) {
      final view = PlatformDispatcher.instance.views.first;
      final screenwidth = view.display.size.width;
      final swidth = screenwidth.toString();
      final screenheight = view.display.size.height;
      final sheight = screenheight.toString();

      return '$swidth × $sheight';
    } else if (Platform.isIOS) {
      return ' ';
    } else {
      throw UnimplementedError();
    }
  }

  static Future<String> getDeviceVersion() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo info = await _deviceinfoplugin.androidInfo;
      return info.version.sdkInt.toString();
    } else if (Platform.isIOS) {
      final info = await _deviceinfoplugin.iosInfo;
      return info.systemVersion;
    } else {
      throw UnimplementedError();
    }
  }
}
