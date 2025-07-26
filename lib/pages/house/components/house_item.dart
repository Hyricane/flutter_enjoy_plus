import 'package:flutter/material.dart';

class HouseItem extends StatefulWidget {
  const HouseItem({super.key, required this.item});

  final Map<String, dynamic> item;

  @override
  State<HouseItem> createState() => _HouseItemState();
}

class _HouseItemState extends State<HouseItem> {
  // 将数字 映射(一个对应一个)成一个个文字
  // Map<int, String> xx = {
  //   1: '审核中',
  //   2: '审核通过',
  //   3: '审核失败',
  // };
  // Map<int, Color> xx2 = {
  //   1: Color.fromRGBO(0, 0, 255, 1),
  //   2: Color.fromRGBO(0, 255, 0, 1),
  //   3: Color.fromRGBO(255, 0, 0, 1),
  // };
  // Map<int, Color> xx3 = {
  //   1: Color.fromRGBO(0, 0, 255, 0.3),
  //   2: Color.fromRGBO(0, 255, 0, 0.3),
  //   3: Color.fromRGBO(255, 0, 0, 0.3),
  // };

  // 优化一下上面的映射逻辑 变成一个大Map
  Map<int, dynamic> xxUltra = {
    1: {
      'text': '审核中',
      'color': Color.fromRGBO(0, 0, 255, 1),
      'bgColor': Color.fromRGBO(0, 0, 255, 0.3),
    },
    2: {
      'text': '审核通过',
      'color': Color.fromRGBO(0, 255, 0, 1),
      'bgColor': Color.fromRGBO(0, 255, 0, 0.3),
    },
    3: {
      'text': '审核未通过',
      'color': Color.fromRGBO(255, 0, 0, 1),
      'bgColor': Color.fromRGBO(255, 0, 0, 0.3),
    },
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text(widget.item['point'])),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                decoration: BoxDecoration(
                  color: xxUltra[widget.item['status']]['bgColor'],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  // widget.item['status'] == 1
                  //     ? '审核中'
                  //     : widget.item['status'] == 2
                  //         ? '审核通过'
                  //         : '审核未通过',
                  // xx[widget.item['status']]!,
                  xxUltra[widget.item['status']]['text'],
                  style: TextStyle(
                    color: xxUltra[widget.item['status']]['color'],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Text(
                '房间号',
                style: TextStyle(color: Colors.grey),
              ),
              Spacer(),
              Expanded(
                child: Text(
                  '${widget.item['building']} ${widget.item['room']}',
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Text(
                '业主',
                style: TextStyle(color: Colors.grey),
              ),
              Spacer(),
              Expanded(
                child: Text(
                  widget.item['name'],
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
