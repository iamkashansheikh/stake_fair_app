import 'package:get/get.dart';
import '../models/menu_model.dart';
import '../services/api_service.dart';


class MenuController extends GetxController {
  var isLoading = true.obs;
  var menuList = <EventTypes>[].obs;

  @override
  void onInit() {
    fetchMenuData();
    super.onInit();
  }

  void fetchMenuData() async {
    try {
      isLoading.value = true;
      MenuModel? menuModel = await ApiService.getMenuData();

      if (menuModel != null && menuModel.data != null) {
        menuList.value = menuModel.data!.eventTypes ?? [];
      }
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}

//   void fetchMenuData() async {
//     try {
//       isLoading.value = true;  // ✅ Start loading
//       MenuModel? menuModel = await ApiService.getMenuData();

//       if (menuModel != null && menuModel.data != null) {
//         menuList.value = menuModel.data!.eventTypes ?? [];
//         print("Fetched ${menuList.length} event types");
//       } else {
//         print("No event types found in API response.");
//       }
//     } catch (e) {
//       print("Error fetching data: $e");
//     } finally {
//       isLoading.value = false;  // ✅ Stop loading
//     }
//   }
// }
