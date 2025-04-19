import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/data/network/network_api_services.dart';
import 'package:stake_fair_app/data/response/api_response.dart';
import 'package:stake_fair_app/data/response/status.dart';
import 'package:stake_fair_app/res/app_urls/app_urls.dart';

class TestScreen extends StatelessWidget {
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Category Search")),
      body: Obx(() {
        if (controller.categoryResponse.value.status == Status.lOADING) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.categoryResponse.value.status == Status.eRROR) {
          return Center(
            child: Text("Error: ${controller.categoryResponse.value.message}"),
          );
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search by event or sport...",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: controller.search,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.filteredData.length,
                  itemBuilder: (context, index) {
                    final item = controller.filteredData[index];
                    return ListTile(
                      title: Text(item["eventName"] ?? "No event name"),
                      subtitle: Text("Sport: ${item["sportName"] ?? "Unknown"}"),
                      trailing: Text(item["marketName"] ?? ""),
                    );
                  },
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}

class HomeController extends GetxController {
  final NetworkApiServices _apiServices = NetworkApiServices();

  var categoryResponse =
      ApiResponse<List<dynamic>>(Status.lOADING, null, null).obs;
  var filteredData = <dynamic>[].obs;

  var searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategoryData();
  }

  void fetchCategoryData() async {
    categoryResponse.value = ApiResponse.loading();

    try {
      final data = await _apiServices.postApi({}, AppUrls.baseUrl + AppUrls.allevenlist);

      final innerMap = data["data"];
      if (innerMap != null && innerMap is Map) {
        List<dynamic> allEvents = [];
        innerMap.forEach((key, value) {
          if (value is List) {
            allEvents.addAll(value);
          }
        });

        categoryResponse.value = ApiResponse.completed(allEvents);
        filteredData.value = allEvents;
      } else {
        categoryResponse.value =
            ApiResponse.error("No data found in API response");
      }
    } catch (e) {
      categoryResponse.value = ApiResponse.error(e.toString());
    }
  }

  void search(String value) {
    searchText.value = value;
    final originalData = categoryResponse.value.data ?? [];

    if (value.isEmpty) {
      filteredData.value = originalData;
    } else {
      filteredData.value = originalData.where((item) {
        final eventName = item["eventName"]?.toString().toLowerCase() ?? '';
        final sportName = item["sportName"]?.toString().toLowerCase() ?? '';
        return eventName.contains(value.toLowerCase()) ||
            sportName.contains(value.toLowerCase());
      }).toList();
    }
  }
}
