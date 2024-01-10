# Feeback_fe (frontend repository)

This service serves as the frontend or client for feedback system. For the backend side we using this repo [feedback-be](https://github.com/faizkautsarr/feedback-be)

## Prequisites

- Flutter 3.3.1
- Dart 2.18.0 (DevTools 2.15.0)
- iOS Simulator (Xcode) or Android Simulator (Android Studio)

## How to run

To run this project locally:

- Make sure you have already clone this repo

- Go to this repo directory

  ```bash
  cd {PATH}feedback_fe
  ```

- open this repo via your code editor (VS Code or Android Studio)

- Make sure you already installed the required flutter and Dart version

- Before install and run this project, we need to make sure that you configured the api endpoint correctly. Go to `lib/repositories/feedback.dart` file and set the baseUrl according to your network IP. This things will make sure that you can integrate locally between your client and server and don't forget that your client apps and your server apps must connect to the same network.

  ```bash
  final String baseUrl = 'http://{YOUR_NETWORK_IP}:7777/api/feedback';
  ```

- Now you can install the package before run the project

  ```bash
  flutter pub get
  ```

- Star your simulator, you can manually star your simulator via Xcode (eg: iPhone 14 plus) or via Android Studio.

- After the installation complete and your simulator is ready, you can run your flutter apps:

  ```bash
  flutter run -d {DEVICE_ID}
  ```

  or if you only have 1 active device you can simply run

  ```bash
  flutter run
  ```

- Wait for a few minutes, when the apps is ready you can see the home screen (home page) of the apps in your simulator

<img src="https://i.ibb.co/FWjVMLf/Simulator-Screen-Shot-i-Phone-14-Plus-2024-01-10-at-13-07-56.png" alt="home page img" width="300">

## Pages and Feature

### Homepage

<img src="https://i.ibb.co/P55stSp/Simulator-Screen-Shot-i-Phone-14-Plus-2024-01-10-at-13-09-07.png" alt="home page-2 img" width="300">

- This is the main page, you can see the list of user feedbacks (from get feedback api) and the button to redirect you to the feedback form page.
- In this page, if you click the feedback item you will redirected to the feedback detail

### Feedback Detail

<img src="https://i.ibb.co/RYychLR/Simulator-Screen-Shot-i-Phone-14-Plus-2024-01-10-at-13-09-47.png" alt="detail page img" width="300">

- This is the feedback detail page that shows to you the detailed feedback data.

### Feedback Form Page

<img src="https://i.ibb.co/P5hGh1x/Simulator-Screen-Shot-i-Phone-14-Plus-2024-01-10-at-13-07-52.png" alt="form page img" width="300">

- This is the feedback form page, in this page you can fill the form that contains rating, name, pet name, comments (option)
- You can submit the form and there will be handlers for success or error condition.

You can see the demo of the apps in [here](https://drive.google.com/file/d/1PpCnVfmEZVMnCIfWLw5knlNNxY67qTj8/view?usp=sharing)

## Authors

- [@faizkautsarr](https://www.github.com/faizkautsarr)
