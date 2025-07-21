import 'package:enjoy_plus_flutter_7/api/home.dart';
import 'package:flutter/material.dart';

class NoticeDetail extends StatefulWidget {
  const NoticeDetail({super.key});

  @override
  State<NoticeDetail> createState() => _NoticeDetailState();
}

class _NoticeDetailState extends State<NoticeDetail> {
  Map notifyDetail = {
    "id": "",
    "content":
        // 前端组件语法
        "",
    "createdAt": "",
    "creatorName": ""
  };

  // 生命周期中获取命名路由传参

  // Map<String, dynamic> getParams() {
  //   return ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
  // }

  // 外部传入的数据改变时自动调用 => 获取路由传参
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var res = ModalRoute.of(context)?.settings.arguments;
    if (res != null) {
      String id = (res as Map<String, dynamic>)['id'];
      getNotifyDetail(id);
    }
    // print(res);
  }

  getNotifyDetail(String id) async {
    var res = await getNotifyDetailAPI(id);
    // setState(() {
    //   notifyDetail = res;
    // });
    notifyDetail = res;
    setState(() {}); // 更新一下ui
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('公告详情'),
        ),
        body: ListView(children: [
          Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 标题
                    Text(notifyDetail['title'] ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(notifyDetail['creatorName'] ?? '',
                              style: const TextStyle(color: Colors.grey)),
                          Text(notifyDetail['createdAt'] ?? '',
                              style: const TextStyle(color: Colors.grey))
                        ]),
                    const SizedBox(height: 10),
                    // 内容
                    // 三方库    3.7    flutter_html目前不支持鸿蒙
                    // Html(
                    //   data: notifyDetail['content'] ?? "",
                    // )
                    // web组件 加载前端页面  runJavascript('')
                    Text(notifyDetail['content'] ?? "")
                  ]))
        ]));
  }
}
