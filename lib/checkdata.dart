import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:stake_fair_app/models/home_models/category_model.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class CategoryDisplayScreen extends StatelessWidget {
  CategoryDisplayScreen({Key? key}) : super(key: key);

  final CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category List Model Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          // Agar data abhi load nahi hua to CircularProgressIndicator show karein
          if (categoryController.categoryListModel.value == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            // Model ko JSON map me convert kar lein for recursive display
            final dataMap = categoryController.categoryListModel.value!.toJson();
            return SingleChildScrollView(
              child: _buildDataDisplay(dataMap),
            );
          }
        }),
      ),
    );
  }

  /// Recursive method to display the JSON data structure
  Widget _buildDataDisplay(dynamic data) {
    if (data is Map<String, dynamic>) {
      List<Widget> displayWidgets = [];
      data.forEach((key, value) {
        displayWidgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: _buildDataItem(key, value),
          ),
        );
      });
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: displayWidgets,
      );
    } else if (data is List) {
      List<Widget> items = [];
      for (var item in data) {
        items.add(_buildDataDisplay(item));
      }
      return Column(children: items);
    } else {
      return Text(data.toString(), style: const TextStyle(fontSize: 16));
    }
  }

  /// Recursive method to check each key/value pair and build expandable items if needed.
  Widget _buildDataItem(String key, dynamic value) {
    if (value is Map) {
      List<Widget> children = [];
      value.forEach((k, v) {
        children.add(_buildDataItem(k.toString(), v));
      });
      return ExpansionTile(
        title: Text(key, style: const TextStyle(fontWeight: FontWeight.bold)),
        children: children,
      );
    } else if (value is List) {
      List<Widget> children = [];
      for (var item in value) {
        if (item is Map) {
          children.add(_buildDataItem(key, item));
        } else {
          children.add(
            ListTile(title: Text("$key : $item")),
          );
        }
      }
      return ExpansionTile(
        title: Text(key, style: const TextStyle(fontWeight: FontWeight.bold)),
        children: children,
      );
    } else {
      return ListTile(
        title: Text("$key : $value"),
      );
    }
  }
}

class CategoryController extends GetxController {
  var categoryListModel = Rxn<CategoryListModel>();

  final String apiUrl = "https://eka247.com/api/navigation/menuList";

  final Map<String, dynamic> postData = {
    "key1": "value1",
    "key2": "value2",
  };

  @override
  void onInit() {
    fetchCategoryData();
    super.onInit();
  }

  Future<void> fetchCategoryData() async {
    try {
      final response = await http
          .post(Uri.parse(apiUrl), body: jsonEncode(postData))
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        // Parse JSON response to CategoryListModel
        var model = CategoryListModel.fromJson(jsonDecode(response.body));
        categoryListModel.value = model;
        if (kDebugMode) {
          print("Category API data: ${response.body}");
        }
      } else {
        if (kDebugMode) {
          print("Error: ${response.statusCode}");
        }
        // Handle error condition as needed
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception: $e");
      }
      // Exception handling (aap custom exception ya snackbar show kar sakte hain)
    }
  }
}
