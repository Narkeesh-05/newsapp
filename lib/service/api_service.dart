import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/article.dart';

class NewsService {
  final String baseUrl = "https://newsapi.org/v2/top-headlines";
  final String apiKey = "d100f9c3583940419cff650cb9bfb225";

  Future<List<Article>> fetchNews() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl?country=us&apiKey=$apiKey"),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['articles'] != null) {
          List<Article> articles =
              (jsonResponse['articles'] as List)
                  .map((articleJson) => Article.fromJson(articleJson))
                  .toList();
          return articles;
        } else {
          throw Exception("No articles found");
        }
      } else {
        throw Exception(
          "Failed to fetch news, status code: ${response.statusCode}",
        );
      }
    } catch (e) {
      print("API Fetch Error: $e");
      throw Exception('Failed to load news.Please try again.');
    }
  }
}
