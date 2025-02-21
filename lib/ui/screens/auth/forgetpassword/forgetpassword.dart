import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/assets/app_icons.dart';
import 'package:movies/ui/screens/auth/login/login.dart';
import 'package:movies/ui/shared_widgets/custom_text_field.dart';

class ForgetpasswordScreen extends StatefulWidget {
  static const String routeName = "/forgetpasswordScreen";

  const ForgetpasswordScreen({super.key});

  @override
  ForgetpasswordScreenState createState() => ForgetpasswordScreenState();
}

class ForgetpasswordScreenState extends State<ForgetpasswordScreen> {
  late AppLocalizations appLocalizations;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _inputController = TextEditingController();

  Future<void> forgetPassword(String input) async {
    final url = Uri.parse('http://localhost:8080/api/v1/auth/forgot-password');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'emailOrPhone': input, // Assuming your backend accepts this field
        }),
      );

      if (response.statusCode == 200) {
        // API success: Navigate to the verification screen
        Navigator.pushNamed(context, LoginScreen.routeName);
      } else {
        // API failed: Show error message
        showMessage(context, "error");
      }
    } catch (e) {
      // Handle network errors
      showMessage(context, 'Error: $e');
    }
  }

  String? _validateInput(String value) {
    final emailRegEx =
        RegExp(r"^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
    final phoneRegEx = RegExp(r"^\d{11}$");

    if (value.isEmpty) {
      return appLocalizations.enterEmailOrPhone;
    } else if (!emailRegEx.hasMatch(value) && !phoneRegEx.hasMatch(value)) {
      return appLocalizations.invalidEmailOrPhoneNumber;
    }
    return null;
  }

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading:IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          //
        ),
        title: Text(appLocalizations.forgetPasswordScreen),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Image.asset(
              AppAssets.forgetPassword,
              height: MediaQuery.of(context).size.height * 0.46,
              width: double.infinity,
            ),
            CustomTextField(
              controller: _inputController,
                prefixIcon: const ImageIcon(AssetImage(AppIcons.emailIcon)),
              validator: (value) {
                return _validateInput(value!);
              }, hint: appLocalizations.email,
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: () {
                // if (_formKey.currentState!.validate()) {
                //   forgetPassword(_inputController.text);
                // }
                Navigator.pushNamed(context, LoginScreen.routeName);
              },
              child: Text(appLocalizations.verify),
            ),
          ],
        ),
      ),
    );
  }
}
