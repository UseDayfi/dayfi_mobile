import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'walkthrough_viewmodel.dart';

class WalkthroughView extends StackedView<WalkthroughViewModel> {
  const WalkthroughView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    WalkthroughViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  WalkthroughViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      WalkthroughViewModel();
}
