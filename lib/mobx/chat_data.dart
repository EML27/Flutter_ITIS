import 'package:first_flutter_project/chattask/domain/entities.dart';
import 'package:mobx/mobx.dart';
import 'package:dio/dio.dart';

part 'chat_data.g.dart';

class MessageStateManager = _MessageStateManager with _$MessageStateManager;

abstract class _MessageStateManager with Store {
  @observable
  ObservableList<Message> data = ObservableList();

  @action
  void addMessage(Message msg) {
    data.add(msg);
  }

  @action
  void setData(List<Message> list) {
    data.clear();
    data.addAll(list);
  }

  @action
  Future<dynamic> loadData() async {
    try {
      var response =
          await Dio().get('https://itis-chat-app-ex.herokuapp.com/chat');
      var res =
          (response.data as List).map((e) => Message.fromJson(e)).toList();
      setData(res);
    } catch (e) {}
  }

  @action
  Future<dynamic> sendMessage(Message msg) async {
    try {
      await Dio().post('https://itis-chat-app-ex.herokuapp.com/chat',
          data: msg.toJson());
    } catch (e) {}

    loadData();
  }
}
