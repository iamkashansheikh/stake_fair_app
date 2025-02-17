import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/controllers/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());


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
            Container(
              width: 415,
              height: 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/top_banner.jpg'),
                  fit: BoxFit.fill
                  )
              ),
            ),
            _buildContainer('Most Popular Bets'),
            _buildList('icon', 'label', 'sub'),

],         
),

       bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: homeController.selectedIndex.value,
            onTap: (index) => homeController.changeIndex(index),
            backgroundColor: Color(0xff303030),
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
              BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Cash Out'),
              BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'My Bets'),
              BottomNavigationBarItem(icon: Icon(Icons.casino), label: 'Casino'),
            ],
          )),
      ),
    );
  }

  

  Widget _buildIconButton(IconData icon, String text, {double width = 70}) {
    return Container(
      width: width,
      height: 45,
      decoration: BoxDecoration(
        color: Color(0xff525252),
        borderRadius: BorderRadius.circular(3),
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

  Widget _buildCategoryBar() {
    return Container(
      height: 50,
      color: Colors.black87,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: homeController.categories.map((item) {
            bool isHighlighted = item['isHighlighted'] ?? false;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 5),
              child: Container(
                width: 85, 
                height: 45,
                decoration: BoxDecoration(
                  color: isHighlighted ? Colors.green : Color(0xff525252),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item['icon'], color: Colors.white, size: 20), 
                    SizedBox(height: 2), 
                    Text(item['label'], style: TextStyle(color: Colors.white, fontSize: 10)),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildContainer(String title){
    return Container(
      width: 415,
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xff525252),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Colors.white),),
      ),
    );
  }

  Widget _buildList(String leading, String title, String sub){
    return  Expanded(  
  child: Obx(() {
    return ListView.builder(
      itemCount: homeController.cricket.length,
      itemBuilder: (context, index) {
        var team = homeController.cricket[index];
        return Card(
          child: ListTile(
            leading: Icon(team[leading]),
            title: Text(
              team[title],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            subtitle: Text(team[sub],style: TextStyle(fontSize: 22,color: Colors.grey)),
          ),
        );
      },
    );
  }),
);
  }
}
