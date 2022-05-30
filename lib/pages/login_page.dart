import 'package:flutter/material.dart';
import 'package:nsai_id/pages/attendance_page.dart';
import 'package:nsai_id/pages/register_page.dart';
import 'package:nsai_id/pages/test_page.dart';
import 'package:nsai_id/theme.dart';
import 'package:nsai_id/widget/checkbox.dart';
import 'package:relative_scale/relative_scale.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController(text: '');

  TextEditingController passwordController = TextEditingController(text: '');

  bool hiddenPassword = true;

  bool isLoading = false;

  bool isChecked = false;

  void iniState() {
    setState(() {});
  }

  FocusNode myFocusNode = FocusNode();

  FocusNode myFocusNode2 = FocusNode();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        Widget logo() {
          return Padding(
            padding: const EdgeInsets.only(top: 27, bottom: 20),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Image.asset(
                "assets/login_logo.png",
                width: sx(330),
                height: sx(250),
                // fit: BoxFit.fitWidth,
              ),
            ),
          );
        }

        Widget username() {
          return Focus(
            onFocusChange: (hasFocus) {
              // When you focus on input email, you need to notify the color change into the widget.
              setState(() => hasFocus ? primaryBlue : grey40);
            },
            child: TextFormField(
              // scrollPadding: EdgeInsets.only(
              //     bottom: MediaQuery.of(context).viewInsets.bottom + 16 * 4),
              focusNode: myFocusNode,
              controller: usernameController,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                labelText: 'Email',
                labelStyle:
                    TextStyle(color: myFocusNode.hasFocus ? primaryBlue : grey),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: primaryBlue,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: grey40,
                    width: 2.0,
                  ),
                ),

                // errorText: 'Error message',
                border: const OutlineInputBorder(),
              ),
            ),
          );
        }

        Widget password() {
          return Focus(
            onFocusChange: (hasFocus2) {
              // When you focus on input email, you need to notify the color change into the widget.
              setState(() => hasFocus2 ? primaryBlue : grey40);
            },
            child: TextFormField(
              // scrollPadding: EdgeInsets.only(
              //     bottom: MediaQuery.of(context).viewInsets.bottom + 16 * 4),
              // initialValue: 'Input text',
              focusNode: myFocusNode2,
              controller: passwordController,
              obscureText: hiddenPassword,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                labelText: 'password',
                labelStyle: TextStyle(
                    color: myFocusNode2.hasFocus ? primaryBlue : grey),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: primaryBlue,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: grey40,
                    width: 2.0,
                  ),
                ),

                suffixIcon: InkWell(
                  onTap: _tooglePasswordView,
                  child: hiddenPassword
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                ),
                // errorText: 'Error message',
                border: const OutlineInputBorder(),
              ),
            ),
          );
        }

        Widget check() {
          return LabeledCheckbox(
            // shape: ,
            contentPadding: EdgeInsets.all(0),
            label: "ingatkan saya",
            // controlAffinity: ListTileControlAffinity.leading,
            activeColor: primaryBlue,
            value: isChecked,
            onTap: (bool? value) {
              setState(() {
                isChecked = value!;
              });
            },
            fontSize: 16,
            gap: 0,
          );
        }

        Widget forgotPassword() {
          return InkWell(
            onTap: () => {},
            child: Text(
              'Lupa Password?',
              style: primaryBlueInterTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
                decoration: TextDecoration.underline,
              ),
            ),
          );
        }

        Widget input() {
          return RelativeBuilder(builder: (context, height, width, sy, sx) {
            return Padding(
              padding: const EdgeInsets.only(top: 27, bottom: 20),
              child: Container(
                // padding: const EdgeInsets.all(30.0),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: [
                    username(),
                    const SizedBox(
                      height: 12,
                    ),
                    password(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [check(), forgotPassword()],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        }

        Widget button() {
          return Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: primaryBlue),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => AttendancePage()));
              },
              child: Container(
                width: 315,
                height: 57,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: primaryBlue,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Log In',
                      style: whiteInterTextStyle.copyWith(
                          fontSize: 16, fontWeight: medium),
                    )
                  ],
                ),
              ),
            ),
          );
        }

        Widget disable() {
          return Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: primaryBlue),
              onPressed: null,
              child: Container(
                width: 315,
                height: 57,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: primaryBlue,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Log In',
                      style: whiteInterTextStyle.copyWith(
                          fontSize: 16, fontWeight: medium),
                    )
                  ],
                ),
              ),
            ),
          );
        }

        Widget signup() {
          return Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Tidak memiliki akun ? ",
                    style: trueBlackTextStyle.copyWith(
                        fontSize: 16, fontWeight: light),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => RegisterPage()));
                    },
                    child: Text(
                      "Register",
                      style: primaryBlueInterTextStyle.copyWith(
                          fontSize: 16, fontWeight: medium),
                    ),
                  )
                ],
              ),
            ),
          );
        }

        Widget body() {
          return Expanded(
            flex: 8,
            child: Container(
              // height: MediaQuery.of(context).size.height,
              // width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  logo(),
                  input(),
                  if (usernameController.text.isEmpty ||
                      passwordController.text.isEmpty) ...[
                    disable()
                  ] else ...[
                    button()
                  ],

                  signup(),
                  // check(),
                ],
              ),
            ),
          );
        }

        Widget header() {
          return Expanded(
            flex: 1,
            child: Container(
              // color: blueBrightColor,
              child: Row(
                // mainAxisAlignment: ,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: whiteColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Log In.',
                    style: whiteRobotoTextStyle.copyWith(
                      fontWeight: extraBold,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return SafeArea(
          child: Scaffold(
            // resizeToAvoidBottomInset: false,
            backgroundColor: blueBrightColor,
            body: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.965,
                  // constraints: BoxConstraints(
                  //     maxHeight: MediaQuery.of(context).size.height),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    // mainAxisSize: MainAxisSize.min,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      header(),
                      body(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _tooglePasswordView() {
    if (hiddenPassword == true) {
      hiddenPassword = false;
    } else {
      hiddenPassword = true;
    }

    setState(() {});
  }
}
