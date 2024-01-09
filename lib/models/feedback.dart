class FeedbackModel {
  final String name;
  final String petName;
  final int rating;
  final String comment;

  FeedbackModel({
    required this.name,
    required this.petName,
    required this.rating,
    this.comment = "",
  });
}
