import 'package:flutter/cupertino.dart';
import 'package:powerwhim/presentation/widget/custom/friend_dm_widget.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> listItem =["ashes","ashes","ashes","ashes","ashes","ashes","ashes","ashes","ashes","ashes","ashes","ashes","ashes","ashes","ashes"];
    return  Container(
      color: Color.fromRGBO(0, 0, 0, .99),
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 0,
        child: ListView.builder(
          itemCount: listItem.length,
          itemBuilder: (context,index){
            return FriendDmWidget();
          },),
      ),
    );
  }
}
