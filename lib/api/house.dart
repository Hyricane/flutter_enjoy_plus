import '../constants/index.dart';
import '../utils/RequestDio.dart';

Future<dynamic> getHouseListAPI() => requestDio.get(HTTP_PATH.HOUSE_LIST);
