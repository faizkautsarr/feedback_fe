import 'package:feedback_fe/components/feedback_card.dart';
import 'package:feedback_fe/models/feedback.dart';
import 'package:feedback_fe/pages/feedback_form.dart';
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
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'Be the first by clicking the\nbutton below!',
            style: TextStyle(
              fontSize: 25,
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

      try {
        List<FeedbackModel> feedbacksTemp =
            await FeedbackRepository().getFeedback();
        setState(() {
          feedbacks = feedbacksTemp.reversed.toList();
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            content:
                Text("Error retrieving feedback data. Please try again later."),
            duration: Duration(seconds: 1),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          toolbarHeight: 0,
        ),
        floatingActionButton: Container(
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 26),
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF065C99), // Background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0), // Border radius
              ),
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                      builder: (_) => const FeedbackFormPage(),
                    ),
                  )
                  .then(
                    (value) => getFeedbacks(),
                  );
            },
            child: const Text(
              'Submit a review',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.normal,
                color: Colors.white, // Set text color
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 48),
                child: const Text(
                  'Our Reviews',
                  style: TextStyle(
                    fontSize: 30,
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
                            return FeedbackCard(
                              feedback: feedbacks[index],
                              // trigger refresh when back from detail page, to fetch latest data
                              triggerRefresh: () {
                                getFeedbacks();
                              },
                            );
                          },
                        ),
                      )
                    : FeedbackEmpty(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
