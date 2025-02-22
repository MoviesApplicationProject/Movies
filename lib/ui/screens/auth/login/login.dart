import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:icons_plus/icons_plus.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/assets/app_icons.dart';
import 'package:movies/core/providers/theme_provider.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/ui/screens/auth/forgetpassword/forgetpassword.dart';
import 'package:movies/ui/screens/auth/register/register.dart';
import 'package:movies/ui/screens/movieDetalis/movie_detalis.dart';
import 'package:movies/ui/screens/onBoarding_screens/explore/explore_now.dart';
import 'package:movies/ui/shared_widgets/custom_button.dart';
import 'package:movies/ui/shared_widgets/custom_text_field.dart';
import 'package:movies/ui/shared_widgets/language_switch.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/loginScreen";

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late AppLocalizations appLocalizations;
  late ThemeProvider themeProvider;



  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool obscurePassword = true;
  String? _emptyFieldError;

  String? emailError;
  String? passwordError;

  var formKey = GlobalKey<FormState>();

  Future<void> loginUser(String email, String password) async {
    const String apiUrl = 'http://172.25..35.134:9090/api/v1/auth/authenticate';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        Navigator.pushNamed(context, ExploreNowScreen.routeName);
        print('Login successful: ${data['token']}');

        setState(() {
          emailError = null;
          passwordError = null;
        });
      } else {
        setState(() {
          emailError = 'Email or password may be incorrect';
          passwordError = 'Email or password may be incorrect';
        });
      }
    } catch (e) {
      print('Error during login: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);

    appLocalizations = AppLocalizations.of(context) ?? AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              Container(
                margin: EdgeInsets.all(70),
                child:Image.asset(
                  AppAssets.login,
                  width: MediaQuery.of(context).size.width * 0.27,
                  height: MediaQuery.of(context).size.height * 0.12,
                ),
              ),
              buildEmailTextField(context),
              const SizedBox(height: 22),
              buildPasswordTextField(context),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, ForgetpasswordScreen.routeName);
                    },
                    child: Text(appLocalizations.forgetPassword + "?"),
                  )
                ],
              ),
              const SizedBox(height: 33),
              buildLoginButton(context),
              const SizedBox(height: 22),
              buildSignUpRow(context),
              const SizedBox(height: 8),
              buildORText(context),
              const SizedBox(height: 16),
              buildGoogleSignInButton(context),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LanguageSwitch(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPasswordTextField(BuildContext context) {
    return CustomTextField(
      controller: passwordController,
      obscureText: obscurePassword,
      hint: appLocalizations.password,
        prefixIcon: const ImageIcon(AssetImage(AppIcons.passwordIcon)),
        suffixIcon: IconButton(
          icon: Icon(
            obscurePassword ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              obscurePassword = !obscurePassword;
            });
          },),
        error: passwordError,
    );
  }

  Widget buildEmailTextField(BuildContext context) {
    return CustomTextField(
      controller: emailController,
      hint: appLocalizations.email,
      prefixIcon: const ImageIcon(AssetImage(AppIcons.emailIcon)),
      error: emailError,
      validator: (email) {
        if (email == null || email.isEmpty) {
          return "Please enter email";
        }
        final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email);
        if (!emailValid) {
          return "The email address is badly formatted";
        }
        return null;
      },
    );
  }

  Widget buildLoginButton(BuildContext context) {
    return CustomButton(
        onClick: () {
          if (formKey.currentState!.validate()) {
            loginUser(emailController.text, passwordController.text);
          }
          Navigator.pushNamed(context, MovieDetalis.routeName);
        },
        title: appLocalizations.login);
  }

  Widget buildSignUpRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Text(
            appLocalizations.dontHaveAccount,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        TextButton(
              onPressed: () {
                Navigator.pushNamed(context, RegisterScreen.routeName);
              },
              child: Text(
                appLocalizations.createAccount,
              ),
            )
      ],
    );
  }

  Padding buildORText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Row(
        children: [
          const Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "OR",
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }

  FilledButton buildGoogleSignInButton(BuildContext context) {
    return FilledButton(
      onPressed: () {},
      style: FilledButton.styleFrom(
      ),
      child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Brand(Brands.google ,colorFilter:  ColorFilter.mode(
                  AppColors.black,
                  BlendMode.srcIn,
                ), ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 3,
                child: Text(
                  appLocalizations.googleLogin,
                ),
              ),
            ],
          )),
    );
  }
}
