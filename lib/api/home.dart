import 'package:enjoy_plus_flutter_7/constants/index.dart';

import '../utils/RequestDio.dart';

// 容易写错  基本不变  => 常量
getNotifyListAPI() => requestDio.get(HTTP_PATH.HOME_NOTIFY_LIST);

// 获取公告详情
getNotifyDetailAPI(String id) =>
    requestDio.get('${HTTP_PATH.HOME_NOTIFY_LIST}/$id');
