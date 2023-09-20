import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/add_person/add_person_page.dart';
import 'package:flutter_application_2/pages/edit_person/edit_person_page.dart';
import 'package:flutter_application_2/pages/home/home_page.dart';

import '../../pages/loading/loading_page.dart';

class AppRouter {
  Route<dynamic>? onGenerateRout(RouteSettings settings) {
    switch (settings.name) {
      case LoadingPage.screenId:
        return MaterialPageRoute(builder: (_) => const LoadingPage());

      case HomePage.screenId:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case AddPersonPage.screenId:
        return MaterialPageRoute(builder: (_) => const AddPersonPage());

      case EditPersonPage.screenId:
        List<dynamic>? args = settings.arguments as List<dynamic>;
        return MaterialPageRoute(
            builder: (_) => EditPersonPage(
                  id: args[0],
                  firstname: args[1],
                  lastname: args[2],
                  sex: args[3],
                  index: args[4],
                ));

      default:
        return null;
    }
  }
}
