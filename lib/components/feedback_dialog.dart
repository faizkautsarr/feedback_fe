import 'package:feedback_fe/pages/home.dart';
import 'package:flutter/material.dart';

class FeedbackDialogContent extends StatelessWidget {
  final String type;

  const FeedbackDialogContent({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 104,
      height: 350,
      padding: const EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            type == "success"
                ? "assets/form_success_check.png"
                : "assets/form_error_close.png",
            width: 43,
            filterQuality: FilterQuality.high,
            gaplessPlayback: true,
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 30),
            child: Text(
              type == "success"
                  ? 'Feedback submitted'
                  : 'An error occurred,\nplease re-submit',
              style: const TextStyle(fontSize: 25.0),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF065C99),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {
                if (type == "success") {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const HomePage(),
                    ),
                  );
                } else {
                  Navigator.pop(context);
                }
              },
              child: Text(
                type == "success" ? 'Return to Home' : 'Close',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
