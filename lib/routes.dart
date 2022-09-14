import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'components/home.dart';

final _router = GoRouter(routes: <GoRoute>[
  GoRoute(
    path: '/',
    builder: (BuildContext context, GoRouterState state) => const MyHomePage(),
  ),
  GoRoute(
    path: '/b',
    builder: (BuildContext context, GoRouterState state) => const MyHomePage(),
  ),
]);

GoRouter createGoRouter() => _router;
