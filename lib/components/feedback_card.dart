import 'package:feedback_fe/pages/feedback_detail.dart';
import 'package:flutter/material.dart';
import 'package:feedback_fe/models/feedback.dart';
import 'package:feedback_fe/components/star_rating.dart';

class FeedbackCard extends StatefulWidget {
  final FeedbackModel feedback;
  final VoidCallback triggerRefresh;

  const FeedbackCard({
    super.key,
    required this.feedback,
    required this.triggerRefresh,
  });

  @override
  State<FeedbackCard> createState() => _FeedbackCardState();
}

class _FeedbackCardState extends State<FeedbackCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 14),
              child: StarRating(rating: widget.feedback.rating),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 13),
                    child: Image.asset(
                      "assets/user.png",
                      width: 20,
                      filterQuality: FilterQuality.high,
                      gaplessPlayback: true,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.feedback.name,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 13),
                  child: Image.asset(
                    "assets/pet.png",
                    width: 20,
                    filterQuality: FilterQuality.high,
                    gaplessPlayback: true,
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.feedback.petName,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context)
            .push(
              MaterialPageRoute(
                builder: (_) => FeedbackDetailPage(
                  feedback: widget.feedback,
                ),
              ),
            )
            .then((_) => {widget.triggerRefresh()});
      },
    );
  }
}
