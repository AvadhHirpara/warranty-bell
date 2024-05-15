class ApiUrls {

  ///-----------START-ApiUrls-----------

  ///BaseUrl
  static const baseUrl = "http://67.205.148.222:3010";
  static const imageUrl = "http://67.205.148.222:3010/Public/";

  ///AuthUrls
  static const login = '$baseUrl/login';
  static const socialLogin = "$baseUrl/social_login";
  static const register = '$baseUrl/sign_up';
  static const forgotPassword = '$baseUrl/send_otp';
  static const resetPassword = '$baseUrl/change_password';
  static const updateProfile = '$baseUrl/update_user_profile';
  static const verifyOtp = "$baseUrl/verify_otp";
  static const deleteAccount = "$baseUrl/delete_account";
  static const logout = "$baseUrl/log_out";
  static const updateNotificationSetting = "$baseUrl/update_notification_setting";
  static const resendOtp = "$baseUrl/resend_otp";

  static const category = "$baseUrl/get_category";
  static const subCategory = "$baseUrl/get_sub_category";
  static const categoryProductCount = "$baseUrl/get_product_count";

  static const products = "$baseUrl/get_products";
  static const addProducts = "$baseUrl/add_product";
  static const deleteProduct = "$baseUrl/delete_product";
  static const updateProduct = "$baseUrl/update_product";
  static const productHistory = "$baseUrl/get_product_history";

  static const notificationSchedule = "$baseUrl/get_notification_schedule";
  static const updateNotificationSchedule = "$baseUrl/set_notification_schedule";
  static const getNotification = "$baseUrl/get_notification_list";
  static const deleteNotification = "$baseUrl/delete_notification";
  static const updateNotification = "$baseUrl/read_notification";

  static const privacy = "$baseUrl/get_policy";
  static const terms = "$baseUrl/get_terms_n_condition";

  ///-----------END-ApiUrls-----------

  ///-----------START-UrlQueryParams-----------
  static const categoryId = "category_id";
  static const id = "id";
  static const notificationId = "notification_id";

  ///-----------END-UrlQueryParams-----------

}