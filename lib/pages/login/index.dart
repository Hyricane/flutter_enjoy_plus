import 'dart:async';

import 'package:enjoy_plus_flutter_7/api/user.dart';
import 'package:enjoy_plus_flutter_7/utils/TokenManager.dart';
import 'package:flutter/material.dart';

import '../../utils/PromptAction.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  Timer? _timer;
  int _count = 6;
  // 标记是否在倒计时期间 默认不在倒计时
  bool flag = false;

  // 彻底销毁的钩子 => 保证内存合理释放
  @override
  void dispose() {
    super.dispose();
    _timer?.cancel(); // 离开页面取消 倒计时
  }

  void beginCountDown() {
    // 节流 保留第一次 用标记处理
    // 防抖 保留最后一次 用定时器处理 加延迟     关定时器 开定时器
    // if (flag) return;

    // flag = true;

    // 倒计时
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _count--;
      });
      if (_count == 0) {
        flag = false;
        _timer?.cancel();

        setState(() {
          _count = 6;
        });
      }
    });
  }

  Widget getTimeShow() {
    if (_count < 6) {
      return Text('$_count 秒后重新获取');
    }
    // 60秒 点击获取验证码
    return Text('获取验证码');
  }

  void sendCode() async {
    if (flag) return;
    flag = true;
    // 验证
    if (phoneController.text.isEmpty) {
      // PromptAction.info('请输入手机号');
      PromptAction.error('你输入一下手机号');
      return;
    }
    //       /^1[3-9]\d{9}$/.test()
    //       new RegExp()
    // flutter 中 正则 RegExp(r'^1[3-9]\d{9}$')
    if (!RegExp(r'^1[3-9]\d{9}$').hasMatch(phoneController.text)) {
      PromptAction.error('手机号格式不正确');
      return;
    }

    // 请求后端 发送验证码(整合三家运营商 电信移动联通)
    // 实际开发 验证码不应该返回给客户端 不安全  容易被黑客截取 然后盗用身份进入一些重要的数据
    // 学习环节才有的操作  后端强行将验证码返回给你了(不涉及重要数据)
    var code = await sendCodeAPI({'mobile': phoneController.text});
    PromptAction.info('验证码已发送 请查收');
    print(code);

    // 倒计时(防止用户疯狂点击)
    beginCountDown();

    // if (!RegExp(r'^1[3-9]\d{9}$').hasMatch(phoneController.text)) {
    //   // PromptAction.info('请输入正确的手机号');
    //   PromptAction.error('请输入正确的手机号');
    //   return;
    // }
  }

  Future<void> login() async {
    if (phoneController.text.isEmpty) {
      PromptAction.info('请输入手机号');
      return;
    }
    if (codeController.text.isEmpty) {
      PromptAction.info('请输入验证码');
      return;
    }
    // 手机号格式校验
    if (!RegExp(r'^1[3-9]\d{9}$').hasMatch(phoneController.text)) {
      PromptAction.info('请输入正确的手机号');
      return;
    }
    // 验证码格式校验
    if (!RegExp(r'^\d{6}$').hasMatch(codeController.text)) {
      PromptAction.info('请输入正确的验证码');
      return;
    }

    var res = await loginAPI(
        {'mobile': phoneController.text, 'code': codeController.text});
    print(res);

    // 关闭倒计时
    _timer?.cancel();

    // 提示
    PromptAction.sucess('登录成功');

    // 存token
    tokenManager.setToken(res['token']);

    // 跳转
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('登录'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '登录',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  '加入享+, 让生活更轻松',
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),
            const SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  // flutter中输入框 没有双绑 => 取而代之的是 控制器
                  // 获取用户输入
                  child: TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: '手机号',
                      hintText: '请输入手机号',
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shadowColor: Colors.transparent,
                    foregroundColor: const Color.fromARGB(255, 85, 145, 175),
                    minimumSize: const Size(100, 50),
                  ),
                  onPressed: () {
                    sendCode();
                    // 0.验证手机号格式
                    // 1.请求服务发短信
                    // 2.倒计时
                    // beginCountDown();
                  },
                  child: getTimeShow(),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: codeController,
              decoration: InputDecoration(
                labelText: '验证码',
                hintText: '请输入6位验证码',
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '未注册手机号经验证后将自动登录',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 85, 145, 175),
                      minimumSize: const Size(100, 50),
                    ),
                    onPressed: () {
                      // // 获取用户输入  控制器的text属性
                      // print(phoneController.text);
                      // print(codeController.text);

                      // 验证手机号和验证码格式  正则
                      // 请求
                      login();
                    },
                    child: const Text(
                      '登录',
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
      ),
    );
  }
}
