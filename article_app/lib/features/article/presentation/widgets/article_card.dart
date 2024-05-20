import 'package:article_app/features/article/presentation/Article_bloc/article_bloc.dart';
import 'package:article_app/features/article/presentation/Feed_bloc/feed_bloc.dart';
import 'package:article_app/features/article/presentation/widgets/article_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/router/routes.dart';
import '../../../../core/presentation/theme/app_colors.dart';
import '../../domain/entities/article.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({required this.article, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 240.h,
        width: 388.w,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: AppColors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 120.w),
              child: ArticlePhoto(article: article),
            ),
            SizedBox(width: 20.w),
          ],
        ),
      ),
      onTap: () async {
        final articleBloc = context.read<FeedBloc>();
        await context.push(Routes.articleDetail, extra: article);
        articleBloc.add(GetAllArticlesEvent());
      },
    );
  }
}
