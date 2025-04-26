
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Step 1: Model - PlayerMarketData
// class PlayerMarketData {
//   final String playerName;
//   final List<Map<String, dynamic>> backOdds;
//   final List<Map<String, dynamic>> layOdds;

//   PlayerMarketData({
//     required this.playerName,
//     required this.backOdds,
//     required this.layOdds,
//   });

//   factory PlayerMarketData.fromJson(Map<String, dynamic> json) {
//     final runner = (json['oddsData']['runners'] as List).first;
//     return PlayerMarketData(
//       playerName: json['marketName'] ?? '',
//       backOdds: List<Map<String, dynamic>>.from(runner['price']['back']),
//       layOdds: List<Map<String, dynamic>>.from(runner['price']['lay']),
//     );
//   }
// }

/// Step 2: Controller - InplayController
// class InplayController extends GetxController {
//   var playerMarkets = <PlayerMarketData>[].obs;
//   Timer? _timer;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchMarkets();
//     _timer = Timer.periodic(const Duration(seconds: 2), (_) {
//       fetchMarkets();
//     });
//   }

//   void fetchMarkets() {
//     final mockJson = json.decode(mockApiResponse);
//     final fancyData = mockJson['data']['fancyData'] as List;
//     playerMarkets.value =
//         fancyData.map((e) => PlayerMarketData.fromJson(e)).toList();
//   }

//   @override
//   void onClose() {
//     _timer?.cancel();
//     super.onClose();
//   }
// }

/// Step 3: Widget - PlayerMarketTile
class PlayerMarketTile extends StatelessWidget {
  final String title;
  final ImageProvider image;
  final List<Map<String, dynamic>> backOdds;
  final List<Map<String, dynamic>> layOdds;

  const PlayerMarketTile({
    super.key,
    required this.title,
    required this.image,
    required this.backOdds,
    required this.layOdds,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              image: DecorationImage(image: image, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Color(0xff212529),
              ),
            ),
          ),
          ...backOdds.take(1).map((odd) => _buildOddsBox(
                price: odd['price'].toString(),
                size: odd['size'].toString(),
                backgroundColor: Colors.blue.shade300,
              )),
          const SizedBox(width: 6),
          ...layOdds.take(1).map((odd) => _buildOddsBox(
                price: odd['price'].toString(),
                size: odd['size'].toString(),
                backgroundColor: Colors.pink.shade300,
              )),
        ],
      ),
    );
  }

  Widget _buildOddsBox({
    required String price,
    required String size,
    required Color backgroundColor,
  }) {
    return Container(
      width: 50,
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(price,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          Text(size,
              style: const TextStyle(fontSize: 12, color: Colors.white)),
        ],
      ),
    );
  }
}

/// Step 4: Main App
// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: InplayScreen(),
//     );
//   }
// }

// class InplayScreen extends StatelessWidget {
//   InplayScreen({super.key});
//  // final InplayController controller = Get.put(InplayController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Inplay Markets')),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: 
//         // Obx(() {
//         //   if (controller.playerMarkets.isEmpty) {
//         //     return const Center(child: CircularProgressIndicator());
//         //   } else {
//              ListView.builder(
//               itemCount: 4,            // controller.playerMarkets.length,
//               itemBuilder: (context, index) {
//                 //final player = controller.playerMarkets[index];
//                 return PlayerMarketTile(
//                   title:'PSL Trophy',         //  player.playerName,
//                   backOdds:[],       //player.backOdds,
//                   layOdds:  [],       //player.layOdds,
//                   image: const AssetImage('assets/images/market.png'),
//                 );
//               },
//             )
//          // }
//       //  }),
//       ),
//     );
//   }
// }

/// Step 5: Mock API Response for Testing
const mockApiResponse = '''
{
  "data": {
    "fancyData": [
      {
        "marketName": "Player 1",
        "oddsData": {
          "runners": [
            {
              "price": {
                "back": [
                  {"price": 1.90, "size": 200}
                ],
                "lay": [
                  {"price": 2.00, "size": 150}
                ]
              }
            }
          ]
        }
      },
      {
        "marketName": "Player 2",
        "oddsData": {
          "runners": [
            {
              "price": {
                "back": [
                  {"price": 1.85, "size": 100}
                ],
                "lay": [
                  {"price": 1.95, "size": 120}
                ]
              }
            }
          ]
        }
      }
    ]
  }
}
''';
