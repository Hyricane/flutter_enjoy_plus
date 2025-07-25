// 用户相关的api请求封装在这里

import 'package:dio/dio.dart';
import 'package:enjoy_plus_flutter_7/constants/index.dart';
import 'package:enjoy_plus_flutter_7/utils/RequestDio.dart';
import 'package:image_picker/image_picker.dart';

// sendCodeAPI({'mobile': '123123123'})
sendCodeAPI(Map<String, dynamic> params) {
  return requestDio.get(HTTP_PATH.USER_SEND_CODE, params: params);
}

// loginAPI({'mobile': '123123123', 'code': '123123'})
loginAPI(Map<String, dynamic> data) {
  return requestDio.post(HTTP_PATH.USER_LOGIN_CODE, data: data);
}

// 封装一个请求我的信息的API接口函数
getUserInfoAPI() {
  return requestDio.get(HTTP_PATH.USER_INFO);
}

// 封装一个请求更新用户信息的API接口函数  updateUserInfoAPI({'nickName': '张三', 'avatar': ''})
updateUserInfoAPI(Map<String, dynamic> data) {
  return requestDio.put(HTTP_PATH.USER_INFO, data: data);
}

// 封装一个请求上传用户头像的API接口函数
uploadAvatarAPI(XFile file) {
  // get post delete put
  // flutter中如何创建formdata实例
  FormData formData = FormData.fromMap({
    // flutter中如何将文件转二进制
    // 'file': await MultipartFile.fromFile(file.path, filename: file.name),
    'type': 'avatar',
  });

  return requestDio.upload(HTTP_PATH.USER_UPLOAD_AVATAR, data: formData);
}
