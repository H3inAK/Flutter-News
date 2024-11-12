import 'package:cached_network_image/cached_network_image.dart';
import 'package:fca_news_app/features/daily_news/presentation/blocs/local/bloc/local_article_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/article.dart';
import '../pages/article_detail/article_detail.dart';

class SavedArticleTile extends StatelessWidget {
  const SavedArticleTile({super.key, required this.article});

  final ArticleEntity article;

  Future<bool?> _comfirmDismiss(
      DismissDirection direction, BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Delete"),
          content: const Text("Are you sure you want to delete this article?"),
          actions: [
            TextButton(
                child: const Text("Yes"),
                onPressed: () {
                  BlocProvider.of<LocalArticleBloc>(context)
                      .add(RemoveArticle(article));
                  Navigator.of(ctx).pop(true);
                }),
            TextButton(
              child: const Text("No"),
              onPressed: () => Navigator.of(ctx).pop(false),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(article.id.toString()),
      background: Container(
        color: Theme.of(context).colorScheme.errorContainer,
        alignment: Alignment.centerLeft,
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {},
      confirmDismiss: (direction) => _comfirmDismiss(direction, context),
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ArticleDetail(article: article),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Card(
            elevation: 0,
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            child: SizedBox(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.width / 3,
              child: Row(
                children: [
                  Hero(
                    tag: article.publishedAt!,
                    child: CachedNetworkImage(
                      imageUrl: article.urlToImage!,
                      imageBuilder: (context, imageProvider) => Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(8),
                          ),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 14,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article.title!,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            article.description!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
