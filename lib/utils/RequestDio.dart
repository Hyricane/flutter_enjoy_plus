import 'package:dio/dio.dart';
import 'package:enjoy_plus_flutter_7/constants/index.dart';
import 'package:enjoy_plus_flutter_7/utils/PromptAction.dart';
import 'package:enjoy_plus_flutter_7/utils/TokenManager.dart';

class RequestDio {
  // 不暴露给外部用  用它发请求麻烦
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

    // 配置拦截器(新来的保安 啥也不会)
    _setInterceptors();
  }

  // 配置拦截器
  _setInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      // 添加一个请求拦截器  options请求配置对象 {}   handler处理函数对象
      // 触发时机:  请求到服务器之前 先走这个函数逻辑 然后再发出  =>  必须放行
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        // 为了保证后续逻辑正常执行  必须放行
        String token = tokenManager.getToken(); // ''
        if (token != '') {
          // 添加请求头
          options.headers['Authorization'] = 'Bearer $token';
          // options.headers['a'] = 'b';
        }
        handler.next(options); // 继续往后走逻辑
      },
      // 添加一个响应拦截器  response响应数据对象 {}   handler处理函数对象   =>  必须放行
      // 触发时机:  服务器返回数据到客户端之前 先走这个函数逻辑 然后再返回给客户端
      onResponse:
          (Response<dynamic> response, ResponseInterceptorHandler handler) {
        // handler.next(response); // 继续往后走逻辑

        // 根据情况判断
        // 目前只处理2xx 其他统一抛出异常
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          // 继续往下走
          handler.next(response);
        } else {
          // 4xx   401token问题  response.statusCode! == 401  清除token  回到登录 提示
          // 如果遇到2xx之外的状态码 应该处理一个失败的Future回去 有一个原因response.requestOptions
          // response.requestOptions 获取请求信息
          PromptAction.error(response.statusMessage ?? '网络错误');
          handler.reject(DioException(requestOptions: response.requestOptions));
        }
      },
      // 添加一个错误拦截器  exception异常对象 {}   handler处理函数对象   =>  必须放行
      onError: (DioException exception, ErrorInterceptorHandler handler) {
        // print('我错了...');
        // print(exception.response?.statusCode);
        // 401   404   500
        // 判断exception.response?.statusCode是否为401 如果是401 利用tokenManager清空token
        if (exception.response?.statusCode == 401) {
          // 清空token
          tokenManager.removeToken();
          // 跳转到登录页面  无法跳转 一会处理
          // Navigator.pu
          //提示重新登录
          PromptAction.error('token过期请重新登录');
        }

        handler.next(exception);
      },
    ));
  }

  // 封装一个get 替代他的get
  Future get(String path,
      {Map<String, dynamic>? params, Map<String, dynamic>? data}) async {
    // return _dio.get(path, queryParameters: params);

    var res = await _dio.get(path, queryParameters: params, data: data);
    return _handleResponse(res);
  }

  // 封装一个 post 替代他的post
  Future post(String path,
      {Map<String, dynamic>? data, Map<String, dynamic>? params}) async {
    var res = await _dio.post(path, data: data, queryParameters: params);
    return _handleResponse(res);
  }

  // 封装一个 put 替代他的put
  Future put(String path,
      {Map<String, dynamic>? data, Map<String, dynamic>? params}) async {
    var res = await _dio.put(path, data: data, queryParameters: params);
    return _handleResponse(res);
  }

  // 封装一个 delete 替代他的delete
  Future delete(String path,
      {Map<String, dynamic>? params, Map<String, dynamic>? data}) async {
    var res = await _dio.delete(path, queryParameters: params, data: data);
    return _handleResponse(res);
  }

  // 封装一个处理响应结果的函数  res.data['data']
  _handleResponse(Response<dynamic> res) {
    // 业务状态码  200      没拿到数据  拿到数据
    if (res.data['code'] == GlobalConstants.CODE) {
      // 10000 才有数据  剥离数据
      return res.data['data'];
    }

    // 提示
    PromptAction.error(res.data['message']);
    throw Exception(res.data['message']);
  }
}

final RequestDio requestDio = RequestDio();
// const int money = 1000;
// requestDio._dio.get('/xxx')  基础地址 超时时间  拦截器(请求头 错误处理)
