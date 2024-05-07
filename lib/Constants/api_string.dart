///CustomExceptionMessage
class CustomExceptionString {
  static const fetchDataException = "Error During Communication: ";
  static const badRequestException = "Invalid Request: ";
  static const unAuthorisedException = "Unauthorised: ";
  static const invalidInputException = "Invalid Input: ";
}

class AppName{
  static const warrantyBell = "Warranty Bell";
}

class UserDefault {
  static const user = "user";
}

///UserLoginType
class LoginTypeDefault{
  static const defaultLogin = "app"; ///For email type
  static const google = "gmail"; ///For google type
  static const facebook = "facebook"; ///For facebook type
}

///CommonString
class CommonString {
  static const networkConnectionsLost = "No Internet Connection";
  static const yes = "Yes";
  static const no = "No";
  static const cancel = "Cancel";
  static const doYouExit = "Do you want to exit?";
  static const takePicture = "Take a picture";
  static const cropImage = "Crop Image";
  static const choosePicture = "Choose a picture";
  static const products = "Products";
  static const viewProfile = "View Profile";
  static const notificationSchedule = "Notification Schedule";
  static const productHistory = "Product History";
  static const setting = "Settings";
  static const logout = "Logout";
  static const areYouSureLogout = "Are you sure you wan't to logout ? ";
  static const days = "Days";
}

///CommonResponseKey
class CommonApiResponseKeys{
  static const success = "success";
  static const message = "message";
}

///LoginScreenString
class LoginString{
  static const signInTitle = "Sign In";
  static const emailHint = "Email I’D";
  static const passwordHint = "Password";
  static const login = "Log In";
  static const forgotPassword = "Forgot Password?";
  static const or = " Or ";
  static const facebook = "Facebook";
  static const google = "Google";
  static const dontHaveAccount = "Don’t have account?";
  static const signUp = " Sign Up";
  static const rememberMe = "Remember me";
}

///RegisterScreenString
class RegisterString{
  static const signUpTitle = "Sign Up";
  static const emailHint = "Email I’D";
  static const firstName = "First Name";
  static const lastName = "Last Name";
  static const mobileNumber = "Mobile Number";
  static const passwordHint = "Password";
  static const login = "Log In";
  static const forgotPassword = "Forgot Password?";
  static const or = " Or ";
  static const facebook = "Facebook";
  static const google = "Google";
  static const doHaveAccount = "Do you have account?";
  static const signIn = " Sign In";
  static const register = "Register";
  static const uploadPhoto = "Upload Photo";
  static const iAgree = "I’m agree to The ";
  static const terms = "Terms of Service ";
  static const and = "and ";
  static const privacy = "Privacy Policy";
  static const removePhoto = "Remove";
}

///ForgotPasswordScreenString
class ForgetPasswordString{
  static const forgotPasswordTitle = "Forgot Password";
  static const forgotDescription = "It was popularised in the 1960s with the release of\n Letraset sheetscontaining Lorem Ipsum.";
  static const continueButton = "Continue";
}

///ResetPasswordScreenString
class ResetPasswordString{
  static const resetPassword = "Reset Password";
  static const resetPasswordDescription = "It was popularised in the 1960s with the release of Letraset sheetscontaining Lorem Ipsum.";
  static const passwordHint = "Password";
  static const confirmPasswordTitle = "Confirm Password";
  static const submit = "Submit";
}

///ChangePasswordScreenString
class ChangePasswordString{
  static const resetPassword = "Change Password";
  static const passwordHint = "Password";
  static const confirmPasswordTitle = "Confirm Password";
  static const submit = "Submit";
}

///OtpVerifyScreenString
class OtpVerifyString {
  static const otp = "Enter OTP";
  static const otpDescription = "Enter the OTP code we just sent\n you on your registered Email/Phone number";
  static const resetPassword = " Reset Password";
  static const didNotGet = "Didn't get OTP?";
  static const resendOtp = " Resend OTP";
}

///AddProductString
class AddProductString {
  static const currentDate = "Enter Purchase Date";
  static const category = "Category";
  static const productName = "Product Name";
  static const enterProductName = "Enter Product Name";
  static const barcodeNumber = "Barcode Number";
  static const viewAll = "View all";
  static const warrantyCardPhoto = "Add Warranty Card Photo";
  static const uploadOrSelectPhoto = "Upload or Capture your warranty card photo";
  static const expiryDate = "Enter Warranty Expire Date";
  static const save = "Save";
  static const discard = "Discard";
  static const supportSvg = "Support JPG file";
  static const removePhoto = "Remove";
  static const productDetails = "Product Details";
  static const deleteProduct = "Delete Product";
  static const areYouSure = "Are you sure you wan't to delete this product ?";
  static const update = "Update";
  static const viewPhoto = "Tap to View Photo";
  static const pleaseSelectPurchaseDate = "Please Select Purchase Date";
  static const pleaseSelectExpiryDate = "Please Select Warranty Expiry Date";
  static const pleaseSelectImage = "Please Select Image";
  static const pleaseSelectCategory = "Please Select Category";
  static const pleaseSelectSubCategory = "Please Select SubCategory";
}

///UserModelKeys
class UserModelKeys{
  /// User Response Object Keys
  static const id = "_id";
  static const email = "email";
  static const userName = "username"; /// for login/register request
  static const password = "password";
  static const deviceType = "device_type";
  static const name = "name";
  static const displayName = "display_name";
  static const firstName = "first_name";
  static const lastName = "last_name";
  static const deviceToken = "device_token";
  static const loginType = "login_type";
  static const authToken = "token"; /// For social login token
  static const mobile = "mobile";
  static const notificationStatus = "is_notification_active";
  static const activeStatus = "active_status";

  /// Other Response Object Keys
  static const data = "data"; /// Response object key
  static const user = "user"; /// Response object key of data object
  static const profile = "profile_image";
  static const thumbnail = "thumbnail";
}

///ApiHeaderKeys
class ApiServicesHeaderKEYs{
  static const accept = "Accept";
  static const contentType = "Content-Type";
  static const authorization = "Authorization";
}

///HomeString
class HomeString{
  static const myProduct = "My Products";
  static const search = "Search";
  static const productName = "Product Name : ";
  static const category = "Category : ";
  static const currentDate = "Purchase Date : ";
  static const warrantyDate = "Warranty Expire Date : ";
  static const barcodeNumber = "Barcode Number : ";
  static const edit = "Edit";
  static const delete = "Delete";
  static const remark = "Remark";
  static const categories = "Categories";
  static const addProductDetails = "Add Product Details";
  static const notAddedAnyProduct = "No any product Details added";
}

class CategoryString{
  static const category = "Category";
  static const noSubCategory = "No SubCategory Available";
}

class NotificationString{
  static const notification = "Notifications";
  static const noNotification = "No Notification Available";
}

class ProductHistoryString{
  static const productHistory = "Product History";
  static const noHistoryFound = "No Product History";
}

class SettingString{
  static const setting = "Settings";
  static const notification = "Notification";
  static const privacyPolicy = "Privacy & Policy";
  static const terms = "Terms & Conditions";
  static const support = "Support";
  static const changePassword = "Change Password";
  static const deleteAccount = "Delete Account";
  static const areYouSureDelete = "Are you sure you wan't to delete account ?";
}