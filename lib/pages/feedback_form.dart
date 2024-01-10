import 'package:feedback_fe/components/feedback_dialog.dart';
import 'package:flutter/material.dart';
import 'package:feedback_fe/repositories/feedback.dart';

class FeedbackFormPage extends StatefulWidget {
  const FeedbackFormPage({
    super.key,
  });

  @override
  State<FeedbackFormPage> createState() => _FeedbackFormPageState();
}

class _FeedbackFormPageState extends State<FeedbackFormPage> {
  int rating = 0;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController petNameController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  bool isButtonEnabled = false;

  // to dynamically check if form is valid or not, if valid user can submit the form
  checkIsButtonEnabled() {
    setState(() {
      isButtonEnabled = petNameController.text.isNotEmpty &&
          nameController.text.isNotEmpty &&
          rating != 0;
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    petNameController.dispose();
    commentController.dispose();
  }

  submitForm() async {
    try {
      String res = await FeedbackRepository().addFeedback(
        name: nameController.text,
        petName: petNameController.text,
        rating: rating,
        comment: commentController.text,
      );
      if (res == "Success") {
        showModal("success");
      }
    } catch (e) {
      showModal("error");
    }
  }

  showModal(String type) {
    showDialog(
      barrierColor: Colors.grey.withOpacity(0.6),
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: FeedbackDialogContent(type: type),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 24,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 24),
                  child: const Text(
                    "Rating",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (int i = 1; i <= 5; i++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  rating = i;
                                  checkIsButtonEnabled();
                                });
                              },
                              child: Image.asset(
                                "assets/star_empty.png",
                                width: 34,
                                filterQuality: FilterQuality.high,
                                gaplessPlayback: true,
                              ),
                            ),
                        ],
                      ),
                      if (rating > 0)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (int i = 1; i <= 5; i++)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    rating = i;
                                    checkIsButtonEnabled();
                                  });
                                },
                                child: Visibility(
                                  maintainSize: true,
                                  maintainState: true,
                                  maintainAnimation: true,
                                  visible: i <= rating,
                                  child: Image.asset(
                                    "assets/star_filled.png",
                                    width: 34,
                                    filterQuality: FilterQuality.high,
                                    gaplessPlayback: true,
                                  ),
                                ),
                              ),
                          ],
                        )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 31,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Name",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 4),
                                    child: const Text(
                                      "*",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TextField(
                              style: const TextStyle(fontSize: 25),
                              controller: nameController,
                              cursorColor: Colors.black,
                              onChanged: (_) {
                                checkIsButtonEnabled();
                              },
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                  color: Colors.grey,
                                ),
                                labelText: 'Your name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 31,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Pets name",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 4),
                                    child: const Text(
                                      "*",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TextField(
                              style: const TextStyle(fontSize: 25),
                              controller: petNameController,
                              cursorColor: Colors.black,
                              onChanged: (_) {
                                checkIsButtonEnabled();
                              },
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(color: Colors.grey),
                                labelText: 'Pets name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: const Text(
                          "Comment (optional)",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: TextField(
                          maxLines: null,
                          textAlignVertical: TextAlignVertical.top,
                          expands: true,
                          style: const TextStyle(fontSize: 25),
                          controller: commentController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            labelStyle: const TextStyle(
                                color: Colors.grey, height: 200),
                            labelText:
                                'Any additional comments\nand much appreciated!',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return const Color(0xFFCDDCEB);
                          }

                          return const Color(0xFF065C99);
                        },
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: isButtonEnabled ? () => submitForm() : null,
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.normal,
                        color: Colors.white, // Set text color
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
