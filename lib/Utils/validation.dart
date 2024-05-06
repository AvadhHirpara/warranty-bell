
String? validateFirstName(String? value){
  String pattern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = RegExp(pattern);
  if(value?.length == 0){
    return "First Name is required";
  }else if(!regExp.hasMatch(value ?? '')){
    return "Name must be a to z";
  }
}

String? validateLastName(String? value) {
  String pattern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = RegExp(pattern);
  if (value?.length == 0) {
    return "Last Name is required";
  } else if (!regExp.hasMatch(value ?? '')) {
    return "Name must be a to z";
  }
}

String? validateProductName(String? value) {
  // String pattern = r'^[A-Za-z0-9_._.]+$';
  String pattern = r'^[A-Za-z0-9 _]*[A-Za-z0-9][A-Za-z0-9 _]*$';
  RegExp regExp = RegExp(pattern);
  if (value?.length == 0) {
    return "Product Name is required";
  } else if (!regExp.hasMatch(value ?? '')) {
    return "Product Name must be a to z";
  }
}

String? validateEmail(String? value){
  String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(pattern);
  if (value?.length == 0) {
    return "Email is required";
  } else if (!regExp.hasMatch(value ?? '')) {
    return "Please Enter Valid Email";
  }
}

String? validatePassword(String? value){
  String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = RegExp(pattern);
  if (value?.length == 0) {
    return "Password is required";
  } else if (value!.length < 8) {
    return "Password must be more than 8 characters";
  } else if(!regExp.hasMatch(value ?? '')){
    return ("Password should contain upper,lower,digit and Special character");
  }
}

String? validateConfirmPassword(String? password,String? confirmPassword){
  String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = RegExp(pattern);
  if (password != confirmPassword) {
    return "Password doesn't match";
  } else if (confirmPassword!.length < 8) {
    return "Password must be more than 8 characters";
  } else if(!regExp.hasMatch(confirmPassword ?? '')){
    return ("Password should contain upper,lower,digit and Special character");
  }
}


String? validateEmptyField (String? value){
  if(value?.length == 0){
    return "This Field is required";
  }
}

String? validateMobileNumber(String? value){
  if(value?.length == 0){
    return "Mobile number is required";
  }
}