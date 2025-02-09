import 'package:dayfi/ui/views/coin_lists_view.dart';
import 'package:dayfi/ui/views/tab_history/tab_history_view.dart';
import 'package:dayfi/ui/views/tab_home/tab_home_view.dart';
import 'package:dayfi/ui/views/tab_settings/tab_settings_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'main_viewmodel.dart';

class MainView extends StackedView<MainViewModel> {
  final int index;

  // ignore: use_super_parameters
  const MainView({
    Key? key,
    this.index = 0,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MainViewModel viewModel,
    Widget? child,
  ) {
    Widget getViewForIndex(int index) {
      switch (index) {
        case 0:
          return TabHomeView();
        case 1:
          return CoinListScreen();
        case 2:
          return TabHistoryView();
        case 3:
          return TabSettingsView();
        default:
          return TabHomeView();
      }
    }

    // ignore: no_leading_underscores_for_local_identifiers
    void _onItemTap(int index) => viewModel.setIndex(index);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: getViewForIndex(viewModel.currentIndex),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: viewModel.currentIndex,
          onTap: _onItemTap,
          elevation: 0,
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontFamily: 'DegularDisplay',
            letterSpacing: -.2,
          ),
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontFamily: 'DegularDisplay',
            letterSpacing: -.2,
          ),
          selectedItemColor: Color.fromARGB(255, 49, 17, 34),
          unselectedItemColor:
              Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.25),
          selectedFontSize: 15,
          unselectedFontSize: 15,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined, size: 28),
              activeIcon: Icon(Icons.account_balance_wallet,
                  size: 28, color: Color.fromARGB(255, 49, 17, 34)),
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on_outlined, size: 28),
              activeIcon: Icon(Icons.monetization_on,
                  size: 28, color: Color.fromARGB(255, 49, 17, 34)),
              label: 'Coins',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.payment_outlined, size: 28),
              activeIcon: Icon(Icons.payment,
                  size: 28, color: Color.fromARGB(255, 49, 17, 34)),
              label: 'Pay',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined, size: 28),
              activeIcon: Icon(Icons.settings,
                  size: 28, color: Color.fromARGB(255, 49, 17, 34)),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  @override
  MainViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MainViewModel();
}
