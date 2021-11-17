import 'package:eclipse_test_task/models/user/user.dart';
import 'package:eclipse_test_task/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eclipse_test_task/consts/my_colors.dart';
import 'package:eclipse_test_task/providers/users.dart';

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
      child: ListView.builder(
        itemBuilder: (context, index) => InkWell(
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
          child: Column(
            children: [
              index == 0 ? SizedBox(height: 15) : SizedBox(),
              ListTile(
                leading: CircleAvatar(
                  child: Text(
                    users[index].id.toString(),
                  ),
                  backgroundColor: MyColors.light_blue,
                  foregroundColor: Colors.white,
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
            ],
          ),
        ),
        itemCount: users.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    var users = Provider.of<Users>(context).users;
    return Scaffold(
      backgroundColor: MyColors.light_white,
      appBar: AppBar(
        title: Text('Users list'),
        backgroundColor: MyColors.light_white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
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
