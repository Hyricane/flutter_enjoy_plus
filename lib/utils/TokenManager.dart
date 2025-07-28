import 'package:enjoy_plus_flutter_7/constants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  // 给当前类添加了一个私有属性
  String? _token;
  // 添加一个刷新token属性
  String? _refreshToken;

  // 获取实例
  _getInstance() async {
    final SharedPreferences pre = await SharedPreferences.getInstance();
    return pre;
  }

  // 设置token
  Future<void> setToken(String token, {String? refreshToken}) async {
    final SharedPreferences pre = await _getInstance();
    // 持久化
    pre.setString(GlobalConstants.TOKEN_KEY, token);
    // 更新_token   后续通过getToken 获取_token
    _token = token;

    if (refreshToken != null) {
      pre.setString(GlobalConstants.REFRESH_TOKEN_KEY, refreshToken);
      _refreshToken = refreshToken;
    }
    // return '';
  }

  // 获取token => 如何让一个异步变成同步(编程技巧)
  // Future<String> getToken() async {
  //   final SharedPreferences pre = await _getInstance();
  //   return pre.getString(GlobalConstants.TOKEN_KEY) ?? '';
  // }

  // 初始化token => 项目一进入 必须初始化  tabbar_page
  initToken() async {
    final SharedPreferences pre = await _getInstance();
    _token = pre.getString(GlobalConstants.TOKEN_KEY);
    _refreshToken = pre.getString(GlobalConstants.REFRESH_TOKEN_KEY);
  }

  // 后续获取token 的公有方法
  String getToken() {
    return _token ?? '';
  }

  String getRefreshToken() {
    return _refreshToken ?? '';
  }

  // 删除token
  Future<void> removeToken() async {
    final SharedPreferences pre = await _getInstance();
    // 清空持久化
    pre.remove(GlobalConstants.TOKEN_KEY);
    // 清空_token
    _token = '';
    pre.remove(GlobalConstants.REFRESH_TOKEN_KEY);
    _refreshToken = '';
  }
}

// 单例模式  封装这个类外面不用  用的是这个类的唯一这个实例
final TokenManager tokenManager = TokenManager();
