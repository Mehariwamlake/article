import 'dart:developer';

import 'package:article_app/core/presentation/router/routes.dart';
import 'package:article_app/features/article/domain/entities/article.dart';
import 'package:article_app/features/article/presentation/Article_bloc/article_bloc.dart';
import 'package:article_app/features/article/presentation/Article_bloc/article_event.dart';
import 'package:article_app/features/article/presentation/Article_bloc/article_state.dart';
import 'package:article_app/features/article/presentation/Article_bloc/tag_bloc.dart';
import 'package:article_app/features/article/presentation/Article_bloc/tag_selector_bloc.dart';
import 'package:article_app/features/article/presentation/widgets/custom_chip.dart';
import 'package:article_app/features/article/presentation/widgets/custom_text_field.dart';
import 'package:article_app/features/article/presentation/widgets/image_selector.dart';
import 'package:article_app/features/article/presentation/widgets/tag_selector.dart';
import 'package:article_app/injection.dart';
import 'package:article_app/user/domain/entities/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/content_widget.dart';
import '../widgets/publish_button.dart';
import '../widgets/input_field.dart';
import 'package:intl/intl.dart';

class ArticleFormPag extends StatefulWidget {
  const ArticleFormPag({super.key});
  @override
  State<ArticleFormPag> createState() => _ArticleFormPageState();
}

class _ArticleFormPageState extends State<ArticleFormPag> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController controllerTags = TextEditingController();
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerSubTitle = TextEditingController();
  TextEditingController controllerContent = TextEditingController();

  XFile? image;

  DateTime now = DateTime.now();

  _ArticleFormPageState();

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
                  BlocBuilder<TagBloc, TagState>(
                    builder: (context, state) {
                      if (state is AllTagsLoadedState) {
                        return TagSelector(tags: state.tags);
                      }
                      return Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              hintText: 'Add Tags',
                              controller: controllerTags,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: screenSize.height * 0.01),
                  Text(
                    'Add as many tags as you want',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: screenSize.height * 0.02),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.05,
                    child: BlocBuilder<TagSelectorBloc, TagSelectorState>(
                      builder: (context, state) {
                        return Wrap(
                          runSpacing: 10,
                          spacing: 10,
                          children: state.tags
                              .map((tag) => CustomChip(
                                    label: tag.name,
                                    onDelete: () {
                                      context
                                          .read<TagSelectorBloc>()
                                          .add(RemoveTagEvent(tag));
                                    },
                                  ))
                              .toList(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  ImageSelector(
                    onImageSelected: _selectImage,
                  ),
                  const SizedBox(height: 30),
                  const ContentFormField(),
                  SizedBox(
                    height: screenSize.height * 0.05,
                  ),
                  Center(
                    child: SizedBox(
                      width: isPortrait
                          ? screenSize.width * 0.3
                          : screenSize.width * 0.15,
                      height: screenSize.height * 0.06,
                      child: ElevatedButton(
                        onPressed: () {
                          _publishArticle(context);
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

  void _selectImage(XFile? file) {
    setState(() {
      image = file;
    });
  }

  void _publishArticle(BuildContext context) {
    final tagsBloc = context.read<TagSelectorBloc>();
    if (image != null) {
      final article = Article(
        content: controllerContent.text,
        title: controllerTitle.text,
        date: now,
        id: AutofillHints.telephoneNumber,
        likesCount: 12,
        subtitle: controllerSubTitle.text,
        tags: tagsBloc.selectedTags.toList(),
        photoUrl: image!.path,
        author: UserData.empty,
      );
      context.read<ArticleBloc>().add(PostArticleEvent(article: article));
    } else {
      log("please select an image");
    }
  }
}
