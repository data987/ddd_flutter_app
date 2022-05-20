import 'package:auto_route/auto_route.dart';
import 'package:ddd_flutter_app/presentation/index.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: SignInPage),
  ],
)
class $AppRouter {}
