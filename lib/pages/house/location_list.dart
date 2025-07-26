import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationList extends StatefulWidget {
  const LocationList({super.key});

  @override
  State<LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 向用户要位置的授权
    _requestLocationPermission();
  }

  _requestLocationPermission() async {
    // 网页 运行在 浏览器   => 网页的权限来自浏览器
    // 浏览器 运行在 系统中  =>  浏览器的权限来自系统(需要检查你们的系统有没有禁用 浏览器的位置权限)
    Permission.location
        .request(); // 请求位置权限  requestPermissionFromUser+module.json5中配权限
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('选择社区'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Row(
            children: [
              Text(
                '当前地址',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
          const SizedBox(height: 10),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(child: Text('北京市昌平区政府街19号')),
                Row(
                  children: [
                    Icon(Icons.location_searching_outlined, color: Colors.blue),
                    SizedBox(width: 2),
                    Text(
                      '重新定位',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                '附近社区',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
          const SizedBox(height: 10),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(child: Text('北京市昌平区政府街19号')),
                    Row(
                      children: [
                        Icon(Icons.arrow_forward_ios,
                            size: 16, color: Colors.black),
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
