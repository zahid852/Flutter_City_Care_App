import 'package:city_care/pages/add_incidents_page.dart';
import 'package:city_care/pages/login_page.dart';
import 'package:city_care/pages/register_page.dart';
import 'package:city_care/view_models/add_incident_view_model.dart';
import 'package:city_care/view_models/login_viewmodel.dart';
import 'package:city_care/view_models/register_Viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppNavigator {
  static Future<bool> navigateToRegisterPage(BuildContext context) async {
    return await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (context) => registerViewModel(),
                  child: RegisterPage(),
                ),
            fullscreenDialog: true));
  }

  static Future<bool> navigateToAddIncidentPage(BuildContext context) async {
    return await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => AddIncidentViewModel(),
                child: AddIncidentsPage()),
            fullscreenDialog: true));
  }

  static Future<bool> navigateToLoginPage(BuildContext context) async {
    return await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (context) => LoginViewModel(),
                  child: LoginPage(),
                ),
            fullscreenDialog: true));
  }
}
