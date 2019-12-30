import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

final baseUrl = 'http://192.168.1.115/';

ajaxSimple(String url, data, Function fun, {Function netError}) async {
  var dio = Dio();
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  CookieJar cookieJar = new PersistCookieJar(dir: tempPath);
  dio.interceptors.add(CookieManager(cookieJar));
  try {
    Response res = await dio.post(
      "$url",
      data: data,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {
//          'X-Requested-With': 'XMLHttpRequest',
          'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
        },
      ),
    );
    fun(res.data);
  } on DioError catch (e) {
    if (netError != null) {
      netError(e);
    }
//    print(e);
    Fluttertoast.showToast(
      msg: '$e',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
    if (e.response != null) {
//        print(e.response.data);
//        print(e.response.headers);
//        print(e.response.request);
//        print(e.response.statusCode);
      //  this.data,
      //  this.headers,
      //  this.request,
      //  this.isRedirect,
      //  this.statusCode,
      //  this.statusMessage,
      //  this.redirects,
      //  this.extra,
    } else {
      // Something happened in setting up or sending the request that triggered an Error
//       print(e.request.connectTimeout);
//       print(e.message);
    }

    // Toast.show('$e', _context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
  }
}

ajax(String url, data, bool toast, Function fun, Function fun2, BuildContext _context, {Function netError}) async {
  var dio = Dio();
  //  var cookieJar = CookieJar();
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  CookieJar cookieJar = new PersistCookieJar(dir: tempPath);
  //  print(cookieJar.loadForRequest(Uri.parse(baseUrl)));
  dio.interceptors.add(CookieManager(cookieJar));
  try {
    Response res = await dio.post(
      "$baseUrl$url",
      data: data,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
        },
      ),
    );
    if (res.data['err_code'] == 0) {
      if (toast == true) {
        Fluttertoast.showToast(
          msg: '${res.data['err_msg']}'.length > 15 ? '成功' : '${res.data['err_msg']}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
      fun(res.data);
    } else {
      if (toast == true) {
        Fluttertoast.showToast(
          msg: '${res.data['err_code']}: ${res.data['err_msg']}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
      fun2();
    }
  } on DioError catch (e) {
    // The request was made and the server responded with a status code
    // that falls out of the range of 2xx and is also not 304.
    if (netError != null) {
      netError(e);
    }
    if (e.response != null) {
      //  print(e.response.data);
      //  print(e.response.headers);
      //  print(e.response.request);
      //  print(e.response.statusCode);
      //  this.data,
      //  this.headers,
      //  this.request,
      //  this.isRedirect,
      //  this.statusCode,
      //  this.statusMessage,
      //  this.redirects,
      //  this.extra,
    } else {
      // Something happened in setting up or sending the request that triggered an Error
      // print(e.request);
      // print(e.message);
    }
    // print(e);
    Fluttertoast.showToast(
      msg: '$e',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
  }
}
