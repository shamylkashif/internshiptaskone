import 'package:internshiptaskone/screens/authentication/signup_screen.dart';

import '../../utils/app_imports.dart';


class ForgotPassword extends StatelessWidget {
   ForgotPassword({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor:AppConstants.backgroundColor,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,)),
        title: Text('Forgot Password', ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50,),
              Text('Enter Email Address registered with this platform', ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      labelText: 'abc@gmail.com',
                      labelStyle: TextStyle(color: Colors.grey[300]),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(28)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(28)
                      )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    // Basic email validation
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 18,),
              InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Text('Back to log in')),
              SizedBox(height: 35,),
              InkWell(
                onTap: (){},
                child: Container(
                  height: 55,
                  width: 310,
                  decoration: BoxDecoration(
                      color: AppConstants.primaryColor,
                      borderRadius: BorderRadius.horizontal(right: Radius.circular(28), left: Radius.circular(28))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text('Send',
                      style: TextStyle(color: AppConstants.textPrimary,fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 70,),
              Text('or', style: TextStyle(fontSize: 18),),

              SizedBox(height: 70,),
              Text('Don\'t have an Account?'),
              SizedBox(height: 15,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                },
                child: Container(
                  height: 55,
                  width: 310,
                  decoration: BoxDecoration(
                      color: AppConstants.primaryColor,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.horizontal(right: Radius.circular(28), left: Radius.circular(28))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text('Sign up',
                      style: TextStyle(color: AppConstants.textPrimary,fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
