import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widget/onboard_pageview.dart';
import 'authScreen/auth_screen.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  int currentPage=0;
  final controller = PageController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AppName"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.only(bottom: 150),
        child: PageView(
          controller: controller,
          children: [
            Container(
              child: onBoardPageView(),
            ),
            Container(
              child: onBoardPageView(),
            ),
            Container(
              child: onBoardPageView(),
            )
          ],
          onPageChanged: (int page) {
            print(page.toString());
            currentPage = page + 1;
          },


        ),
      ),
      bottomSheet: Container(
        height: 150,
        color: Colors.black,
        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Column(
          children: [
            Center(child:
            SmoothPageIndicator(controller: controller, count: 3,effect: ExpandingDotsEffect(
                dotColor:  Colors.yellowAccent,
                activeDotColor:  Colors.green,
                dotWidth: 12,
                dotHeight: 12
            ),),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.all(16.0),

                child: Text("Skip",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w900
                  ),
                ),
              ),InkWell(
                onTap: (){
                  if(currentPage==3){
                   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> const AuthScreen()));
                    
                  }
                  else{
                  controller.animateToPage(
                    currentPage+1,
                    duration: Duration(milliseconds: 500), // Adjust animation duration
                    curve: Curves.easeInOut, // Adjust animation curve
                  );
                  }

                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.green.shade800
                  ),
                  child: Icon(Icons.arrow_right_alt_outlined,color: Colors.white,),
                ),
              )
              ],
            ),
          ],
        ),

      ),
    );
  }
}
