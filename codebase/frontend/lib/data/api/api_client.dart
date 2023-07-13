import 'dart:convert';

import 'package:flutter/foundation.dart' as Foundation;
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as Http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetxService {
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;
  static String noInternetMessage = 'connection_to_api_server_failed'.tr;
  static int timeoutInSeconds = 30;
  ApiClient({required this.appBaseUrl, required this.sharedPreferences});

  Future<Response> getData(String uri, {Map<String, dynamic>? query}) async {
    try {
      if (query != null) {
        uri += '?';
        bool header = false;
        for (var i in query.entries) {
          uri += '${header ? '&' : ''}${i.key}=${i.value}';
          header = true;
        }
      }

      if (Foundation.kDebugMode) {
        print('====> API Call: $uri');
      }

      Http.Response response = await Http.get(
        Uri.parse(appBaseUrl + uri),
        headers: headers,
      ).timeout(const Duration(seconds: 30));
      return handleResponse(response, uri);
    } catch (e) {
      print('------------${e.toString()}');
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  static Map<String, String> headers = {'Content-Type': 'application/json'};

  Future<Response> postData(
    String uri,
    Map<String, dynamic> body,
  ) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API Call: $uri /Headers: $headers');
        print('====> API Body: $body');
      }
      Http.Response response = await Http.post(
        Uri.parse(appBaseUrl + uri),
        body: jsonEncode(body),
        headers: headers,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      print(e);
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putData(
    String uri,
    dynamic body,
  ) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API Call: $uri');
        print('====> API Body: $body');
      }
      Http.Response response = await Http.put(
        Uri.parse(appBaseUrl + uri),
        body: jsonEncode(body),
        headers: headers,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String uri) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API Call: $uri');
      }
      Http.Response response = await Http.delete(
        Uri.parse(appBaseUrl + uri),
        headers: headers,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(Http.Response res, String uri) {
    dynamic body;
    try {
      body = jsonDecode(res.body);
    } catch (e) {}
    Response response = Response(
      body: body ?? res.body,
      bodyString: res.body.toString(),
      request: Request(
          headers: res.request?.headers ?? {},
          method: res.request!.method,
          url: res.request!.url),
      headers: res.headers,
      statusCode: res.statusCode,
      statusText: res.reasonPhrase,
    );
    if (response.statusCode != 200 &&
        response.body != null &&
        response.body is! String) {
      if (response.body.toString().startsWith('{errors: [{code:')) {
        // TODO: FILL WITH DETAILS

      } else if (response.statusCode != 200 && response.body == null) {
        response = Response(statusCode: 0, statusText: noInternetMessage);
      }
      if (Foundation.kDebugMode) {
        print(
            '====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
    }
    return response;
  }
}
