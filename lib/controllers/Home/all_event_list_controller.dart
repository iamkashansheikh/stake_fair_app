import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:stake_fair_app/models/home_models/all_event_list_model.dart';
import '../../repositroy/home_repository/home_repository.dart';

class AllEventListController extends GetxController {
  // ── dependency ──────────────────────────────────────────────
  final HomeRepository _repo = HomeRepository();

  // ── observable state ────────────────────────────────────────
  final isLoading = false.obs;
  final errorMessage = RxnString();

  /// Parsed API response
  final Rx<AllEventListModel?> model = Rx<AllEventListModel?>(null);
  final Map<String, dynamic> postData = {"key": "7"};

  @override
  void onInit() {
    super.onInit();
  }

  // ── fetch data  ─────────────────────────────────────────────
  // competition_market_controller.dart  (only the fetch method changed)

  Future<void> fetchAllEvent() async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      final response = await _repo.alleventlist(postData);

      if (response == null) {
        errorMessage.value = 'Empty response from server';
      } else {
        // Parse the Map<String, dynamic> into your model
        model.value = AllEventListModel.fromJson(response);
        log('All event  list loaded $response');
      }
    } catch (e, s) {
      if (kDebugMode) print('fetchCompetitionMarket error: $e');
      log('All Event  list error', error: e, stackTrace: s);
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
