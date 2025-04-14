import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:stake_fair_app/controllers/getx_controller/scroll_controller.dart';
import 'package:stake_fair_app/res/app_colors/app_colors.dart';
import 'package:stake_fair_app/view/widgets/custom_action_tile.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {

     final ScrollControllerX scrollControllerX = Get.put(ScrollControllerX()); 
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mediaQuerySize.width*0.02),
        child: SingleChildScrollView(
          controller: scrollControllerX.scrollController,
          child: Column(
            children: [
              SizedBox(height: mediaQuerySize.height*0.1,),
              Center(
                child: Container(
                  height: mediaQuerySize.height*0.1,
                  width: mediaQuerySize.width*0.7,
                  decoration: BoxDecoration(
                    color: Color(0xff364452),
                    //color: Colors.blueGrey.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(5)
                  ),
                ),
              ),
              SizedBox(height: mediaQuerySize.height*0.04,),
              Container(
                width: mediaQuerySize.width,
                
              //  height: mediaQuerySize.height*0.2,
                decoration: BoxDecoration(
                  color: Color(0xff364452),
                 // color:  Colors.blueGrey.withOpacity(0.6),

                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                    SizedBox(height: mediaQuerySize.height*0.02,),
                                        Text("text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),


                  ],
                ),
              ),
               SizedBox(height: mediaQuerySize.height*0.04,),
               Center(child: Text('How can we help out?',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),),),
                SizedBox(height: mediaQuerySize.height*0.02,),
               Container(
  height: mediaQuerySize.height * 0.07,
  width: mediaQuerySize.width * 0.8,
  padding: EdgeInsets.symmetric(horizontal: 12),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
  ),
  child: Row(
    children: [
      Icon(Icons.search, color: Colors.grey),
      SizedBox(width: 10),
      Expanded(
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Tell us what you are looking for',
            hintStyle: TextStyle(color: Colors.grey,fontSize: 12,fontWeight: FontWeight.w500),
            border: InputBorder.none,
          ),
        ),
      ),
    ],
  ),
),
SizedBox(height: mediaQuerySize.height*0.04,),
   Padding(
     padding: const EdgeInsets.all(8.0),
     child: Align(
      alignment: Alignment.centerLeft,
      child: Text('Popular Questions',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)),
   ),
   SizedBox(height: mediaQuerySize.height*0.02,),
   Padding(
     padding: EdgeInsets.symmetric(horizontal: mediaQuerySize.width*0.02),
     child: Row(
       children: [
         Container(
          height: mediaQuerySize.height*0.05,
          width: mediaQuerySize.width*0.4,
          decoration: BoxDecoration(
            color: Color(0xff2A2A2C),
           // color: AppColors.helpScrenColor,
            borderRadius: BorderRadius.circular(5)
            //color: Colors.grey.shade500,
          ),
          child: Row(
            children: [
              Container(height: mediaQuerySize.height*0.05,
              width: mediaQuerySize.width*0.01,
              decoration: BoxDecoration(
                color: Colors.amber
              ),
              ),
              SizedBox(width: mediaQuerySize.width*0.02,),
              Text('Account Access(Login)',style: TextStyle(color: Colors.white,fontSize:12,fontWeight: FontWeight.bold),)
            ],
          ),
         ),
         SizedBox(width: mediaQuerySize.width*0.02,),
          Container(
          height: mediaQuerySize.height*0.05,
          width: mediaQuerySize.width*0.4,
          decoration: BoxDecoration(
             color: AppColors.helpScrenColor,
            borderRadius: BorderRadius.circular(5)
            //color: Colors.grey.shade500,
          ),
          child: Row(
            children: [
              Container(height: mediaQuerySize.height*0.05,
              width: mediaQuerySize.width*0.01,
              decoration: BoxDecoration(
                color: Colors.amber
              ),
              ),
              SizedBox(width: mediaQuerySize.width*0.02,),
              Text('Free Bet Information',style: TextStyle(color: Colors.white,fontSize:12,fontWeight: FontWeight.bold),),
            ],
          ),
         ),
       ],
     ),
   ),
    SizedBox(height: mediaQuerySize.height*0.01,),
   Padding(
     padding: EdgeInsets.symmetric(horizontal: mediaQuerySize.width*0.02),
     child: Row(
       children: [
         Container(
          height: mediaQuerySize.height*0.05,
          width: mediaQuerySize.width*0.35,
          decoration: BoxDecoration(
             color: AppColors.helpScrenColor,
            borderRadius: BorderRadius.circular(5)
            //color: Colors.grey.shade500,
          ),
          child: Row(
            children: [
              Container(height: mediaQuerySize.height*0.05,
              width: mediaQuerySize.width*0.01,
              decoration: BoxDecoration(
                color: Colors.amber
              ),
              ),
              SizedBox(width: mediaQuerySize.width*0.02,),
              Text('Account Access(Login)',style: TextStyle(color: Colors.white,fontSize:10,fontWeight: FontWeight.bold),)
            ],
          ),
         ),
         SizedBox(width: mediaQuerySize.width*0.02,),
          Container(
          height: mediaQuerySize.height*0.05,
          width: mediaQuerySize.width*0.35,
          decoration: BoxDecoration(
             color: AppColors.helpScrenColor,
            borderRadius: BorderRadius.circular(5)
            //color: Colors.grey.shade500,
          ),
          child: Row(
            children: [
              Container(height: mediaQuerySize.height*0.05,
              width: mediaQuerySize.width*0.01,
              decoration: BoxDecoration(
                color: Colors.amber
              ),
              ),
              SizedBox(width: mediaQuerySize.width*0.02,),
              Text('Free Bet Information',style: TextStyle(color: Colors.white,fontSize:10,fontWeight: FontWeight.bold),),
            ],
          ),
         ),
       ],
     ),
   ),
   SizedBox(height: mediaQuerySize.height*0.01,),
   Padding(
     padding: EdgeInsets.symmetric(horizontal: mediaQuerySize.width*0.02),
     child: Row(
       children: [
         Container(
          height: mediaQuerySize.height*0.05,
          width: mediaQuerySize.width*0.5,
          decoration: BoxDecoration(
            color: AppColors.helpScrenColor,
            borderRadius: BorderRadius.circular(5)
            //color: Colors.grey.shade500,
          ),
          child: Row(
            children: [
              Container(height: mediaQuerySize.height*0.05,
              width: mediaQuerySize.width*0.01,
              decoration: BoxDecoration(
                color: Colors.amber
              ),
              ),
              SizedBox(width: mediaQuerySize.width*0.02,),
              Text('Updating or removing your card',style: TextStyle(color: Colors.white,fontSize:10,fontWeight: FontWeight.bold),)
            ],
          ),
         ),
         SizedBox(width: mediaQuerySize.width*0.02,),
          Container(
          height: mediaQuerySize.height*0.05,
          width: mediaQuerySize.width*0.27,
          decoration: BoxDecoration(
            color: AppColors.helpScrenColor,
            borderRadius: BorderRadius.circular(5)
            //color: Colors.grey.shade500,
          ),
          child: Row(
            children: [
              Container(height: mediaQuerySize.height*0.05,
              width: mediaQuerySize.width*0.01,
              decoration: BoxDecoration(
                color: Colors.amber
              ),
              ),
              SizedBox(width: mediaQuerySize.width*0.02,),
              Text('Contact Us',style: TextStyle(color: Colors.white,fontSize:10,fontWeight: FontWeight.bold),),
            ],
          ),
         ),
       ],
     ),
   ),
   SizedBox(height: mediaQuerySize.height*0.03,),

  Padding(
     padding: const EdgeInsets.all(8.0),
     child: Align(
      alignment: Alignment.centerLeft,
      child: Text('Find our more about one of these areas',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)),
   ),
   SizedBox(height: mediaQuerySize.height*0.01,),
   CustomActionTile(
    
    title: 'Login & Registration',
    leading: Image.asset('assets/images/h1.png'),
    trailingIcon:Icons.arrow_forward,onTap: () {
     
   }, mediaQuerySize: mediaQuerySize,),
   
             SizedBox(height: mediaQuerySize.height*0.01,),
   CustomActionTile(
    
    title: 'Permotions & Rewards',
    leading: Image.asset('assets/images/2.png'),
    trailingIcon:Icons.arrow_forward,onTap: () {
     
   }, mediaQuerySize: mediaQuerySize,),
   SizedBox(height: mediaQuerySize.height*0.01,),
  CustomActionTile(
    
    title: 'Deposits & Withdrawals',
    leading: Image.asset('assets/images/3.png'),
    trailingIcon:Icons.arrow_forward,onTap: () {
     
   }, mediaQuerySize: mediaQuerySize,),
            
 SizedBox(height: mediaQuerySize.height*0.01,),
 CustomActionTile(
    
    title: 'Football Season 2023/24',
    leading: Image.asset('assets/images/4.png'),
    trailingIcon:Icons.arrow_forward,onTap: () {
     
   }, mediaQuerySize: mediaQuerySize,),
            SizedBox(height: mediaQuerySize.height*0.01,),
            CustomActionTile(
    
    title: 'Verifying Your Account',
    leading: Image.asset('assets/images/5.png'),
    trailingIcon:Icons.arrow_forward,onTap: () {
     
   }, mediaQuerySize: mediaQuerySize,),
 SizedBox(height: mediaQuerySize.height*0.01,),
            CustomActionTile(
    
    title: 'Sports',
    leading: Image.asset('assets/images/6.png'),
    trailingIcon:Icons.arrow_forward,onTap: () {
     
   }, mediaQuerySize: mediaQuerySize,),
 SizedBox(height: mediaQuerySize.height*0.01,),
            CustomActionTile(
    
    title: 'Gaming',
    leading: Image.asset('assets/images/7.png'),
    trailingIcon:Icons.arrow_forward,onTap: () {
     
   }, mediaQuerySize: mediaQuerySize,),
 SizedBox(height: mediaQuerySize.height*0.01,),
            CustomActionTile(
    
    title: 'Safer Gambling',
    leading: Image.asset('assets/images/8.png'),
    trailingIcon:Icons.arrow_forward,onTap: () {
     
   }, mediaQuerySize: mediaQuerySize,),
    SizedBox(height: mediaQuerySize.height*0.01,),
            CustomActionTile(
    
    title: 'Other',
    leading: Image.asset('assets/images/9.png'),
    trailingIcon:Icons.arrow_forward,onTap: () {
     
   }, mediaQuerySize: mediaQuerySize,),

   SizedBox(height: mediaQuerySize.height*0.03,),

  Padding(
     padding: const EdgeInsets.all(8.0),
     child: Align(
      alignment: Alignment.centerLeft,
      child: Text('Not found the answer you were found?',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)),
   ),
 SizedBox(height: mediaQuerySize.height*0.01,),
         
  Container(
        height: mediaQuerySize.height * 0.25,
        width: mediaQuerySize.width * 0.9,
        decoration: BoxDecoration(
          color: const Color(0xff1c1b1a),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
                height: mediaQuerySize.height * 0.05,
                width: mediaQuerySize.width * 0.08,
                decoration: BoxDecoration(
                  color: const Color(0xff1c1b1a),
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.7),
                      //color:  Color(0xff1c1b1a), // Example shadow
                      blurRadius: 3,
                      spreadRadius: 0,
                      offset: const Offset(0, 0),
                    )
                  ],
                ),
                child: Column(

                  children: [
                    SizedBox(height: mediaQuerySize.height*0.04,),
                    Center(child: Image.asset('assets/images/dd.png')),
                    SizedBox(height: mediaQuerySize.height*0.02,),
                    Text('The quickest way to get in touch',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                    
                     SizedBox(height: mediaQuerySize.height*0.02,),
                    
            Container(
           height: mediaQuerySize.height*0.06,
           width: mediaQuerySize.width*0.6,
           decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5)
        ),
        child: Center(child: Text('Get in touch',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
       )
                  ],
                ),
              ),
        ),
           SizedBox(height: mediaQuerySize.height*0.02,),
           Padding(
             padding: const EdgeInsets.all(4.0),
             child: Row(
               children: [
                 Container(
                 height: mediaQuerySize.height*0.045,
                 width: mediaQuerySize.width*0.45,
                 decoration: BoxDecoration(
                           border: Border.all(color: Colors.grey.shade900),
                           borderRadius: BorderRadius.circular(5)
                         ),
                         child: Center(child: Text('Privacy Policy',style: TextStyle(color: Colors.grey.shade700,fontWeight: FontWeight.w500,fontSize: 11),)),
                        ),
                        SizedBox(width: mediaQuerySize.width*0.02,),
                         Container(
                 height: mediaQuerySize.height*0.045,
                 width: mediaQuerySize.width*0.45,
                 decoration: BoxDecoration(
                           border: Border.all(color: Colors.grey.shade900),
                           borderRadius: BorderRadius.circular(5)
                         ),
                         child: Center(child: Text('Terms & Conditions',style: TextStyle(color: Colors.grey.shade700,fontWeight: FontWeight.w500,fontSize: 11),)),
                        ),
               ],
             ),
           ),
            Padding(
             padding: const EdgeInsets.all(4.0),
             child: Row(
               children: [
                 Container(
                 height: mediaQuerySize.height*0.045,
                 width: mediaQuerySize.width*0.45,
                 decoration: BoxDecoration(
                           border: Border.all(color: Colors.grey.shade900),
                           borderRadius: BorderRadius.circular(5)
                         ),
                         child: Center(child: Text('Cookie Policy',style: TextStyle(color: Colors.grey.shade700,fontWeight: FontWeight.w500,fontSize: 11),)),
                        ),
                        SizedBox(width: mediaQuerySize.width*0.02,),
                         Container(
                 height: mediaQuerySize.height*0.065,
                 width: mediaQuerySize.width*0.45,
                 decoration: BoxDecoration(
                           border: Border.all(color: Colors.grey.shade900),
                           borderRadius: BorderRadius.circular(5)
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Center(child: Text(
                            textAlign: TextAlign.center,
                            'Underage Gambling is an Offence',style: TextStyle(color: Colors.grey.shade700,fontWeight: FontWeight.w500,fontSize: 11),)),
                         ),
                        ),
               ],
             ),
           ),
            Padding(
             padding: const EdgeInsets.all(4.0),
             child: Row(
               children: [
                 Container(
                 height: mediaQuerySize.height*0.045,
                 width: mediaQuerySize.width*0.45,
                 decoration: BoxDecoration(
                           border: Border.all(color: Colors.grey.shade900),
                           borderRadius: BorderRadius.circular(5)
                         ),
                         child: Center(child: Text('Rules & Regulations',style: TextStyle(color: Colors.grey.shade700,fontWeight: FontWeight.w500,fontSize: 11),)),
                        ),
                        SizedBox(width: mediaQuerySize.width*0.02,),
                         Container(
                 height: mediaQuerySize.height*0.045,
                 width: mediaQuerySize.width*0.45,
                 decoration: BoxDecoration(
                           border: Border.all(color: Colors.grey.shade900),
                           borderRadius: BorderRadius.circular(5)
                         ),
                         child: Center(child: Text('Betfair.com',style: TextStyle(color: Colors.grey.shade700,fontWeight: FontWeight.w500,fontSize: 11))),
                        ),
               ],
             ),
           ),
           SizedBox(height: mediaQuerySize.height*0.01,),
            Container(
                 height: mediaQuerySize.height*0.09,
                 width: mediaQuerySize.width*0.5,
                 decoration: BoxDecoration(
                           border: Border.all(color: Colors.grey.shade900),
                           borderRadius: BorderRadius.circular(5)
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Center(child: Text(
                            textAlign: TextAlign.center,
                            'Gambling can be addictive, use our online tools for a safer way to play',style: TextStyle(color: Colors.grey.shade700,fontWeight: FontWeight.w500,fontSize: 11),)),
                         ),
                        ),
                        SizedBox(height: mediaQuerySize.height*0.03,),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                  Image.asset('assets/images/bt6.png'),
                  SizedBox(width: mediaQuerySize.width*0.02,),
                  Image.asset('assets/images/commission.png'),
                         SizedBox(width: mediaQuerySize.width*0.02,),
                  Image.asset('assets/images/bt1.png'),

                          ],
                        ),
                        SizedBox(height: mediaQuerySize.height*0.02,),
                         Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                  Image.asset('assets/images/bt5.png'),
                  SizedBox(width: mediaQuerySize.width*0.02,),
                  Image.asset('assets/images/bt3.png'),
                         SizedBox(width: mediaQuerySize.width*0.02,),
                  Image.asset('assets/images/bt8.png'),

                          ],
                        ),
                        SizedBox(height: mediaQuerySize.height*0.02,),
                         Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                  Image.asset('assets/images/jj.png'),
                  SizedBox(width: mediaQuerySize.width*0.02,),
                  Image.asset('assets/images/bt4.png'),
                         SizedBox(width: mediaQuerySize.width*0.02,),
                  Image.asset('assets/images/bt10.png'),

                          ],
                        ),
                      SizedBox(height: mediaQuerySize.height*0.02,),
                      Center(child: Image.asset('assets/images/bt11.png')),
                       SizedBox(height: mediaQuerySize.height*0.03,),
                      Center(child: Image.asset('assets/images/bt2.png')),
           SizedBox(height: mediaQuerySize.height*0.1,),
            ],
          ),
        ),
      ),
     floatingActionButton: FloatingActionButton(
  onPressed: () {
    scrollControllerX.scrollUp(); // Your scroll functionality
  },
  backgroundColor: Colors.transparent, // Make the background transparent
  elevation: 4, // Add a shadow effect to give it a floating look
  child: Container(
    height: 60, // Size of the button
    width: 60, // Size of the button
    decoration: BoxDecoration(
      shape: BoxShape.circle, // Make the button circular
    //  color: Color.fromARGB(255, 61, 61, 52), // iOS-style background color (blue)
      color: AppColors.helpScrenColor,
      boxShadow: [
        BoxShadow(
         // color: Colors.black.withOpacity(0.4), // Shadow effect
           color: AppColors.helpScrenColor,
          blurRadius: 6,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Center(
      child: Icon(
         Icons.arrow_upward,
        color: Colors.blue, // White color for the icon
        size: 30, // Icon size
      ),
    ),
  ),
),

      
      // floatingActionButton:FloatingActionButton(
      //   onPressed: (){
      //     scrollControllerX.scrollUp();
      //   },
      //   child: Icon(Icons.arrow_upward_sharp,),
      // ),
    );

  }
}

