import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/entities/article.dart';
import '../../domain/repository/article_repository.dart';
import '../data_sources/local/app_database.dart';
import '../data_sources/remote/news_api_service.dart';
import '../models/article.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;
  final AppDatabase _appDatabase;

  const ArticleRepositoryImpl(this._newsApiService, this._appDatabase);
  @override
  Future<DataState<List<ArticleEntity>>> getNewsArticles() async {
    try {
      final httpResponse = await _newsApiService.getNewsArticles(
        apiKey: apiKey,
        country: country,
        category: category,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final articles = httpResponse.data.articles!;
        return DataSuccess(articles);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<List<ArticleEntity>> getSavedArticles() async {
    return _appDatabase.articleDAO.getAllArticles();
  }

  @override
  Future<void> removeArticle(ArticleEntity article) {
    return _appDatabase.articleDAO
        .deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<void> saveArticle(ArticleEntity article) {
    return _appDatabase.articleDAO
        .insertArticle(ArticleModel.fromEntity(article));
  }
}
