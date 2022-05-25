import 'package:flutter/material.dart';

import '../app/app_button.dart';

class RecoverPasswordForm extends StatefulWidget {
  const RecoverPasswordForm({Key? key}) : super(key: key);

  @override
  State<RecoverPasswordForm> createState() => _RecoverPasswordFormState();
}

class _RecoverPasswordFormState extends State<RecoverPasswordForm> {
  final _formKey = GlobalKey<FormState>();

  bool sendFormLoading = false;
  bool autoValidate = false;

  final Map<String, String> _formData = {};

  void onSendForm() {
    setState(() {
      sendFormLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
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

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(bottom: 26),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              key: _formKey,
              autovalidateMode: autoValidate
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    onSaved: (value) {
                      if (value != null && value.isNotEmpty) {
                        _formData['email'] = value;
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
                  const SizedBox(height: 5),
                  const Text(
                    'Enter your email to reset your password',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color.fromRGBO(60, 60, 67, 1),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AppButton(
                title: "Submit",
                onPress: onSendForm,
                loading: sendFormLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
