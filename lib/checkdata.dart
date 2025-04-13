import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:stake_fair_app/repositroy/home_repository/home_repository.dart';

class CategoryDisplayScreen extends StatelessWidget {
  CategoryDisplayScreen({Key? key}) : super(key: key);

  final CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category List'),
      ),
      body: Obx(() {
        if (categoryController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (categoryController.errorMessage.value.isNotEmpty) {
          return Center(child: Text(categoryController.errorMessage.value));
        } else if (categoryController.categoryData.value == null) {
          return const Center(child: Text('No data available'));
        } else {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: buildDataDisplay(categoryController.categoryData.value),
          );
        }
      }),
    );
  }

  /// Recursively build widget tree for JSON data (Map or List).
  Widget buildDataDisplay(dynamic data) {
    if (data is Map) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: data.entries.map((entry) {
          return buildDataItem(entry.key.toString(), entry.value);
        }).toList(),
      );
    } else if (data is List) {
      return Column(
        children: data.map<Widget>((item) => buildDataDisplay(item)).toList(),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(data.toString(), style: const TextStyle(fontSize: 16)),
      );
    }
  }

  /// Build widget for a single key-value pair.
  Widget buildDataItem(String key, dynamic value) {
    if (value is Map || value is List) {
      return ExpansionTile(
        title: Text(key, style: const TextStyle(fontWeight: FontWeight.bold)),
        children: [buildDataDisplay(value)],
      );
    } else {
      return ListTile(
        title: Text('$key : $value'),
      );
    }
  }
}



class CategoryController extends GetxController {
  final HomeRepository repository = HomeRepository();

  // Holds the fetched data (could be Map or List)
  Rx<dynamic> categoryData = Rx<dynamic>(null);
  // Loading & error states
  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    fetchCategoryData();
    super.onInit();
  }

  Future<void> fetchCategoryData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      // Pass your post data if needed
      final data = await repository.categoryApi({"key1": "value1", "key2": "value2"});
      categoryData.value = data;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}

