import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:stake_fair_app/data/appexception.dart';
import 'package:stake_fair_app/data/network/base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  dynamic jsonResponse;

  @override
  Future<dynamic> postApi(var data, String url) async {
    if (kDebugMode) {
      print(url);
    }
    try {
      final response = await http
          .post(Uri.parse(url),
              headers: {
                'Content-Type': 'application/json; charset=utf-8',
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Headers':
                    'Origin,X-Requested-With,Content-Type,Accept,X-Auth-Token',
              },
              body: jsonEncode(data))
          .timeout(const Duration(seconds: 20));
      print('NetworkDataResponse$response');
      jsonResponse = returnResponse(response);
      print('NwtworkDatajsonResponse$jsonResponse');
      return jsonResponse;
    } on SocketException {
      throw InternetExceptions();
    } on RequestTimeOut {
      throw RequestTimeOut();
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 400:
        throw InvalidException;
      default:
        throw FetchDataException(response.statusCode.toString());
    }
  }
}
