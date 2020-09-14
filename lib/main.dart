import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_tv_app/utils/localization/app_language.dart';
import 'package:game_tv_app/utils/localization/application_localizations.dart';
import 'package:game_tv_app/view/home_screen.dart';
import 'package:game_tv_app/view/login_screen.dart';
import 'package:game_tv_app/view/splash_screen.dart';
import 'package:game_tv_app/view_model/home_view_model.dart';
import 'package:game_tv_app/view_model/login_view_model.dart';
import 'package:game_tv_app/view_model/splash_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: SplashViewModel()),
        ChangeNotifierProvider.value(value: LoginViewModel()),
        ChangeNotifierProvider.value(value: HomeViewModel()),
        ChangeNotifierProvider.value(value: AppLanguage()),
      ],
      child: Consumer<AppLanguage>(builder: (context, model, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Game Tv',
          theme: ThemeData(
            appBarTheme: AppBarTheme(),
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
          ),
          supportedLocales: [
            Locale('en', 'US'),
            Locale('ja', 'JA'),
          ],
          localizationsDelegates: [
            ApplicationLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          initialRoute: SplashScreen.splash_screen_route,
          routes: {
            SplashScreen.splash_screen_route: (context) => SplashScreen(),
            LoginScreen.login_screen_route: (context) => LoginScreen(),
            HomeScreen.home_screen_route: (context) => HomeScreen(),
          },
        );
      }),
    );
  }
}
