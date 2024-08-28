
// import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
// import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:campuslink/Provider/StudenProvider.dart';
// import 'package:campuslink/Util/util.dart';
// import 'package:provider/provider.dart';

// class KcgptChat extends StatefulWidget {

//   const KcgptChat({super.key});

//   @override
//   State<KcgptChat> createState() => _KcgptChatState();
// }

// class _KcgptChatState extends State<KcgptChat> {
//   final ChatUser kcgCHAt = ChatUser(id: '0',firstName: 'Sk',lastName: 'Chat');
//   final KcgChat = OpenAI.instance.build(
//     token: kcgSKCHAt,
//     enableLog: true,
//     baseOption: HttpSetup(
//       receiveTimeout: Duration(
//         seconds: 1,
//       ),
//     )
//   );
//   List<ChatMessage> _message = <ChatMessage>[];
//   List<ChatUser> _chatUser = <ChatUser>[];
//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<StudentProvider>(context).user;
//     final ChatUser student = ChatUser(id: user.id,firstName: user.name);
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             backgroundColor: themeColor.appThemeColor,
//             title: Text(
//               'KCGPT Chat',
//               style: GoogleFonts.merriweather(
//                 color: Colors.white
//               ),
//             ),
//           ),
//           SliverFillRemaining(
//             child: DashChat(
//               typingUsers: _chatUser,
//               currentUser: student, 
//               messageOptions: MessageOptions(
//                 containerColor: themeColor.appThemeColor
//               ),
//               onSend:(ChatMessage m) {
//                 getChatResponse(m);
//               }, 
//               messages: _message
//             ),
//           )
//         ],
//       )
//     );
//   }

//   Future<void> getChatResponse(ChatMessage m)async{
//     final user = Provider.of<StudentProvider>(context,listen: false).user;
//     final ChatUser student = ChatUser(id: user.id,firstName: user.name);
//     setState(() {
//       _message.insert(0, m);
//       _chatUser.add(kcgCHAt);
//     });
//     List<Messages> _messageHistory = _message.reversed.map((e) {
//       if(m.user == student){
//         return Messages(role: Role.user,content: m.text);
//       }else{
//         return Messages(role:Role.assistant, content: m.text);
//       }
//     }).toList();
//     final request = ChatCompleteText(
//       model: GptTurbo0301ChatModel(), 
//       messages: _messageHistory,
//       maxToken: 200
//     );

//     final response = await KcgChat.onChatCompletion(request: request,);

//     for(var element in response!.choices){
//       if(element.message != null){
//         setState(() {
//           _message.insert(
//             0, 
//             ChatMessage(
//               user: kcgCHAt, 
//               createdAt: DateTime.now(),
//               text: element.message!.content 
//             ),
            
//           );
//         });
//       }
//     }
//     setState(() {
//       _chatUser.remove(kcgCHAt);
//     });
//   }
// }