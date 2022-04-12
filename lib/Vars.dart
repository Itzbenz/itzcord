import 'package:flutter/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';

//Static Class, place static global stuff here
late String appName;
late String packageName;
late String version;
late String buildNumber;

bool initialized = false;

Stream<String> init() async* {
  if (initialized) {
    yield "";
    return;
  }
  WidgetsFlutterBinding.ensureInitialized();
  yield "Fetching info...";
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  appName = packageInfo.appName;
  packageName = packageInfo.packageName;
  version = packageInfo.version;
  buildNumber = packageInfo.buildNumber;
  initialized = true;
  yield "Done!";
}

String userAgent() {
  return '$packageName/$version ($buildNumber)';
}
