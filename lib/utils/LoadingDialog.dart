import 'package:flutter/material.dart';

Widget getLoadingWidget(BuildContext context, {String? message = "数据加载中..."}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(
          color: Colors.blue,
        ),
        const SizedBox(height: 20),
        Text(
          message!,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        )
      ],
    ),
  );
}
