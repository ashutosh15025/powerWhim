import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerwhim/constant/service_api_constant.dart';
import 'package:powerwhim/constant/string_constant.dart';
import 'package:powerwhim/data/model/chats/personal_chat_model.dart';
import 'package:powerwhim/presentation/bloc/chatbloc/personal_chat_bloc.dart';
import 'package:powerwhim/presentation/screens/view_image_screen/view_image_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:powerwhim/presentation/widget/custom/custom_circular_loading_bar.dart';
import 'package:powerwhim/presentation/widget/error/custom_error_widget.dart';
import '../../../constant/color_constant.dart';
import '../../../constant/full_profile_privious_screen.dart';
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
      this.userId,
      this.deactivate_on,
      this.presentInNetwork,
      this.connectionId});

  final String chatId;
  final String name;
  final String? userId;
  final String? previousScreen;
  final String? socketId;
  final DateTime? deactivate_on;
  final int? presentInNetwork;
  final String? connectionId;

  @override
  State<PersonalChatScreen> createState() => _PersonalChatScreenState();
}

class _PersonalChatScreenState extends State<PersonalChatScreen> {
  List<Message> listItem = [];
  IO.Socket? socketP;
  File? file;
  String? inputValue;
  bool showImage = false;
  int totalPage = 0;
  String? image = "https://whim.ams3.digitaloceanspaces.com/whim/Testimage.jpg";
  String? uploaded_file_url;
  final TextEditingController _controller = new TextEditingController();
  final focusInput = FocusNode();
  int page = 0;
  bool scrollLoaderVisibility = false;
  bool disableSendbutton = false;
  bool imageLoader = false;
  DateTime? deactivate_on;
  bool errorWidgetVisibility = false;
  bool endReasonWidget = false;
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  final ScrollController _scrollController = ScrollController();
  String previousScoketId = "";
  String? connectionId;
  int myTotalMessage = 0;
  int addNetworkStatus = 0;

  double? _scrollOffsetBeforeUpdate;
  void _restoreScrollPosition() {
    if (_scrollOffsetBeforeUpdate != null && _scrollController.hasClients) {
      _scrollController.jumpTo(_scrollOffsetBeforeUpdate!);
      _scrollOffsetBeforeUpdate = null; // Reset after use
    }
  }

  bool block = false;

  @override
  void initState() {
    deactivate_on = widget.deactivate_on;
    connectionId = widget.connectionId;
    listItem = [];
    myTotalMessage = 0;
    if( widget.presentInNetwork!=null)
    addNetworkStatus = widget.presentInNetwork!;
    else
      addNetworkStatus = 0;
    initSocket();
    getChat();
    _scrollController.addListener(_onScroll);
    super.initState();
    _scrollToBottom();
  }

  void getChat() {
    BlocProvider.of<PersonalChatBloc>(context)
        .add(GetPersonalChatEvent(chatId: widget.chatId, page: 0));
  }

  void _scrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  void _onScroll() {
    if (_scrollController.position.atEdge) {
      bool isTop = _scrollController.position.pixels == 0;
      if (!isTop && totalPage > page) {
        page++;
        BlocProvider.of<PersonalChatBloc>(context)
            .add(GetPersonalChatEvent(chatId: widget.chatId, page: page));
      }
    }
  }

  initSocket() {
    socketP = IO.io(BASE_URL, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socketP?.connect();
    socketP?.onConnect((_) {
      setState(() {});
    });
    socketP!.on('message', (data) {
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

    socketP?.onDisconnect((_) => {});
    socketP?.onConnectError((err) => {});
    socketP?.onError((err) => {});
  }

  @override
  void dispose() {
    listItem = [];
    socketP!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonalChatBloc, PersonalChatState>(
      buildWhen: (previous, current) {
        if (current is getFullProfileSuccessState) {
          return false;
        } else {
          return true;
        }
      },
      listener: (context, state) {
        if (state is getFullProfileSuccessState) {

            Navigator.of(context).pushNamed('/profile',
                arguments: FullProfilePriviousScreen(
                    state.fullProfile, 'viewProfile'));
        }
      },
      builder: (context, state) {
        if (state is ErrorState) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: CustomErrorWidget(
                error: true,
                closeErrorWidget: () {
                  setState(() {
                    BlocProvider.of<PersonalChatBloc>(context).add(
                        GetPersonalChatEvent(chatId: widget.chatId, page: 0));
                  });
                },
              ),
            ),
          );
        } else if (state is GetStartEndChatsState) {
          if (state.mssg == "Chat Activated") {
            deactivate_on = null;
          } else if (state.mssg == "Chat Deactivated") {
            deactivate_on = DateTime.now();
          } else if (state.mssg == "Added to Network") {
            addNetworkStatus = 1;
            deactivate_on = null;
            connectionId = USER_ID;
          } else if (state.mssg == "Remove from network") {
            deactivate_on = DateTime.now();
            connectionId = null;
          }
          BlocProvider.of<PersonalChatBloc>(context)
              .add(GetPersonalChatEvent(chatId: widget.chatId, page: 0));
          return const CustomCircularLoadingBar();
        } else if (state is GetPersonalChatSuccessState) {
          totalPage = state.personalChatModel.data?.total ?? 1;
          scrollLoaderVisibility = false;
          WidgetsBinding.instance
              .addPostFrameCallback((_) => _restoreScrollPosition());
          if (myTotalMessage <=
              (state.personalChatModel.data?.addNetwork?.count ?? 0)) {
            myTotalMessage =
                state.personalChatModel.data?.addNetwork?.count ?? 0;
          }
          addNetworkStatus =
              state.personalChatModel.data?.addNetwork?.status ?? 0;

          if (socketP!.id != null && previousScoketId != socketP!.id) {
            previousScoketId = socketP!.id!;
            BlocProvider.of<PersonalChatBloc>(context)
                .add(SetSocketEvent(socketP!.id!));
          }
          listItem =
              BlocProvider.of<PersonalChatBloc>(context).personalChatList;
          return PopScope(
            canPop: true,
            onPopInvokedWithResult: (bool didPop, Object? result) {
              if (didPop) {
                final socketId = widget.socketId;
                final chatId = widget.chatId;
                final chatBloc = BlocProvider.of<PersonalChatBloc>(context);
                if (socketId != null) {
                  chatBloc.add(SetSocketEvent(socketId));
                }
                emitActiveTime(chatId);
              }
            },
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                key: _key,
                drawer: const Drawer(),
                appBar: AppBar(
                  leading: new IconButton(
                      icon: new Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  iconTheme: const IconThemeData(
                    color: Colors.white, //change your color here
                  ),
                  actions: [
                    PopupMenuButton(
                      offset: const Offset(0, kToolbarHeight),
                      color: Colors.grey.shade600,
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          height: 36, // Reduce item height
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: GestureDetector(
                            onTap: () {
                              if (deactivate_on == null) {
                                deactivate_on = null;
                                block = true;
                                onPressChatEndCancelWidget();
                              } else {
                                BlocProvider.of<PersonalChatBloc>(context).add(
                                    GetStartEndChatsEvent(
                                        USER_ID!, widget.chatId, 0,
                                        block: 0));
                              }
                              Navigator.pop(context);
                            },
                            child: Text(
                              deactivate_on == null ? "Block" : "Start Chat",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          height: 36,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          onTap: () {
                            focusInput.unfocus();
                            if (connectionId != null) {
                              setState(() {
                                block = false;
                                onPressChatEndCancelWidget();
                              });
                            } else {
                              if (state.personalChatModel.data?.activeChats ==
                                  true) {
                                deactivate_on = null;
                                BlocProvider.of<PersonalChatBloc>(context).add(
                                    GetStartEndChatsEvent(
                                        USER_ID!, widget.chatId, 0,
                                        startChat: 1));
                              } else {
                                setState(() {
                                  errorWidgetVisibility =
                                      !errorWidgetVisibility;
                                });
                              }
                            }
                          },
                          child: Text(
                            connectionId != null
                                ? "End Chat"
                                : "Add To Network",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          height: 36,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          onTap: () {
                            focusInput.unfocus();
                            BlocProvider.of<PersonalChatBloc>(context)
                                .add(getFullProfileEvent(widget.userId!));
                          },
                          child: Text(
                            "View Profile",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                  centerTitle: true,
                  title: Text(
                    widget.name,
                    style: GoogleFonts.baloo2(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.white)),
                  ),
                  backgroundColor: Colors.black,
                ),
                body: Container(
                  height: MediaQuery.of(context).size.height,
                  color: const Color.fromRGBO(0, 0, 0, .9),
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
                                      if (USER_ID == listItem[index].userId) {
                                        return InkWell(
                                          onTap: () {
                                            if (listItem[index].image !=
                                                null) {
                                              onClickImage(
                                                  listItem[index].image);
                                            }
                                          },
                                          child: MyMessageWidget(
                                            message: listItem[index]
                                                .conversationMessage,
                                            time: getHours(
                                                listItem[index].createdOn!),
                                            image: listItem[index].image,
                                          ),
                                        );
                                      } else if (listItem[index].userId !=
                                          null) {
                                        return InkWell(
                                          onTap: () {
                                            if (listItem[index].image !=
                                                null) {
                                              onClickImage(
                                                  listItem[index].image);
                                            }
                                          },
                                          child: OtherMessages(
                                            message: listItem[index]
                                                .conversationMessage,
                                            time: getHours(
                                                listItem[index].createdOn!),
                                            image: listItem[index].image,
                                          ),
                                        );
                                      } else {
                                        return Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              16, 16, 16, 0),
                                          padding: const EdgeInsets.all(8),
                                          constraints: const BoxConstraints(
                                            maxWidth: 500,
                                          ),
                                          decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  218, 202, 58, .1),
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          alignment: Alignment.center,
                                          child: Text(
                                            listItem[index]
                                                .conversationMessage!,
                                            style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12)),
                                          ),
                                        );
                                      }
                                    }),
                              ),
                              Container(
                                constraints: const BoxConstraints(),
                                padding:
                                    const EdgeInsets.fromLTRB(8, 16, 8, 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    file == null
                                        ? const SizedBox.shrink()
                                        : InkWell(
                                            child: const Icon(
                                                Icons.cancel_outlined,
                                                color: Colors.white),
                                            onTap: () async {
                                              setState(() {
                                                file!.delete();
                                                file = null;
                                              });
                                            },
                                          ),
                                    file == null
                                        ? const SizedBox.shrink()
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
                                        child: const Text(
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
                                      cursorColor: themeColorLight,
                                      onChanged: (value) {
                                        inputValue = value;
                                      },
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        prefixIcon: InkWell(
                                            onTap: () {},
                                            child: InkWell(
                                                onTap: () {
                                                  openImagePicker();
                                                },
                                                child: const Icon(Icons
                                                    .photo_library_sharp))),
                                        prefixIconColor: themeColorLight,
                                        suffixIcon: InkWell(
                                          child: const Icon(Icons.send),
                                          onTap: () async {
                                            myTotalMessage++;
                                            if (addNetworkStatus == 0 &&
                                                myTotalMessage == 5) {
                                                  await showDialog<bool>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        Colors.black87,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16)),
                                                    title: const Text(
                                                      "Looks like you're getting along!",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    content: const Text(
                                                      "You’ve exchanged 5 messages with this user. Would you like to add them to your network to continue the conversation?",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white70),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        child: const Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white60)),
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(false),
                                                      ),
                                                      TextButton(
                                                        child: const Text(
                                                            "Add to Network",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .yellow)),
                                                        onPressed: () {
                                                          BlocProvider.of<
                                                                      PersonalChatBloc>(
                                                                  context)
                                                              .add(
                                                            GetStartEndChatsEvent(
                                                                USER_ID!,
                                                                widget.chatId,
                                                                0,
                                                                startChat: 1),
                                                          );
                                                          Navigator.of(context).pop(
                                                              true); // Signal to proceed
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            }

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
                                        suffixIconColor: themeColorLight,
                                        fillColor: Colors.white,
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                                color: themeColorLight,
                                                width: 1)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                                color: themeColorLight,
                                                width: 1)),
                                        hintText: "type here",
                                        hintStyle: GoogleFonts.baloo2(
                                          textStyle: const TextStyle(
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
                            visible: scrollLoaderVisibility,
                            child: Container(
                              height: 40,
                              color: Colors.black,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: themeColorLight,
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                              visible: errorWidgetVisibility,
                              child: Container(
                                height: MediaQuery.of(context).size.height -
                                    MediaQuery.of(context).size.height / 4,
                                child: CustomErrorWidget(
                                  error: true,
                                  mssg: StringConstant.chatIsdiable,
                                  closeErrorWidget: closeErrorWidget,
                                ),
                              )),
                          Visibility(
                              visible: endReasonWidget,
                              child: Container(
                                color: const Color.fromRGBO(255, 255, 255, .3),
                                height: MediaQuery.of(context).size.height -
                                    MediaQuery.of(context).size.height / 5,
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    constraints: BoxConstraints(
                                        maxHeight:
                                            MediaQuery.of(context).size.height /
                                                2),
                                    width: MediaQuery.of(context).size.width -
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(0, 0, 0, 1),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: ListView.builder(
                                      itemBuilder: (context, i) {
                                        if (i == 0) {
                                          return Container(
                                            padding: const EdgeInsets.all(8),
                                            alignment: Alignment.centerRight,
                                            child: IconButton(
                                              icon: const Icon(
                                                  Icons.cancel_rounded),
                                              color: Colors.white,
                                              onPressed: () {
                                                onPressChatEndCancelWidget();
                                              },
                                            ),
                                          );
                                        } else {
                                          return Container(
                                            alignment: Alignment.center,
                                            child: InkWell(
                                              onTap: () {
                                                socketP?.emit("message", {
                                                  "chat_id": "${widget.chatId}",
                                                  "message_text":
                                                      "${CHATENDREASON[i - 1]}"
                                                });
                                                if (block == false) {
                                                  BlocProvider.of<
                                                              PersonalChatBloc>(
                                                          context)
                                                      .add(
                                                          GetStartEndChatsEvent(
                                                              USER_ID!,
                                                              widget.chatId,
                                                              1));
                                                } else {
                                                  BlocProvider.of<
                                                              PersonalChatBloc>(
                                                          context)
                                                      .add(
                                                          GetStartEndChatsEvent(
                                                              USER_ID!,
                                                              widget.chatId,
                                                              0,
                                                              block: 1));
                                                }
                                                deactivate_on = DateTime.now();
                                                onPressChatEndCancelWidget();
                                              },
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        2, 2, 2, 2),
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.all(16),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                color: const Color.fromRGBO(
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
                                        }
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
          return const CustomCircularLoadingBar();
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
        12;
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
          MaterialPageRoute(builder: (_) => ViewImageScreen(image: imageurl)));
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
    } catch (error) {}
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
