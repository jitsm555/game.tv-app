import 'package:flutter/material.dart';
import 'package:game_tv_app/utils/localization/application_localizations.dart';
import 'package:game_tv_app/view/home_screen.dart';
import 'package:game_tv_app/view_model/login_view_model.dart';
import 'package:provider/provider.dart';
import 'package:game_tv_app/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  static const String login_screen_route = "Login_Screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneNoController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isPhoneNoValid = false;
  bool _isPasswordValid = false;

  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  FocusNode phoneFocusNode;
  FocusNode passwordFocusNode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background_image.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: "logo",
                child: Image.asset(
                  'assets/game_tv_logo.png',
                  width: 200,
                ),
              ),
              _phoneNoWidget(),
              _passwordWidget(),
              _loginWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _phoneNoWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 8.0),
      child: TextFormField(
        focusNode: phoneFocusNode,
        controller: phoneNoController,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (value.length < 3 || value.length > 10) {
            _isPhoneNoValid = false;
          } else {
            _isPhoneNoValid = true;
          }
          setState(() {});
        },
        validator: (value) {
          if (value.length != 10) {
            return ApplicationLocalizations.of(context)
                .translate('phone_no_warning');
          }
          return null;
        },
        cursorColor: Colors.white,
        decoration: InputDecoration(
          labelText: ApplicationLocalizations.of(context).translate('phone_no'),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(32)),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _passwordWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: TextFormField(
        focusNode: passwordFocusNode,
        controller: passwordController,
        keyboardType: TextInputType.text,
        onChanged: (value) {
          if (value.length < 3 || value.length > 10) {
            _isPasswordValid = false;
          } else {
            _isPasswordValid = true;
          }
          setState(() {});
        },
        validator: (value) {
          if (value.length < 3 || value.length > 10) {
            return ApplicationLocalizations.of(context)
                .translate('password_warning');
          }
          return null;
        },
        cursorColor: Colors.white,
        decoration: InputDecoration(
          labelText: ApplicationLocalizations.of(context).translate('password'),
          helperText: "",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(32)),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _loginWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: RaisedButton(
          textColor: Colors.black,
          color: _isPhoneNoValid && _isPasswordValid
              ? Theme.of(context).primaryColor
              : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
          ),
          padding: EdgeInsets.fromLTRB(48.0, 16.0, 48.0, 16.0),
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              final isLoggedIn = await Provider.of<LoginViewModel>(context)
                  .tryLoggingIn(
                      phoneNoController.text, passwordController.text);
              if (isLoggedIn) {
                Navigator.of(context).pushNamed(HomeScreen.home_screen_route);
              } else
                _showSnackBar(ApplicationLocalizations.of(context)
                    .translate('invalid_credentials'));
            }
          },
          child: Text(ApplicationLocalizations.of(context).translate('login'))),
    );
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Padding(
          padding: EdgeInsets.all(4),
          child: Text(text),
        )));
  }

  @override
  void dispose() {
    phoneNoController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    phoneFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    passwordFocusNode.addListener(() {
      if (!passwordFocusNode.hasFocus) {
        setState(() {
          _formKey.currentState.validate();
        });
      }
    });
    phoneFocusNode.addListener(() {
      if (!phoneFocusNode.hasFocus) {
        setState(() {
          _formKey.currentState.validate();
        });
      }
    });
  }
}
