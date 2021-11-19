// ignore_for_file: must_be_immutable
import 'package:eclipse_test_task/consts/my_colors.dart';
import 'package:eclipse_test_task/models/user/user.dart';
import 'package:eclipse_test_task/providers/posts_and_comments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostDetailsScreen extends StatefulWidget {
  PostDetailsScreen({
    required this.postId,
    required this.user,
  });

  int postId;
  User user;

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  bool isLoading = false;

  // метод для загрузки списка комментариев для этого поста
  void loadCommentsForThisPost() {
    setState(() {
      isLoading = true;
    });
    if (Provider.of<PostsAndComments>(context, listen: false)
        .posts
        .firstWhere((pst) => pst.id == widget.postId)
        .comments
        .isEmpty) {
      Provider.of<PostsAndComments>(context, listen: false)
          .fetchCommentsForPostFromServer(widget.postId)
          .then(
            (_) => setState(
              () {
                isLoading = false;
              },
            ),
          );
    }
    setState(() {
      isLoading = false;
    });
  }

  // диалог для изменения возраста username
  void showWriteCommentDialog(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController bodyController = TextEditingController();
    TextEditingController titleController = TextEditingController();
    showModalBottomSheet<void>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 49),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: [
                      SizedBox(height: 20),

                      // Title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 20),
                          Icon(
                            Icons.close,
                            color: Colors.transparent,
                          ),
                          Expanded(child: Container()),
                          Text(
                            'You can write comment',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Expanded(child: Container()),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.close),
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        SizedBox(height: 15),
                        Text(
                          'descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        // email field
                        TextFormField(
                          onChanged: (val) {
                            print(val);
                          },
                          controller: emailController,
                          maxLines: 7,
                          minLines: 1,
                          cursorRadius: Radius.circular(2),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: // Text Field height
                                EdgeInsets.only(
                              top: 12,
                              bottom: 12,
                              right: 14,
                              //left: 14,
                            ),
                            fillColor: MyColors.light_white,
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                            labelText: '    email',
                            prefixText: '    ',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),

                        SizedBox(height: 10),

                        // title field
                        TextFormField(
                          onChanged: (val) {
                            print(val);
                          },
                          controller: titleController,
                          maxLines: 7,
                          minLines: 1,
                          cursorRadius: Radius.circular(2),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: // Text Field height
                                EdgeInsets.only(
                              top: 12,
                              bottom: 12,
                              right: 14,
                              //left: 14,
                            ),
                            fillColor: MyColors.light_white,
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                            labelText: '    title',
                            prefixText: '    ',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),

                        SizedBox(height: 10),

                        // body field
                        TextFormField(
                          onChanged: (val) {
                            print(val);
                          },
                          controller: bodyController,
                          maxLines: 7,
                          minLines: 1,
                          cursorRadius: Radius.circular(2),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: // Text Field height
                                EdgeInsets.only(
                              top: 12,
                              bottom: 12,
                              right: 14,
                              //left: 14,
                            ),
                            fillColor: MyColors.light_white,
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                            labelText: '    comment',
                            prefixText: '    ',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),

                        SizedBox(height: 15),

                        // кнопка "отправить комментарий"
                        GestureDetector(
                          onTap: () {
                            Provider.of<PostsAndComments>(context,
                                    listen: false)
                                .addCommentAndSendToServer(
                              postId: widget.postId,
                              title: titleController.text != ""
                                  ? titleController.text
                                  : "title",
                              body: bodyController.text != ""
                                  ? bodyController.text
                                  : "body",
                              email: emailController.text != ""
                                  ? emailController.text
                                  : "email",
                            );
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: MyColors.light_blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            width: MediaQuery.of(context).size.width - 30,
                            height: 45,
                            child: Center(
                              child: Text(
                                'Send comment',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  initState() {
    loadCommentsForThisPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    AppBar appBar = AppBar(
      title: Text('Post #' + widget.postId.toString()),
      backgroundColor: MyColors.light_white,
      foregroundColor: Colors.black,
      elevation: 0.5,
    );

    var post = Provider.of<PostsAndComments>(context)
        .posts
        .firstWhere((pst) => pst.id == widget.postId);

    return Scaffold(
      backgroundColor: MyColors.light_white,
      appBar: appBar,
      body: SafeArea(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    // post fullview
                    Container(
                      width: deviceSize.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      margin: EdgeInsets.all(15),
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // заголовок
                          Text(
                            post.title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'by ' + widget.user.username,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: 5),

                          Divider(),
                          SizedBox(height: 5),
                          //
                          Text(
                            post.body,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          //SizedBox(height: 20),
                          //
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    // "Comments"
                    Row(
                      children: [
                        SizedBox(width: 15),
                        Text(
                          'Comments',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    // List of comments
                    for (var index = 0; index < post.comments.length; index++)
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Container(
                          width: deviceSize.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // заголовок
                              Row(
                                children: [
                                  CircleAvatar(
                                    child: Text(
                                      (index + 1).toString(),
                                    ),
                                    backgroundColor: MyColors.light_blue,
                                    foregroundColor: Colors.white,
                                  ),
                                  SizedBox(width: 15),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          post.comments[index].name,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          'by ' + post.comments[index].email,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Divider(),
                              SizedBox(height: 5),
                              Text(
                                post.comments[index].body,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    SizedBox(height: 100),
                  ],
                ),
              ),
      ),

      // "Write comment" button
      floatingActionButton: GestureDetector(
        onTap: () {
          showWriteCommentDialog(context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: MyColors.light_blue,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          width: deviceSize.width - 30,
          height: 45,
          child: Center(
            child: Text(
              'Write comment',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
