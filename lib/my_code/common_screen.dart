import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/controllers/Home/home_controller.dart';
import 'package:stake_fair_app/my_code/controllers/competitions_controller.dart';

class CommonScreen extends StatefulWidget {
  final dynamic categoryId; // Adjust type as needed (int or String)
  final String eventName;
  final IconData eventIcon;

  const CommonScreen({
    Key? key,
    required this.categoryId,
    required this.eventName,
    required this.eventIcon,
  }) : super(key: key);

  @override
  State<CommonScreen> createState() => _CommonScreenState();
}

class _CommonScreenState extends State<CommonScreen> {
  final CompetitionController competitionController = Get.put(CompetitionController());
    final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    

    // Fetch competitions dynamically based on event type
    WidgetsBinding.instance.addPostFrameCallback((_) {
      competitionController.fetchCompetitions(widget.eventName);
    });

    Size mediaQuery = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        appBar: _buildAppBar(context), // AppBar remains the same
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: mediaQuery.width * 0.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildContainer(widget.eventName), // Dynamic Event Name Instead of "Cricket"
                _buildTimeSection('Time'),
                _buildHorseRacingSection('Competitions'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // **Dynamic Title Instead of Hardcoded "Cricket"**
  Widget _buildContainer(String title) {
    return Container(
      width: double.infinity,
      height: 31,
      color: const Color(0xff303030),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: AutoSizeText(
        title, // Now event type will be shown dynamically
        style: const TextStyle(
            fontWeight: FontWeight.w600, fontSize: 14, color: Colors.white),
        maxLines: 1,
      ),
    );
  }

  Widget _buildHorseRacingSection(String title) {
    final CompetitionController competitionController = Get.put(CompetitionController());
    return Column(
      children: [
        _buildContainer(title),
        Obx(() {
          if (competitionController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (competitionController.competitionList.isEmpty) {
            return Center(
                child: Text("No competitions available for ${widget.eventName}"));
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: competitionController.competitionList.length,
            itemBuilder: (context, index) {
              var competition = competitionController.competitionList[index];
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
                        child: Text(competition.competition?.name ?? "Unknown Competition"),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          size: 14, color: Colors.grey),
                    ),
                  ),
                  const Divider(height: 0.3, thickness: 0.3),
                ],
              );
            },
          );
        })
      ],
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    double appBarHeight = 50;
    double logoWidth = 133;
    double logoHeight = 18;
    double searchButtonWidth = 50;
    double loginButtonWidth = 66;

    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
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
          toolbarHeight: appBarHeight,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: logoWidth,
                    height: logoHeight,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/stakefair.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 34),
                    child: Text(
                      'EXCHANGE',
                      style: TextStyle(
                        fontSize: 14,
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
                    child: _buildIconButton(
                      Icons.search_rounded,
                      'Search',
                      width: searchButtonWidth,
                    ),
                  ),
                  const SizedBox(width: 4),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/login');
                    },
                    child: _buildIconButton(
                      Icons.person,
                      'Login / Join',
                      width: loginButtonWidth,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String text, {double width = 85}) {
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
                  fontSize: 11,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

    Widget _buildSearchField(Size mediaQuery, double textScale, {Key? key}) {
    return Container(
      key: key,
      width: mediaQuery.width,
      height: 55 * textScale,
      color: const Color(0xff303030),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 37,
              child: TextFormField(
                cursorColor: Colors.grey,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder()),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => homeController.isSearchFieldVisible.value = false,
            child: AutoSizeText(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 12 * textScale),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSection(String title) {
    return Column(
      children: [
        _buildContainer(title),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: ListTile(
                    dense: true,
                    visualDensity:
                        const VisualDensity(horizontal: -4, vertical: -4),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                    title: Text('InPlay'),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        size: 14, color: Colors.grey),
                  ),
                ),
                const Divider(height: 0.3, thickness: 0.3),
              ],
            );
          },
        )
      ],
    );
  }
}
