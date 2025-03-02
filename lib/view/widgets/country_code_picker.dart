import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:stake_fair_app/controllers/getx_controller/auth_controller.dart';
import 'package:stake_fair_app/view/widgets/custom_field_widget.dart';

class CountryCodePickerWidget extends StatelessWidget {
 

  CountryCodePickerWidget({  Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    final AuthController controller = Get.find<AuthController>(); 

    return Row(
      children: [
        Container(
          height: mediaQuerySize.height*0.07,
          width: mediaQuerySize.width*0.3.w,
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.07),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Obx(
            () => DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down),
                value: "${controller.selectedCountryCode.value},${controller.selectedCountryFlag.value}",
                onChanged: (value) {
                  if (value != null) {
                    var parts = value.split(',');
                    controller.updateCountry(parts[0], parts[1]);
                  }
                },
                items: countries.map((country) {
                  return DropdownMenuItem<String>(
                    value: "+${country.dialCode},${country.flag}",
                    child: Row(
                      children: [
                        Text(country.flag),
                        SizedBox(width: 8),
                        Text("+${country.dialCode}"),
                      ],
                    ),
                  );
                }).toList(),
                dropdownColor: Colors.white,
                menuMaxHeight: 300, 
                menuWidth: 300,
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        
     
        Expanded(
          child: CustomField(text: 'Phone Number',),
        ),
      ],
    );
  }
}