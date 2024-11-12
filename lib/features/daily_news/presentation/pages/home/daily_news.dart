import 'package:fca_news_app/features/daily_news/presentation/pages/saved_articles/saved_articles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/remote/bloc/remote_article_bloc.dart';
import '../../widgets/article_tile.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _buildBody(),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: const Text(
        "Dialy News",
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const SavedArticles(),
              ),
            );
          },
          icon: const Icon(
            Icons.bookmark_rounded,
            color: Colors.black,
          ),
        )
      ],
    );
  }

  Widget _buildBody() {
    return BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
        builder: (_, state) {
      if (state is RemoteArticleLoading) {
        return const Center(child: CupertinoActivityIndicator());
      }
      if (state is RemoteArticleDone) {
        return ListView.builder(
          itemCount: state.articles!.length,
          itemBuilder: (context, index) {
            return ArticleWidget(
              article: state.articles![index],
            );
          },
        );
      }
      if (state is RemoteArticleError) {
        return Center(
          child: Text("${state.exception!}"),
        );
      }

      return const SizedBox.shrink();
    });
  }
}
