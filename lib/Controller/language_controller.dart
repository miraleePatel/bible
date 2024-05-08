import 'dart:developer';

import 'package:bible_app/Screens/Dashboard/Menu/Language/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  RxInt selectLang = 0.obs;
  var selectedLang = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getSelectedLangValue();
    getInitLanguage();
    update();
  }

  /// Store selected language value
  ///
  storeSelectedLangValue(String locale) {
    GetStorage().write(
      selectedLanuage,
      locale,
    );
  }

  getInitLanguage(){
  if(selectLang == 0){
    selectedLang.value = "english";
  }
  else{
    selectedLang.value = "french";
  }
  }
  ///
  /// Get previous selected value after kill app
  ///
  Locale getSelectedLangValue() {
    String localeValue = GetStorage().read(
          selectedLanuage,
        ) ??
        "";
    log("language =====aa===== ${GetStorage().read(
      selectedLanuage,
    )}");

    // selectedLang.value = localeValue != '' ? localeValue : 'en_US';
    selectLang.value = localeValue == "fr_FR" ? 1 : 0;
    // log("language ===ghh===wwwwww==== ${Locale('${localeValue[3]}', '${localeValue[4]}')}");
    // log("language ===ghh======= ${Locale('${localeValue[0]}${localeValue[1]}', '${localeValue[3]}${localeValue[4]}')}");
    return localeValue != ''
        ? Locale('${localeValue[0]}${localeValue[1]}',
            '${localeValue[3]}${localeValue[4]}')
        : Locale('en', 'US');

    // if(defaultSystemLocale == "en_US"){
    //
    // }
    // else{
    //
    // }
  }
}
