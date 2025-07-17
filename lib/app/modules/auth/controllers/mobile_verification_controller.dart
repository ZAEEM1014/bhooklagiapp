import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bhooklagiapp/app/theme/theme.dart';

import '../../../routes/app_routes.dart';

class MobileVerificationController extends GetxController {
  var selectedCountryCode = '+92'.obs;
  var phone = ''.obs;

  bool get isPhoneValid => phone.value.length >= 10;

  void onPhoneChanged(String value) {
    phone.value = value;
  }

  void pickCountryCode() {
    showCountryPicker(
      context: Get.context!,
      countryListTheme: CountryListThemeData(
        inputDecoration: InputDecoration(

          labelText: 'Search',
          labelStyle: const TextStyle(color: AppColors.textDark),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.border),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.textDark, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        searchTextStyle: const TextStyle(color: AppColors.textDark),
        backgroundColor: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      onSelect: (Country country) {
        selectedCountryCode.value = '+${country.phoneCode}';
      },
    );
  }

  void verifyPhoneNumber() {
    final fullPhoneNumber = '${selectedCountryCode.value}${phone.value}';

    Get.toNamed(
      AppRoutes.codeverification,
      arguments: {
        'phone': phone.value,
        'code': selectedCountryCode.value,
        'full': fullPhoneNumber,
      },
    );
  }

}
