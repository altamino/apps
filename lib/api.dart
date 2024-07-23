import 'package:flutter/material.dart';

import 'amino.dart' as amino;

class Account {
  amino.Client client = amino.Client();
  String login = '';
  String password = '';
  int enterState = 0;
  String currentTab = '';
  List<String> currentCommunity = [];
  List<String> currentChat = [];
  List<String> currentPost = [];

  Future<void> enter(String? login, String? password) async {
    Map<String, dynamic> data = await client.login(login ?? '', password ?? '');
    debugPrint(data.toString());
    if (data != null) {
      enterState = 200;
    }
    /*this.login = login ?? '';
    this.password = password ?? '';
    enterState = 200;*/
  }
  Future<void> register(String nickname, String login, String password, String verification) async {
    await client.verify(login, verification);
    Map<String, dynamic> data = await client.register(nickname, login, password, verification);
    debugPrint(data.toString());
    if (data != null) {
      enterState = 200;
    }
  }
  Future<void> getValidationCode(String email) async {
    Map<String, dynamic> data = await client.getValidationCode(email);
    debugPrint(data.toString());
  }
  List<List<String>> getCommunities() {
    return [['Сообщество 1', '1'], ['Сообщество 2', '2'], ['Сообщество 3', '3']];
  }
  List<List<String>> getChats() {
    return [['Чат 1', '1'], ['Чат 2', '2'], ['Чат 3', '3']];
  }
  List<List<String>> getMessages() {
    switch(currentChat[1]){
      case '1': return [['Сообщение 1', '1'], ['Сообщение 2', '2'], ['Сообщение 3', '3']];
      case '2': return [['Сообщение 4', '4'], ['Сообщение 5', '5'], ['Сообщение 6', '6']];
      case '3': return [['Сообщение 7', '7'], ['Сообщение 8', '8'], ['Сообщение 9', '9']];
      case '4': return [['Сообщение 10', '10'], ['Сообщение 11', '11'], ['Сообщение 12', '12']];
      case '5': return [['Сообщение 13', '13'], ['Сообщение 14', '14'], ['Сообщение 15', '15']];
      case '6': return [['Сообщение 16', '16'], ['Сообщение 17', '17'], ['Сообщение 18', '18']];
      case '7': return [['Сообщение 19', '19'], ['Сообщение 20', '20'], ['Сообщение 21', '21']];
      case '8': return [['Сообщение 22', '22'], ['Сообщение 23', '23'], ['Сообщение 24', '24']];
      case '9': return [['Сообщение 25', '25'], ['Сообщение 26', '26'], ['Сообщение 27', '27']];
      default: return [];
    }
  }
}
