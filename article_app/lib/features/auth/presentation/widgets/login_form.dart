import 'package:article_app/features/auth/domain/entites/auth.dart';
import 'package:article_app/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'login_button.dart';

class LogInForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LogInForm({
    super.key,
    required this.passwordController,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        "Welcome back",
        style: TextStyles.welcomeBack,
      ),
      SizedBox(height: MediaQuery.of(context).size.height * 0.012),
      const Text(
        "Sign in with your account",
        style: TextStyles.signIn,
      ),
      SizedBox(height: MediaQuery.of(context).size.height * 0.03),
      const Text(
        "Username",
        style: TextStyles.formFieldTextStyle,
      ),
      TextFormField(
        controller: emailController,
        decoration: InputDecoration(
          hintText: 'username@gmail.com',
          hintStyle: TextStyles.hintText,
        ),
      ),
      SizedBox(height: MediaQuery.of(context).size.height * 0.03),
      const Text(
        "Password",
        style: TextStyles.formFieldTextStyle,
      ),
      Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: '••••••',
                hintStyle: TextStyles.passwordTextFieldHint,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(
                LoginEvent(
                  authCredentials: Authentication(
                    // Assuming your Authentication entity has username and password fields
                    userName: emailController.text,
                    password: passwordController.text,
                  ),
                ),
              );
            },
            child: Text(
              "Show",
              style: TextStyles.showButton,
            ),
          ),
        ],
      ),
      SizedBox(height: MediaQuery.of(context).size.height * 0.2),
      LogInButton(),
      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          "Forgot your password?",
          style: TextStyles.forgotPassword,
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
        Text(
          "Reset here",
          style: TextStyles.reset,
        ),
      ]),
    ]);
  }
}
