// 全局常量类
class GlobalConstants {
  // 静态属性实现
  static const String BASE_URL = 'https://live-api.itheima.net';
  static const String GD_BASE_URL = 'https://restapi.amap.com/v3';
  static const int TIME_OUT = 5;
  static const int CODE = 10000;
  // token存储键
  static const String TOKEN_KEY = 'enjoy_plus_token';
  // 刷新token存储的键
  static const String REFRESH_TOKEN_KEY = 'enjoy_plus_refresh_token';
}

class HTTP_PATH {
  static const String HOME_NOTIFY_LIST = '/announcement';
  static const String USER_SEND_CODE = '/code';
  static const String USER_LOGIN_CODE = '/login';
  // 请求我的信息的路径
  static const String USER_INFO = '/userInfo';
  // 刷新token的接口路径
  static const String USER_REFRESH_TOKEN = '/refreshToken';
  // 更新用户信息的接口路径
  // static const String USER_UPDATE = '/userInfo';
  // 上传头像的接口路径
  static const String USER_UPLOAD_AVATAR = '/upload';
  static const String HOUSE_LIST = '/room'; // 房屋列表
  // 逆地理编码的接口路径
  static const String REVERSE_GEOCODING = '/geocode/regeo';
  static const String AROUND = "/place/around"; // 周边地址
  // static const String  = '/geocode/regeo'; // 逆地理编码的接口路径
}


// const int money = 10000;