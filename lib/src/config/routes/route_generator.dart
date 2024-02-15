import 'package:flutter/material.dart';

import '../../presentation/ui/details/view/screen_details.dart';
import '../../presentation/ui/home/view/screen_home.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case AppRoutes.routesScreenDetails:
        return MaterialPageRoute(
            builder: (_) =>  ScreenDetails(demoText: args),
            settings:  RouteSettings(name: AppRoutes.routesScreenDetails,arguments: args as String));
      case AppRoutes.routesScreenHome:
        return MaterialPageRoute(
            builder: (_) => const ScreenHome(),
            settings: const RouteSettings(name: AppRoutes.routesScreenHome));
      default:
        return MaterialPageRoute(
            builder: (_) => const ScreenHome(),
            settings: const RouteSettings(name: AppRoutes.routesScreenHome));
    }
  }
}
