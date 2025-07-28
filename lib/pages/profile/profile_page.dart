import 'dart:io';

import 'package:enjoy_plus_flutter_7/utils/EventBus.dart';
import 'package:enjoy_plus_flutter_7/utils/PhotoDialog.dart';
import 'package:enjoy_plus_flutter_7/utils/PromptAction.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../api/user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.userInfo});

  final Map<String, dynamic> userInfo;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // 不是路由表配置的页面 无法直接获取参数
  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();

  //   var res =
  //       ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
  //   print(res['nickName']);
  // }

  TextEditingController _nickNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.userInfo['nickName'] != null &&
        widget.userInfo['nickName'] != '') {
      _nickNameController.text = widget.userInfo['nickName'];
    } else {
      _nickNameController.text = '游客';
    }
  }

  // 15012345678  我用了
  Widget _getAvatarWidget() {
    if (widget.userInfo['avatar'] != null && widget.userInfo['avatar'] != '') {
      if ((widget.userInfo['avatar'] as String).startsWith('/data')) {
        return Image.file(
          File(widget.userInfo['avatar']),
          width: 30,
          height: 30,
        );
      }
      return Image.network(
        widget.userInfo['avatar'],
        width: 30,
        height: 30,
      );
    } else {
      return Image.asset(
        'assets/images/avatar_1.jpg',
        width: 30,
        height: 30,
      );
    }
  }

  _testDebug() {
    // 断点 => 一旦代码开始调试 就会在断点处停下  需要手动执行一行行逻辑  排查问题
    print('测试');
    int num = 1;
    int num2 = 2;
    int num3 = 3;
    int sum = num + num2 + num3;
    print(sum);
  }

  _testDebug2() {
    // 断点 => 一旦代码开始调试 就会在断点处停下  需要手动执行一行行逻辑  排查问题
    print('测试');
    int num4 = 1;
    int num5 = 2;
    int num6 = 3;
    int sum = num4 + num5 + num6;
    print(sum);
  }

  // 上传头像的业务逻辑 抽离到了这个_selectAvatar
  _selectAvatar() async {
    // 下载image_picker  重启项目
    // 选择相册照片
    ImagePicker picker = ImagePicker(); // 创建实例
    // 利用实例去拉起相册选择照片
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      // 临时代码  一会需要上传  要将上传后的图片地址保存到数据中
      // widget.userInfo['avatar'] =
      //     file.path; // 选中照片的临时路径
      // setState(() {});
      // Navigator.pop(context);
      // if (kIsWeb) {
      // 鸿蒙端的代码大部分和web雷同 少部分调整
      // try {
      var res = await uploadAvatarAPI(file);
      print(res);
      widget.userInfo['avatar'] = res['url']; // 上传后的服务中的图片路径
      setState(() {});
      Navigator.pop(context);

      PromptAction.sucess('上传成功');
      eventBus.fire(LogSuccessEvent());
      // } catch (e) {
      //   print(e.toString());
      // }

      // 请求服务器上传
      // } else {
      //   print(file.path); // 临时展示一下
      //   widget.userInfo['avatar'] =
      //       file.path;
      //   setState(() {});
      //   // 关闭弹窗
      //   Navigator.of(context).pop();
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('个人信息'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          SizedBox(
            height: 40,
            child: Row(
              children: [
                const Text(
                  '头像',
                  style: TextStyle(fontSize: 16),
                ),
                const Spacer(),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // 底部弹出半模态 => 解耦的设计思想  业务和UI分离
                        showPhotoDialog(context, () {
                          // 上传头像
                          _selectAvatar();
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox(
                              width: 30,
                              height: 30,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: _getAvatarWidget(),
                              )),
                          const Icon(Icons.arrow_forward_ios, size: 12)
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Row(
            children: [
              Text('昵称'),
              Spacer(),
              Expanded(
                child: TextField(
                  controller: _nickNameController,
                  decoration: InputDecoration(
                    hintText: '请输入昵称',
                    border: InputBorder.none,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 12)
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 85, 145, 175),
                    minimumSize: const Size(100, 50),
                  ),
                  onPressed: () {
                    // 判断非空
                    if (_nickNameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('昵称不能为空'),
                        ),
                      );
                      return;
                    }
                    // 判断用户名是否是2-18位中文或字母或数字或下划线组成
                    if (!RegExp(r'^[\u4e00-\u9fa5a-zA-Z0-9_]{2,18}$')
                        .hasMatch(_nickNameController.text)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('昵称格式不正确'),
                        ),
                      );
                      return;
                    }
                    updateUserInfoAPI({
                      'nickName': _nickNameController.text,
                      // 相当于带着原来的头像 更新
                      // 'avatar': widget.userInfo['avatar'],
                    }).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('保存成功'),
                        ),
                      );
                      eventBus.fire(
                          LogSuccessEvent()); // 发布一个登录成功事件即可   更新minepage页面的用户信息(这个页面订阅了登录成功事件-就会立即请求后端最新的用户信息)
                    });
                  },
                  child: const Text(
                    '保存',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
