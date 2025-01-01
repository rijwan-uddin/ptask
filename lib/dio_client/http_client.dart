import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io' as io;

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:ptask/utils/app_message.dart';


class HttpClient {
  static Future<dynamic> get(String url,
      {String token = '', dynamic parameters}) async {

    try {
      Dio dio = await _dioClient(token);
      Response response = await dio.get(url, queryParameters: parameters);
      print(response);
      return _response(response);
    } on DioError {
      //ToastUtils.showError('check internet connection');
    }
  }

  static Future<dynamic> post(String url,
      {String? token = '',
      dynamic parameters,
      dynamic body,
      dynamic option}) async {
    bool hasInternet = true;
    // hasInternet = await Network.instance.checkNetworkWithOutToast();
    if (hasInternet) {
      try {
        Dio dio = await _dioClient(token);
        Response response = await dio.post(url,
            queryParameters: parameters, data: body, options: option);
        log("thiss is status code");
        log(response.statusCode.toString());
        return _response(response);
      } on DioError {
        throw Exception('something went wrong');
        //ToastUtils.showError('check internet connection');
      }
    } else {
      return {"error": true, "message": "No Internet Connection"};
    }
  }

  static Future<dynamic> put(String url, dynamic parameters, dynamic body,
      {String token = ''}) async {
  bool hasInternet = true;
    // bool hasInternet = await Network.instance.checkNetworkWithOutToast();
    if (hasInternet) {
      try {
        Dio dio = await _dioClient(token);
        Response response =
            await dio.put(url, queryParameters: parameters, data: body);
        return _response(response);
      } on DioError {
        //ToastUtils.showError('check internet connection');
      }
    } else {
      return {"error": true, "message": "No Internet Connection"};
    }
  }

  static Future<dynamic> upload(String url, dynamic body,
      {String token = ''}) async {
    bool hasInternet = true;
    // bool hasInternet = await Network.instance.checkNetworkWithOutToast();
    if (hasInternet) {
      try {
        Dio dio = await _dioClient(token);
        Response response = await dio.post(
          url,
          data: FormData.fromMap(body),
        );
        return _response(response);
      } on DioError {
        //ToastUtils.showError('check internet connection');
      }
    } else {
      return {"error": true, "message": "No Internet Connection"};
    }
  }

  static Future<Dio> _dioClient(String? token) async {
    Dio dio = Dio(await _options(token));
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
    }
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (io.HttpClient client) {
      client.badCertificateCallback =
          (io.X509Certificate cert, String host, int port) => true;
      return null;
    };
    return dio;
  }

  static Future<BaseOptions> _options(String? token) async {
    return BaseOptions(
      connectTimeout: 15000,
      receiveTimeout: 15000,
      followRedirects: true,
      validateStatus: (status) {
        return status! < 500;
      },
      headers: {
        'Authorization': "Bearer $token",
        'Accept': 'application/json',
      },
    );
  }

  static dynamic _response(Response response) async {
    dynamic responseJson;
    // logPrint(response);
    switch (response.statusCode) {
      case 200:
        responseJson = json.decode(response.toString());
        return responseJson;
      case 201:
        responseJson = json.decode(response.toString());
        return responseJson;
      case 412:
        responseJson = json.decode(response.toString());
        return responseJson;
      case 401:
        return response;
      case 400:
        // throw Exception(" Internet Connection");
        if (response.data['code'] != null) {
          throw Exception(response.data["message"]);
        } else if (response.data['messsage'] == null) {
          throw Exception(response.data["message"]);
        } else {
          throw Exception(AppMessage.msgDefaultError);
        }

      case 403:
        if (response.data['code'] != null) {
          throw Exception(response.data["message"]);
        } else {
          throw Exception(AppMessage.msgDefaultError);
        }
      case 404:
        if (response.data['code'] != null) {
          throw Exception(response.data["message"]);
        } else {
          throw Exception(AppMessage.msgDefaultError);
        }
      case 417:
        if (response.data['code'] != null) {
          throw Exception(response.data["message"]);
        } else {
          throw Exception(AppMessage.msgDefaultError);
        }
      case 422:
        if (response.data['code'] != null) {
          throw Exception(response.data["message"]);
        } else {
          throw Exception(AppMessage.msgDefaultError);
        }
      case 500:
        throw Exception('Server Error!');
      case 503:
        throw Exception('Server Error!');
      default:
        throw Exception('Unknown Error!');
    }
  }
}
