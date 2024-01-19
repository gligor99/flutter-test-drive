import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_drive/helpers/snackbar_global.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration:
                  const InputDecoration(hintText: 'Enter your email ...'),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.visiblePassword,
              decoration:
                  const InputDecoration(hintText: 'Enter your password ...'),
            ),
            TextButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;

                  try {
                    final userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: email, password: password);

                    print(userCredential);
                  } on FirebaseAuthException catch (e) {
                    String errorMessage = 'An error occurred';

                    switch (e.code) {
                      case 'invalid-email':
                        errorMessage =
                            'Invalid email format. Please enter a valid email address.';
                        break;
                      case 'weak-password':
                        errorMessage = 'The password provided is too weak.';
                        break;
                      case 'email-already-in-use':
                        errorMessage =
                            'The account already exists for that email.';
                        break;
                    }

                    SnackbarGlobal.show(errorMessage);
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Text('Register')),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login/');
                },
                child: const Text('Already registered? Login here!'))
          ],
        ),
      ),
    );
  }
}
