import 'package:dio/dio.dart';

class QuoteRepo {
  final Dio _dio = Dio();

  Future<List<String>> fetchQuotes({int count = 10}) async {
    try {
      final response = await _dio.get('https://dummyjson.com/quotes', queryParameters: {'limit': count});
      
      if (response.statusCode == 200) {
        // Extract the list of quotes from the response
        List quotes = response.data['quotes'];
        return quotes.map<String>((quote) => quote['quote'] as String).toList();
      } else {
        throw Exception('Failed to load quotes');
      }
    } catch (e) {
      throw Exception('Failed to load quotes: $e');
    }
  }
}
