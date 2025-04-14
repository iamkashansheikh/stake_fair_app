import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScrollControllerX extends GetxController {
  final scrollController = ScrollController(); // Controller for the list

  // Method to move the list upwards
  void scrollUp() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent, // Move to the top
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }
}
