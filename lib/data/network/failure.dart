import 'package:_tut_app/data/network/error_handler.dart';

class Failure {
  int code; //400 or 500
  String message; //error or success

  Failure(this.code, this.message);
}

class DefaultFailure extends Failure {
  DefaultFailure() : super(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
}
