import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies/API/auth_service.dart';
import 'package:movies/Model/avatar.dart';
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
  PageController _pageController = PageController(initialPage: 5, viewportFraction: 0.5);
  double currentPage = 5.0;
  int selectedAvatarId = Avatar.avatars[5]['id'];

  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var repasswordController = TextEditingController();

  bool obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  String? _passwordMatchError;
  String? _emptyFieldError;
  String? _emailError;
  String? _phoneError;

  @override
  void initState() {
    super.initState();
    phoneController.text = '+20';
  }

  bool validateInput() {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        repasswordController.text.isEmpty ||
        phoneController.text.isEmpty) {
      _emptyFieldError = appLocalizations.allFieldsMustBeFilled;
      return false;
    }

    if (!isValidEmail(emailController.text)) {
      _emailError = appLocalizations.invalidEmailAddress;
      return false;
    }

    if (!isValidPhone(phoneController.text)) {
      _phoneError = appLocalizations.invalidPhoneNumber;
      return false;
    }

    if (passwordController.text != repasswordController.text) {
      _passwordMatchError = appLocalizations.passwordsDoNotMatch;
      return false;
    }

    _emptyFieldError = null;
    _passwordMatchError = null;
    _emailError = null;
    _phoneError = null;
    return true;
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool isValidPhone(String phone) {
    final phoneRegex = RegExp(r'^\+?\d{10,15}$');
    return phoneRegex.hasMatch(phone);
  }


  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
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
              margin: const EdgeInsets.only(bottom: 30),

              child:  SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: PageView.builder(
                      controller: _pageController,
                      itemCount: Avatar.avatars.length,
                      onPageChanged: (index) {
                        setState(() {
                            selectedAvatarId = Avatar.avatars[index]['id'];
                            currentPage = index.toDouble();
                        });
                      },
                      itemBuilder: (context, index) {
                        double distanceFromCenter = (currentPage - index).abs();
                        double scaleFactor = (1 - distanceFromCenter * 0.4).clamp(0.4, 1.0);
                        double widthFactor = (1 - distanceFromCenter * 0.03).clamp(0.4, 1.0);
                        return Center(
                          child: Transform.scale(
                            scale: scaleFactor,
                              child:Container(
                                  width: MediaQuery.of(context).size.width * 0.35 * widthFactor,
                                  child:  Image.asset(Avatar
                                    .avatars[index]['asset']),
                          ),
                          )
                        );
                      }
                  )
                  )
      //   Transform.scale(
      //   scale: scaleFactor,
      //   child: Container(
      //     width: MediaQuery.of(context).size.width * 0.7 * widthFactor,
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 0),
      //       child: MovieDesign(movie: movie),
      //     ),
      //   ),
      // ),
            ),
            CustomTextField(
              controller: usernameController,
              hint: appLocalizations.name,
              prefixIcon: const ImageIcon(AssetImage(AppIcons.userIcon)),
            ),
            const SizedBox(height: 24),
            CustomTextField(
              controller: emailController,
              hint: appLocalizations.email,
              error: _emailError,
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
              error: _phoneError,
              prefixIcon: const ImageIcon(AssetImage(AppIcons.phoneIcon)),
            ),
            const SizedBox(height: 24),
            buildRegisterButton(context),
            const SizedBox(height: 16),
            buildSignInTextRow(context),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [LanguageSwitch()],
            ),
          ],
        ),
      ),
    );
  }

  Widget passwordTextField(BuildContext context) {
    return CustomTextField(
      controller: passwordController,
      obscureText: obscureNewPassword,
      hint: appLocalizations.password,
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
      error: _emptyFieldError,
    );
  }

  Widget confirmPasswordTextField(BuildContext context) {
    return CustomTextField(
      controller: repasswordController,
      obscureText: _obscureConfirmPassword,
      hint: appLocalizations.confirmNewPass,
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
      error: _passwordMatchError ?? _emptyFieldError,
    );
  }

  FilledButton buildRegisterButton(BuildContext context) => FilledButton(
      onPressed: () {
        AuthService().registerUser(
            context: context,
            name: usernameController.text,
            email: emailController.text,
            phone: phoneController.text,
            password: passwordController.text,
            confirmPassword: repasswordController.text,
            avaterId: selectedAvatarId);
      },
      child: Text(appLocalizations.createAccount));
  Row buildSignInTextRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          appLocalizations.alreadyHaveAccount,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, LoginScreen.routeName);
          },
          child: Text(appLocalizations.login),
        ),
      ],
    );
  }
}
