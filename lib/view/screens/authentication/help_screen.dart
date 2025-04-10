import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mediaQuerySize.width*0.02),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: mediaQuerySize.height*0.1,),
              Center(
                child: Container(
                  height: mediaQuerySize.height*0.1,
                  width: mediaQuerySize.width*0.7,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ),
              SizedBox(height: mediaQuerySize.height*0.04,),
              Container(
                width: mediaQuerySize.width,
              //  height: mediaQuerySize.height*0.2,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,

                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
                    SizedBox(height: mediaQuerySize.height*0.02,),
                                        Text("text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),


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
            color: Colors.grey,
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
            color: Colors.grey,
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
            color: Colors.grey,
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
            color: Colors.grey,
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
            color: Colors.grey,
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
            color: Colors.grey,
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
    Container(
          height: mediaQuerySize.height*0.06,
          width: mediaQuerySize.width*0.9,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(5)
            //color: Colors.grey.shade500,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(height: mediaQuerySize.height*0.05,
                width: mediaQuerySize.width*0.08,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Icon(Icons.arrow_forward,color: Colors.white,),
                ),
              ),
              SizedBox(width: mediaQuerySize.width*0.02,),
              Text('Login & Registeration',style: TextStyle(color: Colors.white,fontSize:14,fontWeight: FontWeight.bold),),
              SizedBox(width: mediaQuerySize.width*0.25,),
              Icon(Icons.arrow_forward,)
            ],
          ),
         ),
            
             SizedBox(height: mediaQuerySize.height*0.01,),
    Container(
          height: mediaQuerySize.height*0.06,
          width: mediaQuerySize.width*0.9,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(5)
            //color: Colors.grey.shade500,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(height: mediaQuerySize.height*0.05,
                width: mediaQuerySize.width*0.08,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Icon(Icons.arrow_forward,color: Colors.white,),
                ),
              ),
              SizedBox(width: mediaQuerySize.width*0.02,),
              Text('Login & Registeration',style: TextStyle(color: Colors.white,fontSize:14,fontWeight: FontWeight.bold),),
              SizedBox(width: mediaQuerySize.width*0.25,),
              Icon(Icons.arrow_forward,)
            ],
          ),
         ),
          
 SizedBox(height: mediaQuerySize.height*0.01,),
    Container(
          height: mediaQuerySize.height*0.06,
          width: mediaQuerySize.width*0.9,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(5)
            //color: Colors.grey.shade500,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(height: mediaQuerySize.height*0.05,
                width: mediaQuerySize.width*0.08,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Icon(Icons.arrow_forward,color: Colors.white,),
                ),
              ),
              SizedBox(width: mediaQuerySize.width*0.02,),
              Text('Login & Registeration',style: TextStyle(color: Colors.white,fontSize:14,fontWeight: FontWeight.bold),),
              SizedBox(width: mediaQuerySize.width*0.25,),
              Icon(Icons.arrow_forward,)
            ],
          ),
         ),
            
 SizedBox(height: mediaQuerySize.height*0.01,),
    Container(
          height: mediaQuerySize.height*0.06,
          width: mediaQuerySize.width*0.9,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(5)
            //color: Colors.grey.shade500,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(height: mediaQuerySize.height*0.05,
                width: mediaQuerySize.width*0.08,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Icon(Icons.arrow_forward,color: Colors.white,),
                ),
              ),
              SizedBox(width: mediaQuerySize.width*0.02,),
              Text('Login & Registeration',style: TextStyle(color: Colors.white,fontSize:14,fontWeight: FontWeight.bold),),
              SizedBox(width: mediaQuerySize.width*0.25,),
              Icon(Icons.arrow_forward,)
            ],
          ),
         ),
            SizedBox(height: mediaQuerySize.height*0.02,),


         


            ],
          ),
        ),
      ),
    );
  }
}

