import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http_todo_provider/Services/exception_handlers.dart';
import 'api_exceptions.dart';

class DioClient {
  static const int timeOutException = 20;

  //GET
   Future<List<dynamic>> get(String baseUrl, String api) async {
    var uri = Uri.parse(baseUrl + api);
    try {
      var response = await Dio().get(uri.toString()).timeout(const Duration(seconds: timeOutException));
      return _processResponse(response);
    }catch(e){
      throw ExceptionHandler().exceptionError(e);
    }
  }

  //POST
  Future<dynamic> post(String baseUrl, String api, dynamic payloadObj) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);
    try {
      var response = await Dio().post(uri.toString(), data: payload).timeout(const Duration(seconds: timeOutException));
      return _processResponse(response);
    } catch(e){
      throw ExceptionHandler().exceptionError(e);
    }
  }

  //DELETE
  //OTHER

  dynamic _processResponse(response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
        throw BadRequestException(jsonDecode(response.body), response.request!.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(jsonDecode(response.body), response.request!.url.toString());
      case 404:
        throw NotFoundException(jsonDecode(response.body), response.request!.url.toString());
        case 500:
      default:
        throw FetchDataException('Error occurred with code : ${response.statusCode}', response.request!.url.toString());
    }
  }
}