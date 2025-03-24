// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:stake_fair_app/controllers/Home/eventType_controller.dart';
// import 'package:stake_fair_app/controllers/Home/events_controller.dart';

// class EventScreen extends StatelessWidget {
//  // final EventsTypeController eventTypeController = Get.put(EventsTypeController());
//   final EventsController eventsController = Get.put(EventsController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Events')),
//       body: Row(
//         children: [
//           // Event Types List
//           Expanded(
//             flex: 2,
//             child: Obx(() => ListView.builder(
//                   itemCount: eventTypeController.categories.length,
//                   itemBuilder: (context, index) {
//                     final category = eventTypeController.categories[index];
//                     return ListTile(
//                       leading: Icon(category['icon']),
//                       title: Text(category['label']),
//                       onTap: () => eventTypeController.onCategoryTap(category['id']),
//                     );
//                   },
//                 )),
//           ),
//           VerticalDivider(),
//           // Events List
//           Expanded(
//             flex: 3,
//             child: Obx(() => eventsController.events.isEmpty
//                 ? Center(child: Text('Select an event type'))
//                 : ListView.builder(
//                     itemCount: eventsController.events.length,
//                     itemBuilder: (context, index) {
//                       final event = eventsController.events[index];
//                       return ListTile(
//                         title: Text(event['name']),
//                         subtitle: Text(event['date']),
//                       );
//                     },
//                   )),
//           ),
//         ],
//       ),
//     );
//   }
// }
