import 'package:city_care/view_models/register_Viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:city_care/utils/constants.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  late registerViewModel _registerVM;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<bool> _registerUser(BuildContext context) async {
    bool isRegistered = false;

    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _emailController.text;

      isRegistered = await _registerVM.register(email, password);
      if (isRegistered) {
        Navigator.of(context).pop(true);
      }
    }

    return isRegistered;
  }

  @override
  Widget build(BuildContext context) {
    _registerVM = Provider.of<registerViewModel>(context);
    return Scaffold(
        appBar: AppBar(title: Text("Register")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 150,
                    backgroundImage:
                        AssetImage(Constants.REGISTER_PAGE_HERO_IMAGE),
                  ),
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
                    style: TextButton.styleFrom(backgroundColor: Colors.blue),
                    child:
                        Text("Register", style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      _registerUser(context);
                    },
                    // color: Colors.blue
                  ),
                  Text(_registerVM.message)
                ],
              ),
            ),
          ),
        ));
  }
}
