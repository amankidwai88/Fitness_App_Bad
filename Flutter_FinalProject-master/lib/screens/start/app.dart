import 'package:crud/bloc/auth/authentication_bloc.dart';
import 'package:crud/bloc/bloc/firebase_user_bloc.dart';
import 'package:crud/repo/firebaseUser.dart';
import 'package:crud/repo/user_repo.dart';
import 'package:crud/screens/start/appview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainApp extends StatelessWidget {
  final UserRepository userRepository;
  const MainApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider<AuthenticationBloc>(
          create: (_) => AuthenticationBloc(myUserRepository: userRepository)),

                    BlocProvider<TodoBloc>(
            create: (context) => TodoBloc(FirestoreService()),
          ),

    ], child: const MyAppView());
  }
}
