import 'package:article_app/features/auth/domain/entites/auth.dart';
import 'package:article_app/features/auth/presentation/bloc/auth_bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../../core/presentation/router/routes.dart';

import 'custom_text_field.dart';
import 'custom_password_text_form_field.dart';
import 'elevated_button_style.dart';
import 'elevated_button_text.dart';
import 'forgot_password.dart';
import 'show_welcome_message.dart';

class LoginComponent extends StatefulWidget {
  const LoginComponent({super.key});

  @override
  State<LoginComponent> createState() => _LoginComponentState();
}

class _LoginComponentState extends State<LoginComponent> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error as String),
              duration: const Duration(seconds: 4),
            ),
          );
        }

        if (state is Authenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Successfully logged in!'),
              duration: Duration(seconds: 4),
            ),
          );

          context.go(Routes.articles);
        }
      },
      builder: (context, state) {
        if (state is AuthenticationLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AuthenticationFailure) {
          return showLoginForm();
        } else if (state is Authenticated) {
          return showLoginForm();
        } else {
          return showLoginForm();
        }
      },
    );
  }

  Column showLoginForm() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const ShowWelcomeText(),
      SizedBox(height: 37.h),
      Form(
        key: _formKey,
        child: Column(children: [
          CustomTextFormField(
            controller: _usernameController,
            labelText: 'Username',
          ),
          SizedBox(height: 10.h),
          CustomPasswordTextField(passwordController: _passwordController),
          SizedBox(height: 137.h),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      AuthenticationEntites loginRequestEntity =
                          AuthenticationEntites(
                        userName: _usernameController.text,
                        password: _passwordController.text,
                      );

                      context.read<AuthenticationBloc>().add(LoginEvent(
                            authCredentials: loginRequestEntity,
                          ));
                    }
                  },
                  style: elevatedButtonStyle(),
                  child: const ElevatedButtonText(
                    text: 'LOGIN',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          const ForgotPassword(),
        ]),
      )
    ]);
  }
}
