import 'dart:developer';

import 'package:article_app/core/utils/constants/colors.dart';
import 'package:article_app/core/utils/converters/real_pixel_to_logical_pixel.dart';
import 'package:article_app/features/article/domain/entities/article.dart';
import 'package:article_app/features/article/presentation/Article_bloc/tag_bloc.dart';
import 'package:article_app/features/article/presentation/screen1/article_form_secreen.dart';
import 'package:article_app/features/article/presentation/widget1/write_article_page.dart';
import 'package:article_app/features/article/presentation/widgets/article_preview_card.dart';
import 'package:article_app/features/article/presentation/widgets/filter_chips.dart';
import 'package:article_app/features/article/presentation/widgets/loading.dart';
import 'package:article_app/features/article/presentation/widgets/search_bar.dart';
import 'package:article_app/features/article/presentation/widgets/tag_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBody extends StatelessWidget {
  final List<Article> articles;

  const HomeBody({
    super.key,
    required this.articles,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          SizedBox(
            height: convertPixelToScreenHeight(context, 110),
            child: Column(
              children: [
                CustomSearchBar(),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<TagBloc, TagState>(
                  listener: (context, state) {
                    if (state is TagErrorState) {
                      log('error');
                    }
                  },
                  builder: (context, state) {
                    if (state is TagLoadingState) {
                      return const LoadingWidget();
                    } else if (state is AllTagsLoadedState) {
                      return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: TagList(tagList: state.tags));
                    }
                    return const LoadingWidget();
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: convertPixelToScreenHeight(context, 80)),
          Expanded(
              child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              height: convertPixelToScreenHeight(context, 25),
            ),
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return ArticlePreviewCard(article: article);
            },
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    color: defaultButtonColor,
                    borderRadius: BorderRadius.circular(
                        convertPixelToScreenHeight(context, 10))),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ArticleFormPage()),
                    );
                  },
                  child: const Icon(
                    Icons.add,
                    color: defaultIconColor,
                    size: 30,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
