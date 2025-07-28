import 'package:flutter/material.dart';

// 回调的设计 就是保证业务逻辑 和 UI 分离的   解耦
// showPhotoDialog(context, () { print('1') })
// showPhotoDialog(context, () { print('2') })
// showPhotoDialog(context, () { print('3') })
// showPhotoDialog(context, () { 业务逻辑... })
void showPhotoDialog(BuildContext context, Function callback) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            // 设置左上圆角20  右上圆角20
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // 设置下边框
                    border: Border(
                      bottom: BorderSide(color: Colors.black, width: 0.5),
                    ),
                  ),
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 相机的图标
                        Icon(Icons.camera_alt),
                        // 加点间距
                        SizedBox(
                          width: 15,
                        ),
                        Text('拍照'),
                      ],
                    ),
                    onTap: () {
                      //...
                    },
                  )),
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  // 设置下边框
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 0.5),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    //...
                    callback();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 相册的图标
                      Icon(Icons.photo),
                      // 加点间距
                      SizedBox(
                        width: 15,
                      ),
                      Text('相册'),
                    ],
                  ),
                ),
              ),
              Container(
                height: 60,
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    // ...
                    Navigator.of(context).pop(); // 无脑返回 可以直接写死
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 取消的图标
                      Icon(Icons.cancel),
                      // 加点间距
                      SizedBox(
                        width: 15,
                      ),
                      Text('取消'),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      });
}
