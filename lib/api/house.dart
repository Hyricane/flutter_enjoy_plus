import '../constants/index.dart';
import '../utils/RequestDio.dart';

Future<dynamic> getHouseListAPI() => requestDio.get(HTTP_PATH.HOUSE_LIST);

// 封装一个新增房屋的api接口函数
Future<dynamic> addHouseAPI(Map<String, dynamic> data) =>
    requestDio.post(HTTP_PATH.HOUSE_LIST, data: data);
