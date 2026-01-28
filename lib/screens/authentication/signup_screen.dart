import '../../controller/auth_controller.dart';
import '../../utils/app_imports.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  // Controllers
  final AuthController authController = Get.find<AuthController>();

  // Text Editing Controllers
  final TextEditingController nameC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();

  // Form Key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 40),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Text("Signup Here", style: AppConstants.heading1,)),
                  SizedBox(height: 50,),
                  const  Text('Name', style: AppConstants.heading2,),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: nameC,
                    validator: Validators.name,
                    decoration: InputDecoration(
                      labelText: "Name",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  const  Text('Email', style: AppConstants.heading2,),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: emailC,
                    validator: Validators.email,
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  const  Text('Password', style: AppConstants.heading2,),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: passC,
                    validator: Validators.password,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 24),
                  Obx(() => authController.loading.value
                      ? CircularProgressIndicator()
                      : Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants.primaryColor,
                      ),
                      onPressed: () {
                        if (formKey.currentState?.validate()??false) {
                          authController.signup(
                            nameC.text.trim(),
                            emailC.text.trim(),
                            passC.text.trim(),
                          );
                        }
                      },
                      child: Text("Sign Up", style: AppConstants.bodyText),
                    ),
                  )),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?", style: AppConstants.smallText),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("Login", style: TextStyle(color: AppConstants.secondaryColor)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
