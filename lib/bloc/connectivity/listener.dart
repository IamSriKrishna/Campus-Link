import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campuslink/bloc/connectivity/connectivity_bloc.dart';
import 'package:campuslink/bloc/connectivity/connectivity_state.dart';
import 'package:campuslink/widget/components/components.dart';

class ConnectivityListener extends StatelessWidget {
  final Widget child;

  const ConnectivityListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityBloc, ConnectivityState>(
      listener: (context, state) {
        if (state is ConnectivityOffline) {
          Components.topSnackBar(context, text: "You are offline");
        } else if (state is ConnectivityOnline) {
          Components.topSnackBar(context, text: "You are online");
        }
      },
      child: child,
    );
  }
}
