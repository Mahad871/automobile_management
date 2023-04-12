import 'dart:io';
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:automobile_management/Common/constants.dart';
import 'package:automobile_management/Screens/chat_dead/widgets/data.dart';

import 'package:automobile_management/enums/message_enum.dart';
import 'package:automobile_management/providers/message_reply_provider.dart';
import 'package:automobile_management/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

import '../controller/chat_controller.dart';
import 'message_reply_preview.dart';

class BottomChatField extends ConsumerStatefulWidget {
  final String recieverUserId;
  final bool isGroupChat;
  const BottomChatField({
    Key? key,
    required this.recieverUserId,
    required this.isGroupChat,
  }) : super(key: key);

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  bool isShowSendButton = false;
  final TextEditingController _messageController = TextEditingController();
  // FlutterSoundRecorder? _soundRecorder;
  bool isRecorderInit = false;
  bool isShowEmojiContainer = false;
  bool isRecording = false;
  var unitID = 'ca-app-pub-6332643679939235/3985541531';
  var unitIDTest = 'ca-app-pub-3940256099942544/6300978111';
  FocusNode focusNode = FocusNode();

  void postApiData(String prompt, dynamic data) async {
    var url = Uri.parse("https://httpbin.org/post");
    // "https://jsonplaceholder.typicode.com/posts"
    var _payLoad = json.encode(data);
    var _header = {"content-type": "application/json"};
    Response response = await post(url, body: _payLoad, headers: _header);
    // print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint(response.body);
    } else {
      print(response.statusCode);
    }
    // final data = jsonDecode(response.body);

    // print(data);
  }

  void getApiData() async {
    var url = Uri.parse("https://httpbin.org/get");
    // "https://jsonplaceholder.typicode.com/posts"
    var _header = {
      "accept": "application/json",
    };
    Response response = await get(url, headers: _header);
    // print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint(response.body);
    } else {
      print("Get status Code:");
      print(response.statusCode);
    }
    // final data = jsonDecode(response.body);

    // print(data);
  }

  // initBannerAd() {
  //   bannerAd = BannerAd(
  //       size: AdSize.banner,
  //       adUnitId: unitIDTest,
  //       listener: BannerAdListener(
  //         onAdLoaded: (ad) {
  //           setState(() {
  //             isAdLoaded = true;
  //           });
  //         },
  //         onAdFailedToLoad: (ad, error) {
  //           ad.dispose();
  //           print(error);
  //         },
  //       ),
  //       request: const AdRequest());
  //   bannerAd.load();
  // }



  void sendTextMessage() async {
    if (isShowSendButton) {
      ref.read(chatControllerProvider).sendTextMessage(
            context,
            _messageController.text.trim(),
            widget.recieverUserId,
            widget.isGroupChat,
          );
      setState(() {
        _messageController.text = '';
      });
    } else {
      var tempDir = await getTemporaryDirectory();
      var path = '${tempDir.path}/flutter_sound.aac';
      if (!isRecorderInit) {
        return;
      }
     

      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  void sendFileMessage(
    File file,
    MessageEnum messageEnum,
  ) {
    ref.read(chatControllerProvider).sendFileMessage(
          context,
          file,
          widget.recieverUserId,
          messageEnum,
          widget.isGroupChat,
        );
  }

  void selectImage() async {
    File? image = await pickImageFromGallery(context);
    if (image != null) {
      sendFileMessage(image, MessageEnum.image);
    }
  }

  // void selectVideo() async {
  //   File? video = await pickVideoFromGallery(context);
  //   if (video != null) {
  //     sendFileMessage(video, MessageEnum.video);
  //   }
  // }

  void selectGIF() async {
    // final gif = await pickGIF(context);
    // if (gif != null) {
    //   ref.read(chatControllerProvider).sendGIFMessage(
    //         context,
    //         gif.url,
    //         widget.recieverUserId,
    //         widget.isGroupChat,
    //       );
    // }
  }

  void hideEmojiContainer() {
    setState(() {
      isShowEmojiContainer = false;
    });
  }

  void showEmojiContainer() {
    setState(() {
      isShowEmojiContainer = true;
    });
  }

  void showKeyboard() => focusNode.requestFocus();
  void hideKeyboard() => focusNode.unfocus();

  void toggleEmojiKeyboardContainer() {
    if (isShowEmojiContainer) {
      showKeyboard();
      hideEmojiContainer();
    } else {
      hideKeyboard();
      showEmojiContainer();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
    isRecorderInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final messageReply = ref.watch(messageReplyProvider);
    final isShowMessageReply = messageReply != null;
    return Column(
      children: [
        isShowMessageReply ? const MessageReplyPreview() : const SizedBox(),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                focusNode: focusNode,
                controller: _messageController,
                onChanged: (val) {
                  if (val.isNotEmpty) {
                    setState(() {
                      isShowSendButton = true;
                    });
                  } else {
                    setState(() {
                      isShowSendButton = false;
                    });
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: mobileChatBoxColor,
                  suffixIcon: SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: selectImage,
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.grey,
                          ),
                        ),
                        // IconButton(
                        //   onPressed: selectVideo,
                        //   icon: const Icon(
                        //     Icons.attach_file,
                        //     color: Colors.grey,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  hintText: 'Type a message!',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(15),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
                right: 2,
                left: 2,
              ),
              child: CircleAvatar(
                backgroundColor: const Color(0xFF128C7E),
                radius: 25,
                child: GestureDetector(
                  child: Icon(
                    isShowSendButton
                        ? Icons.send
                        : isRecording
                            ? Icons.close
                            : Icons.send,
                    color: Colors.white,
                  ),
                  onTap: () async {
                    setState(() {
                      // sendTextMessage();
                      var user = User(
                          authentication: "Bearer does-not-matter",
                          prompt: _messageController.text,
                          userId: "3");
                      postApiData(_messageController.text, user);
                      getApiData();
                      messageCount++;
                      if (messageCount == 4) {
                      }
                      if (messageCount >= 5) {
                        resetCounter();

                      }

                      print(messageCount);
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        // isShowEmojiContainer
        //     ? SizedBox(
        //         height: 310,
        //         child: EmojiPicker(
        //           onEmojiSelected: ((category, emoji) {
        //             setState(() {
        //               _messageController.text =
        //                   _messageController.text + emoji.emoji;
        //             });

        //             if (!isShowSendButton) {
        //               setState(() {
        //                 isShowSendButton = true;
        //               });
        //             }
        //           }),
        //         ),
        //       )
        //     : const SizedBox(),
        // isAdLoaded
        //     ? SizedBox(
        //         height: bannerAd.size.height.toDouble(),
        //         width: bannerAd.size.width.toDouble(),
        //         child: AdWidget(ad: bannerAd),
        //       )
        //     : SizedBox(),
      ],
    );
  }
}
