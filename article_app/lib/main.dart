import 'package:article_app/core/utils/colors.dart';
import 'package:article_app/features/article/domain/entities/article.dart';
import 'package:article_app/features/article/presentation/screen1/article_reading.dart';
import 'package:article_app/features/article/presentation/screen1/home_page.dart';

import 'package:flutter/material.dart';
import 'package:article_app/injection.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
      home: const ArticlePage(),
    );
  }
}
