import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class onBoardPageView extends StatelessWidget {
  const onBoardPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height/2,
          child: Center(
            child: Container(
              height: 200,
              child: Image.network("https://images.unsplash.com/photo-1591154669695-5f2a8d20c089?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8dXJsfGVufDB8fDB8fHww"),
            ),
          ),
        ),
        Text("here title of page view come here title of page view come here title of page view come",
                style: TextStyle(
                fontSize: 18,
                    color: Colors.white,
                fontWeight: FontWeight.w900
                ),
              textAlign: TextAlign.center,
            ),Text("Skip",
          style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w900
          ),
        ), Text("")
      ],
    );
  }
}
