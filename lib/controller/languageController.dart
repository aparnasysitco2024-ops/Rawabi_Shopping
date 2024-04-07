import 'dart:convert';

import 'package:get/get.dart';
import 'package:rawabi/utils/storage_manager.dart';

import '../model/response/languageResponse.dart';
import '../utils/commonUtils.dart';
import '../utils/constants.dart';
import '../utils/http_client/base_client.dart';

class LanguageController extends GetxController {
  var loading = false.obs;
  var selectedLanguage = "".obs;

  var languageList = <LanguageList>[].obs;

  @override
  onInit() async {
    super.onInit();
    selectedLanguage.value = await StorageManager.getLanguage();
  }

  Future<void> getLanguages() async {
    try {
      loading.value = true;
      var response = await BaseClient().get(languageUrl);
      loading.value = false;
      if (response != null) {
        languageList.clear();
        var responseData =
            LanguageResponse.fromJson(json.decode(response.toString()));
        if (responseData.code == "200") {
          languageList.addAll(responseData.res! as Iterable<LanguageList>);
        } else {
          CommonUtils.showErrorDialog(responseData.message);
        }
      } else {
        CommonUtils.showErrorDialog(response.message);
      }
    } catch (error) {
      // CommonUtils.showErrorDialog(error.toString());
    }
    loading.value = false;
  }
}
