// 导出EventBus单例
import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

// 测试类  吃饭事件  EatEvent()
class EatEvent {
  String message = 'eat';
}

class LogoutEvent {
  final String message = "logout";
}

class LogSuccessEvent {
  final String info = "logsuccess";
}

// EventBus如何使用
// 订阅
// eventBus.on<EatEvent>().listen((event) {
//   // 监听
// });
// 发布一个具体的事件  
// eventBus.fire(EatEvent());
// eventBus.fire(SleepEvent());
