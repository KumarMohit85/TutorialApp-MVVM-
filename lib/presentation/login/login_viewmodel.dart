import 'dart:async';

import 'package:_tut_app/domain/usecase/login_usecase.dart';
import 'package:_tut_app/presentation/base/baseviewmodel.dart';
import 'package:_tut_app/presentation/common/freezed_data_classes.dart';
import 'package:_tut_app/presentation/common/state_renderer/state_render_impl.dart';
import 'package:_tut_app/presentation/common/state_renderer/state_renderer.dart';

class LoginViewModel extends BaseViewModel
    implements LoginViewModelInputs, LoginViewModelOutputs {
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();

  StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();
  var loginObject = LoginObject("", "");
  LoginUseCase _loginUseCase; // to do remove ?
  LoginViewModel(this._loginUseCase);
  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _isAllInputsValidStreamController.close();
  }

  @override
  void start() {
    //view tells tate renderer , please show the content of the screen
    inputState.add(ContentState());
  }

  @override
  // TODO: implement inputPassword
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  // TODO: implement inputUserName
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  login() async {
    inputState.add(
        LoadingState(stateRenderType: StateRendererType.POPUP_LOADING_STATE));
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.userName, loginObject.password)))
        .fold(
            (failure) => {
                  //left->failure
                  inputState.add(ErrorState(
                      StateRendererType.POPUP_ERROR_STATE, failure.message))
                  // print(failure.message)
                },
            (data) => {
                  //right->success
                  inputState.add(ContentState()),
                  print(data.customer?.name),
                  print("loginUseCase executed successfully")

                  //navigate to main screen after the login
                });
  }

  @override
  // TODO: implement outputIsPasswordValid
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  // TODO: implement outputIsUserNameValid
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((username) => _isUsernameValid(username));

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(
        password: password); //data class operation same as kotlin
    _validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    _validate();
  }

  //private functions
  _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  _isUsernameValid(String username) {
    return username.isNotEmpty;
  }

  @override
  // TODO: implement inputIsAllValid
  Sink get inputIsAllValid => _isAllInputsValidStreamController.sink;

  @override
  // TODO: implement outputIsAllInputsValid
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());

  _validate() {
    inputIsAllValid.add(null);
  }

  bool _isAllInputsValid() {
    return _isPasswordValid(loginObject.password) &&
        _isUsernameValid(loginObject.userName);
  }
}

abstract class LoginViewModelInputs {
  //three functions for actions
  setUserName(String userName);

  setPassword(String password);

  login();

  //two sinks
  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputIsAllValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputIsAllInputsValid;
}
