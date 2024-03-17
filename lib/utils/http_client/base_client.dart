import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import '../constants.dart';
import 'app_exception.dart';

IOClient _ioClient = IOClient();

class BaseClient {
  static const int TIME_OUT_DURATION = 60;

  Future<Map<String, String>> getHeader() async {
    Map<String, String> header = {
      "Token": token,
      // "Userid": await StorageManager.getUserID(),
      "Userid": "9",
      "Guestid": "0",

      // "Guestid": await StorageManager.readData(StorageManager.keyGuestID),
      "Lang": Get.locale?.languageCode == 'ar' ? "ar" : "English",
    };
    log('header=$header');
    return header;
  }

  //GET
  Future<dynamic> get(String url_) async {
    log('URL = $url_');
    var uri = Uri.parse(url_);
    try {
      var response = await _ioClient
          .get(uri, headers: await getHeader())
          .timeout(const Duration(seconds: TIME_OUT_DURATION));

      log(response.body);
      if ((response.body.contains('"messageCode": 401') ||
          response.body.contains('"Status": 401'))) {
        throw UnAuthorizedException(response.body, url_);
      }
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException(
          'You do not have internet access'.tr, uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'Error While Processing'.tr, uri.toString());
    }
  }

  Future<dynamic> post(String url_, dynamic payloadObj) async {
    // log('header=$header');
    log('$url_ payloadObj= $payloadObj');
    var uri = Uri.parse(url_);
    var payload = json.encode(payloadObj);
    log(payload);
    try {
      log('URL = $url_');
      var response = await _ioClient
          .post(uri, headers: await getHeader(), body: payload)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      log(response.body);
      print('${response.statusCode}');
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException(
          'You do not have internet access'.tr, uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'error_while_processing'.tr, uri.toString());
    }
  }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request?.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request?.url.toString());
      case 422:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request?.url.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred with code : ${response.statusCode}',
            response.request?.url.toString());
    }
  }
}
