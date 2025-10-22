import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Logic/AuthCubit/auth_cubit.dart';
import 'package:todo_app/Logic/TaskCubit/task_cubit.dart';
import 'package:todo_app/data/isar_data_base_service.dart';
import 'package:todo_app/utils/app_str_style.dart';
import 'package:todo_app/views/home/to_do_home_view.dart';
import 'package:todo_app/views/login%20and%20signUp/login_view.dart';
import 'package:todo_app/views/login%20and%20signUp/sign_up_view.dart';
import 'package:todo_app/views/tasks/task_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarService.init();
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return LoginView();
      },
    ),
    GoRoute(
      path: '/signUp',
      builder: (BuildContext context, GoRouterState state) {
        return SignUpView();
      },
    ),
    GoRoute(
      path: '/toDoHome',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const ToDoHomeView(),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // slide from right
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
      routes: <RouteBase>[
        GoRoute(
          path: 'tasks',
          pageBuilder: (BuildContext context, GoRouterState state) {
            final extra = state.extra as Map<String, dynamic>?;

            final bool isUpdate = extra?['isUpdate'] ?? false;
            final task = extra?['task'];

            return CustomTransitionPage(
              key: state.pageKey,
              child: TaskView(isUpdate: isUpdate, task: task),
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskCubit>(create: (context) => TaskCubit()..loadTasks()),
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
      ],
      child: MaterialApp.router(
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
      ),
    );
  }
}
