import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campuslink/bloc/auth/auth_bloc.dart';
import 'package:campuslink/bloc/auth/auth_state.dart';
import 'package:campuslink/handler/auth/auth_bloc_handler.dart';
import 'package:campuslink/widget/auth/auth_widget.dart';
import 'package:campuslink/widget/components/components.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          AuthBlocHandler.handleAuthState(context, state);
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Stack(
              children: [
                CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    AuthWidget.appBar(),
                    AuthWidget.topContent(),
                    AuthWidget.welcomeContent(),
                    AuthWidget.authField(),
                    AuthWidget.forgetPassword(context),
                    AuthWidget.submit(context),
                    AuthWidget.credit()
                  ],
                ),
                if (state is LoadingAuthState) Components.blurBackground(),
              ],
            );
          },
        ),
      ),
    );
  }
}
