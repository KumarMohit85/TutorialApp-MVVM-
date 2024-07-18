import 'package:_tut_app/data/network/failure.dart';
import 'package:_tut_app/data/request/request.dart';
import 'package:_tut_app/domain/model/model.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
}
