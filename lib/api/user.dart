// 用户相关的api请求封装在这里

import 'package:enjoy_plus_flutter_7/constants/index.dart';
import 'package:enjoy_plus_flutter_7/utils/RequestDio.dart';

// sendCodeAPI({'mobile': '123123123'})
sendCodeAPI(Map<String, dynamic> params) {
  return requestDio.get(HTTP_PATH.USER_SEND_CODE, params: params);
}
