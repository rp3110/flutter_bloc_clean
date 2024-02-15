import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/src/config/routes/route_generator.dart';
import 'package:flutter_bloc_clean_architecture/src/presentation/ui/home/bloc/home_page_bloc/home_page_bloc.dart';
import 'package:flutter_bloc_clean_architecture/src/presentation/ui/home/view/screen_home.dart';

import 'src/utils/navigator_key.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return HomePageApiBloc();
          },
        )
      ],
      child: MaterialApp(
        home: const ScreenHome(),
        debugShowMaterialGrid: false,
        showSemanticsDebugger: false,
        showPerformanceOverlay: false,
        navigatorKey: NavigatorKey.navigatorKey,
        // initialRoute: AppRoutes.routesScreenHome,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
