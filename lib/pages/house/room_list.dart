import 'dart:math';

import 'package:flutter/material.dart';

class RoomList extends StatefulWidget {
  RoomList({super.key, required this.point, required this.building});

  String point;
  String building;

  @override
  State<RoomList> createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  // 1. 定义初始数据
  Map data = {
    'point': '', // 小区信息
    'building': '', // 楼栋信息
    'rooms': [
      // 101, 102, 201, 202, 301, 302,
      // 随机几层  6-10层
      // 一层几户  2-4户
    ], // 随机产生的房间号
  };

  @override
  void initState() {
    super.initState();
    // print(widget.point);
    // print(widget.building);
    _getRoomList();
  }

  void _getRoomList() {
    // mock数据
    data['point'] = widget.point;
    data['building'] = widget.building;
    data['rooms'] = generateRandomRooms(); // 两层for循环
    print(data);

    // 'rooms': [
    //   // 101, 102, 201, 202, 301, 302,
    //   // 随机几层  6-10层
    //   // 一层几户  2-4户
    // ], // 随机产生的房间号
    // 帮我基于以上业务随机得到一个rooms房间号数组
    // 需要随机几层 随机几户 最后数组应该是这个样子 [101, 102, 201, 202, 301, 302]

    setState(() {});
  }

  List<int> generateRandomRooms() {
    final Random random = Random();

    // 随机楼层数（6-10层）
    final int floorCount = random.nextInt(5) + 6; // 6-10

    // 随机生成每层的户数（2-4户）
    final int roomsPerFloor = random.nextInt(3) + 2; // 2-4

    final List<int> rooms = [];

    for (int floor = 1; floor <= floorCount; floor++) {
      for (int room = 1; room <= roomsPerFloor; room++) {
        // 生成房间号，格式为楼层+房间号（如101表示1楼1号）
        rooms.add(floor * 100 + room);
      }
    }

    return rooms;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('选择房间'),
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Container(
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                child: Row(children: [
                  Expanded(
                      child: Text(
                          '${data['point']}${data['building']}${data['rooms'][index]}室')),
                  const Row(children: [
                    Icon(Icons.arrow_forward_ios,
                        size: 16, color: Colors.black),
                  ])
                ]));
          },
          itemCount: (data['rooms'] as List).length,
        ));
  }
}
