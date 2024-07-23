import 'core/generators.dart';
import 'package:dio/dio.dart';
import 'ApiException.dart';
import 'dart:convert' show json;

Map<String, String> baseHeaders = {
    "Accept-Language": "en-US",
    "User-Agent": "Apple iPhone16,2 iOS v16.2 Main/3.13.1",
    "Accept-Encoding": "gzip",
    "Connection": "Keep-Alive",
    "Content-Type": "application/json"
};

final requestWrapper = InterceptorsWrapper(
  onRequest:(RequestOptions options, RequestInterceptorHandler handler) async {
          // options.headers["Content-Type"] = "application/x-www-form-urlencoded";
      if (options.data != null) {
          final DateTime now = DateTime.now();
          final int timestamp = now.millisecondsSinceEpoch;
          // Добавляем timestamp
          options.data["timestamp"] = timestamp;

        // Преобразуем в json
        options.data = json.encode(options.data);

        // Если данные есть, вызываем функцию для генерации NDC-MSG-SIG
        String ndcMsgSig = genSignature(options.data);
        options.headers["NDC-MSG-SIG"] = ndcMsgSig;
      }

    return handler.next(options);
  },

  onError: (error, handler) {
    final response = error.response;
        throw ApiException(response!.data);
  },
);

final customOptions = BaseOptions(
    contentType: Headers.jsonContentType,
    baseUrl: "https://service.altamino.top/api/v1",
    headers: baseHeaders
  );