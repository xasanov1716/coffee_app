import 'package:chandlier/data/repositories/auth_repository.dart';
import 'package:chandlier/ui/auth/auth_screen.dart';
import 'package:chandlier/ui/tab_client/tab_box_client.dart';
import 'package:chandlier/utils/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../tab_admin/tab_box.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: context.read<AuthRepository>().listenAuthState(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.data == null) {
            return const AuthScreen();
          } else {
            return snapshot.data!.email == adminEmail
                ? const TabBoxAdmin()
                : const TabBoxClient();
          }
        },
      ),
    );
  }
}
