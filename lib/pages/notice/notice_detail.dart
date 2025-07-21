import 'package:flutter/material.dart';

class NoticeDetail extends StatefulWidget {
  const NoticeDetail({Key? key}) : super(key: key);

  @override
  _NoticeDetailState createState() => _NoticeDetailState();
}

class _NoticeDetailState extends State<NoticeDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('公告详情'),
    );
  }
}
