import 'package:flutter/material.dart';
import 'package:mydigiceipts_flutter/providers/authentication_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/signup/signup_form.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
    bool isLoading = false;

    Future<void> onSendForm(Map<String,String> formData) async {
      if (formData.isNotEmpty) {
        await Provider.of<AuthenticationProvider>(context, listen: false).signup(formData);
      }
  }

  @override
  Widget build(BuildContext context) {
    print(context.read<AuthenticationProvider>());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Create an Account',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: SignupForm(onSendForm: onSendForm),
      ),
    );
  }
}
