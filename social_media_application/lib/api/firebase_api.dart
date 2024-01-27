import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:social_media_application/main.dart';

class FirebaseApi
{
  //create an instance of Firebase Messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  //function to initialize Firebase notifications
  Future<void> initNotifications() async
  {
    //request permission to send notifications
    await _firebaseMessaging.requestPermission();

    //fetch the Firebase cloud messaging token for the device
    final fCMToken = await _firebaseMessaging.getToken();

    //print the token to the console(normally you would send this to your server)
    print('Token: $fCMToken');

    // initialize further settings for push notifications
    initPushNotifications();
  }

  //function to handle received notifications
  void handleMessage(RemoteMessage? message)
  {
    //if the message is null, do nothing
    if (message == null) return;

    //navigate to new screen when message is received and user taps notification
    navigatorKey.currentState?.pushNamed
    (
      '/notification_screen',
      arguments: message,
    );
  }

  //function to initialize background settings
  Future initPushNotifications() async
  {
    //handle notifications if the app was terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    //attach event listeners for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

  }
}