import 'package:_tut_app/data/data_source/remote_data_source.dart';
import 'package:_tut_app/data/mapper/mapper.dart';
import 'package:_tut_app/data/network/error_handler.dart';
import 'package:_tut_app/data/network/failure.dart';
import 'package:_tut_app/data/network_info.dart';
import 'package:_tut_app/data/request/request.dart';
import 'package:_tut_app/data/responses/responses.dart';
import 'package:_tut_app/domain/model/model.dart';
import 'package:_tut_app/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl extends Repository {
  RemoteDataSource _remoteDataSource;
  NetworkInfo _networkInfo;

  RepositoryImpl(this._networkInfo, this._remoteDataSource);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        //its safe to call the API
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.SUCCESS) //success
        {
          //return data success
          //return right
          return Right(response.toDomain());
        } else {
          //return biz logic error
          //return left
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
