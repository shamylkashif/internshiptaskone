import 'package:internshiptaskone/screens/authentication/login_screen.dart';
import 'utils/app_imports.dart';
import 'package:pusher_beams/pusher_beams.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PusherBeams.instance.start("e58938f3-11da-4bd0-bddd-5ff896d9d9b2");
  await PusherBeams.instance.addDeviceInterest("hello");
  runApp(const MyApp());
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
