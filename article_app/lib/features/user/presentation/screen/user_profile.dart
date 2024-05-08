import 'dart:developer';

import 'package:article_app/core/presentation/router/routes.dart';
import 'package:article_app/core/presentation/theme/app_colors.dart';
import 'package:article_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:article_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:article_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<UserBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LogoutSuccessState) {
            context.go(Routes.home);
          } else if (state is AuthError) {
            log('error');
          }
        },
        child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.gray100,
              shadowColor: Colors.transparent,
              title: Container(
                color: AppColors.gray100,
                margin: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 24.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Profile',
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              ),
              actions: [
                PopupMenuButton(
                  onSelected: (value) {
                    if (value == 'logout') {
                      context.read<AuthBloc>().add(LogoutEvent());
                    }
                  },
                  icon: const Icon(
                    Icons.more_horiz,
                    color: AppColors.darkerBlue,
                  ),
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        value: 'logout',
                        child: Text('Logout'),
                      ),
                    ];
                  },
                ),
              ]),
          body: Stack(
            children: [
              SafeArea(
                  child: Column(
                children: [
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state is LoadedUserState) {
                        return Container(
                          child: Text('data'),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
