import 'package:demo_movies_app/core/utils/api_constant.dart';
import 'package:demo_movies_app/core/utils/app_api_url.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dioProvider = Provider((_) => AppDio.getInstance());

class AppDio with DioMixin implements Dio {
  AppDio._([BaseOptions? options]) {
    options = BaseOptions(
      baseUrl: AppApiUrl.baseUrl,
      contentType: ApiConstant.contentType,
      responseType: ResponseType.json,
      connectTimeout: ApiConstant.timeOut,
      sendTimeout: ApiConstant.timeOut,
      receiveTimeout: ApiConstant.receiveTimeout,
    );

    this.options = options;

    if (kDebugMode) {
      interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    }

    httpClientAdapter = DefaultHttpClientAdapter();
  }

  static Dio getInstance() => AppDio._();
}
