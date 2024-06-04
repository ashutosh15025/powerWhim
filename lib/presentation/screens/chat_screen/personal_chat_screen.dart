import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerwhim/constant/service_api_constant.dart';
import 'package:powerwhim/data/model/chats/personal_chat_model.dart';
import 'package:powerwhim/presentation/bloc/chatbloc/chat_bloc.dart';
import 'package:powerwhim/presentation/screens/view_image_screen/view_image_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:powerwhim/presentation/widget/custom/custom_circular_loading_bar.dart';
import 'package:powerwhim/presentation/widget/error/custom_error_widget.dart';

import '../../widget/message_widget/my_message_widget.dart';
import '../../widget/message_widget/other_messages.dart';
import 'package:dospace/dospace.dart' as dospace;
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

class PersonalChatScreen extends StatefulWidget {
  const PersonalChatScreen(
      {super.key,
      required this.chatId,
      required this.name,
      this.previousScreen, this.socketId});

  final String chatId;
  final String name;
  final String? previousScreen;
  final String? socketId;




  @override
  State<PersonalChatScreen> createState() => _PersonalChatScreenState();
}

class _PersonalChatScreenState extends State<PersonalChatScreen> {
  List<Message> listItem = [];
  List<Message> traceList = [];
  IO.Socket? socketP;
  File? file;
  String? inputValue;
  bool showImage = false;
  String? image = "https://whim.ams3.digitaloceanspaces.com/whim/Testimage.jpg";
  String? uploaded_file_url;
  final TextEditingController _controller = new TextEditingController();

  int pageCount = 0;

  bool scrollLoaderVisibility = false;


  bool disableSendbutton = false;

  bool imageLoader = false;


  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    initSocket();
    super.initState();
    _scrollToBottom();
  }

  void _scrollToBottom() async {
    // Wait for the ListView to build (optional, adjust based on your needs)
    await Future.delayed(Duration(milliseconds: 100));
    // _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  initSocket() {
    print("in init ");
    socketP = IO.io(BASE_URL, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socketP?.connect();
    socketP?.onConnect((_) {
      print('Connection established');
      setState(() {});
    });
    socketP!.on('message', (data) {
      // Listen for the 'message' event
      print("message new is"+data['message_text'].toString());
      String chatId = data['chat_id'];
      print("chatId"+chatId.toString());
      if (widget.chatId == chatId) {
        setState(() {
          imageLoader =false;
          listItem.insert(0,Message(
              conversationMessage: data['message_text'],
              image: data['image'],
              createdOn: DateTime.now(),
              userId: data['user_id']));
        });
      }
      print('Received message dataaaaa: $data'); // Print "hi" on receiving a message
    });

    socketP?.onDisconnect((_) => print('Connection Disconnection'));
    socketP?.onConnectError((err) => print(err));
    socketP?.onError((err) => print(err));
  }

  @override
  void dispose() {
    socketP!.dispose();
    super.dispose();
  }

// This is what you're looking for!

  @override
  Widget build(BuildContext context) {
    if (socketP != null && socketP!.id != null) {
      BlocProvider.of<ChatBloc>(context).add(SetSocketEvent(socketP!.id!));
    }


    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {},
      builder: (context, state) {
        print(state.toString());
        print("build");
        if (state is ErrorState) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: CustomErrorWidget(
              error: true,
              closeErrorWidget: () {
                setState(() {
                  BlocProvider.of<ChatBloc>(context)
                      .add(GetPersonalChatEvent(chatId:widget.chatId,page:0));
                  print("errorrr");
                });
              },
            ),
          );
        } else if (state is GetPersonalChatSuccessState) {
          scrollLoaderVisibility = false;
          print("ashes");
          print(state.personalChatModel.data!.messages!.length.toString()+"state");
          listItem=state.personalChatModel.data!.messages!;
          print("list"+listItem.length.toString());
          return PopScope(
            canPop: true,
            onPopInvoked: (bool didPop) {
              if( widget.socketId!=null)
                BlocProvider.of<ChatBloc>(context).add(SetSocketEvent(widget.socketId!));

              socketP?.emit("active-time",
                  {"user_id": "$USER_ID", "chat_id": "${widget.chatId}"});
              if (widget.previousScreen == "FriendsScreen") {
                BlocProvider.of<ChatBloc>(context)
                    .add(GetFriendsEvent(USER_ID!));
              } else if (widget.previousScreen == "ChatScreen")
                BlocProvider.of<ChatBloc>(context).add(GetChatsEvent());
            },
            child: Scaffold(
              appBar: AppBar(
                leading: new IconButton(
                    icon: new Icon(Icons.arrow_back),
                    onPressed: () {
                      if( widget.socketId!=null)
                        BlocProvider.of<ChatBloc>(context).add(SetSocketEvent(widget.socketId!));
                      socketP?.emit("active-time", {
                        "user_id": "$USER_ID",
                        "chat_id": "${widget.chatId}"
                      });
                      if (widget.previousScreen == "FriendsScreen") {
                        BlocProvider.of<ChatBloc>(context)
                            .add(GetFriendsEvent(USER_ID!));
                      } else if (widget.previousScreen == "ChatScreen")
                        BlocProvider.of<ChatBloc>(context).add(GetChatsEvent());
                      Navigator.pop(context, true);
                    }),
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
                centerTitle: true,
                title: Text(
                  widget.name,
                  style: GoogleFonts.baloo2(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.white)),
                ),
                backgroundColor: Colors.black,
              ),
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  color: Color.fromRGBO(0, 0, 0, .9),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          reverse: true,
                          child: Stack(
                            children:[Column(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height -
                                      MediaQuery.of(context).size.height / 5 -
                                      MediaQuery.of(context).viewInsets.bottom,
                                  child: ListView.builder(
                                      controller: _scrollController,
                                      reverse: true,
                                      itemCount: listItem.length,
                                      itemBuilder: (context, i) {
                                        if(i==listItem.length-1){
                                          print("top");
                                        }
                                        int index =i; if (USER_ID == listItem[index]!.userId)
                                          return InkWell(
                                            onTap: () {
                                              if (listItem[index]!.image !=
                                                  null) {
                                                onClickImage(listItem[index]!.image);
                                              }
                                            },
                                            child: MyMessageWidget(
                                              message: listItem[index]!
                                                  .conversationMessage,
                                              time: getHours(listItem[index]!
                                                  .createdOn!),
                                              image:  listItem[index].image,
                                            ),
                                          );
                                        else
                                          return InkWell(
                                            onTap: () {
                                              if (listItem[index]!.image !=
                                                  null) {
                                                onClickImage(listItem[index]!.image);
                                              }
                                            },
                                            child: OtherMessages(
                                              message: listItem[index]!
                                                  .conversationMessage,
                                              time: getHours(listItem[index]!
                                                  .createdOn!),
                                              image: listItem[index].image,
                                            ),
                                          );

                                      }),



                                ),
                                Container(
                                  constraints: BoxConstraints(
                                  ),
                                  padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      file==null?SizedBox.shrink():InkWell(
                                        child: Icon(Icons.cancel_outlined,color:Colors.white),
                                        onTap: () async {
                                          setState(() {
                                            file!.delete();
                                            file = null;
                                          });
                                        },),

                                      file==null?SizedBox.shrink():Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: Image.file(
                                          file!,
                                          height: 200,
                                        ),
                                      ),
                                      Visibility(
                                        visible: imageLoader,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          alignment: Alignment.center,
                                            child: Text("sending...",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white
                                            ),),
                                        ),
                                      ),
                                      TextField(
                                        controller: _controller,
                                        cursorColor: Colors.yellow.shade600,
                                        onChanged: (value) {
                                          inputValue = value;
                                        },
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          prefixIcon: InkWell(
                                              onTap: () {},
                                              child: InkWell(
                                                  onTap: () {
                                                    openImagePicker();
                                                  },
                                                  child: Icon(
                                                      Icons.photo_library_sharp))),
                                          prefixIconColor: Colors.yellow,
                                          suffixIcon: InkWell(
                                            child: Icon(Icons.send),
                                            onTap: () async {
                                              if(disableSendbutton == false){
                                                disableSendbutton = true;

                                                print(DateTime.now());
                                              print("sent");
                                              if (inputValue != null &&
                                                  inputValue!.isNotEmpty) {
                                                if (file == null) {
                                                  imageLoader  = true;
                                                  print("input not null");

                                                  print("input non empty");
                                                  socketP?.emit("message", {
                                                    "message_text": "$inputValue",
                                                    "chat_id": "${widget.chatId}",
                                                    "user_id": "$USER_ID"
                                                  });

                                                } else {
                                                  setState(() {
                                                    imageLoader=true;
                                                  });
                                                  await uploadfile();
                                                  print(uploaded_file_url);
                                                  socketP?.emit("message", {
                                                    "message_text": "$inputValue",
                                                    "chat_id": "${widget.chatId}",
                                                    "user_id": "$USER_ID",
                                                    "image": "$uploaded_file_url"
                                                  });
                                                  await file!.delete();
                                                  file = null;

                                                }
                                              } else if (file != null) {
                                                print("file not null");
                                                setState(() {
                                                  imageLoader=true;
                                                });
                                                await uploadfile();
                                                print(uploaded_file_url);
                                                socketP?.emit("message", {
                                                  "chat_id": "${widget.chatId}",
                                                  "user_id": "$USER_ID",
                                                  "image": "$uploaded_file_url"
                                                });
                                                inputValue=null;
                                                await file!.delete();
                                                file = null;
                                              }
                                                disableSendbutton = false;

                                              }
                                              _controller.clear();
                                              inputValue = null;

                                              },
                                          ),
                                          suffixIconColor: Colors.yellow,
                                          fillColor: Colors.white,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30),
                                              borderSide: BorderSide(
                                                  color: Colors.yellow, width: 1)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30),
                                              borderSide: BorderSide(
                                                  color: Colors.yellow, width: 1)),
                                          hintText: "type here",
                                          hintStyle: GoogleFonts.baloo2(
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                              Visibility(child: Container(
                                height: 40,
                                color: Colors.black,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.yellow,
                                  ),
                                ),
                              ),
                                visible: scrollLoaderVisibility,
                              ),]
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else
          return CustomCircularLoadingBar();
      },
    );
  }

  String getHours(DateTime datetime) {
    print(datetime);
    var localTIme = datetime.toLocal();
    String formattedTime = localTIme.toString();
    List<String> parts = formattedTime.split(' ');
    String time = parts[1];
    int hour = int.parse(time.substring(0, 2));
    int minute = int.parse(time.substring(3, 5));
    String amPm = hour < 12 ? "AM" : "PM";
    hour = hour %
        12; // Adjust hour for 12-hour format (12 becomes 12, 13 becomes 1)
    String extractedTime =
        "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $amPm";
    return extractedTime; // Output: 12:08 PM
  }

  void openImagePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (result != null) {
      setState(() {
        file = File(result.files.single.path!);
      });
      print("we get file");
    } else {}
  }


  void onClickImage(String ? imageurl) {
    print("clicked image");
    if(imageurl!=null) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => ViewImageScreen(image: imageurl!)));
    }
  }

  String removeChars(String text, String charsToRemove) {
    final newString = StringBuffer();
    for (final char in text.runes) {
      if (!charsToRemove.contains(String.fromCharCode(char))) {
        newString.write(String.fromCharCode(char));
      }
    }
    return newString.toString();
  }

  Future<void> uploadfile() async {
    dospace.Spaces spaces = new dospace.Spaces(
      //change with your project's region
      region: "ams3",
      //change with your project's accessKey
      accessKey: "DO003CPQUP4NKAVJ362N",
      //change with your project's secretKey
      secretKey: "k2djROfqM4o9Lc01EzUHCdobFTi+OxLyCwJCb44KNvI",
    );

    //change with your project's name
    String project_name = "whim";
    //change with your project's region
    String region = "ams3";
    //change with your project's folder
    String folder_name = "whim";
    String file_name = file!.path.split('/').last;
    String time = DateTime.now().toString();
    String charsToRemove = "-.: ";
    String result1 = removeChars(time, charsToRemove);
    try {
      String? etag = await spaces.bucket(project_name).uploadFile(
          USER_ID! + '/' + result1 + '/' + file_name,
          file,
          p.extension(file!.path),
          dospace.Permissions.public);
    uploaded_file_url = USER_ID! + '/' + result1 + '/' + file_name;
      print("https://whim.ams3.digitaloceanspaces.com/"+USER_ID! + '/' + result1 + '/' + file_name);
      await spaces.close();
    } catch (error) {
      print(error);
    }
  }
}
