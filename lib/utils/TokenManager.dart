import 'package:enjoy_plus_flutter_7/constants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  // 获取实例
  _getInstance() async {
    final SharedPreferences pre = await SharedPreferences.getInstance();
    return pre;
  }

  // 设置token
  Future<void> setToken(String token) async {
    final SharedPreferences pre = await _getInstance();
    pre.setString(GlobalConstants.TOKEN_KEY, token);
    // return '';
  }

  // 获取token
  Future<String> getToken() async {
    final SharedPreferences pre = await _getInstance();
    return pre.getString(GlobalConstants.TOKEN_KEY) ?? '';
  }

  // 删除token
  Future<void> removeToken() async {
    final SharedPreferences pre = await _getInstance();
    pre.remove(GlobalConstants.TOKEN_KEY);
  }
}

// 单例模式  封装这个类外面不用  用的是这个类的唯一这个实例
final TokenManager tokenManager = TokenManager();
