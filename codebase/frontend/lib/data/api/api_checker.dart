import 'package:get/get.dart';

import '../../views/base/custom_snackbar.dart';

class ApiChecker {
  static void checkApi(Response response, {bool getXSnackBar = false}) {
    showCustomSnackBar(response.statusText!, getXSnackBar: getXSnackBar);
  }
}
