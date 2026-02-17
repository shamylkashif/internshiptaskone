import 'package:firebase_core/firebase_core.dart';
import 'package:internshiptaskone/firebase_options.dart';
import 'package:internshiptaskone/screens/authentication/login_screen.dart';
import 'utils/app_imports.dart';

void main() {
  runApp(const MyApp());
  _initializeFirebase();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

_initializeFirebase() async {
 await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}