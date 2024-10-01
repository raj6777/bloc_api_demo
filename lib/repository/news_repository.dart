import '../model/NewsModel.dart';

abstract class NewsRepository {
  Future<NewsModel> fetchTopHeadlines();
}