import 'package:dayfi/app/app.bottomsheets.dart';
import 'package:dayfi/app/app.dialogs.dart';
import 'package:dayfi/app/app.locator.dart';
import 'package:dayfi/app/app.router.dart';
import 'package:dayfi/ui/common/snackbar/setup_snackbar_ui.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupSnackbarUi();
  setupBottomSheetUi();
  runApp(const MainApp());

  await Supabase.initialize(
    url: 'https://gjlxljxroqgdypzwkeff.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdqbHhsanhyb3FnZHlwendrZWZmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzgzNDk0MDcsImV4cCI6MjA1MzkyNTQwN30.LUaQlc0fNplNEv_UKPLSDCvsaV8AhxdtMYcwoyV6YBQ',
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(374, 844),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.startupView,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        navigatorKey: StackedService.navigatorKey,
        navigatorObservers: [
          StackedService.routeObserver,
        ],
        title: 'Dayfi',
        theme: ThemeData(
          fontFamily: 'DegularDisplay',
          useMaterial3: true,
          primaryColor: Colors.white,
        ),
      ),
    );
  }
}

// ===========================================================================
// ===========================================================================
