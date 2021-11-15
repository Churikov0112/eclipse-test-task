//import 'package:hive/hive.dart';
//part 'company.g.dart';

//@HiveType(typeId: 2)
class Company {
  //@HiveField(0)
  String name;

  //@HiveField(1)
  String catchPhrase;

  //@HiveField(2)
  String bs;

  Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });
}
