import '../geo/geo.dart';
// import 'package:hive/hive.dart';
// part 'address.g.dart';

//@HiveType(typeId: 3)
class Address {
  //@HiveField(0)
  String street;

  //@HiveField(1)
  String suite;

  //@HiveField(2)
  String city;

  //@HiveField(3)
  String zipcode;

  // @HiveField(4)
  Geo geo;

  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
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
