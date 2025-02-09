import 'package:dayfi/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:dayfi/ui/views/startup/startup_view.dart';
import 'package:dayfi/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:dayfi/ui/views/walkthrough/walkthrough_view.dart';
import 'package:dayfi/ui/views/auth_signup/auth_signup_view.dart';
import 'package:dayfi/ui/views/auth_login/auth_login_view.dart';
import 'package:dayfi/ui/views/main/main_view.dart';
import 'package:dayfi/ui/views/tab_home/tab_home_view.dart';
import 'package:dayfi/ui/views/tab_history/tab_history_view.dart';
import 'package:dayfi/ui/views/tab_settings/tab_settings_view.dart';
import 'package:dayfi/ui/views/payment_setup/payment_setup_view.dart';
import 'package:dayfi/ui/views/auth_forgot_password/auth_forgot_password_view.dart';
import 'package:dayfi/ui/views/auth_verify_code/auth_verify_code_view.dart';
import 'package:dayfi/ui/views/auth_new_password/auth_new_password_view.dart';
import 'package:dayfi/ui/views/profile/profile_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView),
    MaterialRoute(page: WalkthroughView),
    MaterialRoute(page: AuthSignupView),
    MaterialRoute(page: AuthLoginView),
    MaterialRoute(page: MainView),
    MaterialRoute(page: TabHomeView),
    MaterialRoute(page: TabHistoryView),
    MaterialRoute(page: TabSettingsView),
    MaterialRoute(page: PaymentSetupView),
    MaterialRoute(page: AuthForgotPasswordView),
    MaterialRoute(page: AuthVerifyCodeView),
    MaterialRoute(page: AuthNewPasswordView),
    MaterialRoute(page: ProfileView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: SnackbarService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
// @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
