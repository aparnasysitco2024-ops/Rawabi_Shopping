import 'package:get/get.dart';

import '../utils/storage_manager.dart';

class VerificationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var mobile = '';
  var isLogin = false.obs;

  @override
  onInit() async {
    super.onInit();

    mobile = await StorageManager.readData(StorageManager.keyUserMobile);
  }


}
