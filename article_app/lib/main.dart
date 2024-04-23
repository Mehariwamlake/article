import 'package:article_app/core/utils/colors.dart';
import 'package:article_app/features/auth/domain/usecase/auth_usecase.dart';
import 'package:article_app/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:article_app/features/auth/presentation/screen/home_screen.dart';
import 'package:article_app/features/auth/presentation/screen/login_page.dart';
import 'package:article_app/injection.dart' as di;
import 'package:article_app/injection.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.inti();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (_) => AuthenticationBloc(
        loginUseCase: sl<LoginUseCase>(), // Directly call the instance from sl
        signupUseCase:
            sl<SignupUseCase>(), // Directly call the instance from sl
      ),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: whiteColor,
        ),
        home: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            // Check if the authentication state is Authenticated
            if (state is Authenticated) {
              // Navigate to the home page
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => HomePage(),
              ));
            }
          },
          child: const LoginPage(),
        ),
      ),
    );
  }
}
