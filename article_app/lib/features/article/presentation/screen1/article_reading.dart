import 'package:article_app/features/article/domain/entities/article.dart';
import 'package:flutter/material.dart';

class ArticleReading extends StatelessWidget {
  final Article article;

  const ArticleReading({super.key, required this.article});
  @override
  Widget build(BuildContext context) {
    String articleDescription = article.content;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // header goes here.
            Padding(
              padding: EdgeInsets.only(
                  left: width * 0.133,
                  right: width * 0.133,
                  top: height * 0.08867,
                  bottom: height * 0.027),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // back icon button
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      // three dots icon button
                      const Icon(Icons.more_horiz)
                    ],
                  ),
                  SizedBox(height: height * 0.0369),
                  // header Text goes here
                  Text(
                    article.subtitle,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: height * 0.032),

                  // User card goes here. should be implemented in widgets folder.
                ],
              ),
            ),

            // Article detail card. should be a stack as we need Like icon button on it.
          ],
        ),
      ),
    );
  }
}
