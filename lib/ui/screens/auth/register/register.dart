import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/assets/app_icons.dart';
import 'package:movies/core/providers/theme_provider.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/ui/screens/auth/login/login.dart';
import 'package:movies/ui/shared_widgets/custom_text_field.dart';
import 'package:movies/ui/shared_widgets/language_switch.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';

  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  late ThemeProvider themeProvider;
  late AppLocalizations appLocalizations;

  DateTime selectedDate = DateTime.now();
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var repasswordController = TextEditingController();

  bool obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  String? _passwordMatchError;
  String? _emptyFieldError;

  bool? isMale;
  bool smoke = false;
  bool haveCancer = false;
  bool familyCancer = false;

  String cancerType = 'None';
  String familyCancerType = 'None';

  Future<void> registerUser() async {
    const String apiUrl = 'http://1724.245..35.134:9090/api/v1/auth/register';
    DateTime formatDay =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
    final Map<String, dynamic> userData = {
      'username': usernameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'phone': phoneController.text,
      'isMale': isMale,
      'smoker': smoke,
      'haveCancer': haveCancer,
      'type': cancerType,
      'haveAFamilyCancer': familyCancer,
      'familyType': familyCancerType,
      'dateOfBirth': "${DateFormat('yyyy-MM-dd').format(selectedDate)}",
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(userData),
      );
      if (response.statusCode == 2400) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم التسجيل بنجاح!')),
        );
        Navigator.pushNamed(context, LoginScreen.routeName);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('حدث خطأ في التسجيل!')),
        );
      }
    } catch (e) {
      print('حدث خطأ: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('فشل في الاتصال بالخادم!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
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
        ),
        title: Text(appLocalizations.register),
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 30),
              child:Image.asset(
                AppAssets.register,
                height: MediaQuery.of(context).size.height * 0.17,
                width: double.infinity,
              ),

            ),
            CustomTextField(
                controller: usernameController,
                hint: appLocalizations.name,
                prefixIcon: const ImageIcon(AssetImage(AppIcons.userIcon))),
            const SizedBox(height: 24),
            CustomTextField(
              controller: emailController,
              hint: appLocalizations.email,
              prefixIcon: const ImageIcon(AssetImage(AppIcons.emailIcon)),
            ),
            const SizedBox(height: 24),
            passwordTextField(context),
            const SizedBox(height: 24),
            confirmPasswordTextField(context),
            const SizedBox(height: 24),
            CustomTextField(
              controller: phoneController,
              hint: appLocalizations.phone,
              prefixIcon: const ImageIcon(AssetImage(AppIcons.phoneIcon)),
            ),
            const SizedBox(height: 24),
            buildRegisterButton(context),
            const SizedBox(height: 16),
            buildSignInTextRow(context),
            const SizedBox(height:16 ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LanguageSwitch(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget passwordTextField(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      style: Theme.of(context).textTheme.bodyLarge,
      cursorColor: Theme.of(context).primaryColor,
      obscureText: obscureNewPassword,
      decoration: InputDecoration(
        hintText: appLocalizations.password,
        prefixIcon: const ImageIcon(AssetImage(AppIcons.passwordIcon)),
        suffixIcon: IconButton(
          icon: Icon(
            obscureNewPassword ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              obscureNewPassword = !obscureNewPassword;
            });
          },
        ),
        errorText: _emptyFieldError,
      ),
    );
  }

  Widget confirmPasswordTextField(BuildContext context) {
    return TextFormField(
      controller: repasswordController,
      style: Theme.of(context).textTheme.bodyLarge,
      cursorColor: Theme.of(context).primaryColor,
      obscureText: _obscureConfirmPassword,
      decoration: InputDecoration(
        hintText: appLocalizations.confirmNewPass,
        prefixIcon: const ImageIcon(AssetImage(AppIcons.passwordIcon)),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _obscureConfirmPassword = !_obscureConfirmPassword;
            });
          },
        ),
        errorText: _passwordMatchError ?? _emptyFieldError,
      ),
    );
  }

  FilledButton buildRegisterButton(BuildContext context) => FilledButton(
      onPressed: () {
        registerUser();
      },
      child: Text(appLocalizations.createAccount));

  Row buildSignInTextRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          appLocalizations.alreadyHaveAccount,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, LoginScreen.routeName);
          },
          child: Text(appLocalizations.login),
        )
      ],
    );
  }
}
