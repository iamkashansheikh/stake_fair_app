import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/res/responsive.dart';

class CompetitionDropdown extends StatelessWidget {
  final String id; // Unique identifier
  final String title;
  final Color? color;
  final List<String> competitions;

  CompetitionDropdown({
    required this.id,
    required this.title,
    required this.competitions,
    this.color,
    super.key,
  });

  final DropdownController controller = Get.put(DropdownController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isExpanded = controller.isExpanded(id); // Check expansion state

      return BaseResponsiveScreen(
        child: Container(
          color: color ?? Colors.white,
          child: Column(
            children: [
              // Title row with expand/collapse icon
              SizedBox(
                height: 30.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7.w),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 11.sp,
                          ),
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          isExpanded ? Icons.remove : Icons.add,
                          size: 16.sp,
                        ),
                        onPressed: () => controller.toggle(id),
                      ),
                    ],
                  ),
                ),
              ),

              // Slide-down animation for dropdown content
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: isExpanded
                    ? Column(
                        children: List.generate(competitions.length, (index) {
                          return Column(
                            children: [
                              ListTile(
                                dense: true,
                                visualDensity: const VisualDensity(
                                    horizontal: 0, vertical: -4),
                                title: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.w),
                                  child: Text(
                                    competitions[index],
                                    style: TextStyle(fontSize: 10.sp),
                                  ),
                                ),
                                trailing: Icon(Icons.keyboard_arrow_right,
                                    size: 18.sp),
                                onTap: () {
                                  // Handle item tap
                                },
                              ),
                              if (index != competitions.length - 1)
                                const Divider(thickness: 0.5, height: 2),
                            ],
                          );
                        }),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class DropdownController extends GetxController {
  final RxString _expandedId = ''.obs;

  bool isExpanded(String id) => _expandedId.value == id;

  void toggle(String id) {
    if (_expandedId.value == id) {
      _expandedId.value = ''; // collapse if already open
    } else {
      _expandedId.value = id; // open this and collapse others
    }
  }
}
