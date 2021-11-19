import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:eclipse_test_task/models/address/address.dart';
import 'package:eclipse_test_task/models/company/company.dart';
import 'dart:convert';
import 'dart:async';

import 'package:eclipse_test_task/models/user/user.dart';

class Users with ChangeNotifier {
  List<User> _loadedUsers = [];

  List<User> get users {
    return _loadedUsers;
  }

  // загрузка списка пользователей из локальной БД или с сервера
  Future<void> fetchUsers() async {
    var usersData = await Hive.openBox<User>('userData');
    if (usersData.get(1) != null) {
      // если в БД есть пользователи
      print('Список пользователей был загружен из локальной БД');
      _loadedUsers.clear();
      for (var userData in usersData.values) {
        _loadedUsers.add(userData);
      }
    } else {
      // если в БД нет пользователей
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
      );
      final extractedData = json.decode(response.body);
      print('Список пользователей был загружен с сервера');
      _loadedUsers.clear();
      for (var user in extractedData) {
        User newUser = User(
          id: user['id'],
          name: user['name'],
          username: user['username'],
          email: user['email'],
          address: Address(
            street: user['address']['street'],
            suite: user['address']['suite'],
            city: user['address']['city'],
            zipcode: user['address']['zipcode'],
          ),
          phone: user['phone'],
          website: user['website'],
          company: Company(
            name: user['company']['name'],
            catchPhrase: user['company']['catchPhrase'],
            bs: user['company']['bs'],
          ),
        );
        _loadedUsers.add(newUser);
        await usersData.put(newUser.id, newUser);
      }
      print('Список пользователей был добавлен в локальную БД');
    }
    usersData.close();
    notifyListeners();
  }
}
