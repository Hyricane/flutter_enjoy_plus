import 'package:dio/dio.dart';
import 'package:enjoy_plus_flutter_7/constants/index.dart';
import 'package:enjoy_plus_flutter_7/utils/EventBus.dart';
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

  // 请求刷新token
  Future<bool> _refreshToken() async {
    try {
      // 不能再用_dio请求了  里面存的是过期的token
      // return _dio.post(
      //   HTTP_PATH.USER_REFRESH_TOKEN,
      // );
      String refreshToken = tokenManager.getRefreshToken();

      Dio dio = Dio(); // 创建一个新的dio实例请求
      var res = await dio.post(
          GlobalConstants.BASE_URL + HTTP_PATH.USER_REFRESH_TOKEN,
          options: Options(headers: {'Authorization': 'Bearer $refreshToken'}));

      if (res.data['code'] == GlobalConstants.CODE) {
        // 刷新token成功!!!!
        tokenManager.setToken(res.data['data']['token'],
            refreshToken: res.data['data']['refreshToken']);
        return true;
      } else {
        // 刷新token失败!!!!
        return false;
      }
      // 后端返回的数据
    } catch (e) {
      // 刷新token失败!!!!
      return false;
    }
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
      onError: (DioException exception, ErrorInterceptorHandler handler) async {
        // print('我错了...');
        // print(exception.response?.statusCode);
        // 401   404   500
        // 判断exception.response?.statusCode是否为401 如果是401 利用tokenManager清空token
        if (exception.response?.statusCode == 401) {
          // 一旦发现401 先看看refreshToken
          var refreshToken = tokenManager.getRefreshToken();
          if (refreshToken != '') {
            // 有refreshToken => 请求后端刷新token(封装函数)
            bool isOk = await _refreshToken(); // 刷新token的成功与否
            if (isOk) {
              // 刷新成功!!!

              // 重新发之前错的请求 => 用户"无感"
              // exception.requestOptions; // 错误请求的相关配置(请求方式  请求参数  请求地址)
              // _dio.get(exception.requestOptions;) // _dio可以用了  已经刷新token了
              // _dio.fetch 通用请求
              // 请求毕竟是401  也就意味着 这个请求 是个失败的future
              // handler.resolve(response)
              // 请求重新发
              // 页面中要的是结果
              // 返回 => 打断他 next
              // return await _dio.fetch(exception.requestOptions); // _dio可以用了  已经刷新token了
              //  return;

              // 将重新发送的请求 的成功结果  包装成一个成功的promise  返回给页面
              var newRes = await _dio.fetch(exception.requestOptions);
              return handler.resolve(newRes); // Promise.resolve()

              // _dio.fetch(RequestOptions());   axios({method: 'get',})   axios.get('xxxx')  axios.post
            } else {
              // 刷新失败
              // 无refreshToken
              // 清空token
              tokenManager.removeToken();
              // flutter 的三方库有一个发布订阅叫eventbus
              // 下载 使用
              // 跳转到登录页面  无法跳转 一会处理 => emitter  发布订阅模式  eventhub   eventbus
              eventBus.fire(LogoutEvent()); // login   logout
              // Navigator.pu
              // 提示重新登录
              PromptAction.error('token过期请重新登录');
            }
          } else {
            // 无refreshToken
            // 清空token
            tokenManager.removeToken();
            // flutter 的三方库有一个发布订阅叫eventbus
            // 下载 使用
            // 跳转到登录页面  无法跳转 一会处理 => emitter  发布订阅模式  eventhub   eventbus
            eventBus.fire(LogoutEvent()); // login   logout
            // Navigator.pu
            // 提示重新登录
            PromptAction.error('token过期请重新登录');
          }

          // // 清空token
          // tokenManager.removeToken();
          // // flutter 的三方库有一个发布订阅叫eventbus
          // // 下载 使用
          // // 跳转到登录页面  无法跳转 一会处理 => emitter  发布订阅模式  eventhub   eventbus
          // eventBus.fire(LogoutEvent()); // login   logout
          // // Navigator.pu
          // // 提示重新登录
          // PromptAction.error('token过期请重新登录');
        }

        handler.next(exception); // 带着这个异常往下执行 然后数据就传回页面了
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

  // 封装一个 post 替代他的post
  Future upload(String path,
      {FormData? data, Map<String, dynamic>? params}) async {
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
