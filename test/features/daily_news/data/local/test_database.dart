import 'package:flutter_test/flutter_test.dart';
import 'package:fca_news_app/features/daily_news/data/data_sources/local/DAO/article_dao.dart';
import 'package:fca_news_app/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:fca_news_app/features/daily_news/data/models/article.dart';

void main() {
  late AppDatabase database;
  late ArticleDao articleDao;

  // Set up an in-memory database before each test
  setUp(() async {
    database = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
    articleDao = database.articleDAO;
  });

  // Close the database after each test
  tearDown(() async {
    await database.close();
  });

  // Test for inserting and retrieving a single article
  test('insert and retrieve an article', () async {
    const article = ArticleModel(
      id: 1,
      author: 'John Doe',
      title: 'Sample Article',
      description: 'A test article description',
      url: 'https://example.com',
      urlToImage: 'https://example.com/image.jpg',
      publishedAt: '2024-01-01T12:00:00Z',
      content: 'This is the content of the sample article.',
    );

    // Insert the article into the database
    await articleDao.insertArticle(article);

    // Retrieve articles from the database
    final retrievedArticles = await articleDao.getAllArticles();

    // Verify that the retrieved article matches the inserted article
    expect(retrievedArticles.length, 1);
    expect(retrievedArticles.first.title, 'Sample Article');
    expect(retrievedArticles.first.author, 'John Doe');
  });

  // Test for retrieving an empty list when no articles are in the database
  test('retrieve an empty list when no articles exist', () async {
    final articles = await articleDao.getAllArticles();
    expect(articles.isEmpty, true);
  });

  // Test for deleting an article
  test('delete an article', () async {
    const article = ArticleModel(
      id: 1,
      author: 'John Doe',
      title: 'Sample Article to Delete',
      description: 'Description for delete test',
      url: 'https://example.com',
      urlToImage: 'https://example.com/image.jpg',
      publishedAt: '2024-01-01T12:00:00Z',
      content: 'This article will be deleted.',
    );

    // Insert and then delete the article
    await articleDao.insertArticle(article);
    await articleDao.deleteArticle(article);

    // Verify that no articles exist in the database
    final articlesAfterDelete = await articleDao.getAllArticles();
    expect(articlesAfterDelete.isEmpty, true);
  });
}
