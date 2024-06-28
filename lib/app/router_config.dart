import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/app/dependency_injection.dart';
import 'package:flutter_template/auth/bloc/login_bloc.dart';
import 'package:flutter_template/auth/bloc/register_bloc.dart';
import 'package:go_router/go_router.dart';

import '../auth/view/login_page.dart';
import '../auth/view/register_page.dart';
import '../home/view/home_page.dart';

enum AppRoute {
  root('/'),
  login('/login'),
  postLogin('/post-login'),
  register('/register'),
  forgotPassword('/forgot-password'),
  home('/home'),
  ;

  final String routePath;

  const AppRoute(
    this.routePath,
  );
}

final appRouterConfig = GoRouter(
  initialLocation: AppRoute.root.routePath,
  routes: [
    GoRoute(
      path: AppRoute.root.routePath,
      redirect: (context, state) {
        return AppRoute.login.routePath;
      },
    ),
    GoRoute(
      path: AppRoute.login.routePath,
      builder: (context, state) {
        return BlocProvider.value(
          value: locator<LoginBloc>(),
          child: LoginPage(),
        );
      },
    ),
    GoRoute(
      path: AppRoute.postLogin.routePath,
      redirect: (context, state) {
        return AppRoute.home.routePath;
      },
    ),
    GoRoute(
      path: AppRoute.register.routePath,
      builder: (context, state) {
        return BlocProvider.value(
          value: locator<RegisterBloc>(),
          child: RegisterPage(),
        );
      },
    ),
    GoRoute(
      path: AppRoute.home.routePath,
      builder: (context, state) {
        return const HomePage();
      },
    ),
  ],
);

extension RouterNavigation on BuildContext {
  void goAppRoute(AppRoute route) {
    go(route.routePath);
  }

  void pushAppRoute(AppRoute route) {
    push(route.routePath);
  }
}
