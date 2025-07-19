import 'package:dio/dio.dart';
import 'package:enjoy_plus_flutter_7/constants/index.dart';

class RequestDio {
  final Dio _dio = Dio();
  // int age = 18;

  // 实例化时调用这个同名构造函数
  RequestDio() {
    // 基础地址 超时时间
    // _dio.options.baseUrl = GlobalConstants.BASE_URL;
    // _dio.options.connectTimeout = Duration(seconds: GlobalConstants.TIME_OUT);
    // _dio.options.sendTimeout = Duration(seconds: GlobalConstants.TIME_OUT);

    // dart中对 对象 连续赋值  可以使用..省略
    _dio.options
      ..baseUrl = GlobalConstants.BASE_URL
      ..connectTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
      ..sendTimeout = Duration(seconds: GlobalConstants.TIME_OUT);
  }
}

final RequestDio requestDio = new RequestDio();
// const int money = 1000;
// requestDio._dio.get('/xxx')  基础地址 超时时间  拦截器(请求头 错误处理) 