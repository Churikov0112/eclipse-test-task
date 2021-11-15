//import 'package:hive/hive.dart';

import '../address/address.dart';
import '../company/company.dart';
//part 'user.g.dart';

//@HiveType(typeId: 0)
class User {
  //@HiveField(0)
  int id;

  //@HiveField(1)
  String name;

  //@HiveField(2)
  String username;

//@HiveField(3)
  String email;

  //@HiveField(4)
  Address address;

  //@HiveField(5)
  String phone;

  //@HiveField(6)
  String website;

  //@HiveField(7)
  Company company;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });
}
