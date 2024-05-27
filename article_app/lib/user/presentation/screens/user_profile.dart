import 'package:article_app/features/article/presentation/Article_bloc/bookmark_bloc.dart';
import 'package:article_app/features/article/presentation/widgets/snackbar.dart';
import 'package:article_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:article_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/router/routes.dart';
import '../../../../core/presentation/theme/app_colors.dart';

import '../bloc/profile_page_bloc.dart';
import '../bloc/user_bloc.dart';
import '../widgets/userprofile/article_grid_view.dart';
import '../widgets/userprofile/article_list_view.dart';
import '../widgets/userprofile/gradient_at_bottom.dart';
import '../widgets/userprofile/show_posts_and_bookmarks.dart';
import '../widgets/userprofile/user_profile_details.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => serviceLocator<UserBloc>()
            ..add(GetUserEvent(
                token: BlocProvider.of<AuthBloc>(context).authToken)),
        ),

        //
        BlocProvider(
            create: (context) =>
                serviceLocator<BookmarkBloc>()..add(LoadBookmarksEvent())),

        //
        BlocProvider(create: (context) => serviceLocator<ProfilePageBloc>()),
      ],

      //
      //
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LogoutSuccessState) {
            context.go(Routes.home);
          } else if (state is AuthError) {
            showError(context, 'Failed to logout');
          } else if (state is UserProfileUpdatedState) {
            context.read<UserBloc>().add(GetUserEvent(
                token: BlocProvider.of<AuthBloc>(context).authToken));
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // const ProfileBar(),
                      BlocBuilder<UserBloc, UserState>(
                          builder: (context, state) {
                        if (state is LoadedUserState) {
                          return UserProfileDetails(user: state.userData);
                        } else if (state is ErrorState) {
                          return Text(state.message);
                        } else {
                          return const Center(child: Text("unautorized"));
                        }
                      }),
                      GestureDetector(
                        onTap: () {},

                        //
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(28.0),
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.025,
                            )),
                        child: Container(),
                      )
                    ],
                  ),
                ),
              ),
              const GradientAtBottom()
            ],
          ),
        ),
      ),
    );
  }
}
