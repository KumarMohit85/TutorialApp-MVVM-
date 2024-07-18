import 'package:_tut_app/data/network/app_api.dart';
import 'package:_tut_app/data/request/request.dart';
import 'package:_tut_app/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  AppServiceClient _appServiceClient;
  RemoteDataSourceImplementer(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(loginRequest.email,
        loginRequest.password, loginRequest.imei, loginRequest.deviceType);
    // return await _appServiceClient.login(
    //     loginRequest.email, loginRequest.password, "", "");
  }
}
