import 'dart:async';

import 'package:_tut_app/presentation/common/state_renderer/state_render_impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    implements BaseViewModelOutputs {
  //shared variables and functions that will be used through any view model.

  StreamController _inputStateStreamController =
      StreamController<FlowState>.broadcast();

  @override
  // TODO: implement inputState
  Sink get inputState => _inputStateStreamController.sink;

  @override
  // TODO: implement outputState
  Stream<FlowState> get outputState =>
      _inputStateStreamController.stream.map((flowState) => flowState);

  @override
  void dispose() {
    _inputStateStreamController.close();
  }
}

abstract class BaseViewModelInputs {
  void start(); //will be called while initialization of view model
  void dispose(); // will be called when viewmodel dies

  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
