import 'package:feedback_fe/components/FeedbackCard.dart';
import 'package:feedback_fe/models/feedback.dart';
import 'package:feedback_fe/repositories/feedback.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<FeedbackModel> feedbacks = [];
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    getFeedbacks();
  }

  Widget FeedbackEmpty() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            'Submit a review',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'Be the first by clicking the\nbutton below!',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black, // Set text color
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> getFeedbacks() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      List<FeedbackModel> feedbacksTemp =
          await FeedbackRepository().getFeedback();
      setState(() {
        feedbacks = feedbacksTemp;
      });

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 0,
      ),
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF065C99), // Background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0), // Border radius
            ),
          ),
          onPressed: () {},
          child: const Text(
            'Submit a review',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.white, // Set text color
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 32),
              child: const Text(
                'Our Reviews',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: feedbacks.isNotEmpty
                  ? Container(
                      margin: const EdgeInsets.only(bottom: 60),
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: feedbacks.length,
                        itemBuilder: (context, index) {
                          return FeedbackCard(feedback: feedbacks[index]);
                        },
                      ),
                    )
                  : FeedbackEmpty(),
            )
          ],
        ),
      ),
    );
  }
}
