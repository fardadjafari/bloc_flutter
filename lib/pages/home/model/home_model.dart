import 'package:hive/hive.dart';

import 'package:hive_flutter/hive_flutter.dart';

part 'home_model.g.dart';

@HiveType(typeId: 0)
class PersonModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String firstname;

  @HiveField(2)
  final String lastname;

  @HiveField(3)
  final String sex;

  PersonModel(
      {required this.id,
      required this.firstname,
      required this.lastname,
      required this.sex});
}
