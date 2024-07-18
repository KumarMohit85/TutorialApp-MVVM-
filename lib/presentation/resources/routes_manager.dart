import 'package:_tut_app/presentation/forgotPassword/forgot_password.dart';
import 'package:_tut_app/presentation/login/login_view.dart';
import 'package:_tut_app/presentation/main/main_viw.dart';
import 'package:_tut_app/presentation/onBoarding/onboarding_view.dart';
import 'package:_tut_app/presentation/register/register_view.dart';
import 'package:_tut_app/presentation/resources/strings_manager.dart';
import 'package:_tut_app/presentation/splash/splash_view.dart';
import 'package:_tut_app/presentation/storeDetails/store_details.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
}

class RoutesGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => OnBoardingView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => LoginView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => RegisterView());
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => ForgotPasswordView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => MainView());
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder: (_) => StoreDetailsView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text(AppStrings.noRoutesFound),
              ),
              body: Center(
                child: Text(AppStrings.noRoutesFound),
              ),
            ));
  }
}
