import '../constants/index.dart';
import '../utils/RequestDio.dart';

Future<dynamic> getHouseListAPI() => requestDio.get(HTTP_PATH.HOUSE_LIST);

// 封装一个新增房屋的api接口函数
Future<dynamic> addHouseAPI(Map<String, dynamic> data) =>
    requestDio.post(HTTP_PATH.HOUSE_LIST, data: data);
//获取房屋详情

Future<dynamic> getHouseDetailAPI(id) =>
    requestDio.get('${HTTP_PATH.HOUSE_LIST}/$id');
// 删除房屋
Future<dynamic> delHouseAPI(id) =>
    requestDio.delete('${HTTP_PATH.HOUSE_LIST}/$id');
