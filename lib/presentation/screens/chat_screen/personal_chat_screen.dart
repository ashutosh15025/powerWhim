import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerwhim/constant/color_constant.dart';
import 'package:powerwhim/constant/service_api_constant.dart';
import 'package:powerwhim/constant/string_constant.dart';
import 'package:powerwhim/data/model/chats/chats_details_model.dart';
import 'package:powerwhim/data/model/chats/personal_chat_model.dart';
import 'package:powerwhim/presentation/bloc/chatbloc/chat_bloc.dart';
import 'package:powerwhim/presentation/screens/view_image_screen/view_image_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:powerwhim/presentation/widget/custom/custom_circular_loading_bar.dart';
import 'package:powerwhim/presentation/widget/error/custom_error_widget.dart';

import '../../widget/message_widget/my_message_widget.dart';
import '../../widget/message_widget/other_messages.dart';
import 'package:dospace/dospace.dart' as dospace;
import 'package:path/path.dart' as p;

class PersonalChatScreen extends StatefulWidget {
  const PersonalChatScreen(
      {super.key,
        required this.chatId,
        required this.name,
        this.previousScreen,
        this.socketId,
        this.deactivate_on});

  final String chatId;
  final String name;
  final String? previousScreen;
  final String? socketId;
  final DateTime? deactivate_on;

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
  final focusInput = FocusNode();

  int pageCount = 0;

  bool scrollLoaderVisibility = false;

  bool disableSendbutton = false;

  bool imageLoader = false;

  DateTime? deactivate_on;

  bool errorWidgetVisibility = false;

  bool endReasonWidget = false;

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    deactivate_on = widget.deactivate_on;
    initSocket();
    super.initState();
    _scrollToBottom();
  }

  void _scrollToBottom() async {
    await Future.delayed(Duration(milliseconds: 100));
  }

  initSocket() {
    socketP = IO.io(BASE_URL, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socketP?.connect();
    socketP?.onConnect((_) {
      setState(() {
        print("connection");
      });
    });
    socketP!.on('message', (data) {
      // Listen for the 'message' event
      String chatId = data['chat_id'];
      if (widget.chatId == chatId) {
        setState(() {
          imageLoader = false;
          listItem.insert(
              0,
              Message(
                  conversationMessage: data['message_text'],
                  image: data['image'],
                  createdOn: DateTime.now(),
                  userId: data['user_id']));
        });
      }
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

    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ErrorState) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: CustomErrorWidget(
              error: true,
              closeErrorWidget: () {
                setState(() {
                  BlocProvider.of<ChatBloc>(context).add(
                      GetPersonalChatEvent(chatId: widget.chatId, page: 0));
                });
              },
            ),
          );
        } else if (state is GetStartEndChatsState) {
          if (state.mssg == "Chat Activated") {
            deactivate_on = null;
          } else if (state.mssg == "Chat Deactivated") {
            deactivate_on = DateTime.now();
          }
          BlocProvider.of<ChatBloc>(context)
              .add(GetPersonalChatEvent(chatId: widget.chatId, page: 0));
          return CustomCircularLoadingBar();
        } else if (state is GetPersonalChatSuccessState) {
          print("GetPersonalChatSuccessState");
          scrollLoaderVisibility = false;
          if(socketP!.id!=null)
          BlocProvider.of<ChatBloc>(context).add(SetSocketEvent(socketP!.id!));
          listItem = state.personalChatModel.data!.messages!;
          return PopScope(
            canPop: true,
            onPopInvoked: (bool didPop) {
              if (widget.socketId != null)
                BlocProvider.of<ChatBloc>(context)
                    .add(SetSocketEvent(widget.socketId!));
              emitActiveTime(widget.chatId);
              if (widget.previousScreen == "FriendsScreen") {
                BlocProvider.of<ChatBloc>(context)
                    .add(GetFriendsEvent(USER_ID!));
              } else if (widget.previousScreen == "ChatScreen")
                BlocProvider.of<ChatBloc>(context).add(GetChatsEvent(1));
              else if (widget.previousScreen == "AllEndedChatScreen")
                BlocProvider.of<ChatBloc>(context).add(GetChatsEvent(0));
            },
            child: GestureDetector(
              onTap: (){
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                key: _key,
                drawer: Drawer(),
                appBar: AppBar(
                  leading: new IconButton(
                      icon: new Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  iconTheme: IconThemeData(
                    color: Colors.white, //change your color here
                  ),
                  actions: [
                    PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            onTap: () {
                              focusInput.unfocus();
                              if (deactivate_on == null) {
                                setState(() {
                                  onPressChatEndCancelWidget();
                                });

                              } else {
                                if (state.personalChatModel.data
                                    ?.activeChats ==
                                    true) {
                                  deactivate_on = null;
                                  BlocProvider.of<ChatBloc>(context).add(
                                      GetStartEndChatsEvent(
                                          USER_ID!, widget.chatId, 0));
                                } else {
                                  setState(() {
                                    errorWidgetVisibility =
                                    !errorWidgetVisibility;
                                  });
                                }
                              }
                            },
                            child: deactivate_on == null
                                ? Center(
                                child: Text(
                                  "End Chat",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ))
                                : Center(
                                child: Text(
                                  "Start Chat",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                )),
                          )
                        ])
                  ],
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
                body: Container(
                  height: MediaQuery.of(context).size.height,
                  color: Color.fromRGBO(0, 0, 0, .9),
                  child: Column(children: [
                    Expanded(
                      child: SingleChildScrollView(
                        reverse: true,
                        child: Stack(children: [
                          Column(
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
                                      if (i == listItem.length - 1) {}
                                      int index = i;
                                      if (USER_ID == listItem[index]!.userId)
                                        return InkWell(
                                          onTap: () {
                                            if (listItem[index]!.image !=
                                                null) {
                                              onClickImage(
                                                  listItem[index]!.image);
                                            }
                                          },
                                          child: MyMessageWidget(
                                            message: listItem[index]!
                                                .conversationMessage,
                                            time: getHours(
                                                listItem[index]!.createdOn!),
                                            image: listItem[index].image,
                                          ),
                                        );
                                      else if (listItem[index]!.userId !=
                                          null) {
                                        return InkWell(
                                          onTap: () {
                                            if (listItem[index]!.image !=
                                                null) {
                                              onClickImage(
                                                  listItem[index]!.image);
                                            }
                                          },
                                          child: OtherMessages(
                                            message: listItem[index]!
                                                .conversationMessage,
                                            time: getHours(
                                                listItem[index]!.createdOn!),
                                            image: listItem[index].image,
                                          ),
                                        );
                                      } else {
                                        return Container(
                                          margin: EdgeInsets.fromLTRB(
                                              16, 16, 16, 0),
                                          padding: EdgeInsets.all(8),
                                          constraints: BoxConstraints(
                                            maxWidth: 500,
                                          ),
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  218, 202, 58, .1),
                                              borderRadius:
                                              BorderRadius.circular(16)),
                                          alignment: Alignment.center,
                                          child: Text(
                                            listItem[index]!
                                                .conversationMessage!,
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12)),
                                          ),
                                        );
                                      }
                                    }),
                              ),
                              Container(
                                constraints: BoxConstraints(),
                                padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    file == null
                                        ? SizedBox.shrink()
                                        : InkWell(
                                      child: Icon(Icons.cancel_outlined,
                                          color: Colors.white),
                                      onTap: () async {
                                        setState(() {
                                          file!.delete();
                                          file = null;
                                        });
                                      },
                                    ),
                                    file == null
                                        ? SizedBox.shrink()
                                        : Container(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width,
                                      child: Image.file(
                                        file!,
                                        height: 200,
                                      ),
                                    ),
                                    Visibility(
                                      visible: imageLoader,
                                      child: Container(
                                        width:
                                        MediaQuery.of(context).size.width,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "sending...",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    TextField(
                                      focusNode: focusInput,
                                      controller: _controller,
                                      minLines: 1,
                                      maxLines: 3,
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
                                                child: Icon(Icons
                                                    .photo_library_sharp))),
                                        prefixIconColor: Colors.yellow,
                                        suffixIcon: InkWell(
                                          child: Icon(Icons.send),
                                          onTap: () async {

                                            if (disableSendbutton == false &&
                                                deactivate_on == null) {
                                              disableSendbutton = true;
                                              if (inputValue != null &&
                                                  inputValue!.isNotEmpty) {
                                                if (file == null) {
                                                  imageLoader = true;
                                                  socketP?.emit("message", {
                                                    "message_text":
                                                    "$inputValue",
                                                    "chat_id":
                                                    "${widget.chatId}",
                                                    "user_id": "$USER_ID"
                                                  });
                                                } else {
                                                  setState(() {
                                                    imageLoader = true;
                                                  });
                                                  await uploadfile();
                                                  socketP?.emit("message", {
                                                    "message_text":
                                                    "$inputValue",
                                                    "chat_id":
                                                    "${widget.chatId}",
                                                    "user_id": "$USER_ID",
                                                    "image":
                                                    "$uploaded_file_url"
                                                  });
                                                  await file!.delete();
                                                  file = null;
                                                }
                                              } else if (file != null) {
                                                setState(() {
                                                  imageLoader = true;
                                                });
                                                await uploadfile();
                                                socketP?.emit("message", {
                                                  "chat_id": "${widget.chatId}",
                                                  "user_id": "$USER_ID",
                                                  "image": "$uploaded_file_url"
                                                });
                                                inputValue = null;
                                                await file!.delete();
                                                file = null;
                                              }
                                              disableSendbutton = false;
                                            } else if (deactivate_on != null) {
                                              setState(() {
                                                errorWidgetVisibility =
                                                !errorWidgetVisibility;
                                                FocusScope.of(context)
                                                    .unfocus();
                                              });
                                            }
                                            _controller.clear();
                                            inputValue = null;
                                          },
                                        ),
                                        suffixIconColor: Colors.yellow,
                                        fillColor: Colors.white,
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                                color: Colors.yellow,
                                                width: 1)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                                color: Colors.yellow,
                                                width: 1)),
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
                          Visibility(
                            child: Container(
                              height: 40,
                              color: Colors.black,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.yellow,
                                ),
                              ),
                            ),
                            visible: scrollLoaderVisibility,
                          ),
                          Visibility(
                              visible: errorWidgetVisibility,
                              child: Container(
                                height: MediaQuery.of(context).size.height -
                                    MediaQuery.of(context).size.height / 4,
                                child: CustomErrorWidget(
                                  error: true,
                                  mssg:StringConstant.chatIsdiable,
                                  closeErrorWidget: closeErrorWidget,
                                ),
                              )),
                          Visibility(
                              visible: endReasonWidget,
                              child: Container(
                                color: Color.fromRGBO(255, 255, 255, .3),
                                height: MediaQuery.of(context).size.height -
                                    MediaQuery.of(context).size.height / 5,
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    constraints: BoxConstraints(
                                      maxHeight: MediaQuery.of(context)
                                          .size
                                          .height/2
                                    ),
                                    width: MediaQuery.of(context).size.width -
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: ListView.builder(
                                      itemBuilder: (context, i) {
                                        if (i == 0)
                                          return Container(
                                            padding: EdgeInsets.all(8),
                                            alignment: Alignment.centerRight,
                                            child: IconButton(
                                              icon:
                                              Icon(Icons.cancel_rounded),
                                              color: Colors.white,
                                              onPressed: () {
                                                onPressChatEndCancelWidget();
                                              },
                                            ),
                                          );
                                        else
                                          return Container(
                                            alignment: Alignment.center,
                                            child: InkWell(
                                              onTap: () {
                                                socketP?.emit("message", {
                                                  "chat_id":
                                                  "${widget.chatId}",
                                                  "message_text":
                                                  "${CHATENDREASON[i-1]}"
                                                });
                                                print(widget.chatId!+"chat id to deactivate");
                                                BlocProvider.of<ChatBloc>(
                                                    context)
                                                    .add(
                                                    GetStartEndChatsEvent(
                                                        USER_ID!,
                                                        widget.chatId,
                                                        1));
                                                deactivate_on = DateTime.now();
                                                onPressChatEndCancelWidget();
                                              },
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    2, 2, 2, 2),
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(16),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                color: Color.fromRGBO(
                                                    218, 202, 58, .2),
                                                child: Text(
                                                  CHATENDREASON[i - 1],
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          );
                                      },
                                      itemCount: CHATENDREASON.length + 1,
                                    ),
                                  ),
                                ),
                              ))
                        ]),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          );
        } else {
          return CustomCircularLoadingBar();
        }
      },
    );
  }

  void closeErrorWidget() {
    setState(() {
      FocusScope.of(context).unfocus();
      errorWidgetVisibility = !errorWidgetVisibility;
    });
  }

  String getHours(DateTime datetime) {
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
    } else {}
  }

  void onClickImage(String? imageurl) {
    if (imageurl != null) {
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
      region: dotenv.env['REGION'],
      accessKey: dotenv.env['ACCESS_KEY'],
      secretKey: dotenv.env['SECRET_KEY'],
    );
    String? project_name = dotenv.env['PROJECT_NAME'];
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
      await spaces.close();
    } catch (error) {
      print(error);
    }
  }

  void emitActiveTime(String chatId) {
    socketP?.emit("active-time", {"user_id": "$USER_ID", "chat_id": "$chatId"});
  }

  void onPressChatEndCancelWidget() {
    setState(() {
      endReasonWidget = !endReasonWidget;
      FocusScope.of(context).unfocus();
    });
  }
}
