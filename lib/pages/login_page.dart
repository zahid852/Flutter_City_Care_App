import 'package:city_care/view_models/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:city_care/utils/constants.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late LoginViewModel _loginViewModel;
  bool isLogedIn = false;
  void _login(BuildContext context) async {
    final email = _emailController.text;
    final password = _passwordController.text;
    isLogedIn = await _loginViewModel.login(email, password);
    if (isLogedIn) {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    _loginViewModel = Provider.of<LoginViewModel>(context);

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future<bool>.value(false);
      },
      child: Scaffold(
          appBar: AppBar(title: Text("Login")),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CircleAvatar(
                          maxRadius: 150,
                          backgroundImage:
                              AssetImage(Constants.LOGIN_PAGE_HERO_IMAGE)),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email is required!";
                          }
                          return null;
                        },
                        decoration: InputDecoration(hintText: "Email"),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password is required!";
                          }
                          return null;
                        },
                        decoration: InputDecoration(hintText: "Password"),
                      ),
                      TextButton(
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.blue),
                        child: Text("Login",
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          _login(context);
                        },
                        // color: Colors.blue
                      ),
                      Text(_loginViewModel.message)
                    ],
                  )),
            ),
          )),
    );
  }
}
