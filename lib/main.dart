import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:internshiptaskone/screens/authentication/login_screen.dart';
import 'controller/auth_controller.dart';
import 'controller/chat_controller.dart';
import 'firebase_options.dart';
import 'utils/app_imports.dart';
import 'package:pusher_beams/pusher_beams.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  try {
    String? token = await FirebaseMessaging.instance.getToken();
    print('FCM token: $token');
  } catch (e) {
    print('Error getting FCM token: $e');
  }
  await PusherBeams.instance.start("e58938f3-11da-4bd0-bddd-5ff896d9d9b2");
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController()); // Your Node.js auth controller
        Get.put(ChatController());
      }),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
