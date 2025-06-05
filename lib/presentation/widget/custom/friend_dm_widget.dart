import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerwhim/constant/color_constant.dart';
import 'package:powerwhim/presentation/bloc/chatbloc/chat_bloc.dart';
import 'package:powerwhim/presentation/bloc/profilebloc/profilebloc_bloc.dart';

import '../../../constant/service_api_constant.dart';
import '../../screens/chat_screen/personal_chat_screen.dart';

class FriendDmWidget extends StatelessWidget {
  const FriendDmWidget({
    super.key,
    required this.name,
    required this.description,
    required this.userId,
    required this.chatId,
    this.deactivate_on,
    required this.event,
    required this.showEventWidget,
    this.profileUpdated,
    this.connectionStatus,
    this.unreadMessages,
    required this.markAsRead,
  });

  final String name;
  final String? description;
  final String userId;
  final String chatId;
  final String? event;
  final int pageCount = 0;
  final DateTime? profileUpdated;
  final String? connectionStatus;
  final Function(String, String) showEventWidget;
  final DateTime? deactivate_on;
  final String? unreadMessages;
  final Function(String chatId) markAsRead;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Name & Description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.baloo2(
                        fontSize: 18,
                        color: Colors.yellow.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (description != null)
                      Text(
                        description!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.baloo2(
                          fontSize: 12,
                          color: Colors.yellow.shade600,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              viewProfileWidget(userId: userId, profileUpdated: profileUpdated),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  markAsRead(chatId);
                  BlocProvider.of<ChatBloc>(context).add(
                    GetPersonalChatEvent(chatId: chatId, page: pageCount),
                  );
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => PersonalChatScreen(
                        chatId: chatId,
                        name: name,
                        previousScreen: "FriendsScreen",
                        deactivate_on: deactivate_on,
                        userId: userId,
                        presentInNetwork: 1,
                        connectionId: connectionStatus,
                      ),
                    ),
                  );
                },
                child: MessageIcon(
                  messageCount: int.tryParse(unreadMessages ?? '0') ?? 0,
                ),
              ),
              if (event != null) ...[
                const SizedBox(width: 8),
                InkWell(
                  onTap: () => showEventWidget(name, event!),
                  child: Icon(Icons.event, color: green),
                ),
              ],
            ],
          ),
        ),
        Divider(
          color: Colors.yellow.shade600,
          thickness: 0.5,
        ),
      ],
    );
  }
}

class viewProfileWidget extends StatelessWidget {
  const viewProfileWidget({
    super.key,
    required this.userId,
    required this.profileUpdated,
  });

  final String userId;
  final DateTime? profileUpdated;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<ChatBloc>(context).add(GetFullProfileEvent(userId));
      },
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          const Icon(Icons.visibility, color: green),
          if (profileUpdated != null)
            Positioned(
              top: -1,
              right: 0,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class MessageIcon extends StatelessWidget {
  final int messageCount;

  const MessageIcon({super.key, required this.messageCount});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        const Icon(Icons.message, color: green),
        if (messageCount > 0)
          Positioned(
            top: -3,
            right: -3,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                _formatCount(messageCount),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  String _formatCount(int count) {
    if (count > 999) return '999+';
    return count.toString();
  }
}
