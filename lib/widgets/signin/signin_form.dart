import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../providers/authentication_provider.dart';
import '../../screens/signup/signup_screen.dart';
import '../../screens/password_recovery/password_recovery_screen.dart';
import '../../widgets/app/app_button.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);
  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  late FocusNode passwordFocusNode;

  bool autoValidate = false;
  bool isPasswordShow = false;
  bool sendFormLoading = false;

  Map<String, String> formData = {};

  @override
  void initState() {
    super.initState();

    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    passwordFocusNode.dispose();

    super.dispose();
  }

  void onSendForm (BuildContext ctx) async {
    setState(() {
      sendFormLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      FocusManager.instance.primaryFocus?.unfocus();

      if(formData['email'] != null && formData['password'] != null) {
        await Provider.of<AuthenticationProvider>(context, listen: false).login(formData['email'], formData['password']);
      }

      setState(() {
        autoValidate = false;
        sendFormLoading = false;
      });
    } else {
      setState(() {
        autoValidate = true;
        sendFormLoading = false;
      });
    }
  }

  void navigateToSignUp(BuildContext ctx) {
    Navigator.pushNamed(ctx, SignUpScreen.routeName);
  }

  void navigateToRecoverPassword(BuildContext ctx) {
    Navigator.pushNamed(ctx, PasswordRecoverScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode:
          autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: const Color.fromRGBO(243, 243, 243, 1),
              hintText: 'Email',
              errorStyle: const TextStyle(color: Colors.red),
              hintStyle: const TextStyle(
                fontSize: 17,
                color: Color.fromRGBO(60, 60, 67, 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                borderRadius: BorderRadius.circular(10),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.red,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.red,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 19,
              ),
            ),
            style: const TextStyle(
              color: Color.fromRGBO(60, 60, 67, 1),
              fontSize: 17,
            ),
            cursorWidth: 1,
            autocorrect: false,
            cursorColor: const Color.fromRGBO(60, 60, 67, 1),
            keyboardType: TextInputType.emailAddress,
            onFieldSubmitted: (_) => passwordFocusNode.requestFocus(),
            onSaved: (value) {
              if (value != null && value.isNotEmpty) {
                formData['email'] = value;
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter email!';
              }
              if (!RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value)) {
                return 'Please enter a valid email!';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Stack(
            children: [
              TextFormField(
                focusNode: passwordFocusNode,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: const Color.fromRGBO(243, 243, 243, 1),
                  hintText: 'Password',
                  errorStyle: const TextStyle(color: Colors.red),
                  hintStyle: const TextStyle(
                    fontSize: 17,
                    color: Color.fromRGBO(60, 60, 67, 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.red,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.red,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 19,
                  ),
                ),
                style: const TextStyle(
                  color: Color.fromRGBO(60, 60, 67, 1),
                  fontSize: 17,
                ),
                cursorWidth: 1,
                obscureText: !isPasswordShow,
                autocorrect: false,
                cursorColor: const Color.fromRGBO(60, 60, 67, 1),
                keyboardType: TextInputType.text,
                onFieldSubmitted: (_) => onSendForm(context),
                onSaved: (value) {
                  if (value != null && value.isNotEmpty) {
                    formData['password'] = value;
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password can not be empty!';
                  }
                  RegExp hasLower = RegExp(r'[a-z]');

                  if (!RegExp(r'.{6,}').hasMatch(value)) {
                    return 'Passwords must have at least 6 characters';
                  }
                
                  if (!hasLower.hasMatch(value)) {
                    return 'Passwords must have at least one lowercase character';
                  }
                  return null;
                },
              ),
              Positioned(
                right: 15,
                top: 15,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPasswordShow = !isPasswordShow;
                    });
                  },
                  child: SvgPicture.asset(
                    !isPasswordShow
                        ? "assets/icons/show-password.svg"
                        : "assets/icons/hide-password.svg",
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () => navigateToRecoverPassword(context),
            child: const Text(
              'Forgot password?',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(10, 132, 255, 1),
              ),
            ),
          ),
          const SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "New to the app?",
                style: TextStyle(
                  color: Color.fromRGBO(60, 60, 67, 1),
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 3),
              GestureDetector(
                onTap: () => navigateToSignUp(context),
                child: const Text(
                  "Create account",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromRGBO(10, 132, 255, 1),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 30),
          AppButton(
            title: "Sign In",
            onPress: () => onSendForm(context),
            loading: sendFormLoading,
          ),
        ],
      ),
    );
  }
}
