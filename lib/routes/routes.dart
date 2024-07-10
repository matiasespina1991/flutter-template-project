import 'package:go_router/go_router.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/loading_screen/loading_screen.dart';
import '../screens/login_screen/login_screen.dart';
import '../screens/not_found_screen/not_found_screen.dart';

class Routes {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/loading',
        builder: (context, state) => const LoadingScreen(),
      ),
    ],
  );
}
