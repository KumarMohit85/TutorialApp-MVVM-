import 'package:_tut_app/app/di.dart';
import 'package:_tut_app/data/data_source/remote_data_source.dart';
import 'package:_tut_app/data/repository/repository_impl.dart';
import 'package:_tut_app/domain/repository/repository.dart';
import 'package:_tut_app/domain/usecase/login_usecase.dart';
import 'package:_tut_app/presentation/common/state_renderer/state_render_impl.dart';
import 'package:_tut_app/presentation/login/login_viewmodel.dart';
import 'package:_tut_app/presentation/resources/assets_manager.dart';
import 'package:_tut_app/presentation/resources/color_manager.dart';
import 'package:_tut_app/presentation/resources/routes_manager.dart';
import 'package:_tut_app/presentation/resources/strings_manager.dart';
import 'package:_tut_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginViewModel _viewModel = instance<LoginViewModel>();

  _bind() {
    _viewModel.start();
    _usernameController
        .addListener(() => _viewModel.setUserName(_usernameController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                _viewModel.login();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p100),
      color: ColorManager.white,
      child: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image(image: AssetImage(ImageAssets.splash_logo)),
                SizedBox(
                  height: AppSize.s28,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: AppSize.s28, right: AppSize.s28),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsUserNameValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _usernameController,
                        decoration: InputDecoration(
                            hintText: AppStrings.username,
                            labelText: AppStrings.username,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.errorUsername),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: AppSize.s28,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: AppSize.s28, right: AppSize.s28),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsPasswordValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        decoration: InputDecoration(
                            hintText: AppStrings.password,
                            labelText: AppStrings.password,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.errorUsername),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: AppSize.s40,
                  width: double.infinity,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: AppSize.s28, right: AppSize.s28),
                  child: StreamBuilder<bool>(
                    stream:
                        _viewModel.outputIsAllInputsValid, //to do - implement
                    builder: (context, snapshot) {
                      return ElevatedButton(
                          onPressed: (snapshot.data ?? false)
                              ? () {
                                  _viewModel.login();
                                }
                              : null,
                          child: Text(AppStrings.login));
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: AppPadding.p8,
                      left: AppPadding.p28,
                      right: AppPadding.p28),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.forgotPasswordRoute);
                          },
                          child: Text(
                            AppStrings.forgotPassword,
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.end,
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.registerRoute);
                          },
                          child: Text(
                            AppStrings.register,
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.end,
                          ))
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
