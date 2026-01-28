
class Validators{
  static String? email(String? value){
   if (value == null || value.isEmpty) return "Email is required";
   if (!value.contains('@')) return "Invalid email";
    return null;
  }

  static String? password(String? value){
    if (value == null || value.isEmpty) return "Password id required";
    if (value.length < 8) return "Password must be atleast 8 characters";
     return null;
  }

  static String? name(String? value) {
    if (value == null || value.isEmpty) return "Name is required";
    return null;
  }
}


