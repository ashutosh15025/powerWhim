import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerwhim/presentation/screens/add_profile_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constant/service_api_constant.dart';
import '../widget/onboard_pageview.dart';
import 'authScreen/auth_screen.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  int currentPage = 0;
  final controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          color: Color.fromRGBO(0, 0, 0, 1),
          padding: EdgeInsets.only(bottom: 0),
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
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 150,
            color: Color.fromRGBO(0, 0, 0, 0),
            child: Column(
              children: [
                Center(
                  child: SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: ExpandingDotsEffect(
                        dotColor: Colors.yellowAccent.shade700,
                        activeDotColor: green,
                        dotWidth: 12,
                        dotHeight: 12),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Skip",
                          style: GoogleFonts.baloo2(
                              textStyle: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)),
                          textAlign: TextAlign.center,
                        )),
                    InkWell(
                      onTap: () {
                        if (currentPage == 3) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (_) => const AuthScreen()));
                        } else {
                          controller.animateToPage(
                            currentPage + 1,
                            duration: Duration(milliseconds: 500),
                            // Adjust animation duration
                            curve: Curves.easeInOut, // Adjust animation curve
                          );
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                         margin: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: green),
                        child: Icon(
                          Icons.arrow_forward_outlined,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
