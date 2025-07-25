import 'package:flutter/material.dart';

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
    }
  }

  Widget _getAvatarWidget() {
    if (widget.userInfo['avatar'] != null && widget.userInfo['avatar'] != '') {
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: _getAvatarWidget(),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 12)
                  ],
                )
              ],
            ),
          ),
          Row(
            children: [
              Text(widget.userInfo['nickName']),
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
                  onPressed: () {},
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
