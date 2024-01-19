import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_drive/firebase_options.dart';
import 'package:test_drive/helpers/snackbar_global.dart';

// Chapter 15 -- NEXT

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    scaffoldMessengerKey: SnackbarGlobal.key,
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      useMaterial3: true,
    ),
    home: const HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text('HomePage'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;

              // Non-Null Assertion -> user!.emailVerified
              // Null-Aware Approach
              if (user?.emailVerified ?? false) {
                print('Verified User');
              } else {
                print('Not Verified User');
              }

              return const Text('Done');
            default:
              return const Text('Loading...');
          }
        },
      ),
    );
  }
}
