import 'package:article_app/core/utils/constants/colors.dart';
import 'package:article_app/core/utils/constants/styles.dart';
import 'package:article_app/core/utils/converters/real_pixel_to_logical_pixel.dart';
import 'package:article_app/core/utils/style.dart';
import 'package:article_app/features/article/domain/entities/article.dart';
import 'package:article_app/features/article/presentation/screen1/article_reading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ArticlePreviewCard extends StatelessWidget {
  final Article article;
  const ArticlePreviewCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ArticleReading(article: article))),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              convertPixelToScreenHeight(context, 10),
            ),
            boxShadow: const [
              homePageFirstShadowStyle,
              homePageSecondShadowStyle
            ]),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 25),
          child: SizedBox(
            height: convertPixelToScreenHeight(context, 240),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Container(
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    AssetImage("assets/images/card_image.jpg")),
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                  children: [
                    Expanded(
                      child: Text(
                        article.title.toUpperCase(),
                        style: cardHeaderTextStyle,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      width: convertPixelToScreenHeight(context, 70),
                      height: convertPixelToScreenHeight(context, 21),
                      decoration: BoxDecoration(
                        color: cardTagColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          article.tags[0],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
