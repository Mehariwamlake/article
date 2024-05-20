import '../../domain/entities/article.dart';
import 'article_model.dart';

extension ArticleMapper on Article {
  ArticleModel toArticleModel() {
    return ArticleModel(
      id: id,
      title: title,
      content: content,
      tags: tags,
      date: date,
      photoUrl: photoUrl,
      subtitle: subtitle,
      likesCount: likesCount,
      author: author,
    );
  }
}
