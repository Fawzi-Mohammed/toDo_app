import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Logic/AuthCubit/auth_cubit.dart';
import 'package:todo_app/Logic/TaskCubit/task_cubit.dart';
import 'package:todo_app/data/isar_data_base_service.dart';
import 'package:todo_app/data/shared_prefes_of_loged_in_user.dart';
import 'package:todo_app/utils/app_str_style.dart';
import 'package:todo_app/views/home/to_do_home_view.dart';
import 'package:todo_app/views/login%20and%20signUp/login_view.dart';
import 'package:todo_app/views/login%20and%20signUp/sign_up_view.dart';
import 'package:todo_app/views/tasks/task_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarService.init();
  await SharedPrefesOfLoggedInUser.init();

  // 👇 Determine initial route dynamically
  final bool isLoggedIn = await SharedPrefesOfLoggedInUser.hasUser();
  final String initialRoute = isLoggedIn ? '/toDoHome' : '/';

  // 👇 Create router dynamically
  final GoRouter router = _createRouter(initialRoute);

  runApp(MyApp(router: router));
}

/// 🔹 Create router with animated transitions and dynamic start route
GoRouter _createRouter(String initialRoute) {
  return GoRouter(
    initialLocation: initialRoute,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        pageBuilder: (context, state) =>
            _buildTransitionPage(key: state.pageKey, child: LoginView()),
      ),
      GoRoute(
        path: '/signUp',
        pageBuilder: (context, state) =>
            _buildTransitionPage(key: state.pageKey, child: SignUpView()),
      ),
      GoRoute(
        path: '/toDoHome',
        pageBuilder: (context, state) => _buildTransitionPage(
          key: state.pageKey,
          child: const ToDoHomeView(),
        ),
        routes: [
          GoRoute(
            path: 'tasks',
            pageBuilder: (context, state) {
              final extra = state.extra as Map<String, dynamic>?;
              final bool isUpdate = extra?['isUpdate'] ?? false;
              final task = extra?['task'];

              return _buildTransitionPage(
                key: state.pageKey,
                child: TaskView(isUpdate: isUpdate, task: task),
              );
            },
          ),
        ],
      ),
    ],
  );
}

/// 🔹 Reusable page transition for all routes
CustomTransitionPage _buildTransitionPage({
  required LocalKey key,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: key,
    child: child,
    transitionDuration: const Duration(milliseconds: 400),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // Slide from right
      const end = Offset.zero;
      const curve = Curves.easeInOutCubic;

      final tween = Tween(
        begin: begin,
        end: end,
      ).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: FadeTransition(opacity: animation, child: child),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  final GoRouter router;
  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit()..checkIfLoggedIn(),
        ),
        BlocProvider<TaskCubit>(create: (context) => TaskCubit()..loadTasks()),
      ],
      child: MaterialApp.router(
        routerConfig: router,
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
