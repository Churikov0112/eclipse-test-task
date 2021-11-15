import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eclipse_test_task/models/address/address.dart';
import 'package:eclipse_test_task/models/company/company.dart';
import 'package:eclipse_test_task/models/geo/geo.dart';
import 'dart:convert';
import 'dart:async';

import 'package:eclipse_test_task/models/user/user.dart';

class Users with ChangeNotifier {
  List<User> _loadedUsers = [];

  List<User> get users {
    return _loadedUsers;
  }

  Future<void> fetchUsersFromServer() async {
    print('метод fetchUsersFromServer() начал свое выполнение');
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );
    final extractedData = json.decode(response.body);
    print(extractedData);
    _loadedUsers.clear();
    for (var user in extractedData) {
      _loadedUsers.add(
        User(
          id: user['id'],
          name: user['name'],
          username: user['username'],
          email: user['email'],
          address: Address(
            street: user['address']['street'],
            suite: user['address']['suite'],
            city: user['address']['city'],
            zipcode: user['address']['zipcode'],
            geo: Geo(
              lat: double.parse(user['address']['geo']['lat']),
              lng: double.parse(user['address']['geo']['lng']),
            ),
          ),
          phone: user['phone'],
          website: user['website'],
          company: Company(
            name: user['company']['name'],
            catchPhrase: user['company']['catchPhrase'],
            bs: user['company']['bs'],
          ),
        ),
      );
    }
    notifyListeners();
  }
}
