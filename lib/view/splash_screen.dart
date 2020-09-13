import 'package:flutter/material.dart';
import 'package:game_tv_app/view/home_screen.dart';
import 'package:game_tv_app/view/login_screen.dart';
import 'package:game_tv_app/view_model/splash_view_model.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  static const String splash_screen_route = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: Provider.of<SplashViewModel>(context).isLoggedIn(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                      child: Image.asset(
                    'assets/game_tv_logo.png',
                    width: 200,
                  )),
                ),
              ),
            );
          }
          return snapshot.data ? HomeScreen() : LoginScreen();
        },
      ),
    );
  }
}
