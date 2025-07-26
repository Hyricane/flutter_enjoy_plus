import 'package:flutter/material.dart';

class HouseItem extends StatefulWidget {
  const HouseItem({super.key});

  @override
  State<HouseItem> createState() => _HouseItemState();
}

class _HouseItemState extends State<HouseItem> {
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
              const Expanded(child: Text('仙基公寓')),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(50, 91, 177, 227),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  '已绑定',
                  style: TextStyle(
                    color: Color.fromARGB(255, 85, 145, 175),
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
                  '1栋2003室',
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
                  '张继科',
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
