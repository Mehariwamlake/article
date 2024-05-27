import 'package:article_app/core/presentation/theme/app_colors.dart';
import 'package:article_app/features/article/domain/entities/article.dart';
import 'package:article_app/features/article/presentation/Article_bloc/article_bloc.dart';
import 'package:article_app/features/article/presentation/Article_bloc/article_event.dart';
import 'package:article_app/features/article/presentation/Article_bloc/tag_bloc.dart';
import 'package:article_app/features/article/presentation/Article_bloc/tag_selector_bloc.dart';
import 'package:article_app/features/article/presentation/Article_bloc/tag_state.dart';
import 'package:article_app/features/article/presentation/widgets/custom_chip.dart';
import 'package:article_app/features/article/presentation/widgets/custom_text_field.dart';
import 'package:article_app/features/article/presentation/widgets/image_selector.dart';
import 'package:article_app/features/article/presentation/widgets/multiline_text_field.dart';
import 'package:article_app/features/article/presentation/widgets/snackbar.dart';
import 'package:article_app/features/article/presentation/widgets/tag_selector.dart';
import 'package:article_app/user/domain/entities/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreateArticleForm extends StatefulWidget {
  const CreateArticleForm({super.key});

  @override
  State<CreateArticleForm> createState() => _CreateArticleFormState();
}

class _CreateArticleFormState extends State<CreateArticleForm> {
  final titleFieldController = TextEditingController();
  final subtitleFieldController = TextEditingController();
  final contentFieldController = TextEditingController();

  XFile? image;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            controller: titleFieldController,
            hintText: 'Add title',
          ),
          const SizedBox(height: 15),

          // Subtitle field
          CustomTextField(
            controller: subtitleFieldController,
            hintText: 'Add subtitle',
          ),
          const SizedBox(height: 15),

          // tag field
          BlocBuilder<TagBloc, TagState>(
            builder: (context, state) {
              if (state is AllTagsLoadedState) {
                return TagSelector(tags: state.tags);
              }
              return const CustomTextField(
                hintText: "Add tags",
              );
            },
          ),
          const SizedBox(height: 5),
          const Text(
            'add as many tags as you want',
            style: TextStyle(
              color: AppColors.gray300,
              fontFamily: 'Poppins',
              fontSize: 13,
              fontWeight: FontWeight.w200,
            ),
          ),
          const SizedBox(height: 25),

          // selected tags
          SizedBox(
            width: double.infinity,
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
          const SizedBox(
            height: 30,
          ),

          ImageSelector(
            onImageSelected: _selectImage,
          ),
          const SizedBox(height: 30),

          // Content field
          MultilineTextInput(
            controller: contentFieldController,
            hintText: 'Article content',
          ),
          const SizedBox(height: 50),

          // Create article button
          Center(
            child: ElevatedButton(
              onPressed: () => _publishArticle(context),
              child: const Text('Publish'),
            ),
          ),
        ],
      )),
    );
  }

  void _selectImage(XFile? file) {
    setState(() {
      image = file;
    });
  }

  void _publishArticle(BuildContext context) {
    final articleBloc = context.read<ArticleBloc>();
    final tagsBloc = context.read<TagSelectorBloc>();

    if (image != null) {
      final article = Article(
        id: '',
        title: titleFieldController.text,
        subtitle: subtitleFieldController.text,
        content: contentFieldController.text,
        photoUrl: image!.path,
        tags: tagsBloc.selectedTags.toList(),
        author: UserData.empty,
        date: DateTime.now(),
        likesCount: 12,
      );

      articleBloc.add(PostArticleEvent(article: article));
    } else {
      showError(context, 'Please select an image');
    }
  }
}
