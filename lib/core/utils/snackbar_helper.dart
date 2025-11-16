import 'package:get/get.dart';
import 'package:smart_prop_app/core/theme/app_theme.dart';

class SnackBarHelper{
  //success
  static showSuccessSnackBar(String message){
    return Get.snackbar("Message", message, backgroundColor: AppTheme.successColor, duration: Duration(seconds: 3));
  }

  //error
  static showErrorSnackBar(String message){
    return Get.snackbar("Error", message, backgroundColor: AppTheme.errorColor, duration: Duration(seconds: 5));
  }

  //warning
  static showWarningSnackBar(String message){
    return Get.snackbar("Warning", message, backgroundColor: AppTheme.warningColor, duration: Duration(seconds: 5));
  }
}

