import 'package:eclipse_test_task/models/address/address.dart';
import 'package:eclipse_test_task/models/album/album.dart';
import 'package:eclipse_test_task/models/comment/comment.dart';
import 'package:eclipse_test_task/models/company/company.dart';
import 'package:eclipse_test_task/models/photo/photo.dart';
import 'package:eclipse_test_task/models/post/post.dart';
import 'package:eclipse_test_task/models/user/user.dart';
import 'package:eclipse_test_task/providers/albums_and_photos.dart';
import 'package:eclipse_test_task/providers/posts_and_comments.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:eclipse_test_task/providers/users.dart';
import 'package:eclipse_test_task/screens/users_list_screen.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(CompanyAdapter());
  Hive.registerAdapter(AddressAdapter());
  Hive.registerAdapter(PostAdapter());
  Hive.registerAdapter(AlbumAdapter());
  Hive.registerAdapter(PhotoAdapter());
  Hive.registerAdapter(CommentAdapter());

  // var albumsData = await Hive.openBox<Album>('albumsData');
  // var postsData = await Hive.openBox<Post>('postsData');
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
          value: PostsAndComments(),
        ),
        ChangeNotifierProvider.value(
          value: AlbumsAndPhotos(),
        ),
      ],
      child: Consumer<Users>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(),
          home: UsersListScreen(),
        ),
      ),
    );
  }
}
