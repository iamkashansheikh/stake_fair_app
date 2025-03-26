import 'package:flutter/material.dart';

class CommonScreen extends StatelessWidget {
  const CommonScreen({super.key});

  @override
  Widget build(BuildContext context) {
  Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mediaQuery.width*0.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: mediaQuery.height*0.08,),
                Container(
                  height: mediaQuery.height*0.05,
                  width: mediaQuery.width,
                  decoration: BoxDecoration(
                    color: Colors.black
                  ),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: mediaQuery.width*0.02),
                      child: Row(
                        children: [
                          Icon(Icons.sports_cricket,color: Colors.white,size: 18,),
                          SizedBox(width: mediaQuery.width*0.02,),
                          Text('Cricket',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),)
                        ],
                      ),
                    ),
                ),
                Container(
                  height: mediaQuery.height*0.001,
                  width: mediaQuery.width,
                  decoration: BoxDecoration(
                    color: Colors.grey
                  ),
                ),
               Container(
                  height: mediaQuery.height*0.05,
                  width: mediaQuery.width,
                  decoration: BoxDecoration(
                    color: Colors.black
                  ),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: mediaQuery.width*0.02),
                      child: Row(
                        children: [
                         
                          Text('Time',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),)
                        ],
                      ),
                    ),
                ), 
                SizedBox(height: mediaQuery.height*0.02,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Today',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                  Icon(Icons.arrow_forward_ios_outlined,size: 16,)
                ],
              ),
            ),
            Divider(color: Colors.grey,),
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tomorrow',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                  Icon(Icons.arrow_forward_ios_outlined,size: 16,)
                ],
              ),
            ),
              Container(
                  height: mediaQuery.height*0.05,
                  width: mediaQuery.width,
                  decoration: BoxDecoration(
                    color: Colors.black
                  ),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: mediaQuery.width*0.02),
                      child: Row(
                        children: [
                         
                          Text('Competitions',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),)
                        ],
                      ),
                    ),
                ),
                 Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Womens Premier league',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                  Icon(Icons.arrow_forward_ios_outlined,size: 16,)
                ],
              ),
            ),
            Divider(color: Colors.grey,),
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('CSA-One Day',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                  Icon(Icons.arrow_forward_ios_outlined,size: 16,)
                ],
              ),
            ),
             Divider(color: Colors.grey,),
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Womens Premier league',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                  Icon(Icons.arrow_forward_ios_outlined,size: 16,)
                ],
              ),
            ),
            Divider(color: Colors.grey,),
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('CSA-One Day',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                  Icon(Icons.arrow_forward_ios_outlined,size: 16,)
                ],
              ),
            ),
             Divider(color: Colors.grey,),
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Womens Premier league',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                  Icon(Icons.arrow_forward_ios_outlined,size: 16,)
                ],
              ),
            ),
            Divider(color: Colors.grey,),
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('CSA-One Day',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                  Icon(Icons.arrow_forward_ios_outlined,size: 16,)
                ],
              ),
            ),
             Container(
                  height: mediaQuery.height*0.05,
                  width: mediaQuery.width,
                  decoration: BoxDecoration(
                    color: Colors.black
                  ),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: mediaQuery.width*0.02),
                      child: Row(
                        children: [
                         
                          Text('Popular Sports',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),)
                        ],
                      ),
                    ),
                ),
                  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('CSA-One Day',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                  Icon(Icons.arrow_forward_ios_outlined,size: 16,)
                ],
              ),
            ),
             Container(
                  height: mediaQuery.height*0.08,
                  width: mediaQuery.width,
                  decoration: BoxDecoration(
                    color: Colors.black
                  ),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: mediaQuery.width*0.02),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         
                          Container(
                            height: mediaQuery.height*0.05,
                            width: mediaQuery.width*0.1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.red)
                            ),
                            child: Center(child: Text('18+',style: TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.w500),)),
                          ),
                          SizedBox(width: mediaQuery.width*0.03,),
                          Text('Popular Sports',style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w500),),
                           SizedBox(width: mediaQuery.width*0.03,),
                          Container(
                            height: mediaQuery.height*0.06,
                            width: mediaQuery.width*0.35,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Center(
                              child: Text('More Details',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                            ),
                          ),
                        ],
                      ),
                    ),
                ),
                Row(
  crossAxisAlignment: CrossAxisAlignment.start, // Ensures proper alignment
  children: [
    // Text(
    //   'Warning: ',
    //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    // ),
    Expanded( // Prevents overflow issues
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: mediaQuery.width*0.04),
        child:  Text(
              "Lorem Ipsum has been the industry's"
              "standard dummy text ever since the 1500s,"
              "when an unknown printer took a galley of type and scrambled it"
              "to make a type specimen book. It has survived not only for five centuries.",
              textAlign: TextAlign.center, // Aligns text properly
              style: TextStyle(fontSize: 11),
            ),
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
}