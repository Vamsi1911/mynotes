// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify here'),
      ),
      body: Column(
        children: [
          const Text(
              "We've sent a verification email verification please open it to verify your account"),
          const Text(
              "If you haven't received a email yet, press the button below"),
          TextButton(
              onPressed: () async {
                AuthService.firebase().sendEmailVerification();
              },
              child: const Text('Send email Verification')),
          // TextButton(
          //     onPressed: () async {
          //       Navigator.of(context)
          //           .pushNamedAndRemoveUntil(loginRoute, (route) => false);
          //     },
          //     child: const Text('Verified?')),
          TextButton(
              onPressed: () async {
                AuthService.firebase().logOut();
                if (!context.mounted) return;
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(registerRoute, (route) => false);
              },
              child: const Text('Restart'))
        ],
      ),
    );
  }
}
