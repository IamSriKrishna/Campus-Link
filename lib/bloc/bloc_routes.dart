import 'package:campuslink/bloc/event/events_bloc.dart';
import 'package:campuslink/bloc/event/events_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campuslink/app/app_controller.dart';
import 'package:campuslink/bloc/auth/auth_bloc.dart';
import 'package:campuslink/bloc/auth/auth_event.dart';
import 'package:campuslink/bloc/bottom/bottom_bloc.dart';
import 'package:campuslink/bloc/chat/chat_bloc.dart';
import 'package:campuslink/bloc/chat/chat_event.dart';
import 'package:campuslink/bloc/connectivity/connectivity_bloc.dart';
import 'package:campuslink/bloc/credit/credit_bloc.dart';
import 'package:campuslink/bloc/fcm/fcm_bloc.dart';
import 'package:campuslink/bloc/follow/follow_bloc.dart';
import 'package:campuslink/bloc/form/form_bloc.dart';
import 'package:campuslink/bloc/gate_pass/gate_pass_bloc.dart';
import 'package:campuslink/bloc/message/message_bloc.dart';
import 'package:campuslink/bloc/post/post_bloc.dart';
import 'package:campuslink/bloc/post/post_event.dart';
import 'package:campuslink/bloc/read_auth/read_auth_bloc.dart';
import 'package:campuslink/bloc/search_post/search_post_bloc.dart';
import 'package:campuslink/bloc/search_post/search_post_event.dart';
import 'package:campuslink/bloc/student/student_bloc.dart';
import 'package:campuslink/bloc/student/student_event.dart';
import 'package:campuslink/main.dart';
import 'package:campuslink/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class BlocRoute {
  static MultiBlocProvider router() {
    //Bloc
    return MultiBlocProvider(providers: [
      //get Post Data
      BlocProvider(
        create: (context) {
          final postBloc = PostBloc(AppController.postController);
          postBloc.add(ReadPostEvent());
          return postBloc;
        },
      ),
      //get Search Post Data
      BlocProvider(
        create: (context) {
          final searchBloc = SearchPostBloc(AppController.postController);
          searchBloc.add(ShuffleSearchPostEvent());
          return searchBloc;
        },
      ),
      //get Search student Data
      BlocProvider(
        create: (context) {
          final studentBloc = StudentBloc(AppController.studentController);

          studentBloc.add(
            StudentSearchEvent(name: 'sri'),
          );
          return studentBloc;
        },
      ),
      //get Event Data
      BlocProvider(
        create: (context) {
          final eventBloc = EventsBloc(AppController.eventController);

          eventBloc.add(GetEventsEvent());
          return eventBloc;
        },
      ),
      //get particular student data
      BlocProvider(
        create: (context) {
          final studentBloc = StudentBloc(AppController.studentController);

          return studentBloc;
        },
      ),
      //Login Auth
      BlocProvider(
        create: (context) {
          final authBloc = AuthBloc(AppController.authController);
          authBloc.add(GetStudentByIdEvent());
          return authBloc;
        },
      ),
      //chat bloc
      BlocProvider(
        create: (context) {
          final chatBloc = ChatBloc(AppController.chatController);
          chatBloc.add(GetChatEvent());
          return chatBloc;
        },
      ),
      //Message bloc
      BlocProvider(
          create: (context) => MessageBloc(AppController.messageController)),
      //Follow Bloc
      BlocProvider(
        create: (context) {
          final followBloc = FollowBloc(AppController.followController);
          return followBloc;
        },
      ),
      //create Form(gatepass/leave/OD)
      BlocProvider(
        create: (context) => FormBloc(AppController.formController),
      ),
      // update fcm token
      BlocProvider(
        create: (context) => FcmBloc(AppController.fcmController),
      ),
      //update credit
      BlocProvider(
        create: (context) => CreditBloc(AppController.creditController),
      ),
      //check network connection
      BlocProvider(
        create: (context) => ConnectivityBloc(),
      ),
      BlocProvider(
        create: (context) => BottomBloc(),
      ),
      BlocProvider(
        create: (context) => GatePassBloc(),
      ),
      BlocProvider(
        create: (context) => ReadAuthBloc(),
      ),
      //provider
      ChangeNotifierProvider(
        create: (context) => AuthProvider()..loadUser(),
      )
    ], child: const MyApp());
  }
}
