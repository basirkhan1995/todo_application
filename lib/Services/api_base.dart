import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_todo_provider/Services/exception_handlers.dart';
import 'api_exceptions.dart';

 class BaseClient {
  static const int timeOutDuration = 20;

  //GET
  Future <List<dynamic>> get(String baseUrl, String api) async {
    var uri = Uri.parse(baseUrl + api);

    try {
      var response =
          await http.get(uri).timeout(const Duration(seconds: timeOutDuration));
      return _processResponse(response);
    } catch (e) {
      throw ExceptionHandler().exceptionError(e);
    }
  }

  //POST
  Future<dynamic> post(String baseUrl, String api, dynamic payloadObj) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);
    try {
      var response = await http
          .post(uri, body: payload)
          .timeout(const Duration(seconds: timeOutDuration));
      return _processResponse(response);
    } catch (e) {
      throw ExceptionHandler().exceptionError(e);
    }
  }

  //DELETE
  //OTHER

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:

      final responseJson = jsonDecode(response.body);
      print(responseJson);
      print(response.statusCode);
      return responseJson;

      case 400:
        throw BadRequestException(
            jsonDecode(response.body), response.request!.url.toString());

      case 401:
      case 403:
        throw UnAuthorizedException(
            jsonDecode(response.body), response.request!.url.toString());

      case 422:
      case 500:
        throw BadRequestException(
            jsonDecode(response.body), response.request!.url.toString());

      case 404:
        throw NotFoundException(
            jsonDecode(response.body), response.request!.url.toString());

      default:
        throw FetchDataException(
            'Error occurred with code : ${response.statusCode}',
            response.request!.url.toString());
    }
  }
}
