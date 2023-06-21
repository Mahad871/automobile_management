import 'package:automobile_management/Common/constants.dart';
import 'package:automobile_management/databases/auth_methods.dart';
import 'package:automobile_management/databases/chat_api.dart';
import 'package:automobile_management/dependency_injection/injection_container.dart';
import 'package:automobile_management/enums/chat/message_type_enum.dart';
import 'package:automobile_management/function/time_date_functions.dart';
import 'package:automobile_management/models/auth_method.dart';
import 'package:automobile_management/models/chat/message_attachment.dart';
import 'package:automobile_management/models/chat/message_read_info.dart';
import 'package:automobile_management/models/user_model.dart';
import 'package:automobile_management/providers/user/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../models/chat/chat.dart';
import '../../../models/chat/message.dart';
import '../../../widgets/chat/chat_message_tile.dart';
import '../../../widgets/chat/messages_list.dart';
import '../../../widgets/chat/no_old_chat_available_widget.dart';
import '../../../widgets/custom_widgets/custom_profile_image.dart';
import '../../../widgets/custom_widgets/show_loading.dart';

class PersonalChatScreen extends StatefulWidget {
  const PersonalChatScreen({
    required this.chat,
    required this.chatWith,
    this.url,
    Key? key,
  }) : super(key: key);
  final Chat chat;
  final UserModel chatWith;
  final String? url;

  @override
  State<PersonalChatScreen> createState() => _PersonalChatScreenState();
}

class _PersonalChatScreenState extends State<PersonalChatScreen> {
  @override
  void initState() {
    super.initState();
    widget.url != null ? asd() : null;
  }

  void asd() async {
    final UserProvider userPro = sl.get<UserProvider>();
    final List<String> allUsers = widget.chat.persons;
    final String otherUID = ChatAPI.othersUID(allUsers)[0];
    final UserModel receiver = userPro.user(uid: otherUID);
    final UserModel sender = userPro.user(uid: AuthMethods.uid);
    final int time = TimeDateFunctions.timestamp;
    final Message msg = Message(
      messageID: time.toString(),
      text: 'need any help?',
      type: MessageTypeEnum.image,
      attachment: [
        MessageAttachment(url: widget.url!, type: MessageTypeEnum.image)
      ],
      sendBy: AuthMethods.uid,
      sendTo: <MessageReadInfo>[MessageReadInfo(uid: receiver.id!)],
      timestamp: time,
    );
    widget.chat.timestamp = time;
    widget.chat.lastMessage = msg;
    // _text.clear();
    await ChatAPI().sendMessage(
      chat: widget.chat,
      receiver: receiver,
      sender: sender,
    );
// sl.get<ChatAPI>().sendMessage(chat: chat, receiver: receiver, sender: sender);
  }


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
                CustomProfileImage(imageURL: widget.chatWith.photoUrl ?? ''),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.chatWith.username ?? 'no name',
                        style: const TextStyle(color: textColor),
                      ),
                      const Text(
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
                stream: ChatAPI().messages(widget.chat.chatID),
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
            ChatMessageTile(chat: widget.chat),
          ],
        ),
      ),
    );
  }
}
