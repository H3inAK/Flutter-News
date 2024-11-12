import '../../../../core/usecases/usecase.dart';
import '../entities/article.dart';
import '../repository/article_repository.dart';

class GetSavedArticlesUseCase implements UseCase<List<ArticleEntity>, void> {
  final ArticleRepository _articleRepository;
  GetSavedArticlesUseCase(this._articleRepository);

  @override
  Future<List<ArticleEntity>> call({void params}) {
    return _articleRepository.getSavedArticles();
  }
}
