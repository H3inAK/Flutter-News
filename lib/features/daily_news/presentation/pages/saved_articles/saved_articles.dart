import 'package:fca_news_app/features/daily_news/presentation/blocs/local/bloc/local_article_bloc.dart';
import 'package:fca_news_app/features/daily_news/presentation/widgets/saved_article_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedArticles extends StatefulWidget {
  const SavedArticles({super.key});

  @override
  State<SavedArticles> createState() => _SavedArticlesState();
}

class _SavedArticlesState extends State<SavedArticles> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100)).then((_) {
      BlocProvider.of<LocalArticleBloc>(context).add(const GetSavedArticle());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(CupertinoIcons.back),
      ),
      title: Text(
        "Saved Articles",
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget _buildBody(context) {
    return BlocBuilder<LocalArticleBloc, LocalArticleState>(
      bloc: BlocProvider.of<LocalArticleBloc>(context),
      builder: (context, state) {
        if (state is LocalArticleDone) {
          final savedArticles = state.articles!;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 8,
            ),
            itemCount: savedArticles.length,
            itemBuilder: (context, index) {
              return SavedArticleTile(article: savedArticles[index]);
            },
          );
        }

        if (state is LocalArticleLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        return const SizedBox();
      },
    );
  }
}
