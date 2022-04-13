import 'dart:math';

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
  await Future.delayed(const Duration(seconds: 2));
  var rng = Random();
  for (var i = 0; i < 11; i++) {
    yield "Fetching info... $i/10";
    int w = rng.nextInt(1000);
    await Future.delayed(Duration(milliseconds: w));
  }
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
