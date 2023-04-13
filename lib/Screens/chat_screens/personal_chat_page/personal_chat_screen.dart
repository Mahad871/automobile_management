import 'package:automobile_management/Common/constants.dart';
import 'package:automobile_management/databases/auth_methods.dart';
import 'package:automobile_management/databases/chat_api.dart';
import 'package:automobile_management/models/user_model.dart';
import 'package:flutter/material.dart';
import '../../../models/chat/chat.dart';
import '../../../models/chat/message.dart';
import '../../../widgets/chat/chat_message_tile.dart';
import '../../../widgets/chat/messages_list.dart';
import '../../../widgets/chat/no_old_chat_available_widget.dart';
import '../../../widgets/custom_widgets/custom_profile_image.dart';
import '../../../widgets/custom_widgets/show_loading.dart';

class PersonalChatScreen extends StatelessWidget {
  const PersonalChatScreen({
    required this.chat,
    required this.chatWith,
    Key? key,
  }) : super(key: key);
  final Chat chat;
  final UserModel chatWith;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          shadowColor: Colors.white,
          foregroundColor: textColor,
          backgroundColor: textFieldColor,
          centerTitle: false,
          title: InkWell(
            onTap: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute<OthersProfile>(
              //     builder: (BuildContext context) =>
              //         OthersProfile(user: chatWith),
              //   ),
              // );
            },
            child: Row(
              children: <Widget>[
                CustomProfileImage(imageURL: chatWith.photoUrl ?? ''),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        chatWith.username ?? 'no name',
                        style: TextStyle(color: textColor),
                      ),
                      Text(
                        'Tab here to open profile',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder<List<Message>>(
                stream: ChatAPI().messages(chat.chatID),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Message>> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Facing some error'));
                  } else if (snapshot.hasData) {
                    final List<Message> messages = snapshot.data!;
                    return messages.isEmpty
                        ? const NoOldChatAvailableWidget()
                        : MessageLists(messages: messages);
                  } else {
                    return const ShowLoading();
                  }
                },
              ),
            ),
            ChatMessageTile(chat: chat),
          ],
        ),
      ),
    );
  }
}
