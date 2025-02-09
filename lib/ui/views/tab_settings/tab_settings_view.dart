import 'package:dayfi/app/app.router.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'tab_settings_viewmodel.dart';

class TabSettingsView extends StackedView<TabSettingsViewModel> {
  const TabSettingsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TabSettingsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Color(0xfff7f7f7),
      appBar: AppBar(
        backgroundColor: Color(0xfff7f7f7),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Settings",
          style: TextStyle(
            fontSize: 26,
            height: 1.2,
            color: Color.fromARGB(255, 49, 17, 34),
            // color: Color(0xffff0082)Accent,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(viewModel),
            const SizedBox(height: 32),
            _buildSettingsList(),
            const Spacer(),
            _buildSignOutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(TabSettingsViewModel viewModel) {
    return GestureDetector(
      onTap: () => viewModel.navigationService.navigateToProfileView(),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Color.fromARGB(255, 49, 17, 34).withOpacity(.2),
            backgroundImage: const NetworkImage(
              'https://avatar.iran.liara.run/public/52',
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Ife Oluwafemi",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text("Ife.dev@gmail.com"),
              SizedBox(height: 4),
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF6422AA).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  // border: Border.all(
                  //   color: const Color(0xFFFFD700).withOpacity(0.5),
                  //   width: 1,
                  // ),
                ),
                child: Text(
                  "Tier 1",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsList() {
    return Column(
      children: [
        _buildListItem(Icons.verified_user, "Verification and limits",
            "Manage your account verification and tier limits"),
        _buildListItem(Icons.account_balance_wallet, "Payment methods",
            "Manage saved bank accounts"),
        _buildListItem(
            Icons.security, "Security", "Manage password, PIN & 2FA"),
        _buildListItem(
            Icons.settings, "Preferences", "Manage notifications & languages"),
        _buildListItem(Icons.card_giftcard, "Referrals & Rewards",
            "Earn money for referring your friends and performing tasks"),
        _buildListItem(
            Icons.support_agent, "Support", "Contact us for some help"),
      ],
    );
  }

  Widget _buildSignOutButton() {
    return Center(
      child: TextButton(
        onPressed: () {},
        child: const Text("Sign out", style: TextStyle(color: Colors.red)),
      ),
    );
  }

  Widget _buildListItem(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: CircleAvatar(
        radius: 18,
        backgroundColor: Color.fromARGB(255, 49, 17, 34).withOpacity(.1),
        child: Icon(
          icon,
          color: Color.fromARGB(255, 49, 17, 34),
          size: 18,
        ),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey.shade600),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }

  @override
  TabSettingsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      TabSettingsViewModel();
}
