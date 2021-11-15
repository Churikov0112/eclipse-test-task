import 'package:flutter/material.dart';
import 'package:eclipse_test_task/consts/my_colors.dart';

class MyAppbar extends StatelessWidget {
  const MyAppbar({
    Key? key,
    required this.deviceSize,
    required this.title,
    required this.hasBackButton,
  }) : super(key: key);

  final Size deviceSize;
  final String title;
  final bool hasBackButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceSize.width,
      height: 40,
      color: MyColors.light_white,
      child: Row(
        children: [
          SizedBox(width: 15),
          hasBackButton
              ? Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back_sharp,
                      ),
                      splashRadius: 1,
                    ),
                    SizedBox(width: 15),
                  ],
                )
              : Container(),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
              color: MyColors.light_blue,
            ),
          ),
        ],
      ),
    );
  }
}
