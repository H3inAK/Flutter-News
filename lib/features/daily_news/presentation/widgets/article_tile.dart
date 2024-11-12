import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '/features/daily_news/domain/entities/article.dart';
import '../pages/article_detail/article_detail.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({
    super.key,
    this.article,
  });

  final ArticleEntity? article;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ArticleDetail(article: article!),
        ),
      ),
      child: Container(
        padding: const EdgeInsetsDirectional.only(
          start: 14,
          end: 14,
          bottom: 28,
        ),
        height: MediaQuery.of(context).size.width / 2.2,
        child: Row(
          children: [
            _buildImage(context),
            _buildTitleAndDescription(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: article!.urlToImage ??
          "https://fortune.com/img-assets/wp-content/uploads/2024/11/GettyImages-2176089209-e1730872146231.jpg?resize=1200,600",
      imageBuilder: (context, imageProvider) => Padding(
        padding: const EdgeInsetsDirectional.only(end: 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Hero(
            tag: article!.publishedAt!,
            child: Container(
              width: MediaQuery.of(context).size.width / 3,
              height: double.maxFinite,
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
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
        padding: const EdgeInsetsDirectional.only(end: 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.08),
            ),
            child: LinearProgressIndicator(
              value: downloadProgress.progress,
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Padding(
        padding: const EdgeInsetsDirectional.only(end: 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.08),
            ),
            child: const Icon(Icons.error),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndDescription() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article!.title ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  article!.description ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Row(
              children: [
                const Icon(Icons.timeline_outlined, size: 16),
                const SizedBox(width: 4),
                Text(
                  article!.publishedAt!,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
