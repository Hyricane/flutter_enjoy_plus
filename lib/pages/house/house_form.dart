import 'dart:io';

import 'package:enjoy_plus_flutter_7/api/house.dart';
import 'package:enjoy_plus_flutter_7/api/user.dart';
import 'package:enjoy_plus_flutter_7/utils/PhotoDialog.dart';
import 'package:enjoy_plus_flutter_7/utils/PromptAction.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class HouseForm extends StatefulWidget {
  const HouseForm({super.key, required this.params});

  final Map<String, dynamic> params;

  @override
  State<HouseForm> createState() => _HouseFormState();
}

class _HouseFormState extends State<HouseForm> {
  final Map<String, dynamic> _formData = {
    'point': '', // 小区信息
    'building': '', // 小区楼栋信息
    'room': '', // 小区房间信息
    'name': '', // 业主姓名
    'gender': 1, // 业主性别0女1男
    'mobile': '', // 业主电话
    'idcardFrontUrl': '', // 身份证正面
    'idcardBackUrl': '', // 身份证背面
  };

  @override
  initState() {
    super.initState();
    _formData['point'] = widget.params['point'];
    _formData['building'] = widget.params['building'];
    _formData['room'] = widget.params['room'];
    setState(() {});
    print(_formData);
  }

  selectSFZ(String tag) async {
    // 自己的业务  通过回调 塞进去
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    // 关闭弹窗
    Navigator.of(context).pop();
    if (file != null) {
      var res = await uploadAvatarAPI(file, false);
      _formData[tag] = res['url']; // 传到服务器后的图片地址 存下来
      print(res['url']);
      setState(() {});
      // 上传到服务器 再展示
      // setState(() {
      //   _formData[tag] = file.path; // 临时展示
      // });
    }
  }

  // tag:  'idcardFrontUrl' 正面  'idcardBackUrl' 背面
  // 点击上传时  我需要区分这次上传正面还是背面  用tag区分
  // info: UI组件中的文字部分
  Widget _buildAddIdcardPhoto(String tag, String info) {
    return GestureDetector(
      onTap: () {
        showPhotoDialog(context, () {
          selectSFZ(tag);
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.add,
            size: 30,
            color: Color.fromARGB(255, 85, 145, 175),
          ),
          Text(
            info,
            style: TextStyle(
              color: Color.fromARGB(255, 85, 145, 175),
            ),
          ),
        ],
      ),
    );
  }

  getSFZPicture(String photoUrl) {
    if (kIsWeb || !photoUrl.startsWith('/data')) {
      // 只考虑了web平台 没有考虑别的平台 ios 安卓 鸿蒙
      return Image.network(photoUrl, fit: BoxFit.contain);
    } else {
      // 其他平台
      return Image.file(File(photoUrl), fit: BoxFit.contain);
    }
  }

  // tag 区分正面 背面
  // photoUrl 上传好的图片地址
  Widget _buildIdcardPhoto(String tag, String photoUrl) {
    return Stack(children: [
      SizedBox(
        width: MediaQuery.of(context).size.width - 20,
        height: 300,
        child: getSFZPicture(photoUrl),
      ),
      Positioned(
        right: 0,
        top: 0,
        child: GestureDetector(
          child: const Icon(Icons.delete, color: Colors.red),
          onTap: () {
            setState(() {
              _formData[tag] = '';
            });
          },
        ),
      )
    ]);
  }

  _submit() async {
    // 提交前 校验
    // 小区名 楼栋号 房间号 不能为空
    if (_formData['point'] == '' ||
        _formData['building'] == '' ||
        _formData['room'] == '') {
      PromptAction.error('请填写完整的小区信息');
      return;
    }
    // 业主名不能为空
    if (_formData['name'] == '') {
      PromptAction.error('请填写业主姓名');
      return;
    }
    // 业主名需要满足2-16位中文 需要考虑到少数民族名字中有·这种情况 需要用正则表达式
    if (!RegExp(r'^[\u4e00-\u9fa5]{2,20}(·[\u4e00-\u9fa5]{2,20}){0,4}$')
        .hasMatch(_formData['name'])) {
      PromptAction.error('请填写2-16位中文的业主姓名');
      return;
    }
    // 业主电话不能为空
    if ((_formData['mobile'] as String).isEmpty) {
      PromptAction.error('请填写业主电话');
      return;
    }
    // 业主电话格式校验
    if (!RegExp(r'^1[3-9]\d{9}$').hasMatch(_formData['mobile'])) {
      PromptAction.error('请填写正确的手机号码');
      return;
    }

    // 身份证照片不能为空
    if ((_formData['idcardFrontUrl'] as String).isEmpty) {
      PromptAction.error('请上传身份证正面照片');
      return;
    }
    if ((_formData['idcardBackUrl'] as String).isEmpty) {
      PromptAction.error('请上传身份证背面照片');
      return;
    }

    print('完成校验 等待请求');
    print(_formData);

    await addHouseAPI(_formData);
    // 提示
    PromptAction.sucess('添加成功');
    // 返回
    // Navigator.pop(context);
    // Navigator.pop(context);
    // Navigator.pop(context);
    // Navigator.pop(context);
    // Navigator.pop(context);  一直返回 直到某个页面 停下来(回调函数的返回值一旦是true 停在这个页面 不再返回)
    // 返回到指定的页面
    Navigator.popUntil(context, (Route<dynamic> route) {
      // 直到有一个页面的路由名是 /house
      return route.settings.name == '/house';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('添加房屋信息'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        children: [
          // 房屋信息
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              '房屋信息',
              style: TextStyle(
                  color: Color.fromARGB(255, 97, 94, 94), fontSize: 16),
            ),
          ),
          Container(
            color: Colors.white,
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
            child: Text(
                '${_formData['point']} ${_formData['building']} ${_formData['room']}'),
          ),
          // 业主信息
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              '业主信息',
              style: TextStyle(
                  color: Color.fromARGB(255, 97, 94, 94), fontSize: 16),
            ),
          ),
          // 业主姓名
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              maxLength: 15,
              decoration: const InputDecoration(
                labelText: '姓名',
                hintText: '请输入业主姓名',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(15),
              ],
              onChanged: (String value) {
                setState(() {
                  _formData['name'] = value;
                });
              },
            ),
          ),
          // 性别
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                const Text(
                  '性别',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 20),
                Radio(
                  value: 1, // 当前单选框的值
                  groupValue: _formData['gender'], // Radio默认选中的值
                  onChanged: (value) {
                    // 选中状态改变时 触发onChange
                    setState(() {
                      _formData['gender'] = value ?? '';
                      // print('object');
                      // PromptAction.sucess('选中了${_formData['gender']}');
                    });
                  },
                ),
                const Text('男'),
                const SizedBox(width: 10),
                Radio(
                  value: 0,
                  groupValue: _formData['gender'],
                  onChanged: (value) {
                    setState(() {
                      _formData['gender'] = value ?? '';
                      // PromptAction.sucess('选中了${_formData['gender']}');
                    });
                  },
                ),
                const Text('女'),
              ],
            ),
          ),
          // 业主手机号
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextField(
                keyboardType: TextInputType.phone,
                maxLength: 11, // 最大长度
                decoration: const InputDecoration(
                  labelText: '手机号',
                  hintText: '请输入您的手机号',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(11),
                ], // 限制输入长度
                onChanged: (String value) {
                  setState(() {
                    _formData['mobile'] = value;
                  });
                }),
          ),
          // 业主信息
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              '本人身份证照片',
              style: TextStyle(
                  color: Color.fromARGB(255, 97, 94, 94), fontSize: 16),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: const Text(
              '请拍摄证件原件，并使照片中证件边缘完整，文字清晰，光线均匀。',
              style: TextStyle(
                  color: Color.fromARGB(255, 97, 94, 94), fontSize: 12),
            ),
          ),
          // 身份证正面
          Container(
            color: Colors.white,
            height: 320,
            padding: const EdgeInsets.all(10),
            child: _formData['idcardFrontUrl'] == '' // 没有上传 显示上传组件
                ? _buildAddIdcardPhoto('idcardFrontUrl', '上传人像面照片')
                : _buildIdcardPhoto(
                    'idcardFrontUrl',
                    _formData['idcardFrontUrl'], // 上传图片地址
                  ),
          ),
          const SizedBox(height: 20),
          // 身份证反面
          Container(
            color: Colors.white,
            height: 320,
            padding: const EdgeInsets.all(10),
            child: _formData['idcardBackUrl'] == '' // 身份证背面图片为空 显示上传组件
                ? _buildAddIdcardPhoto('idcardBackUrl', '上传国徽面照片')
                : _buildIdcardPhoto(
                    'idcardBackUrl',
                    _formData['idcardBackUrl'],
                  ),
          ),
          const SizedBox(height: 20),
          // 提交审核
          Container(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                _submit();
              },
              child: const Column(
                children: [
                  SizedBox(height: 8),
                  Icon(Icons.exit_to_app),
                  Text('提交审核'),
                  SizedBox(height: 8)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
