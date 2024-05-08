import 'package:article_app/features/article/presentation/widgets/snackbar.dart';
import 'package:article_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:article_app/features/user/domain/entites/user_data.dart';
import 'package:article_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:article_app/features/user/presentation/widget/user_bio.dart';
import 'package:article_app/features/user/presentation/widget/user_profile_info.dart';
import 'package:article_app/features/user/presentation/widget/user_profile_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileDetails extends StatelessWidget {
  final UserEntity user;
  const UserProfileDetails({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    double horizontalPadding = 40.w;
    double topPadding = 19.h;
    double cardMarginLeft = 32.w;
    double cardMarginTop = 19.h;
    double cardMarginRight = 20.w;
    double cardBorderRadius = 16.0.w;

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserProfileUpdatedState) {
          showSuccess(context, 'Profile updated successfully');

          context.read<UserBloc>().add(GetUserEvent());
        }
      },
      child: Container(
        child: Text('data'),
      ),
    );
  }
}
