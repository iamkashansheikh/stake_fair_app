import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/controllers/home_controller.dart';
import 'package:stake_fair_app/view/Check_file.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: Offset(0, -1),
                          end: Offset(0, 0),
                        ).animate(animation),
                        child: FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                      );
                    },
                    child: homeController.isSearchFieldVisible.value
                        ? _buildSearchField()
                        : SizedBox.shrink(),
                  )),
              _buildCategoryBar(),
              _buildBanner(),
              _buildSection('Most Popular Bets', 'icon', 'label', 'sub'),
              _buildHorseRacingSection('Horse Racing'),
              _buildContainer('QuickLinks'),
              _buildQuickLinksSection('name', 'icon'),
              _buildFooter(),
              SizedBox(height: 5),
              _buildWarningText(),
              SizedBox(height: 35),
              // Additional footer texts
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: _buildSaferGamblingDropdown()),
                  SizedBox(height: 5),
                  Center(child: _buildAboutStakefairDropdown()),
                  SizedBox(height: 8),
                  _buildText('Help'),
                  _buildText('Affiliates'),
                  _buildText('18+'),
                  _buildText('Developers'),
                  _buildText('StakeFair Exchange Sitemap'),
                  _buildText('B2B Partnerships'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Divider(thickness: 1),
                  ),
                  SizedBox(height: 15),
                  _buildText('Privacy Policy'),
                  _buildText('Cookie Policy'),
                  _buildText('Privacy Preference Centre'),
                  _buildText('Rules & Regulations'),
                  _buildText('Terms & Conditions'),
                  SizedBox(height: 40),
                ],
              )
            ],
          ),
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: homeController.selectedIndex.value,
            onTap: homeController.changeIndex,
            backgroundColor: const Color(0xff303030),
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: InkWell(child: Icon(Icons.menu),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                 return CheckFile();
                }));
              },
              ), label: 'Menu'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet),
                  label: 'Cash Out'),
              BottomNavigationBarItem(
                  icon: Image(
                    image: AssetImage('assets/images/money.png'),
                    width: 30,
                  ),
                  label: 'My Bets'),
              BottomNavigationBarItem(
                  icon: Image(
                    image: AssetImage('assets/images/casino-chip (1).png'),
                    width: 30,
                  ),
                  label: 'Casino'),
            ],
          ),
        ),
      ),
    );
  }
  
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      toolbarHeight: 70,
      backgroundColor: Colors.orange,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('StakeFair', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              Text('EXCHANGE', style: TextStyle(fontSize: 16)),
            ],
          ),
          Row(
            children: [
              InkWell(
                onTap: () => homeController.isSearchFieldVisible.toggle(),
                child: _buildIconButton(Icons.search_rounded, 'Search', width: 50),
              ),
              SizedBox(width: 8),
              InkWell(child: _buildIconButton(Icons.person, 'Login/Join', width: 70),
              onTap: () {
                Get.toNamed('/login');
              },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      key: ValueKey("searchField"),
      width: 415,
      height: 80,
      color: Color(0xff525252),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () => homeController.isSearchFieldVisible.value = false,
            child: Text("Cancel", style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildText(String title) {
    return Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
  }

  Widget _buildSaferGamblingDropdown() {
    return Obx(() {
      bool expanded = homeController.isSaferGamblingExpanded.value;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: homeController.isSaferGamblingExpanded.toggle,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(homeController.saferGambling[0],
                    style: TextStyle(decoration: TextDecoration.underline, fontSize: 20, fontWeight: FontWeight.bold)),
                Icon(expanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              ],
            ),
          ),
          if (expanded)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: homeController.saferGambling.skip(1)
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(item, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                      ))
                  .toList(),
            ),
        ],
      );
    });
  }

  Widget _buildAboutStakefairDropdown() {
    return Obx(() {
      bool expanded = homeController.isAboutStakefairExpanded.value;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: homeController.isAboutStakefairExpanded.toggle,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(homeController.aboutStakefair[0],
                    style: TextStyle(decoration: TextDecoration.underline, fontSize: 20, fontWeight: FontWeight.bold)),
                Icon(expanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              ],
            ),
          ),
          if (expanded)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: homeController.aboutStakefair.skip(1)
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(item, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                      ))
                  .toList(),
            ),
        ],
      );
    });
  }

  Widget _buildCategoryBar() {
    return Container(
      height: 50,
      color: Colors.black87,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: homeController.categories.map((item) {
            bool highlighted = item['isHighlighted'] ?? false;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 5),
              child: Container(
                width: 85,
                height: 45,
                decoration: BoxDecoration(
                  color: highlighted ? Colors.green : Color(0xff525252),
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

  Widget _buildBanner() {
    return Container(
      width: 415,
      height: 80,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/top_banner.jpg'), fit: BoxFit.fill),
      ),
    );
  }

  Widget _buildSection(String title, String leading, String label, String sub) {
    return Column(
      children: [
        _buildContainer(title),
        _buildList(leading, label, sub),
      ],
    );
  }

  Widget _buildList(String leading, String label, String sub) {
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: homeController.cricket.length,
          itemBuilder: (context, index) {
            var team = homeController.cricket[index];
            return Card(
              child: ListTile(
                leading: Icon(team[leading]),
                title: Text(team[label], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                subtitle: Text(team[sub], style: TextStyle(fontSize: 22, color: Colors.grey)),
              ),
            );
          },
        ));
  }

  Widget _buildHorseRacingSection(String title) {
    return Column(
      children: [
        _buildContainer(title),
        Obx(() => ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: homeController.horseRacing.length,
              itemBuilder: (context, index) {
                String item = homeController.horseRacing[index];
                return Card(
                  child: ListTile(
                    title: Text(item, style: TextStyle(fontSize: 22)),
                  ),
                );
              },
            )),
      ],
    );
  }

  Widget _buildQuickLinksSection(String title, String leading) {
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: homeController.quickLinks.length,
          itemBuilder: (context, index) {
            var links = homeController.quickLinks[index];
            return Card(
              child: ListTile(
                leading: Icon(links[leading]),
                title: Text(links[title].toString(), style: TextStyle(fontSize: 22)),
              ),
            );
          },
        ));
  }

  Widget _buildContainer(String title) {
    return Container(
      width: double.infinity,
      height: 50,
      color: Color(0xff525252),
      padding: EdgeInsets.all(8.0),
      child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white)),
    );
  }

  Widget _buildIconButton(IconData icon, String text, {double width = 70}) {
    return Container(
      width: width,
      height: 45,
      decoration: BoxDecoration(color: Color(0xff525252), borderRadius: BorderRadius.circular(3)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 20),
          Text(text, style: TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      height: 100,
      width: 415,
      color: Color(0xff525252),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.red, width: 3)),
              child: Center(child: Text('18+', style: TextStyle(color: Colors.white, fontSize: 20))),
            ),
          ),
          Text('Please Gamble\nResponsible', style: TextStyle(color: Colors.white, fontSize: 20)),
          Container(
            width: 130,
            height: 60,
            color: Color(0xffD9D9D9),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('More\nDetails', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningText() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(text: 'Warning: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
            TextSpan(
              text: "Although the current score, time elapsed, video and other data provided on this site is sourced from feeds provided by third parties, you should be aware that this data may be subject to a time delay and/or be inaccurate. Please also be aware that other StakeFair customers may have access to data that is faster and/or more accurate than the data shown on the StakeFair site. If you rely on this data to place bets, you do so entirely at your own risk. StakeFair provides this data AS IS with no warranty as to the accuracy, completeness or timeliness of such data and accepts no responsibility for any loss (direct or indirect) suffered by you as a result of your reliance on it.",
              style: TextStyle(fontSize: 16, color: Colors.black, wordSpacing: 2),
            ),
          ],
        ),
      ),
    );
  }
}