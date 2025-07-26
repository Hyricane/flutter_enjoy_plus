import 'package:dio/dio.dart';
import 'package:enjoy_plus_flutter_7/constants/index.dart';
import 'package:enjoy_plus_flutter_7/utils/PromptAction.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class LocationList extends StatefulWidget {
  const LocationList({super.key});

  @override
  State<LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  String _address = '获取中...';
  List list = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 向用户要位置的授权
    if (kIsWeb) {
      // 单独处理web 不要授权过程 直接获取经纬度!!!
      _getLocation();
      // _requestLocationPermission();
    } else {
      _requestLocationPermission();
    }
  }

  // 授权
  _requestLocationPermission() async {
    // 网页 运行在 浏览器   => 网页的权限来自浏览器
    // 浏览器 运行在 系统中  =>  浏览器的权限来自系统(需要检查你们的系统有没有禁用 浏览器的位置权限)
    PermissionStatus status = await Permission.location
        .request(); // 请求位置权限  requestPermissionFromUser+module.json5中配权限
    if (status == PermissionStatus.granted) {
      print('获取位置权限成功');
      // 获取当前位置的经纬度 封装一个函数
      _getLocation();
    } else {
      print('获取位置权限失败');
    }
  }

  // 获取经纬度
  _getLocation() async {
    Position p = await Geolocator.getCurrentPosition();
    print('${p.longitude} ${p.latitude}');
    // 经纬度转出具体的位置呢?? 三方库(高德)   鸿蒙全是内置的模块

    // 封装函数 逆地理编码
    _getAddress(p.longitude, p.latitude);
    _getNearbyCommunity(p.longitude, p.latitude);
  }

  // 获取地址
  _getAddress(double longitude, double latitude) async {
    Dio dio = Dio();
    var res = await dio.get(
        '${GlobalConstants.GD_BASE_URL}${HTTP_PATH.REVERSE_GEOCODING}',
        queryParameters: {
          'key': 'dd47b6b234842e9a25de0f90e46b243d',
          'location': '$longitude,$latitude',
        });
    print(res);
    if (res.data['infocode'] == '10000') {
      setState(() {
        _address = res.data['regeocode']['formatted_address'];
      });
    } else {
      // print('逆地理编码失败');
      PromptAction.error('逆地理编码失败');
    }
  }

  // 获取周边小区
  _getNearbyCommunity(double longitude, double latitude) async {
    Dio dio = Dio();
    var res = await dio.get('${GlobalConstants.GD_BASE_URL}${HTTP_PATH.AROUND}',
        queryParameters: {
          'key': 'xxxx', // 标识使用者的身份信息
          // 'key': 'dd47b6b234842e9a25de0f90e46b243d', // 标识使用者的身份信息
          'location': '$longitude,$latitude', // 经纬度
          'keywords': '养生', // 搜索周边的什么
          'radius': 3000, // 搜索区域的半径  1000米
          'offset': 10 // 搜索结果的数量
        });
    print(res.data['pois']);
    if (res.data['infocode'] == '10000') {
      setState(() {
        list = res.data['pois']; // 周边公交站   map
      });
    } else {
      // print('逆地理编码失败');
      PromptAction.error('周边搜索失败');
    }
  }

  List<Widget> getListChildren() {
    return list.map((item) {
      return Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(child: Text(item['name'])),
            Row(
              children: [
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
              ],
            )
          ],
        ),
      );
    }).toList();
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
                Expanded(child: Text(_address)),
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
              children: getListChildren()
              // [
              //   Container(
              //     color: Colors.white,
              //     padding: const EdgeInsets.all(10),
              //     child: Row(
              //       children: [
              //         Expanded(child: Text('北京市昌平区政府街19号')),
              //         Row(
              //           children: [
              //             Icon(Icons.arrow_forward_ios,
              //                 size: 16, color: Colors.black),
              //           ],
              //         )
              //       ],
              //     ),
              //   )
              // ],
              )
        ],
      ),
    );
  }
}
