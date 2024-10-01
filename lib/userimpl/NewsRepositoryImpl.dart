import 'dart:convert';

import 'package:api_calling_bloc_mvvm_demo/model/NewsModel.dart';
import 'package:api_calling_bloc_mvvm_demo/repository/news_repository.dart';
import 'package:http/http.dart' as http;

class NewsRepositoryImpl implements  NewsRepository {
  final String apiKey = 'e991664226354a229291d8f3bd6d41c9';
  final String country = 'us';
  final String category = 'business';

  @override
  Future<NewsModel> fetchTopHeadlines() async {
      final uri = Uri.https('newsapi.org', '/v2/top-headlines', {
        'country': country,
        'category': category,
        'apiKey': apiKey, // Your API key here
      });

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        return NewsModel.fromJson(jsonData); // Handle the parsed data here
      } else {
        throw Exception("Failed to load news");
      }
    }
  }
