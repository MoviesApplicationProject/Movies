import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies/API/auth_service.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/assets/app_icons.dart';
import 'package:movies/core/providers/theme_provider.dart';
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

  bool validateInput() {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        repasswordController.text.isEmpty ||
        phoneController.text.isEmpty) {
      _emptyFieldError = 'يجب ملء جميع الحقول';
      return false;
    }

    if (!isValidEmail(emailController.text)) {
      _emailError = 'البريد الإلكتروني غير صالح';
      return false;
    }

    if (!isValidPhone(phoneController.text)) {
      _phoneError = 'رقم الهاتف غير صالح';
      return false;
    }

    if (passwordController.text != repasswordController.text) {
      _passwordMatchError = 'كلمة المرور غير متطابقة';
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

  Future<void> registerUser() async {
    if (!validateInput()) {
      setState(() {});
      return;
    }

    try {
      bool success = await AuthService().registerUser(
        name: usernameController.text,
        email: emailController.text,
        password: passwordController.text,
        confirmPassword: repasswordController.text,
        phone: phoneController.text,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم التسجيل بنجاح!')),
        );
        Navigator.pushNamed(context, LoginScreen.routeName);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('حدث خطأ في التسجيل. تأكد من صحة البيانات!')),
        );
      }
    } catch (e) {
      // معالجة الأخطاء وعرض رسالة للمستخدم
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ أثناء التسجيل: $e')),
      );
      print('Error during registration: $e'); // طباعة الخطأ في الـ console للتصحيح
    }
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
              child: Image.asset(
                AppAssets.register,
                height: MediaQuery.of(context).size.height * 0.17,
                width: double.infinity,
              ),
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
        ),
      ],
    );
  }
}
