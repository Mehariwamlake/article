import 'package:article_app/core/presentation/util/time_calculator.dart';
import 'package:article_app/features/article/domain/entities/article.dart';
import 'package:article_app/features/article/presentation/Article_bloc/bookmark_bloc.dart';
import 'package:article_app/features/article/presentation/Article_bloc/bookmark_event.dart';
import 'package:article_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/presentation/router/routes.dart';
import '../../../../../core/presentation/theme/app_colors.dart';

import '../../bloc/user_bloc.dart';

class SingleArticlePostGridView extends StatelessWidget {
  final Article article;

  const SingleArticlePostGridView({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imageWidth = double.infinity;
    double imageHeight = 150.w;
    double titleFontSize = 14.sp;
    double subTitleFontSize = 14.sp;
    double statsFontSize = 12.sp;
    double iconSize = 14.w;
    double statsSpacing = 4.w;

    const likes = '2.1k';

    final imageUrl = article.photoUrl;
    final articleTitle = article.title;
    final articleSubTitle = article.subtitle;
    final timeSincePosted =
        timePassedFormatter(timePassedCalculator(article.date));

    return GestureDetector(
      onTap: () async {
        final userBloc = context.read<UserBloc>();
        final authBloc = context.read<AuthBloc>();
        final bookmarkBloc = context.read<BookmarkBloc>();
        await context.push(Routes.articleDetail, extra: article);
        userBloc.add(GetUserEvent(token: authBloc.authToken));
        bookmarkBloc.add(LoadBookmarksEvent());
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: imageWidth,
              height: imageHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  articleTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: titleFontSize,
                    color: AppColors.blue,
                  ),
                ),
                SizedBox(height: statsSpacing),
                Text(
                  articleSubTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: subTitleFontSize,
                    color: AppColors.darkerBlue,
                  ),
                ),
                SizedBox(height: 8.w),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.thumb_up_alt_outlined,
                          color: AppColors.darkBlue,
                          size: iconSize,
                        ),
                        SizedBox(width: statsSpacing),
                        Text(
                          likes,
                          style: TextStyle(
                            fontSize: statsFontSize,
                            fontWeight: FontWeight.w500,
                            color: AppColors.darkBlue,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: AppColors.darkBlue,
                          size: iconSize,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          timeSincePosted,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.darkBlue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: statsSpacing),
                    Icon(
                      Icons.bookmark_outlined,
                      color: AppColors.blue,
                      size: iconSize,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
