import 'dart:io';

import 'package:flutter/material.dart';

import 'amino.dart' as amino;

class Account {
  amino.Client client = amino.Client();
  String login = '';
  String password = '';
  bool enterState = false;
  String currentTab = '';
  String currentCommunity = '';
  List<String> currentChat = [];
  List<String> currentPost = [];

  Future<void> enter(String? login, String? password) async {
    Map<String, dynamic> data = await client.login(login ?? '', password ?? '');
    debugPrint(data.toString());
    if (data['api:statuscode'] == 0) {
      enterState = true;
    }
  }
  Future<void> register(String nickname, String login, String password, String verification) async {
    await client.verify(login, verification);
    Map<String, dynamic> data = await client.register(nickname, login, password, verification);
    debugPrint(data.toString());
    if (data['api:statuscode'] == 0) {
      enterState = true;
    }
  }
  Future<void> getValidationCode(String email) async {
    Map<String, dynamic> data = await client.getValidationCode(email);
    debugPrint(data.toString());
  }
  Future<List<List<String>>> getCommunities() async {
    Map<String, dynamic> data = await client.subClients();
    debugPrint(data.toString());
    return [];
  }
  List<List<String>> getChats() {
    Map<String, dynamic> data = {};
    client.getChats().then((value) {
      data = value;
    });
    debugPrint(data['threadList']);
    return data['threadList'] ?? [];
  }
  List<List<String>> getMessages(){
    return [];
    //TODO: create function
  }
  Future<void> createCommunity(
      String name,
      String tagLine,
      String iconPath,
      String themeColor,
      [int joinType = 0, String primaryLanguage = 'en']) async {
    dynamic aminoPath = await client.uploadMedia(iconPath);
    // TODO: add functionality
  }
  Future<Map<String, dynamic>> getUserInfo() async {
    Map<String, dynamic> data = await client.getUserInfo();
    debugPrint(data.toString());
    return data;
  }

  Future<void> createChat(String title) async {
    Map<String, dynamic> data = await client.createChat(title);
    debugPrint(data.toString());
  }
}
