import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/utils/app_str_style.dart';
import 'package:todo_app/views/home/home_view.dart';
import 'package:todo_app/views/tasks/task_view.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeView();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'tasks',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const TaskView(),
              transitionDuration: const Duration(milliseconds: 500),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;

                    var tween = Tween(
                      begin: begin,
                      end: end,
                    ).chain(CurveTween(curve: curve));

                    return SlideTransition(
                      position: animation.drive(tween),
                      child: FadeTransition(opacity: animation, child: child),

                      
                    );
                  },
            );
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Hive Todo App',
      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: AppStrStyle.headline1Style,
          titleMedium: AppStrStyle.subtitle1Style,
          displayMedium: AppStrStyle.headline2Style,
          displaySmall: AppStrStyle.headline3Style,
          headlineMedium: AppStrStyle.headline4Style,
          headlineSmall: AppStrStyle.headline5Style,
          titleSmall: AppStrStyle.subtitle2Style,
          titleLarge: AppStrStyle.headline6Style,
        ),
      ),
    );
  }
}
