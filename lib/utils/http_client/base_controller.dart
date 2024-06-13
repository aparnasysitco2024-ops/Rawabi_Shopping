import 'package:get/get.dart';

import '../commonUtils.dart';
import 'app_exception.dart';

class BaseController {
  void handleError(error) {
    if (error is BadRequestException) {
      var message = error.message;
      if (message == "{\"Message\":\"Invalid token.\"}") {
        return;
      }
      CommonUtils.showErrorDialog(message);
    } else if (error is FetchDataException) {
      var message = error.message;
      CommonUtils.showErrorDialog(message);
    } else if (error is ApiNotRespondingException) {
      CommonUtils.showErrorDialog('error_while_processing'.tr);
    } else if (error is UnAuthorizedException ||
        error is UnAuthorizedException) {
      // CommonUtils.showErrorDialogUnAuthorized('token_expired'.tr);
    }
    // else if (error
    //     .toString()
    //     .contains("type 'Null' is not a subtype of type")) {
    // }
    else {
      CommonUtils.showErrorDialog(error.toString());
    }

    return;
  }

  showLoading() {
    CommonUtils.showLoader();
  }

  hideLoading() {
    CommonUtils.hideLoader();
  }
}
