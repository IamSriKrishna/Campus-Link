import 'dart:async';

import 'package:campuslink/Feature/Service/NotificationService.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:campuslink/Feature/Screen/3rdUserProfile/ThirdUserProfile.dart';
import 'package:campuslink/Feature/Screen/Messenger/messageTExtField.dart';
import 'package:campuslink/Feature/Service/Chat/MessageService.dart';
import 'package:campuslink/Model/Chat/ReceiveMessage.dart';
import 'package:campuslink/Model/Chat/sendMessage.dart';
import 'package:campuslink/Provider/StudenProvider.dart';
import 'package:campuslink/Provider/chat_provider.dart';
import 'package:campuslink/Util/util.dart';
import 'package:campuslink/Widget/Additional/CustomAppBar.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

class ChatScreen extends StatefulWidget {
  static const route = '/ChatScreen';
  const ChatScreen(
      {super.key,
      required this.title,
      required this.id,
      required this.profile,
      required this.fcmtoken,
      required this.rollno,
      required this.certified,
      required this.department,
      required this.senderName,
      required this.studentid,
      required this.user});

  final String title;
  final String department;
  final String rollno;
  final String senderName;
  final String id;
  final String fcmtoken;
  final String studentid;
  final bool certified;
  final String profile;
  final List<String> user;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isSendingMessage = false;
  final NotificationService _fcmNotification = NotificationService();
  Timer? timer;
  int offset = 1;
  IO.Socket? socket;
  Future<List<ReceivedMessge>>? msgList;
  List<ReceivedMessge> messages = [];
  TextEditingController messageController = TextEditingController();
  String receiver = '';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    getMessages(offset);
    connect();
    timer = Timer.periodic(Duration(milliseconds: 1500), (timer) {
      getMessages(offset);
      connect();
    });
    joinChat();
    handleNext();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
    super.dispose();
  }

  void getMessages(int offset) {
    msgList = MesssagingHelper.getMessages(widget.id, offset);
    setState(() {});
  }

  void handleNext() {
    _scrollController.addListener(() async {
      if (_scrollController.hasClients) {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
          if (messages.length >= 12) {
            //getMessages(offset++);
          }
        }
      }
    });
  }

  void connect() {
    var chatNotifier = Provider.of<ChatNotifier>(context, listen: false);
    socket = IO.io(uri, <String, dynamic>{
      "transports": ['websocket'],
      "autoConnect": false,
    });
    socket!.emit("setup", chatNotifier.userId);
    socket!.connect();
    socket!.onConnect((_) {
      socket!.on('online-users', (userId) {
        chatNotifier.online
            .replaceRange(0, chatNotifier.online.length, [userId]);
        chatNotifier.online == true;
      });

      socket!.on('typing', (status) {
        chatNotifier.typingStatus = true;
      });

      socket!.on('stop typing', (status) {
        chatNotifier.typingStatus = false;
      });

      socket!.on('message received', (newMessageReceived) {
        sendStopTypingEvent(widget.id);
        ReceivedMessge receivedMessge =
            ReceivedMessge.fromJson(newMessageReceived);

        if (receivedMessge.sender.id != chatNotifier.userId) {
          setState(() {
            messages.insert(0, receivedMessge);
          });
        }
      });
    });

    setState(() {});
  }

  void sendMessage(String content, String chatId, String receiver) {
    setState(() {
      _isSendingMessage = true; // Set the sending message state to true
    });
    messageController.clear();
    _fcmNotification.sendNotificationtoOne(
        widget.fcmtoken, '${widget.senderName.toLowerCase()}:$content');
    SendMessage model =
        SendMessage(content: content, chatId: chatId, receiver: receiver);

    MesssagingHelper.sendMessage(model).then((response) {
      var emmission = response[2];
      socket!.emit('new message', emmission);
      sendStopTypingEvent(widget.id);
      setState(() {
        _isSendingMessage = false;
        messages.insert(0, response[1]);
      });
    });
    setState(() {});
  }

  void sendTypingEvent(String status) {
    socket!.emit('typing', status);
  }

  void sendStopTypingEvent(String status) {
    socket!.emit('stop typing', status);
  }

  void joinChat() {
    socket!.emit('join chat', widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final my = Provider.of<StudentProvider>(context).user;
    return Consumer<ChatNotifier>(
      builder: (context, chatNotifier, child) {
        receiver = widget.user.firstWhere((id) => id != chatNotifier.userId);
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: CustomAppBar(
              text: Text(
                widget.title,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(() => ThirdUserProfile(
                              index: widget.id,
                              name: widget.title,
                              department: widget.department,
                              rollno: widget.rollno,
                              dp: widget.profile,
                              certified: widget.certified,
                              id: widget.studentid,
                              fcmtoken: widget.fcmtoken,
                              current_student_id: my.id));
                        },
                        child: Hero(
                          transitionOnUserGestures: true,
                          tag: widget.id,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(widget.profile),
                          ),
                        ),
                      ),
                      Positioned(
                          right: 3,
                          child: CircleAvatar(
                              radius: 5,
                              backgroundColor:
                                  chatNotifier.online.contains(receiver)
                                      ? Colors.green
                                      : const Color.fromARGB(255, 160, 11, 0)))
                    ],
                  ),
                )
              ],
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: !chatNotifier.typing
                      ? Colors.white
                      : Color.fromARGB(255, 127, 238, 169),
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.5),
              child: Column(
                children: [
                  Expanded(
                    child: FutureBuilder<List<ReceivedMessge>>(
                        future: msgList,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                  "Chat System Is Currently In Developing Mode :\\"),
                            );
                          } else if (snapshot.data == null) {
                            return Center(
                              child: Lottie.asset('asset/lottie/type.json',
                                  height: MediaQuery.of(context).size.height *
                                      0.06),
                            );
                          } else if (snapshot.data!.isEmpty) {
                            return const Text(
                              "You do not have message",
                              style: TextStyle(color: Colors.white),
                            );
                          } else {
                            final msgList = snapshot.data;
                            messages = msgList!;
                            return ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: messages.length,
                                reverse: true,
                                controller: _scrollController,
                                itemBuilder: (context, index) {
                                  final data = messages[index];
                                  return DelayedDisplay(
                                    delay: Duration(milliseconds: 150 * index),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 1, bottom: 1.5.h),
                                      child: ChatBubble(
                                        padding: data.sender.id !=
                                                chatNotifier.userId
                                            ? EdgeInsets.all(10)
                                            : EdgeInsets.only(
                                                left: 5,
                                                top: 5,
                                                bottom: 3.5,
                                                right: 3.5),
                                        clipper: ChatBubbleClipper5(
                                            type: data.sender.id ==
                                                    chatNotifier.userId
                                                ? BubbleType.sendBubble
                                                : BubbleType.receiverBubble),
                                        alignment: data.sender.id ==
                                                chatNotifier.userId
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        margin: EdgeInsets.only(top: 2),
                                        backGroundColor: data.sender.id !=
                                                chatNotifier.userId
                                            ? Color(0xffE7E7ED)
                                            : Color.fromARGB(
                                                255, 102, 149, 196),
                                        child: Container(
                                          constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  data.content,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: data.sender.id ==
                                                              chatNotifier
                                                                  .userId
                                                          ? Colors.white
                                                          : Colors.black),
                                                ),
                                              ),
                                              if (data.sender.id ==
                                                  chatNotifier.userId)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15.0, left: 5),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "${data.updatedAt.hour}:${data.updatedAt.minute}", // Display the sent time
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                      Icon(
                                                        Icons.done_all,
                                                        color: Colors.white,
                                                        size: 14,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }
                        }),
                  ),
                  chatNotifier.typing
                      ? Container(
                          alignment: Alignment.centerLeft,
                          width: double.infinity,
                          child: Lottie.asset('asset/lottie/type.json',
                              height:
                                  MediaQuery.of(context).size.height * 0.06),
                        )
                      : SizedBox(),
                  _isSendingMessage
                      ? Container(
                          alignment: Alignment.centerRight,
                          width: double.infinity,
                          child: Lottie.asset('asset/lottie/type.json',
                              height:
                                  MediaQuery.of(context).size.height * 0.06),
                        )
                      : SizedBox(),
                  Container(
                    padding: EdgeInsets.all(6.h),
                    alignment: Alignment.bottomCenter,
                    child: MessaginTextField(
                        onSubmitted: (_) {
                          sendMessage(
                              messageController.text, widget.id, receiver);
                        },
                        sufixIcon: IconButton(
                          onPressed: () {
                            sendMessage(
                                messageController.text, widget.id, receiver);
                          },
                          icon: Icon(
                            Icons.send,
                            size: 24,
                            color: Colors.lightBlue,
                          ),
                        ),
                        onTapOutside: (_) {
                          sendStopTypingEvent(widget.id);
                        },
                        onChanged: (_) {
                          sendTypingEvent(widget.id);
                        },
                        onEditingComplete: () {
                          sendMessage(
                              messageController.text, widget.id, receiver);
                        },
                        messageController: messageController),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
