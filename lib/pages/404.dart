import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  const NotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "您访问的页面去火星了",
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Icon(
            Icons.warning_amber,
            color: Colors.grey,
            size: 100,
          )
        ],
      ),
    );
  }
}
