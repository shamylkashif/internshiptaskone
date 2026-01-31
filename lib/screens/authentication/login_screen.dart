import 'package:internshiptaskone/screens/authentication/forgot_password.dart';
import 'package:internshiptaskone/screens/authentication/signup_screen.dart';

import '../../controller/auth_controller.dart';
import '../../utils/app_imports.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  //Controller
  final AuthController authController = Get.put(AuthController());

  //Text Editing Controllers
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();

  //Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body:SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Center(
                     child: SizedBox(
                       height: 270,
                       width: 200,
                       child: Image.asset('assets/logo.png',fit: BoxFit.cover,),
                     ),
                   ),
                  const  Text('Email', style: AppConstants.heading2,),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: emailC,
                    validator: Validators.email,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const  SizedBox(height: 20,),
                  const  Text('Password', style: AppConstants.heading2,),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: passC,
                    validator: Validators.password,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Obx( () => authController.loading.value
                    ? Center(child: CircularProgressIndicator())
                    : Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: AppConstants.primaryColor,),
                          onPressed: (){
                             if (formKey.currentState?.validate()??false) {
                               authController.login(emailC.text.trim(), passC.text.trim());
                             }
                          },
                          child:
                          Text('Login', style: AppConstants.bodyText,)
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  GestureDetector(
                    onTap: (){
                      Get.to(ForgotPassword());
                    },
                    child: Align(
                        alignment: Alignment.center,
                        child: Text('Forgot Password', style: AppConstants.smallText,)
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account", style: AppConstants.smallText,),
                      TextButton(onPressed: (){
                        Get.to(() => SignupScreen());
                      },
                          child: Text('Signup', style: TextStyle(color: AppConstants.secondaryColor),))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ) ,
    );
  }
}

