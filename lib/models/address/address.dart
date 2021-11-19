import 'package:hive/hive.dart';
part 'address.g.dart';

@HiveType(typeId: 2)
class Address extends HiveObject {
  @HiveField(0)
  String street;

  @HiveField(1)
  String suite;

  @HiveField(2)
  String city;

  @HiveField(3)
  String zipcode;

  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
  });

  String getAddress() {
    return city +
        ", " +
        "St. " +
        street +
        ", " +
        suite +
        ", " +
        "Zip-code " +
        zipcode +
        ", ";
  }
}
