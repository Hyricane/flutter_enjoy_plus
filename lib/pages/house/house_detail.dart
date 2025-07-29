import 'package:flutter/material.dart';

import '../../api/house.dart';

class HouseDetail extends StatefulWidget {
  const HouseDetail({super.key, required this.id});
  final String id;

  @override
  State<HouseDetail> createState() => _HouseDetailState();
}

class _HouseDetailState extends State<HouseDetail> {
  Map<String, dynamic>? house;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!widget.id.isEmpty) {
      _getHouseDetail();
    }
  }

  void _getHouseDetail() async {
    var res = await getHouseDetailAPI(widget.id);
    house = res;

    setState(() {});
  }

  String getDisplayName() {
    if (house != null) {
      return house!["point"] + '-' + house!["building"];
    }
    return "";
  }

  Widget getDetailWidget() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ListView(
          padding: const EdgeInsets.only(bottom: 100),
          children: [
            // 房屋信息
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text('房屋信息',
                  style: TextStyle(
                      color: Color.fromARGB(255, 97, 94, 94), fontSize: 16)),
            ),
            Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 15, bottom: 15),
                child: Row(
                  children: [
                    Expanded(child: Text(getDisplayName())),
                    tagBuilder(1)
                  ],
                )),
            // 业主信息
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text('业主信息',
                  style: TextStyle(
                      color: Color.fromARGB(255, 97, 94, 94), fontSize: 16)),
            ),
            Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 15, bottom: 15),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 60,
                      child: Text('房间号'),
                    ),
                    const SizedBox(width: 30),
                    Expanded(child: Text(house!["room"]))
                  ],
                )),
            Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 15, bottom: 15),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 60,
                      child: Text('业主'),
                    ),
                    const SizedBox(width: 30),
                    Expanded(child: Text(house!["name"]))
                  ],
                )),
            Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 15, bottom: 15),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 60,
                      child: Text('手机号'),
                    ),
                    const SizedBox(width: 30),
                    Expanded(child: Text(house!["mobile"]))
                  ],
                )),
            const SizedBox(height: 30),
            Container(
                padding: const EdgeInsets.all(10),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('本人身份证照片'),
                    Image.network(house!["idcardFrontUrl"], height: 200),
                    Image.network(house!["idcardBackUrl"], height: 200)
                  ],
                )),
          ],
        ),
        Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: 80,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {},
                      child: const Column(
                        children: [
                          SizedBox(
                            height: 8,
                            width: 120,
                          ),
                          Icon(Icons.delete),
                          Text('删除房屋'),
                          SizedBox(height: 8)
                        ],
                      )),
                  ElevatedButton(
                      onPressed: () {},
                      child: const Column(
                        children: [
                          SizedBox(
                            height: 8,
                            width: 120,
                          ),
                          Icon(Icons.edit),
                          Text('修改房屋'),
                          SizedBox(height: 8)
                        ],
                      ))
                ]))
      ],
    );
  }

  Widget tagBuilder(int status) {
    List tagList = [
      {},
      {
        "bgColor": const Color.fromARGB(50, 91, 177, 227),
        "textColor": const Color.fromARGB(255, 85, 145, 175),
        "title": "审核中"
      },
      {
        "bgColor": const Color.fromARGB(255, 91, 243, 91),
        "textColor": const Color.fromRGBO(1, 50, 1, 1),
        "title": "审核成功"
      },
      {
        "bgColor": const Color.fromARGB(255, 247, 129, 133),
        "textColor": const Color.fromARGB(255, 84, 1, 1),
        "title": "审核失败"
      }
    ];

    return Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
        decoration: BoxDecoration(
            color: tagList[status]['bgColor'],
            borderRadius: BorderRadius.circular(5)),
        child: Text('${tagList[status]['title']}',
            style: TextStyle(color: tagList[status]['textColor'])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('房源详情'),
          centerTitle: true,
        ),
        body: getDetailWidget());
  }
}
