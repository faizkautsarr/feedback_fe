import 'dart:convert';
import 'package:feedback_fe/models/feedback.dart';
import 'package:http/http.dart' as http;

class FeedbackRepository {
  final String baseUrl = 'http://192.168.1.2:7777/api/feedback';

  Future<String> addFeedback({
    required String name,
    required String petName,
    required int rating,
    String comment = '',
  }) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'petName': petName,
        'rating': rating,
        'comment': comment,
      }),
    );

    if (response.statusCode == 201) {
      return 'Success';
    } else {
      throw Exception('Failed to add feedback');
    }
  }

  Future<List<FeedbackModel>> getFeedback() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonList = json.decode(response.body);

      List<FeedbackModel> feedbacks = [];

      for (var json in jsonList["data"]) {
        FeedbackModel feedbackTemp = FeedbackModel(
          name: json['name'],
          petName: json['petName'],
          rating: json['rating'],
          comment: json['comment'],
        );

        feedbacks.add(feedbackTemp);
      }
      return feedbacks;
    } else {
      throw Exception('Failed to get feedback');
    }
  }
}
