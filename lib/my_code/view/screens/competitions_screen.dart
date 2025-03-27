



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/my_code/controllers/competitions_controller.dart';


class CompetitionScreen extends StatelessWidget {
  final String eventName;
  final IconData eventIcon;
  final CompetitionController controller = Get.put(CompetitionController());

  CompetitionScreen({required this.eventName, required this.eventIcon});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchCompetitions(eventName);
    });

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(eventIcon, size: 24),
            SizedBox(width: 10),
            Text(eventName),
          ],
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.competitionList.isEmpty && controller.eventList.isEmpty) {
          return Center(child: Text("No Data Available"));
        }

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.competitionList.isNotEmpty) ...[
                  Text(
                    "Competitions",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Column(
                    children: controller.competitionList.map((item) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              item.competition?.name ?? "Unknown Competition",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                          ),
                          Divider(),
                        ],
                      );
                    }).toList(),
                  ),
                ],

                SizedBox(height: 15),

                // Events Section
                if (controller.eventList.isNotEmpty) ...[
                  Text(
                    "Events",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Column(
                    children: controller.eventList.map((item) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              item.eventType?.name ?? "Unknown Event",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            trailing: Icon(Icons.sports, size: 14, color: Colors.grey),
                          ),
                          Divider(),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
        );
      }),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:post_api_project/controllers/competitions_controller.dart';

// class CompetitionScreen extends StatelessWidget {
//   final String eventName;
//   final IconData eventIcon;
//   final CompetitionController controller = Get.put(CompetitionController());

//   CompetitionScreen({required this.eventName, required this.eventIcon});

//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.fetchCompetitionsByEvent(eventName); // ✅ Fetch competitions
//     });

//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Icon(eventIcon, size: 24),
//             SizedBox(width: 10),
//             Text(eventName),
//           ],
//         ),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }

//         if (controller.competitionList.isEmpty && controller.eventList.isEmpty) {
//           return Center(child: Text("No Data Available"));
//         }

//         return SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // ✅ Competitions Section
//                 _buildSection("Competitions", controller.competitionList, (item) {
//                   return ListTile(
//                     title: Text(
//                       item.competition?.name ?? "Unknown Competition",
//                       style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//                     ),
//                     trailing: Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
//                     onTap: () {
//                       // ✅ You can add navigation logic here if needed
//                       print("Tapped on ${item.competition?.name}");
//                     },
//                   );
//                 }),

//                 SizedBox(height: 15),

//                 // ✅ Events Section
//                 _buildSection("Events", controller.eventList, (item) {
//                   return ListTile(
//                     title: Text(
//                       item.name ?? "Unknown Event",
//                       style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//                     ),
//                     trailing: Icon(Icons.sports, size: 14, color: Colors.grey),
//                   );
//                 }),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }

//   // ✅ Reusable Section Builder
//   Widget _buildSection<T>(String title, List<T> items, Widget Function(T) itemBuilder) {
//     if (items.isEmpty) return SizedBox.shrink();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 5),
//         Column(
//           children: items.map((item) {
//             return Column(
//               children: [
//                 itemBuilder(item),
//                 Divider(),
//               ],
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }





