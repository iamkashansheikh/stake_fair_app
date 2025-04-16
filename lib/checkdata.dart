import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/models/home_models/category_model.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


class CategoryDisplayScreen extends StatelessWidget {
  CategoryDisplayScreen({Key? key}) : super(key: key);

  // Register the CategoryController using GetX
  final CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category List Model Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search field at the top
            TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search events...',
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                // Update the searchQuery observable as the user types
                categoryController.searchQuery.value = query;
              },
            ),
            const SizedBox(height: 16),
            // Display the events based on API response and search filtering
            Expanded(
              child: Obx(() {
                // Check if categoryListModel is null or events empty
                if (categoryController.categoryListModel.value == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  final events = categoryController.filteredEvents;
                  if (events.isEmpty) {
                    return const Center(child: Text("No Events Found"));
                  }
                  // ListView to display filtered events
                  return ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final item = events[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(item.event?.name ?? "No Event Name"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Competition: ${item.competition?.name ?? 'N/A'}"),
                              Text("Event Type: ${item.eventType?.name ?? 'N/A'}"),
                              // You can add more fields as needed
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}




class CategoryController extends GetxController {
  // Holds the fetched category data from the API
  var categoryListModel = Rxn<CategoryListModel>();

  // Observable to hold the search query entered by the user
  var searchQuery = ''.obs;
  
  final String apiUrl = "https://eka247.com/api/navigation/menuList";
  
  // Post data to pass with the API call (if required by your API)
  final Map<String, dynamic> postData = {
    "key1": "value1",
    "key2": "value2",
  };

  @override
  void onInit() {
    fetchCategoryData();
    super.onInit();
  }

  // Fetch the category data from the API and decode into CategoryListModel
  Future<void> fetchCategoryData() async {
    try {
      final response = await http
          .post(Uri.parse(apiUrl), body: jsonEncode(postData))
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        var model = CategoryListModel.fromJson(jsonDecode(response.body));
        categoryListModel.value = model;
        if (kDebugMode) {
          print("Category API data: ${response.body}");
        }
      } else {
        if (kDebugMode) {
          print("Error: ${response.statusCode}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception: $e");
      }
    }
  }
  
  // Returns the filtered list of events based on the search query.
  // If searchQuery is empty, all events are returned.
  List<dynamic> get filteredEvents {
    final events = categoryListModel.value?.data?.events ?? [];
    if (searchQuery.value.isEmpty) {
      return events;
    } else {
      return events.where((event) {
        final eventName = event.event?.name?.toString().toLowerCase() ?? '';
        return eventName.contains(searchQuery.value.toLowerCase());
      }).toList();
    }
  }
}