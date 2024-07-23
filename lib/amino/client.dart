import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'core/generators.dart';
import 'constants.dart';

class Client {
  final httpClient = Dio();
  String deviceId = genDeviceId();
  int comId = 0;
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

  Future<Map<String, dynamic>> login(String email, String password) async {
    final Map<String, dynamic> data = {
      "email": email,
      "secret": "0 $password",
      "clientType": 100,
      "v": 2,
      "deviceID": deviceId
    };

    final response = await httpClient.post(
      "/g/s/auth/login",
      data: data,
    );

    httpClient.options.headers["NDCAUTH"] = "sid=${response.data["sid"]}";
    httpClient.options.headers["AUID"] = response.data["account"]["uid"];
    return response.data;
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

    final responce = await httpClient.post("/g/s/auth/check-security-validation",
        data: data);
    return responce.data;
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

    try {
      final response = await httpClient.post("/g/s/auth/register",
          data: data);
      return response.data;
    }catch (e) {
      debugPrint(e.toString());
      return {};
    }
  }

  Future<Map<String, dynamic>> getValidationCode(String email) async {
    final Map<String, dynamic> data = {
      "deviceID": deviceId,
      "type": 1,
      "identity": email
    };

    try {
      final response = await httpClient.post(
          "/g/s/auth/request-security-validation",
          data: data);
      return response.data;
    } catch (e) {
      debugPrint(e.toString());
      return {};
    }
  }

  Future<Map<String, dynamic>> subClients(
      [int start = 0, int size = 100]) async {
    final response = await httpClient.get("/g/s/community/joined",
        queryParameters: {"start": start, "size": size});
    return response.data;
  }

  Future<Map<String, dynamic>> getFromCode(String code) async {
    final response = await httpClient
        .get("/g/s/link-resolution", queryParameters: {"q": code});
    return response.data["linkInfoV2"]["extensions"]["linkInfo"];
  }
}
