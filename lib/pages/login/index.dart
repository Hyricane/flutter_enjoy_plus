import 'dart:async';

import 'package:flutter/material.dart';

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

  void beginCountDown() {
    // 节流 保留第一次 用标记处理
    // 防抖 保留最后一次 用定时器处理 加延迟     关定时器 开定时器
    if (flag) return;

    flag = true;

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
                    // 倒计时开始
                    beginCountDown();
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
                      // 获取用户输入  控制器的text属性
                      print(phoneController.text);
                      print(codeController.text);
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
