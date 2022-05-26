import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/app/app_button.dart';

class SignupForm extends StatefulWidget {
  final Function(Map<String, String>) onSendForm;
  const SignupForm({Key? key, required this.onSendForm}) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();

  late FocusNode _surnameFocusNode;
  late FocusNode _birthdayFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;

  bool autoValidate = false;
  bool isPasswordShow = false;
  bool sendFormLoading = false;

  @override
  void initState() {
    super.initState();

    _surnameFocusNode = FocusNode();
    _birthdayFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _surnameFocusNode.dispose();
    _birthdayFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();

    super.dispose();
  }

  final Map<String, String> _formData = {};

  void onSendForm() async {
    setState(() {
      sendFormLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      FocusManager.instance.primaryFocus?.unfocus();

      if (_formData.isNotEmpty) {
        await widget.onSendForm(_formData);
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

  void navigateToSignIn(BuildContext ctx) {
    Navigator.pop(ctx);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: const Color.fromRGBO(243, 243, 243, 1),
                  prefixIcon: const Padding(
                    child: Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 17,
                        color: Color.fromRGBO(60, 60, 67, 1),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                  ),
                  prefixIconConstraints:
                      const BoxConstraints(minWidth: 0, minHeight: 0),
                  errorStyle: const TextStyle(color: Colors.red),
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
                autocorrect: false,
                cursorColor: const Color.fromRGBO(60, 60, 67, 1),
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                onFieldSubmitted: (_) => _surnameFocusNode.requestFocus(),
                onSaved: (value) {
                  if (value != null && value.isNotEmpty) {
                    _formData['first_name'] = value;
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                focusNode: _surnameFocusNode,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: const Color.fromRGBO(243, 243, 243, 1),
                  prefixIcon: const Padding(
                    child: Text(
                      "Surname",
                      style: TextStyle(
                        fontSize: 17,
                        color: Color.fromRGBO(60, 60, 67, 1),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                  ),
                  prefixIconConstraints:
                      const BoxConstraints(minWidth: 0, minHeight: 0),
                  errorStyle: const TextStyle(color: Colors.red),
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
                autocorrect: false,
                textCapitalization: TextCapitalization.words,
                cursorColor: const Color.fromRGBO(60, 60, 67, 1),
                keyboardType: TextInputType.text,
                onFieldSubmitted: (_) => _birthdayFocusNode.requestFocus(),
                onSaved: (value) {
                  if (value != null && value.isNotEmpty) {
                    _formData['last_name'] = value;
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your surname!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                focusNode: _birthdayFocusNode,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: const Color.fromRGBO(243, 243, 243, 1),
                  prefixIcon: const Padding(
                    child: Text(
                      "Birthday",
                      style: TextStyle(
                        fontSize: 17,
                        color: Color.fromRGBO(60, 60, 67, 1),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                  ),
                  prefixIconConstraints:
                      const BoxConstraints(minWidth: 0, minHeight: 0),
                  errorStyle: const TextStyle(color: Colors.red),
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
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                autocorrect: false,
                cursorColor: const Color.fromRGBO(60, 60, 67, 1),
                keyboardType: TextInputType.number,
                onFieldSubmitted: (_) => _emailFocusNode.requestFocus(),
                onSaved: (value) {
                  if (value != null && value.isNotEmpty) {
                    _formData['birth_year'] = value;
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Birthday!';
                  }

                  if (value.length < 4 || value.length > 4) {
                    return "Please enter a correct year of Birth!";
                  }

                  DateTime now = DateTime.now();
                  int year = now.year;

                  if (year - int.parse(value) > 100) {
                    return "Please enter a correct year of Birth!";
                  }

                  if (year - int.parse(value) < 18) {
                    return "You should be at least 18 years to signup!";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                focusNode: _emailFocusNode,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: const Color.fromRGBO(243, 243, 243, 1),
                  prefixIcon: const Padding(
                    child: Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 17,
                        color: Color.fromRGBO(60, 60, 67, 1),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                  ),
                  prefixIconConstraints:
                      const BoxConstraints(minWidth: 0, minHeight: 0),
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
                autocorrect: false,
                cursorColor: const Color.fromRGBO(60, 60, 67, 1),
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (_) => _passwordFocusNode.requestFocus(),
                onSaved: (value) {
                  if (value != null && value.isNotEmpty) {
                    _formData['login'] = value;
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
                    focusNode: _passwordFocusNode,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: const Color.fromRGBO(243, 243, 243, 1),
                      prefixIcon: const Padding(
                        child: Text(
                          "Password",
                          style: TextStyle(
                            fontSize: 17,
                            color: Color.fromRGBO(60, 60, 67, 1),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                      ),
                      prefixIconConstraints:
                          const BoxConstraints(minWidth: 0, minHeight: 0),
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
                    onFieldSubmitted: (_) => onSendForm(),
                    onSaved: (value) {
                      if (value != null && value.isNotEmpty) {
                        _formData['password'] = value;
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password can not be empty!';
                      }

                      RegExp hasUpper = RegExp(r'[A-Z]');
                      RegExp hasLower = RegExp(r'[a-z]');

                      if (!RegExp(r'.{6,}').hasMatch(value)) {
                        return 'Passwords must have at least 6 characters';
                      }
                      if (!hasUpper.hasMatch(value)) {
                        return 'Passwords must have at least one uppercase character';
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: Color.fromRGBO(60, 60, 67, 1),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  GestureDetector(
                    onTap: () => navigateToSignIn(context),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(10, 132, 255, 1),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              AppButton(title: "Create Account", onPress: onSendForm, loading: sendFormLoading),
              const SizedBox(height: 30),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  const Text(
                    'By selecting Agree and continue, I agree to app',
                    style: TextStyle(
                      color: Color.fromRGBO(60, 60, 67, 1),
                      fontSize: 13,
                    ),
                  ),
                  GestureDetector(
                    child: const Text(
                      'Terms & Conditions',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromRGBO(10, 132, 255, 1),
                      ),
                    ),
                  ),
                  const Text(
                    ' and ',
                    style: TextStyle(
                      color: Color.fromRGBO(60, 60, 67, 1),
                      fontSize: 13,
                    ),
                  ),
                  GestureDetector(
                    child: const Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromRGBO(10, 132, 255, 1),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
