import 'package:_tut_app/data/mapper/mapper.dart';
import 'package:_tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:_tut_app/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

//LOADING STATE(POPUP,FULL SCREEN)
class LoadingState extends FlowState {
  StateRendererType stateRenderType;
  String message;

  LoadingState({required this.stateRenderType, String? message})
      : message = message ?? AppStrings.loading;

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRenderType;
}

//ERROR STATE (POPUP,LOADING)

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

//CONTENT STATE
class ContentState extends FlowState {
  @override
  String getMessage() => EMPTY;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.CONTENT_SCREEN_STATE;
}

//EMPTY STATE
class EmptyState extends FlowState {
  String message;
  EmptyState(this.message);
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.EMPTY_SCREEN_STATE;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryFunctionButton) {
    switch (this.runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.POPUP_LOADING_STATE) {
            //SHOWING POP UP DIALOG
            showPopUp(context, getStateRendererType(), getMessage());
            //RETURN THE CONTENT UI OF THE SCREEN
            return contentScreenWidget;
          } else {
            //SHOWING FULL SCREEN ERROR STATE
            return StateRenderer(
                stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE,
                message: getMessage(),
                retryActionFunction: () {});
          }
        }
      case ErrorState:
        {
          dismissDialog(context);
          if (getStateRendererType() == StateRendererType.POPUP_ERROR_STATE) {
            //SHOWING POP UP DIALOG
            showPopUp(context, getStateRendererType(), getMessage());
            //RETURN THE CONTENT UI OF THE SCREEN
            return contentScreenWidget;
          } else {
            //SHOWING FULL SCREEN ERROR STATE
            return StateRenderer(
                stateRendererType: StateRendererType.FULL_SCREEN_ERROR_STATE,
                message: getMessage(),
                retryActionFunction: () {});
          }
        }
      case EmptyState:
        {
          return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: () {});
        }
      case ContentState:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
      default:
        {
          return contentScreenWidget;
        }
    }
  }

  dismissDialog(BuildContext context) {
    if (_isThereCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  _isThereCurrentDialogShowing(BuildContext context) {
    return ModalRoute.of(context)?.isCurrent != true;
  }

  showPopUp(
      BuildContext context, StateRendererType stateRenderType, String message) {
    WidgetsBinding.instance?.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (context) => StateRenderer(
            stateRendererType: stateRenderType,
            message: message,
            retryActionFunction: () {})));
  }
}
