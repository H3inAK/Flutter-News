import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/theme/app_themes.dart';
import 'features/daily_news/presentation/blocs/local/bloc/local_article_bloc.dart';
import 'features/daily_news/presentation/blocs/remote/bloc/remote_article_bloc.dart';
import 'features/daily_news/presentation/pages/home/daily_news.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticleBloc>(
      create: (context) => sl()..add(const GetArticles()),
      child: BlocProvider<LocalArticleBloc>(
        create: (context) => sl(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: theme(),
          home: const DailyNews(),
        ),
      ),
    );
  }
}
