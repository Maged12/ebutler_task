
import 'package:ebutler_task/core/routes/app_routes.dart';
import 'package:ebutler_task/core/utils/app_strings.dart';
import 'package:ebutler_task/core/utils/app_theme.dart';
import 'package:flutter/material.dart';

class EbutlerApp extends StatelessWidget {
  const EbutlerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: getAppTheme(context, false),
      darkTheme: getAppTheme(context, true),
      initialRoute: Routes.initialRoute,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
