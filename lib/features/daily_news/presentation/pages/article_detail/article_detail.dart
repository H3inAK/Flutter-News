import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/article.dart';
import '../../blocs/local/bloc/local_article_bloc.dart';

class ArticleDetail extends StatelessWidget {
  const ArticleDetail({
    super.key,
    required this.article,
  });

  final ArticleEntity article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => _onBackButtonPressed(context),
          icon: const Icon(CupertinoIcons.back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              child: Text(
                article.title!,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(Icons.access_time, size: 20),
                  const SizedBox(width: 6),
                  Text(
                    article.publishedAt!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            CachedNetworkImage(
              imageUrl: article.urlToImage ?? "",
              imageBuilder: (context, imageProvider) => Hero(
                tag: article.publishedAt!,
                child: Container(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height / 3.2,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.08),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 12,
              ),
              child: Text(
                article.description ?? "",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 12,
              ),
              child: Text(
                article.content ?? "",
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => _onSaveButtonPressed(context),
        child: const Icon(Icons.bookmark),
      ),
    );
  }

  void _onBackButtonPressed(BuildContext context) {
    Navigator.pop(context);
  }

  void _onSaveButtonPressed(BuildContext context) {
    BlocProvider.of<LocalArticleBloc>(context).add(SaveArticle(article));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Article saved'),
      ),
    );
  }
}
