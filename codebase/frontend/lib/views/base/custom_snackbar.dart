import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String message,
    {bool isError = true, bool getXSnackBar = false}) {
  if (message.isNotEmpty) {
    if (getXSnackBar) {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: isError ? Colors.red : Colors.green,
          message: message,
          duration: const Duration(seconds: 3),
          snackStyle: SnackStyle.FLOATING,
          borderRadius: 10,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
        ),
      );
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.horizontal,
          duration: const Duration(seconds: 3),
          backgroundColor: isError ? Colors.red : Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Text(
            message,
          ),
        ),
      );
    }
  }
}
