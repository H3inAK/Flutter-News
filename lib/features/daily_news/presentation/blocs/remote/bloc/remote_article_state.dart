// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'remote_article_bloc.dart';

abstract class RemoteArticleState extends Equatable {
  final List<ArticleEntity>? articles;
  final DioException? exception;
  const RemoteArticleState({
    this.articles,
    this.exception,
  });

  @override
  List<Object?> get props => [articles, exception];
}

class RemoteArticleLoading extends RemoteArticleState {
  const RemoteArticleLoading();
}

class RemoteArticleDone extends RemoteArticleState {
  const RemoteArticleDone(List<ArticleEntity> articles)
      : super(articles: articles);
}

class RemoteArticleError extends RemoteArticleState {
  const RemoteArticleError(DioException exception)
      : super(exception: exception);
}
