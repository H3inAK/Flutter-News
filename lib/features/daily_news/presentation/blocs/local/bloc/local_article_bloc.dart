// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../daily_news/domain/usecases/save_article.dart';
import '../../../../domain/entities/article.dart';
import '../../../../domain/usecases/get_saved_articles.dart';
import '../../../../domain/usecases/remove_article.dart';

part 'local_article_event.dart';
part 'local_article_state.dart';

class LocalArticleBloc extends Bloc<LocalArticleEvent, LocalArticleState> {
  final SaveArticleUseCase _saveArticleUseCase;
  final GetSavedArticlesUseCase _getSavedArticlesUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;
  LocalArticleBloc(
    this._saveArticleUseCase,
    this._getSavedArticlesUseCase,
    this._removeArticleUseCase,
  ) : super(const LocalArticleLoading()) {
    on<GetSavedArticle>(onGetSavedArticle);
    on<SaveArticle>(onSaveArticle);
    on<RemoveArticle>(onRemoveArticle);
  }

  void onGetSavedArticle(
    GetSavedArticle getSavedArticle,
    Emitter<LocalArticleState> emit,
  ) async {
    final savedArticles = await _getSavedArticlesUseCase();
    emit(LocalArticleDone(savedArticles));
  }

  void onSaveArticle(
    SaveArticle saveArticle,
    Emitter<LocalArticleState> emit,
  ) async {
    await _saveArticleUseCase(params: saveArticle.article);
    final articles = await _getSavedArticlesUseCase();
    emit(LocalArticleDone(articles));
  }

  void onRemoveArticle(
    RemoveArticle removeArticle,
    Emitter<LocalArticleState> emit,
  ) async {
    await _removeArticleUseCase(params: removeArticle.article);
    final articles = await _getSavedArticlesUseCase();
    emit(LocalArticleDone(articles));
  }
}
