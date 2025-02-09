// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dayfi/ui/common/transaction.dart' as _i16;
import 'package:dayfi/ui/views/auth_forgot_password/auth_forgot_password_view.dart'
    as _i11;
import 'package:dayfi/ui/views/auth_login/auth_login_view.dart' as _i5;
import 'package:dayfi/ui/views/auth_new_password/auth_new_password_view.dart'
    as _i13;
import 'package:dayfi/ui/views/auth_signup/auth_signup_view.dart' as _i4;
import 'package:dayfi/ui/views/auth_verify_code/auth_verify_code_view.dart'
    as _i12;
import 'package:dayfi/ui/views/main/main_view.dart' as _i6;
import 'package:dayfi/ui/views/payment_setup/payment_setup_view.dart' as _i10;
import 'package:dayfi/ui/views/profile/profile_view.dart' as _i14;
import 'package:dayfi/ui/views/startup/startup_view.dart' as _i2;
import 'package:dayfi/ui/views/tab_history/tab_history_view.dart' as _i8;
import 'package:dayfi/ui/views/tab_home/tab_home_view.dart' as _i7;
import 'package:dayfi/ui/views/tab_settings/tab_settings_view.dart' as _i9;
import 'package:dayfi/ui/views/walkthrough/walkthrough_view.dart' as _i3;
import 'package:flutter/material.dart' as _i15;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i17;

class Routes {
  static const startupView = '/startup-view';

  static const walkthroughView = '/walkthrough-view';

  static const authSignupView = '/auth-signup-view';

  static const authLoginView = '/auth-login-view';

  static const mainView = '/main-view';

  static const tabHomeView = '/tab-home-view';

  static const tabHistoryView = '/tab-history-view';

  static const tabSettingsView = '/tab-settings-view';

  static const paymentSetupView = '/payment-setup-view';

  static const authForgotPasswordView = '/auth-forgot-password-view';

  static const authVerifyCodeView = '/auth-verify-code-view';

  static const authNewPasswordView = '/auth-new-password-view';

  static const profileView = '/profile-view';

  static const all = <String>{
    startupView,
    walkthroughView,
    authSignupView,
    authLoginView,
    mainView,
    tabHomeView,
    tabHistoryView,
    tabSettingsView,
    paymentSetupView,
    authForgotPasswordView,
    authVerifyCodeView,
    authNewPasswordView,
    profileView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.startupView,
      page: _i2.StartupView,
    ),
    _i1.RouteDef(
      Routes.walkthroughView,
      page: _i3.WalkthroughView,
    ),
    _i1.RouteDef(
      Routes.authSignupView,
      page: _i4.AuthSignupView,
    ),
    _i1.RouteDef(
      Routes.authLoginView,
      page: _i5.AuthLoginView,
    ),
    _i1.RouteDef(
      Routes.mainView,
      page: _i6.MainView,
    ),
    _i1.RouteDef(
      Routes.tabHomeView,
      page: _i7.TabHomeView,
    ),
    _i1.RouteDef(
      Routes.tabHistoryView,
      page: _i8.TabHistoryView,
    ),
    _i1.RouteDef(
      Routes.tabSettingsView,
      page: _i9.TabSettingsView,
    ),
    _i1.RouteDef(
      Routes.paymentSetupView,
      page: _i10.PaymentSetupView,
    ),
    _i1.RouteDef(
      Routes.authForgotPasswordView,
      page: _i11.AuthForgotPasswordView,
    ),
    _i1.RouteDef(
      Routes.authVerifyCodeView,
      page: _i12.AuthVerifyCodeView,
    ),
    _i1.RouteDef(
      Routes.authNewPasswordView,
      page: _i13.AuthNewPasswordView,
    ),
    _i1.RouteDef(
      Routes.profileView,
      page: _i14.ProfileView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.StartupView: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.StartupView(),
        settings: data,
      );
    },
    _i3.WalkthroughView: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.WalkthroughView(),
        settings: data,
      );
    },
    _i4.AuthSignupView: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.AuthSignupView(),
        settings: data,
      );
    },
    _i5.AuthLoginView: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.AuthLoginView(),
        settings: data,
      );
    },
    _i6.MainView: (data) {
      final args = data.getArgs<MainViewArguments>(
        orElse: () => const MainViewArguments(),
      );
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.MainView(key: args.key, index: args.index),
        settings: data,
      );
    },
    _i7.TabHomeView: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.TabHomeView(),
        settings: data,
      );
    },
    _i8.TabHistoryView: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.TabHistoryView(),
        settings: data,
      );
    },
    _i9.TabSettingsView: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.TabSettingsView(),
        settings: data,
      );
    },
    _i10.PaymentSetupView: (data) {
      final args = data.getArgs<PaymentSetupViewArguments>(nullOk: false);
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => _i10.PaymentSetupView(
            key: args.key,
            selectedPaymentMethod: args.selectedPaymentMethod,
            transactionService: args.transactionService),
        settings: data,
      );
    },
    _i11.AuthForgotPasswordView: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i11.AuthForgotPasswordView(),
        settings: data,
      );
    },
    _i12.AuthVerifyCodeView: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i12.AuthVerifyCodeView(),
        settings: data,
      );
    },
    _i13.AuthNewPasswordView: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i13.AuthNewPasswordView(),
        settings: data,
      );
    },
    _i14.ProfileView: (data) {
      return _i15.MaterialPageRoute<dynamic>(
        builder: (context) => const _i14.ProfileView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class MainViewArguments {
  const MainViewArguments({
    this.key,
    this.index = 0,
  });

  final _i15.Key? key;

  final int index;

  @override
  String toString() {
    return '{"key": "$key", "index": "$index"}';
  }

  @override
  bool operator ==(covariant MainViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.index == index;
  }

  @override
  int get hashCode {
    return key.hashCode ^ index.hashCode;
  }
}

class PaymentSetupViewArguments {
  const PaymentSetupViewArguments({
    this.key,
    required this.selectedPaymentMethod,
    required this.transactionService,
  });

  final _i15.Key? key;

  final String selectedPaymentMethod;

  final _i16.TransactionService transactionService;

  @override
  String toString() {
    return '{"key": "$key", "selectedPaymentMethod": "$selectedPaymentMethod", "transactionService": "$transactionService"}';
  }

  @override
  bool operator ==(covariant PaymentSetupViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.selectedPaymentMethod == selectedPaymentMethod &&
        other.transactionService == transactionService;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        selectedPaymentMethod.hashCode ^
        transactionService.hashCode;
  }
}

extension NavigatorStateExtension on _i17.NavigationService {
  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToWalkthroughView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.walkthroughView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAuthSignupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.authSignupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAuthLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.authLoginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMainView({
    _i15.Key? key,
    int index = 0,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.mainView,
        arguments: MainViewArguments(key: key, index: index),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTabHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.tabHomeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTabHistoryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.tabHistoryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTabSettingsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.tabSettingsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPaymentSetupView({
    _i15.Key? key,
    required String selectedPaymentMethod,
    required _i16.TransactionService transactionService,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.paymentSetupView,
        arguments: PaymentSetupViewArguments(
            key: key,
            selectedPaymentMethod: selectedPaymentMethod,
            transactionService: transactionService),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAuthForgotPasswordView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.authForgotPasswordView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAuthVerifyCodeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.authVerifyCodeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAuthNewPasswordView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.authNewPasswordView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithWalkthroughView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.walkthroughView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAuthSignupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.authSignupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAuthLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.authLoginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMainView({
    _i15.Key? key,
    int index = 0,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.mainView,
        arguments: MainViewArguments(key: key, index: index),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTabHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.tabHomeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTabHistoryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.tabHistoryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTabSettingsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.tabSettingsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPaymentSetupView({
    _i15.Key? key,
    required String selectedPaymentMethod,
    required _i16.TransactionService transactionService,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.paymentSetupView,
        arguments: PaymentSetupViewArguments(
            key: key,
            selectedPaymentMethod: selectedPaymentMethod,
            transactionService: transactionService),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAuthForgotPasswordView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.authForgotPasswordView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAuthVerifyCodeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.authVerifyCodeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAuthNewPasswordView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.authNewPasswordView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
