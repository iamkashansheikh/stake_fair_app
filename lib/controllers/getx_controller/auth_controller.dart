import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';

class AuthController extends GetxController {
  var selectedIcon = 1.obs;
  var selectedCountryCode = '+92'.obs; // Pakistan Code
  var selectedCountryFlag = '🇵🇰'.obs; // Pakistan Flag
  var selectedCountryName = 'Pakistan'.obs;
  TextEditingController mobileFieldController = TextEditingController();
  OtpFieldController otpController = OtpFieldController();

  void updateCountry(String code, String flag, String name) {
    selectedCountryCode.value = code;
    selectedCountryFlag.value = flag;
    selectedCountryName.value = name;

    var selectedGender = ''.obs;

    void selectGender(String gender) {
      selectedGender.value = gender;
    }
  }

  String userId = '';
  var verId = '';
  int? resendTokenId;
  bool phoneAuthcheck = false;
  dynamic credentials;

  void sendOTP(number) async {
    log('otppNumber  $number');
    String phone = number;
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 60),
      codeSent: (verificationId, resendToken) {
        verId = verificationId;
        resendTokenId = resendToken;

        log('Code send');
        Get.snackbar(
          'success'.tr,
          'codesent'.tr,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.indigo,
        );

        // Get.to(() => PinputExample(

        //     number: email.text));
      },
      verificationCompleted: (credential) async {
        log('completed');
        Get.snackbar(
          'success'.tr,
          'completed'.tr,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.indigo,
        );
        credentials = credential;
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (ex) {
        log('failed');
        Get.snackbar(
          'Error',
          'failed!',
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.indigo,
        );
        if (ex.code == 'invalid-phone-number') {
          log('invalid phone number');
          Get.snackbar(
            'Error',
            'invalid phone number',
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.indigo,
          );
        }
        log(ex.code.toString());
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  verifyOTP(String otp) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verId,
        smsCode: otp,
      );

      final authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (authResult.user != null) {
        Get.snackbar(
          'success'.tr,
          'successfullyloggedin'.tr,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.indigo,
        );
        // OTP verification successful

        return true;
      } else {
        Get.snackbar(
          'errorwrongotp'.tr,
          'pleaseentercorrectotp'.tr,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.indigo,
        );
        // OTP verification failed
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'errorwrongotp'.tr,
        'failedloggedin'.tr,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.indigo,
      );
      // Error occurred during OTP verification
      print('Error verifying OTP: $e');
      return false;
    }
  }
}
