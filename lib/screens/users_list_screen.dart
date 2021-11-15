import 'package:eclipse_test_task/models/user/user.dart';
import 'package:eclipse_test_task/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eclipse_test_task/consts/my_colors.dart';
import 'package:eclipse_test_task/providers/users.dart';
import 'package:eclipse_test_task/widgets/my_appbar.dart';

class UsersListScreen extends StatefulWidget {
  static const routeName = '/users-list';

  @override
  _UsersListScreenState createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  bool isLoading = false;

  void loadUsers() {
    setState(() {
      isLoading = true;
    });
    Provider.of<Users>(context, listen: false).fetchUsersFromServer().then(
          (_) => setState(() {
            isLoading = false;
          }),
        );
  }

  @override
  initState() {
    loadUsers();
    super.initState();
  }

  // список загруженных пользователей
  Widget listOfUsers(List<User> users, Size deviceSize) {
    return Container(
      height:
          deviceSize.height - (MediaQuery.of(context).padding.top + 60 + 27),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserScreen(
                      id: Provider.of<Users>(
                        context,
                        listen: false,
                      ).users[index].id,
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 10,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: MyColors.light_blue,
                    child: Center(
                      child: Text(
                        users[index].id.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    users[index].username,
                  ),
                  subtitle: Text(
                    users[index].name,
                  ),
                  trailing: Icon(
                    Icons.chevron_right_sharp,
                  ),
                ),
              ),
            ),
          ),
          itemCount: users.length,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    var users = Provider.of<Users>(context).users;
    return Scaffold(
      backgroundColor: MyColors.light_white,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).padding.top + 27,
                ),
                MyAppbar(
                  deviceSize: deviceSize,
                  title: 'Список пользователей',
                  hasBackButton: false,
                ),
                SizedBox(height: 20),
                RefreshIndicator(
                  onRefresh: () async {
                    loadUsers();
                  },
                  child: listOfUsers(users, deviceSize),
                ),
              ],
            ),
    );
  }
}
