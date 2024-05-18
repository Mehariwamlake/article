import 'dart:developer';

import 'package:article_app/core/presentation/router/routes.dart';
import 'package:article_app/features/article/domain/entities/article.dart';
import 'package:article_app/features/article/presentation/Article_bloc/article_bloc.dart';
import 'package:article_app/features/article/presentation/Article_bloc/article_event.dart';
import 'package:article_app/features/article/presentation/Article_bloc/article_state.dart';
import 'package:article_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../widgets/content_widget.dart';
import '../widgets/publish_button.dart';
import '../widgets/input_field.dart';
import 'package:intl/intl.dart';

class ArticleFormPage extends StatefulWidget {
  const ArticleFormPage({super.key});
  @override
  State<ArticleFormPage> createState() => _ArticleFormPageState();
}

class _ArticleFormPageState extends State<ArticleFormPage> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController controllerTags = TextEditingController();
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerSubTitle = TextEditingController();
  TextEditingController controllerContent = TextEditingController();
  List chipList = [];

  DateTime now = DateTime.now();

  _ArticleFormPageState();

  void _addChip(String chipText) {
    setState(() {
      chipList.add(chipText);
      controllerTags.clear();
    });
  }

  void removeChips(String chipText) {
    setState(() {
      chipList.remove(chipText);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return BlocProvider(
      create: (context) => serviceLocator<ArticleBloc>(),
      child: BlocConsumer<ArticleBloc, ArticleState>(
        listener: (context, state) {
          if (state is ArticleSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("successfully posted"),
                duration: Duration(seconds: 4),
              ),
            );
            context.go(Routes.articleDetail, extra: state.article);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {},
              ),
              title: const Text(
                'New Article',
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  InputField(
                    labelText: 'Add Title',
                    textEditingController: controllerTitle,
                  ),
                  SizedBox(height: screenSize.height * 0.01),
                  InputField(
                    labelText: 'Add Subtitle',
                    textEditingController: controllerSubTitle,
                  ),
                  SizedBox(height: screenSize.height * 0.01),
                  Row(
                    children: [
                      Expanded(
                        child: InputField(
                          labelText: 'Add Tags',
                          textEditingController: controllerTags,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  SizedBox(height: screenSize.height * 0.01),
                  Text(
                    'Add as many tags as you want',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: screenSize.height * 0.02),
                  ),
                  SizedBox(height: screenSize.height * 0.05),
                  const ContentFormField(),
                  SizedBox(height: screenSize.height * 0.05),
                  Center(
                    child: SizedBox(
                      width: isPortrait
                          ? screenSize.width * 0.3
                          : screenSize.width * 0.15,
                      height: screenSize.height * 0.06,
                      child: ElevatedButton(
                        onPressed: () {
                          Article article = Article(
                            content: controllerContent.text,
                            title: controllerTitle.text,
                            date: now,
                            id: AutofillHints.telephoneNumber,
                            likesCount: 12,
                            subtitle: controllerSubTitle.text,
                            tags: const ["sport", "foot ball"],
                          );
                          context
                              .read<ArticleBloc>()
                              .add(PostArticleEvent(article: article));
                        },
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('Publish',
                            style: TextStyle(fontSize: 20)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
