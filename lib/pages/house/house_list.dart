import 'package:flutter/material.dart';

import '../../api/house.dart';
import 'components/house_item.dart';

// 定义一个接口路径
// 封装一个api函数
// 组件内封装一个调用请求的函数  fn   定义状态  赋值 setState(() {})
// initState中  fn()
// 渲染UI

class HouseList extends StatefulWidget {
  const HouseList({super.key});

  @override
  State<HouseList> createState() => _HouseListState();
}

class _HouseListState extends State<HouseList> {
  List list = []; // 定义数组

  void getHouseList() async {
    list = await getHouseListAPI();
    print(list);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHouseList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 238, 238),
      appBar: AppBar(
        title: const Text('我的房屋'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 80, left: 10, right: 10),
            child: ListView.separated(
              // 自己手动循环遍历生成一个个结构
              // 自动完成遍历  只需要你提供一个结构
              itemBuilder: (BuildContext context, int index) {
                return HouseItem(item: list[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  height: 10,
                  color: const Color.fromARGB(255, 241, 238, 238),
                );
              },
              itemCount: list.length,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(10),
              color: Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          Icon(Icons.add),
                          Text('添加房屋'),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
