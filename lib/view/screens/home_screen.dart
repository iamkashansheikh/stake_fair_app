import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/controllers/home_controller.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  _buildCategoryBar(),
                  _buildBanner(),
                  Obx(() {
                    return homeController.isBannerVisible.value
                        ? _buildWhyWinBanner()
                        : SizedBox.shrink();
                  }),
                  _buildSection('Most Popular Bets', 'icon', 'label', 'sub'),
                  _buildHorseRacingSection('Horse Racing'),
                  _buildContainer('QuickLinks'),
                  _buildQuickLinksSection('name', 'icon'),
                  _buildFooter(),
                  _buildWarningText(),
                  const SizedBox(height: 5),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: _buildSaferGamblingDropdown()),
                      const SizedBox(height: 5),
                      Center(child: _buildAboutStakefairDropdown()),
                      const SizedBox(height: 5),
                      _buildText('Help'),
                      _buildText('Affiliates'),
                      _buildText('18+'),
                      _buildText('Developers'),
                      _buildText('StakeFair Exchange Sitemap'),
                      _buildText('B2B Partnerships'),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Divider(thickness: 1),
                      ),
                      const SizedBox(height: 15),
                      _buildText('Privacy Policy'),
                      _buildText('Cookie Policy'),
                      _buildText('Privacy Preference Centre'),
                      _buildText('Rules & Regulations'),
                      _buildText('Terms & Conditions'),
                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
            Obx(() => AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  top: homeController.isSearchFieldVisible.value ? 0 : -80,
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity:
                        homeController.isSearchFieldVisible.value ? 1.0 : 0.0,
                    child: _buildSearchField(),
                  ),
                )),
          ],
        ),
        bottomNavigationBar: Obx(() {
          return Container(
            color: const Color(0xff525252),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(
                  index: 0,
                  label: 'Home',
                  icon: Icons.home,
                  onTap: () => homeController.changeIndex(0),
                ),
                _buildNavItem(
                  index: 1,
                  label: 'Menu',
                  icon: Icons.menu,
                  onTap: () => homeController.changeIndex(1),
                ),
                _buildNavItem(
                  index: 2,
                  label: 'Cash Out',
                  icon: Icons.account_balance_wallet,
                  onTap: () => homeController.changeIndex(2),
                ),
                _buildNavItemWithAsset(
                  index: 3,
                  label: 'My Bets',
                  assetPath: 'assets/images/money.png',
                  onTap: () => homeController.changeIndex(3),
                ),
                _buildNavItemWithAsset(
                  index: 4,
                  label: 'Casino',
                  assetPath: 'assets/images/casino-chip (1).png',
                  onTap: () => homeController.changeIndex(4),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

PreferredSizeWidget _buildAppBar() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(53),
    child: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xffFFB300),
            Color(0xffFF8801),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: AppBar(
        toolbarHeight: 53,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  width: 133,
                  height: 20,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/stakefair.png'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 9),
                  child: const Text(
                    'EXCHANGE',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                InkWell(
                  onTap: () => homeController.isSearchFieldVisible.toggle(),
                  child: _buildIconButton(Icons.search_rounded, 'Search',
                      width: 50),
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    Get.toNamed('/login');
                  },
                  child:
                      _buildIconButton(Icons.person, 'Login/Join', width: 70),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

  Widget _buildSearchField({Key? key}) {
    return Container(
      key: key,
      width: 415,
      height: 80,
      color: const Color(0xff525252),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => homeController.isSearchFieldVisible.value = false,
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildText(String title) {
    return Text(title,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500));
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
                Text(
                  homeController.saferGambling[0],
                  style: const TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                Icon(expanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              ],
            ),
          ),
          if (expanded)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: homeController.saferGambling
                  .skip(1)
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          item,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
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
                Text(
                  homeController.aboutStakefair[0],
                  style: const TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                Icon(expanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              ],
            ),
          ),
          if (expanded)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: homeController.aboutStakefair
                  .skip(1)
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          item,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ))
                  .toList(),
            ),
        ],
      );
    });
  }

  Widget _buildCategoryBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      color: const Color(0xff303030),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          spacing: 5,
          children: homeController.categories.map((item) {
            bool highlighted = item['isHighlighted'] ?? false;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: highlighted ? Colors.green : const Color(0xff525252),
                borderRadius: BorderRadius.circular(1),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                      child: Icon(item['icon'], color: Colors.white, size: 20)),
                  const SizedBox(height: 2),
                  Center(
                      child: Text(item['label'],
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10))),
                ],
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
      height: 65,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/top_banner.jpg'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildWhyWinBanner() {
    return Container(
      width: 415,
      color: Color(0xffD7DCDF),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          height: 180,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xffFFB80C),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 8,
                offset: Offset(0, 4),
              )
            ],
            image: DecorationImage(
              image: AssetImage('assets/images/whywin.jpeg'),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => homeController.isBannerVisible.value = false,
                  child: const Icon(
                    Icons.close,
                    color: Color(0xff424242),
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
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
          physics: const NeverScrollableScrollPhysics(),
          itemCount: homeController.cricket.length,
          itemBuilder: (context, index) {
            var team = homeController.cricket[index];
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: ListTile(
                      dense: true,
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: -4),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 3, vertical: 0),
                      leading: Icon(team[leading], size: 20),
                      title: Text(team[label],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      subtitle: Text(team[sub],
                          style: const TextStyle(
                              fontSize: 15, color: Colors.grey)),
                      trailing:
                          const Icon(Icons.keyboard_arrow_right, size: 18),
                    ),
                  ),
                  const Divider(height: 0.5, thickness: 0.5),
                ],
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
              physics: const NeverScrollableScrollPhysics(),
              itemCount: homeController.horseRacing.length,
              itemBuilder: (context, index) {
                String item = homeController.horseRacing[index];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: ListTile(
                        dense: true,
                        visualDensity:
                            const VisualDensity(horizontal: -4, vertical: -4),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 0),
                        title: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(item,
                              style: const TextStyle(
                                  fontSize: 15, color: Color(0xff212529))),
                        ),
                        trailing:
                            const Icon(Icons.keyboard_arrow_right, size: 18),
                      ),
                    ),
                    const Divider(height: 0.5, thickness: 0.5),
                  ],
                );
              },
            )),
      ],
    );
  }

  Widget _buildQuickLinksSection(String title, String leading) {
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: homeController.quickLinks.length,
          itemBuilder: (context, index) {
            var links = homeController.quickLinks[index];
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: ListTile(
                    dense: true,
                    visualDensity:
                        const VisualDensity(horizontal: -4, vertical: -4),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 3, vertical: 0),
                    leading: Icon(links[leading], size: 20),
                    title: Text(links[title].toString(),
                        style: const TextStyle(
                            fontSize: 15, color: Color(0xff212529))),
                    trailing: const Icon(Icons.keyboard_arrow_right, size: 18),
                  ),
                ),
                const Divider(height: 0.5, thickness: 0.5),
              ],
            );
          },
        ));
  }

  Widget _buildContainer(String title) {
    return Container(
      width: double.infinity,
      height: 32,
      color: const Color(0xff303030),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Text(title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white)),
    );
  }

  Widget _buildIconButton(IconData icon, String text, {double width = 70}) {
    return Container(
      width: width,
      height: 38,
      decoration: BoxDecoration(
          color: const Color(0xff424242),
          borderRadius: BorderRadius.circular(2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 20),
          Text(text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      height: 60,
      width: 415,
      color: const Color(0xff1E1E1E),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xffFF0000), width: 2)),
              child: const Center(
                  child: Text(
                '18+',
                style: TextStyle(color: Colors.white, fontSize: 18),
              )),
            ),
          ),
          const SizedBox(width: 7),
          const Text('Please Gamble Responsible',
              style: TextStyle(
                  color: Color(0xffC4C4C4),
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          const SizedBox(width: 15),
          Container(
            width: 100,
            height: 35,
            decoration: BoxDecoration(
              color: const Color(0xffD4D4D4),
              borderRadius: BorderRadius.circular(2),
            ),
            alignment: Alignment.center,
            child: const Text(
              'More Details',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWarningText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: RichText(
        text: TextSpan(
          children: [
            const TextSpan(
              text: 'Warning',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                wordSpacing: 2,
              ),
            ),
            const TextSpan(
              text:
                  " : Although the current score, time elapsed, video and other",
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
                wordSpacing: 2,
              ),
            ),
            _buildWidgetSpan(
                " data provided on this site is sourced from feeds provided by third",
                14),
            _buildWidgetSpan(
                " parties, you should be aware that this data may be subject to a time",
                5),
            _buildWidgetSpan(
                " delay and/or be inaccurate. Please also be aware that other",
                28),
            _buildWidgetSpan(
                " StakeFair customers may have access to data that is faster and/or",
                12),
            _buildWidgetSpan(
                " more accurate than the data shown on the StakeFair site. If you rely on",
                8),
            _buildWidgetSpan(
                " this data to place bets, you do so entirely at your own risk.",
                35),
            _buildWidgetSpan(
                " StakeFair provides this data AS IS with no warranty as to the accuracy,",
                6),
            _buildWidgetSpan(
                " completeness or timeliness of such data and accepts no", 35),
            _buildWidgetSpan(
                " responsibility for any loss (direct or indirect) suffered by you as a",
                20),
            _buildWidgetSpan(" result of your reliance on it.", 125),
          ],
        ),
      ),
    );
  }

  InlineSpan _buildWidgetSpan(String text, double horizontalPadding) {
    return WidgetSpan(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 1),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    bool isSelected = (index == homeController.selectedIndex.value);
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 55,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff303030) : const Color(0xff525252),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.orange : Colors.white,
              size: 26,
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItemWithAsset({
    required int index,
    required String label,
    required String assetPath,
    required VoidCallback onTap,
  }) {
    bool isSelected = (index == homeController.selectedIndex.value);
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 55,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff303030) : const Color(0xff525252),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              assetPath,
              width: 30,
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
