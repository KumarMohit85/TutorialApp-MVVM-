import 'package:_tut_app/data/network/failure.dart';
import 'package:dio/dio.dart';

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECTION_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      //dio error so its error from response of the API
      failure = _handleError(error);
    } else {
      //default error
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}

Failure _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.CONNECTION_TIMEOUT.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.RECEIVE_TIMEOUT.getFailure();
    case DioExceptionType.badCertificate:
      return DataSource.BAD_REQUEST.getFailure();
    case DioExceptionType.badResponse:
      return DataSource.BAD_REQUEST.getFailure();
    case DioExceptionType.cancel:
      return DataSource.CANCEL.getFailure();
    case DioExceptionType.connectionError:
      return DataSource.NO_INTERNET_CONNECTION.getFailure();
    case DioExceptionType.unknown:
      return DataSource.DEFAULT.getFailure();
  }
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS);
      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT);
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTHORISED:
        return Failure(ResponseCode.UNAUTHORISED, ResponseMessage.UNAUTHORISED);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECTION_TIMEOUT:
        return Failure(ResponseCode.CONNECTION_TIMEOUT,
            ResponseMessage.CONNECTION_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.RECEIVE_TIMEOUT:
        return Failure(
            ResponseCode.RECEIVE_TIMEOUT, ResponseMessage.RECEIVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
      default:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}

class ResponseCode {
  //API status codes
  static const int NO_CONTENT = 201; //success with no data
  static const int BAD_REQUEST = 400; //failure, api rejected the data
  static const int FORBIDDEN = 403; //failure, api rejected the data
  static const int UNAUTHORISED = 401; //failure, user is not authorised
  static const int SUCCESS = 200; //success with data
  static const int NOT_FOUND =
      404; //failure, api url is not correct and not found
  static const int INTERNAL_SERVER_ERROR =
      500; //failure, crash happened in server side

  //local status codes
  static const int CONNECTION_TIMEOUT = -1;
  static const int DEFAULT = -2;
  static const int CANCEL = -3;
  static const int RECEIVE_TIMEOUT = -4;
  static const int SEND_TIMEOUT = -5;
  static const int CACHE_ERROR = -6;
  static const int NO_INTERNET_CONNECTION = -7;
}

class ResponseMessage {
  //API status codes
  static const String NO_CONTENT =
      "success with no content"; //success with no data
  static const String BAD_REQUEST =
      "bad request, try again later"; //failure, api rejected the data
  static const String FORBIDDEN =
      "forbidden request, try again later"; //failure, api rejected the data
  static const String UNAUTHORISED =
      "user is unauthorised, try again later"; //failure, user is not authorised
  static const String SUCCESS = "success"; //success with data
  static const String NOT_FOUND =
      "url is not found try again later"; //failure, api url is not correct and not found
  static const String INTERNAL_SERVER_ERROR =
      "something went wrong , try agsin later"; //failure, crash happened in server side

  //local status codes
  static const String CONNECTION_TIMEOUT = "timeout error , try agsin later";
  static const String DEFAULT = "something went wrong , try agsin later";
  static const String CANCEL = "request was cancelled , try agsin later";
  static const String RECEIVE_TIMEOUT = "timeout error , try agsin later";
  static const String SEND_TIMEOUT = "timeout error , try agsin later";
  static const String CACHE_ERROR = "cache error , try agsin later";
  static const String NO_INTERNET_CONNECTION =
      "please check your internet connection , try agsin later";
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}
