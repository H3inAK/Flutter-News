import 'package:json_annotation/json_annotation.dart';
import 'article.dart';

part 'news_response.g.dart';

@JsonSerializable()
class NewsResponse {
  final List<ArticleModel>? articles;

  NewsResponse({this.articles});

  factory NewsResponse.fromJson(Map<String, dynamic> json) =>
      _$NewsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NewsResponseToJson(this);
}
