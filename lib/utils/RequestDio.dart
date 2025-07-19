import 'package:dio/dio.dart';

class RequestDio {
  final Dio _dio = Dio();
  // int age = 18;

  // 实例化时调用这个同名构造函数
  RequestDio() {
    // 基础地址 超时时间
    _dio.options.baseUrl = 'https://live-api.itheima.net';
    _dio.options.connectTimeout = Duration(seconds: 5);
    _dio.options.sendTimeout = Duration(seconds: 5);
  }
}

final RequestDio requestDio = new RequestDio();
// const int money = 1000;
// requestDio._dio.get('/xxx')  基础地址 超时时间  拦截器(请求头 错误处理) 