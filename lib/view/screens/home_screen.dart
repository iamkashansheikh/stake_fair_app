import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.play_arrow, 'label': 'Play', 'isHighlighted': true},
    {'icon': Icons.sports_cricket, 'label': 'Cricket'},
    {'icon': Icons.sports_tennis, 'label': 'Tennis'},
    {'icon': Icons.sports_soccer, 'label': 'Soccer'},
    {'icon': Icons.sports, 'label': 'Horse Racing'},
    {'icon': Icons.sports_basketball, 'label': 'Basketball'},
    {'icon': Icons.sports_volleyball, 'label': 'Volleyball'},
    {'icon': Icons.sports_baseball, 'label': 'Baseball'},
    {'icon': Icons.sports_hockey, 'label': 'Hockey'},
    {'icon': Icons.sports_mma, 'label': 'MMA'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.orange,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'StakeFair',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      Text(
                        'EXCHANGE',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.unfold_more, size: 22),
                ],
              ),
              Row(
                children: [
                  _buildIconButton(Icons.search_rounded, 'Search'),
                  SizedBox(width: 8),
                  _buildIconButton(Icons.person, 'Login/Join', width: 100),
                ],
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            _buildCategoryBar(),
            Expanded(child: Center(child: Text("Main Content Here"))),
          ],
        ),
      ),
    );
  }

  // 🔹 Compact Button Widget for Search & Login
  Widget _buildIconButton(IconData icon, String text, {double width = 70}) {
    return Container(
      width: width,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 20),
          Text(text, style: TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  // 🔹 Horizontal Scrollable Category Bar (Bilkul Play Wale Jaisa Sab!)
  Widget _buildCategoryBar() {
    return Container(
      height: 50,
      color: Colors.black87,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((item) {
            bool isHighlighted = item['isHighlighted'] ?? false;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 5),
              child: Container(
                width: 85, // Chota rakha taake compact lage
                height: 45, // Height bhi kam ki
                decoration: BoxDecoration(
                  color: isHighlighted ? Colors.green : Colors.blueGrey, // Play = Green, Others = BlueGrey
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item['icon'], color: Colors.white, size: 20), // Chota icon
                    SizedBox(height: 2), // Space adjust kiya
                    Text(item['label'], style: TextStyle(color: Colors.white, fontSize: 10)), // Chota text
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
