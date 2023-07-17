import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:my_app_hospital/app/network/data/provider/error_resolver.dart';
import 'package:my_app_hospital/app/network/local/cache_helper.dart';
import 'package:my_app_hospital/app/network/storage_manager.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:my_app_hospital/app/network/data/provider/my_reponse.dart';

class MyCallBack {
  final String _apiBaseUrl = "192.168.1.178:1012";

  final Logger _logger = Logger("MyCallBack");
  final Dio _dio = Dio();

  static final MyCallBack _instance = MyCallBack._internal();

  MyCallBack._internal() {
    setupInterceptors();
  }

  factory MyCallBack() {
    return _instance;
  }

  Future<MyResponse?> get({
    final String? url,
    final String? endPoint,
    final object,
    final Map<String, dynamic>? params,
  }) async {
    try {
      Response response = await _dio.get(uri(endPoint, url: url ?? '').toString(), options: await options(), queryParameters: params);

      return base(response, object);
    } on DioError catch (e) {
      if (DioErrorType.receiveTimeout == e.type || DioErrorType.connectionTimeout == e.type) {
      } else if (DioErrorType.unknown == e.type) {
        if (e.message!.contains('SocketException')) {
          return MyResponse(false, 400, ErrorResolver.getCodeError(400), null, ErrorResolver.getCodeError(400), null, null);
        }
      } else {
        return MyResponse(
          false,
          e.response?.data['statusCode'] ?? 400,
          e.response?.data['code'] ?? 'error',
          ((e.response?.data["message"] is List) ? e.response?.data['message'].cast<String>() : [e.response?.data['message']]),
          e.response?.data['error'] ?? 'error',
          null,
          null,
        );
      }
      _logger.log(Level.INFO, "Exception occured: " + e.toString());
    }
    return null;
  }

  Future<MyResponse?> post({
    final String? url,
    final String? endPoint,
    final object,
    final Map<String, dynamic>? params,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      print("flutter params" + params.toString());
      Response response = await _dio.post(uri(endPoint, url: url ?? '').toString(), options: await options(), data: params, queryParameters: queryParameters);
      return base(response, object);
    } on DioError catch (e) {
      if (DioErrorType.receiveTimeout == e.type || DioErrorType.connectionTimeout == e.type) {
        print("object");
      } else if (DioErrorType.unknown == e.type) {
        if (e.message!.contains('SocketException')) {
          return MyResponse(false, 400, ErrorResolver.getCodeError(400), null, ErrorResolver.getCodeError(400), null, null);
        }
      } else {
        return MyResponse(
          false,
          e.response?.data['statusCode'] ?? 400,
          e.response?.data['code'] ?? 'error',
          ((e.response?.data["message"] is List) ? e.response?.data['message'].cast<String>() : [e.response?.data['message']]),
          e.response?.data['error'] ?? 'error',
          null,
          null,
        );
      }
      _logger.log(Level.INFO, "Exception occured: " + e.toString());
    } catch (exc) {
      // ErrorResolver.toast(exc.toString());
      _logger.log(Level.INFO, "Exception occured: " + exc.toString());
    }
    return null;
  }

  Future<MyResponse?> put({
    final String? endPoint,
    final object,
    final Map<String, dynamic>? params,
  }) async {
    try {
      print("flutter params" + params.toString());
      Response response = await _dio.put(uri(endPoint).toString(), options: await options(), data: params);
      return base(response, object);
    } on DioError catch (e) {
      if (DioErrorType.receiveTimeout == e.type || DioErrorType.connectionTimeout == e.type) {
        print("object");
      } else if (DioErrorType.unknown == e.type) {
        if (e.message!.contains('SocketException')) {
          return MyResponse(false, 400, ErrorResolver.getCodeError(400), null, ErrorResolver.getCodeError(400), null, null);
        }
      } else {
        return MyResponse(
          false,
          e.response?.data['statusCode'] ?? 400,
          e.response?.data['code'] ?? 'error',
          ((e.response?.data["message"] is List) ? e.response?.data['message'].cast<String>() : [e.response?.data['message']]),
          e.response?.data['error'] ?? 'error',
          null,
          null,
        );
      }
      _logger.log(Level.INFO, "Exception occured: " + e.toString());
    } catch (exc) {
      // ErrorResolver.toast(exc.toString());
      _logger.log(Level.INFO, "Exception occured: " + exc.toString());
    }
    return null;
  }

  Future<MyResponse?> delete({final String? endPoint, final object, final Map<String, dynamic>? params = null}) async {
    try {
      print("flutter params" + params.toString());
      Response response = await _dio.delete(uri(endPoint).toString(), options: await options(), queryParameters: params);
      return base(response, object);
    } on DioError catch (e) {
      if (DioErrorType.receiveTimeout == e.type || DioErrorType.connectionTimeout == e.type) {
        print("object");
      } else if (DioErrorType.unknown == e.type) {
        if (e.message!.contains('SocketException')) {
          return MyResponse(false, 400, ErrorResolver.getCodeError(400), null, ErrorResolver.getCodeError(400), null, null);
        }
      } else {
        return MyResponse(
          false,
          500,
          ErrorResolver.getCodeError(500),
          null,
          ErrorResolver.getCodeError(500),
          null,
          null,
        );
      }
      _logger.log(Level.INFO, "Exception occured: " + e.toString());
    } catch (exc) {
      // ErrorResolver.toast(exc.toString());
      _logger.log(Level.INFO, "Exception occured: " + exc.toString());
    }
    return null;
  }

  Future<MyResponse?> base(final Response response, final lass) async {
    try {
      if (response.statusCode == 201 || response.statusCode == 200) {
        MyResponse data;
        if (response.data is String) {
          Map<String, dynamic> responsedata = {
            "data": [response.data]
          };
          data = new MyResponse.fromJson(responsedata, lass);
        } else {
          data = new MyResponse.fromJson(response.data, lass);
        }

        return data;
      }
    } catch (exc) {
      debugPrint('catch ${exc.toString()}');
      _logger.log(Level.INFO, "Exception occured: " + exc.toString());
    }
    return null;
  }

  void setupInterceptors() {
    _dio.interceptors.add(PrettyDioLogger());
  }

  Uri uri(endPoint, {String url = ''}) {
    return Uri.http(url == '' ? _apiBaseUrl : url, endPoint);
  }

  Future<Options> options({bool isNotUsedContentType = true}) async {
    final StorageManager _storageManager = StorageManager();

    var token = await _storageManager.getToken();

    var options = Options();
    if (CacheHelper.getData(key: 'token') == null || CacheHelper.getData(key: 'token') == '') {
      options = Options(
        headers: {
          'agent': '65e6c6d1-0b51-4a73-9288-573e894be58c',
        },
      );
    } else {
      options = Options(
        headers: {
          'agent': '65e6c6d1-0b51-4a73-9288-573e894be58c',
          'Authorization': 'Bearer: ${CacheHelper.getData(key: 'token')}',
        },
      );
    }

    log("[DEV] token: ${token.toString()}");

    options.contentType = 'application/json';

    return options;
  }
}
