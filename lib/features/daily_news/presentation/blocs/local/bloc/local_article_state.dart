part of 'local_article_bloc.dart';

abstract class LocalArticleState extends Equatable {
  const LocalArticleState({this.articles});

  final List<ArticleEntity>? articles;

  @override
  List<Object?> get props => [articles];
}

class LocalArticleLoading extends LocalArticleState {
  const LocalArticleLoading();
}

class LocalArticleDone extends LocalArticleState {
  const LocalArticleDone(List<ArticleEntity> articles)
      : super(articles: articles);
}
