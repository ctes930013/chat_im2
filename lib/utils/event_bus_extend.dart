import 'package:chat_im/main.dart';
import 'package:event_bus/event_bus.dart';

extension EventBusExtent on EventBus {
  /*
  * 创建者：eric
  * 監聽某個key的事件
  * key: 事件名稱
  * eventFunc: 回調的方法
  * */
  listening(String key, Function eventFunc) {
    return eventBus.on().listen((event) {
      //{game_keyboard: {insert: 5}}
      Map mapEvent = event;
      String keys = "";
      mapEvent.forEach((key, value) {
        keys = key;
      });
      if (keys == key) {
        //找到事件
        eventFunc(mapEvent[keys]);
      }
    });
  }

  /*
  * 创建者：eric
  * 觸發某個key的事件
  * key: 事件名稱
  * data: 欲傳入的資料
  * */
  void emit(String key, dynamic data) {
    eventBus.fire({key: data});
  }
}
