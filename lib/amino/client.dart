import 'package:dio/dio.dart';
import 'core/generators.dart';
import 'constants.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:mime/mime.dart';


class Client {
  final httpClient = Dio();
  String deviceId = genDeviceId();
  int comId = 0;
  String chatId = '';
  String userId = '';
  static final Client _singleton = Client._();

  factory Client() {
    return _singleton;
  }

  Client._() {
    httpClient.interceptors.add(requestWrapper);
    httpClient.options = customOptions;
    httpClient.options.headers["NDCDEVICEID"] = deviceId;
  }

  void setComId(int comId) {
    _singleton.comId = comId;
  }

  int getComId() {
    return _singleton.comId;
  }

  void setChatId(String chatId) {
    _singleton.chatId = chatId;
  }

  String getChatId() {
    return _singleton.chatId;
  }

  Future<Map<String, dynamic>> post(String url,  {dynamic data, Map<String, dynamic>? headers}) async {
    try {
      final response = await httpClient.post(
          url,
          data: data,
          options: Options(headers: headers)
      );
      return response.data;
    } catch(e) {
      print(e.toString());
      print('separator');
      try {
        return json.decode(e.toString());
      } on FormatException {
        return {'error': 'Empty responce from server'};
      } catch (e) {
        return {'error': e.toString()};
      }
    }
  }
  Future<Map<String, dynamic>> get(String url, {Map<String, dynamic>? queryData, Map<String, dynamic>? headers}) async {
    try {
      final response = await httpClient.get(
          url,
          queryParameters: queryData
      );
      return response.data;
    } catch (error1) {
      print(error1.toString());
      print('separator');
      try {
        return json.decode(error1.toString());
      } on FormatException {
        return {'error': 'Empty responce from server'};
      } catch (error2) {
        return {'error': error2.toString()};
      }
    }
  }

  Future<String> login(String email, String password) async {
    final Map<String, dynamic> data = {
      "email": email,
      "secret": "0 $password",
      "clientType": 100,
      "v": 2,
      "deviceID": deviceId
    };

    final responseData = await post("/g/s/auth/login", data: data);

    if (responseData['error'] != null) {
      return responseData['error'];
    }

    httpClient.options.headers["NDCAUTH"] = "sid=${responseData["sid"]}";
    httpClient.options.headers["AUID"] = responseData["account"]["uid"];

    userId = responseData["account"]["uid"];

    return 'OK';
  }
  Future<Map<String, dynamic>> verify(String email, String code) async {
    final Map<String, dynamic> data = {
      "validationContext": {
        "type": 1,
        "identity": email,
        "data": {"code": code}
      },
      "deviceID": deviceId,
    };
    return await post("/g/s/auth/check-security-validation", data: data);
  }
  Future<Map<String, dynamic>> register(
      String nickname, String email, String password, String verification) async {
    final Map<String, dynamic> data = {
      "secret": "0 $password",
      "deviceID": deviceId,
      "email": email,
      "clientType": 100,
      "nickname": nickname,
      "latitude": 0,
      "longitude": 0,
      "address": null,
      "clientCallbackURL": "narviiapp://relogin",
      "validationContext": {
        "data": {
          "code": verification
        },
        "type": 1,
        "level": 1,
        "identity": email
      },
      "type": 1,
      "identity": email
    };
    
    final response = await post("/g/s/auth/register", data:data);
    httpClient.options.headers["NDCAUTH"] = "sid=${response["sid"]}";
    httpClient.options.headers["AUID"] = response["account"]["uid"];
    return response;
  }

  Future<Map<String, dynamic>> getValidationCode(String email) async {
    final Map<String, dynamic> data = {
      "deviceID": deviceId,
      "type": 1,
      "identity": email
    };
    
    return await post("/g/s/auth/request-security-validation", data: data);
  }

  /* TODO: Future<Map<String, dynamic>> createCommuniy() async {
    
  } */

  Future<Map<String, dynamic>> uploadMedia(String filePath) async {
    // TODO: create upload
    File file = File(filePath);
    Uint8List data = await file.readAsBytes();

    Digest fileHash = sha1.convert(data);
    String mimeType = lookupMimeType(filePath) ?? 'image/jpeg';

    return await post("/g/s/media/upload");
  }

  Future<Map<String, dynamic>> subClients() async {
    // TODO: create get communities function
    return await get("/g/s/community/joined", queryData: {"start": 0, "size": 100});
  }

  Future<Map<String, dynamic>> getFromCode(String url) async {
    return await get("/g/s/link-resolution", queryData: {"q": url});
  }

  Future<Map<String, String>> getChats({int start = 0, int size = 100}) async{
    Map<String, dynamic> data = {
      "start": start,
      "size": size,
      "type": "joined-me"
    };
    Map<String, dynamic> responceData = await get("/g/s/chat/thread", queryData: data);
    List<dynamic> forData = responceData['threadList'];
    Map<String, String> returnData = {};
    for (int i = 0; i < forData.length; i++) {
      returnData[forData[i]['title']] = forData[i]['threadId'];
    }
    return returnData;
  }

  Future<Map<String, dynamic>> getUserInfo() async {
    return await get("/g/s/account");
  }

  Future<Map<String, dynamic>> createChat(String title, {String? message, String? content}) async {
    Map<String, dynamic> data = {
      "title": title,
      "inviteeUids": [],
      "initialMessageContent": message ?? 'Welcome',
      "content": content ?? 'New chat',
      "type": 0,
      "publishToGlobal": true
    };
    Map<String, dynamic> responceData = await post("/g/s/chat/thread", data: data);
    return responceData;
  }

  Future<Map<String, List<String>>> getMessages([int start = 0, int size = 100]) async {
    Map<String, dynamic> responceData = await get(
        "/g/s/chat/thread/$chatId/message",
        queryData: {'v': 2, "pagingType": "t", "start": start, "size": size}
    );
    List<dynamic> forData = responceData['messageList'];
    Map<String, List<String>> returnData = {};
    for (int i = 0; i < forData.length; i++) {
      returnData[forData[i]['messageId']] = [forData[i]['author']['nickname'], forData[i]['content'] ?? ''];
    }
    return returnData;
  }

  Future<Map<String, dynamic>> getComInfo(int comId) async {
    return await get("/g/s-x$comId/community/info");
  }

  Future<Map<String, dynamic>> sendMessage(String content) async {
    Map<String, dynamic> data = {
      'type': 0,
      'content': content
    };
    Map<String, dynamic> responceData = await post("/g/s/chat/thread/$chatId/message", data: data);
    return responceData;
  }

  Future<Map<String, String>> searchChats(String query) async {
    Map<String, dynamic> responceData = await get(
        "/g/s/chat/thread/explore/search",
        queryData: {
          'q': query
        }
    );

    List<dynamic> forData = responceData['threadListWrapper']['threadList'];
    Map<String, String> returnData = {};
    for(int i = 0; i < forData.length; i++) {
      returnData[forData[i]['threadId']] = forData[i]['title'];
    }
    return returnData;
  }

  Future<Map<String, String>> getChatUsers([int start = 0, int size = 100]) async {
    Map<String, dynamic> queryData = {
      "start": start,
      "size": size,
      "type": "default",
      "cv": "1.2"
    };

    Map<String, dynamic> responceData = await get("/g/s/chat/thread/$chatId/member", queryData: queryData);

    Map<String, String> returnData = {};
    List<dynamic> forData = responceData['memberList'];
    for (int i = 0; i < forData.length; i++) {
      returnData[forData[i]['uid']] = forData[i]['nickname'];
    }

    return returnData;
  }

  Future<Map<String, dynamic>> joinChat() async {
    print(userId);
    print(httpClient.options.headers["AUID"]);
    Map<String, dynamic> responceData = await post("/g/s/chat/thread/$chatId/member/$userId");
    return responceData;
  }
}
