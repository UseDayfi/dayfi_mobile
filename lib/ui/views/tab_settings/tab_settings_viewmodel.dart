import 'package:dayfi/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TabSettingsViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();

  final List<SettingsSectionModel> settingsSections = [
    SettingsSectionModel(
      header: 'Account',
      settingsSectionTiles: [
        SettingSectionTileModel(
          title: "Profile Information",
          description: "Update and manage your personal details",
          icon: "icon",
        ),
      ],
    ),
    SettingsSectionModel(
      header: 'Referral',
      settingsSectionTiles: [
        SettingSectionTileModel(
          title: "Invite & Earn",
          description: "Get rewards when you refer friends",
          icon: "icon",
        ),
      ],
    ),
    SettingsSectionModel(
      header: 'Banks',
      settingsSectionTiles: [
        SettingSectionTileModel(
          title: "Linked Banks",
          description: "View and manage your linked bank accounts",
          icon: "icon",
        ),
      ],
    ),
    SettingsSectionModel(
      header: 'Security Settings',
      settingsSectionTiles: [
        // SettingSectionTileModel(
        //   title: "Set Transaction PIN",
        //   description: "Secure your withdrawals with a PIN",
        //   icon: "icon",
        // ),
        // SettingSectionTileModel(
        //   title: "Update Transaction PIN",
        //   description: "Modify your existing transaction PIN",
        //   icon: "icon",
        // ),
        SettingSectionTileModel(
          title: "Change Password",
          description: "Update your login password",
          icon: "icon",
        ),
        // SettingSectionTileModel(
        //   title: "Biometric Authentication",
        //   description: "Enable fingerprint or face ID for security",
        //   icon: "icon",
        // ),
        // SettingSectionTileModel(
        //   title: "Two-Factor Authentication",
        //   description: "Enhance your account security with 2FA",
        //   icon: 'assets/svgs/2fa.svg',
        // ),
      ],
    ),
    SettingsSectionModel(
      header: 'About Dayfi',
      settingsSectionTiles: [
        // SettingSectionTileModel(
        //   title: "Rate Us",
        //   description: "Enjoying Dayfi? Leave a review!",
        //   icon: "icon",
        // ),
        // SettingSectionTileModel(
        //   title: "Help Center",
        //   description: "Find answers to common questions",
        //   icon: "icon",
        // ),
        // SettingSectionTileModel(
        //   title: "Official Website",
        //   description: "Visit our homepage for more info",
        //   icon: "icon",
        // ),
        // SettingSectionTileModel(
        //   title: "Latest Updates",
        //   description: "Stay informed with our news and blog",
        //   icon: "icon",
        // ),
        SettingSectionTileModel(
          title: "Support",
          description: "Need help? Contact our support team",
          icon: 'assets/svgs/2fa.svg',
        ),
      ],
    ),
    SettingsSectionModel(
      header: 'Account Options',
      settingsSectionTiles: [
        SettingSectionTileModel(
          title: "Log Out",
          description: "Sign out from your Dayfi account",
          icon: "icon",
        ),
        SettingSectionTileModel(
          title: "Delete Account",
          description: "Permanently remove your account",
          icon: "icon",
        ),
      ],
    ),
  ];
}

class SettingsSectionModel {
  final String header;
  final List<SettingSectionTileModel> settingsSectionTiles;

  SettingsSectionModel({
    required this.header,
    required this.settingsSectionTiles,
  });
}

class SettingSectionTileModel {
  final String title;
  final String description;
  final String icon;

  SettingSectionTileModel({
    required this.title,
    required this.description,
    required this.icon,
  });
}
