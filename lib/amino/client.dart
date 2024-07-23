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

  Future<Map<String, dynamic>> post(String url, Map<String, dynamic> data) async {
    try {
      final response = await httpClient.post(
          url,
          data: data
      );
      return response.data;
    } catch(e) {
      return json.decode(e.toString());
    }
  }
  Future<Map<String, dynamic>> get(String url, Map<String, dynamic> queryData) async {
    try {
      final response = await httpClient.get(
          url,
          queryParameters: queryData
      );
      return response.data;
    } catch(e) {
      return json.decode(e.toString());
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final Map<String, dynamic> data = {
      "email": email,
      "secret": "0 $password",
      "clientType": 100,
      "v": 2,
      "deviceID": deviceId
    };

    final responseData = await post("/g/s/auth/login", data);

    httpClient.options.headers["NDCAUTH"] = "sid=${responseData["sid"]}";
    httpClient.options.headers["AUID"] = responseData["account"]["uid"];
    return responseData;
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
    return await post("/g/s/auth/check-security-validation", data);
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

    return await post("/g/s/auth/register", data);
  }

  Future<Map<String, dynamic>> getValidationCode(String email) async {
    final Map<String, dynamic> data = {
      "deviceID": deviceId,
      "type": 1,
      "identity": email
    };

    return post("/g/s/auth/request-security-validation", data);
  }

  Future<Map<String, dynamic>> createCommuniy() async {

  }

  Future<void> uploaadMedia(String filePath) async {
    File file = File(filePath);
    Uint8List data = await file.readAsBytes();

    Digest fileHash = sha1.convert(data);
    String mimeType = lookupMimeType(filePath) ?? 'image/jpeg';

    post("/g/s/media/upload");
  }

  Future<Map<String, dynamic>> subClients(
      [int start = 0, int size = 100]) async {
    return await get("/g/s/community/joined", {"start": start, "size": size});
  }

  Future<Map<String, dynamic>> getFromCode(String code) async {
    return await get("/g/s/link-resolution", {"q": code});
  }
}
