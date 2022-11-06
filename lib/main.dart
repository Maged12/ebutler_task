import 'package:bloc/bloc.dart';
import 'package:ebutler_task/core/app/app.dart';
import 'package:ebutler_task/core/app/bloc_observer.dart';
import 'package:ebutler_task/core/app/injection_container.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  BlocOverrides.runZoned(
    () {
      runApp(const EbutlerApp());
    },
    blocObserver: AppBlocObserver(),
  );
}
