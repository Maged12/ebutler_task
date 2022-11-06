import 'package:ebutler_task/core/app/injection_container.dart';
import 'package:ebutler_task/core/utils/app_strings.dart';
import 'package:ebutler_task/features/auth_feature/presentation/cubit/auth_feature_cubit.dart';
import 'package:ebutler_task/features/auth_feature/presentation/pages/auth_screen.dart';
import 'package:ebutler_task/features/users_feature/presentation/cubit/users_feature_cubit.dart';
import 'package:ebutler_task/features/users_feature/presentation/pages/users_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app/app_prefs.dart';

class Routes {
  static const String initialRoute = '/';
  static const String auhRoute = '/auhRoute';
  static const String usersRoute = '/usersRoute';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) {
            return const SplashScreen();
          },
        );
      case Routes.auhRoute:
        initAuthModule();
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (_) => instance<AuthFeatureCubit>(),
              child: const AuthScreen(),
            );
          },
        );
      case Routes.usersRoute:
        initUsersModule();
        return MaterialPageRoute(
          builder: (context) => BlocProvider<UsersFeatureCubit>(
            create: (_) => instance<UsersFeatureCubit>(),
            child: const UsersHomeScreen(),
          ),
        );
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () => Navigator.of(context).pushReplacementNamed(
        instance<AppPreferences>().isStillActiveLogin()
            ? Routes.usersRoute
            : Routes.auhRoute,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Splash"),
      ),
    );
  }
}
