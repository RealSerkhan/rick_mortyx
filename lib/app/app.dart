import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rick_morty/base/di/di_entry_point.dart';

class App {
  Future<void> initSdks() async {
    WidgetsFlutterBinding.ensureInitialized();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    await Future.wait([initDependencyInjection(getIt: getIt)]);
  }
}
