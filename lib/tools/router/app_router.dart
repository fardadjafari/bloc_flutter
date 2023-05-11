import 'package:flutter/material.dart';

import '../../pages/loading/loading_page.dart';

class AppRouter {
  Route<dynamic>? onGenerateRout(RouteSettings settings) {
    switch (settings.name) {
      case LoadingPage.screenId:
        return MaterialPageRoute(builder: (_) => const LoadingPage());

      default:
        return null;
    }
  }
}
