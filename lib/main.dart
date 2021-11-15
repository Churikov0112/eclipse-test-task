import 'package:eclipse_test_task/providers/posts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eclipse_test_task/providers/users.dart';
import 'package:eclipse_test_task/screens/users_list_screen.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Users(),
        ),
        ChangeNotifierProvider.value(
          value: Posts(),
        ),
      ],
      child: Consumer<Users>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(),
          home: UsersListScreen(),
          routes: {
            UsersListScreen.routeName: (ctx) => UsersListScreen(),
          },
        ),
      ),
    );
  }
}
