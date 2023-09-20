import 'package:flutter/material.dart';

import 'widget/body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const String screenId = "/welcom_page";

  @override
  Widget build(BuildContext context) {
    return const Body();
  }
}
