import 'package:article_app/core/utils/constants/colors.dart';
import 'package:article_app/core/utils/converters/real_pixel_to_logical_pixel.dart';
import 'package:article_app/features/article/domain/entities/article.dart';
import 'package:article_app/features/article/presentation/screen1/write_article_page.dart';
import 'package:article_app/features/article/presentation/widgets/article_preview_card.dart';
import 'package:article_app/features/article/presentation/widgets/filter_chips.dart';
import 'package:flutter/material.dart';

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
              children: [SearchBar(), FilterChips()],
            ),
          ),
          SizedBox(height: convertPixelToScreenHeight(context, 30)),
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
                margin: EdgeInsets.symmetric(vertical: 15),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ArticleFormPage()),
                    );
                  },
                  child: const Icon(
                    Icons.add,
                    color: defaultIconColor,
                    size: 30,
                  ),
                ),
                decoration: BoxDecoration(
                    color: defaultButtonColor,
                    borderRadius: BorderRadius.circular(
                        convertPixelToScreenHeight(context, 10))),
              )
            ],
          )
        ],
      ),
    );
  }
}
