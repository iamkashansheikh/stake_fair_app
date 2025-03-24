import 'package:get/get.dart';
import 'dart:convert';

import 'package:stake_fair_app/my_code/models/menu_model.dart';

class EventsController extends GetxController {
  var eventsList = <Events>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  void fetchEvents(String jsonResponse) {
  try {
    isLoading.value = true;
    errorMessage.value = '';
    
    // Parse JSON response
    Map<String, dynamic> jsonData = jsonDecode(jsonResponse);
    print("Decoded JSON: $jsonData"); // Debugging print

    MenuModel menuModel = MenuModel.fromJson(jsonData);
    
    // Extract events
    if (menuModel.data?.events != null) {
      eventsList.assignAll(menuModel.data!.events!);
      print("Events Loaded: ${eventsList.length}"); // Debugging print
    } else {
      eventsList.clear();
      print("No Events Found!"); // Debugging print
    }
  } catch (e) {
    errorMessage.value = 'Failed to load events: $e';
    print("Error: $e"); // Debugging print
  } finally {
    isLoading.value = false;
  }
}
}


