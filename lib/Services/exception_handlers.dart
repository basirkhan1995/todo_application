import 'dart:async';
import 'dart:io';
import 'package:http_todo_provider/Services/api_exceptions.dart';

class ExceptionHandler{
   exceptionError(error){
    if(error is SocketException){
      return "You're offline, No Internet Connection";
    }else if(error is HttpException){
      return "Http error occurred";
    }else if (error is FormatException){
      return "Invalid format";
    }else if(error is TimeoutException){
      return "Oops! took longer time to respond";
    }else if(error is ApiNotRespondingException){
      var message = error.message.toString();
      return message;
    }else if(error is BadRequestException){
      var message = error.message.toString();
      return message;
    }else if(error is UnAuthorizedException){
      var message = error.message.toString();
      return message;
    }else if(error is NotFoundException){
      var message = error.message.toString();
      return message;
    }else if (error is FetchDataException){
      var message = error.message.toString();
      return message;
    }else{
      return error.toString();
    }
  }
 }