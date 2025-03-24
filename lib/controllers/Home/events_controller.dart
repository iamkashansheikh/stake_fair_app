// import 'package:get/get.dart';
// import 'package:stake_fair_app/repositroy/home_repository/home_repository.dart';

// class EventsController extends GetxController {
//   final HomeRepository _homeRepository = HomeRepository();
//   final RxList<Map<String, dynamic>> events = <Map<String, dynamic>>[].obs;

//   void fetchEvents(int categoryId) async {
//     try {
//       var response = await _homeRepository.categoryApi({'categoryId': categoryId});
//       if (response != null) {
//         events.assignAll(response['data'].map<Map<String, dynamic>>((e) {
//           return {
//             'id': e['id'],
//             'name': e['name'],
//             'date': e['date'],
//           };
//         }).toList());
//       }
//     } catch (e) {
//       print("Error fetching events: $e");
//     }
//   }
// }
