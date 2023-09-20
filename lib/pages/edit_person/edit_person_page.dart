import 'package:flutter/material.dart';

import 'widget/body.dart';

class EditPersonPage extends StatelessWidget {
  const EditPersonPage(
      {super.key,
      required this.id,
      required this.firstname,
      required this.lastname,
      required this.sex,
      required this.index});
  static const String screenId = "/edit_person_page";
  final String id;
  final String firstname;
  final String lastname;
  final String sex;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Body(
      id: id,
      firstname: firstname,
      lastname: lastname,
      sex: sex,
      index: index,
    );
  }
}
