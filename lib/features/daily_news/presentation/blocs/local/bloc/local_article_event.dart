// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'local_article_bloc.dart';

abstract class LocalArticleEvent extends Equatable {
  const LocalArticleEvent({this.article});

  final ArticleEntity? article;

  @override
  List<Object?> get props => [article];
}

class GetSavedArticle extends LocalArticleEvent {
  const GetSavedArticle();
}

class SaveArticle extends LocalArticleEvent {
  const SaveArticle(ArticleEntity article) : super(article: article);
}

class RemoveArticle extends LocalArticleEvent {
  const RemoveArticle(ArticleEntity article) : super(article: article);
}
