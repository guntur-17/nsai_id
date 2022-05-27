import 'package:flutter/material.dart';
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
            child: Container(
              width: 315,
              height: 57,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: primaryBlue,
              ),
              child: InkWell(
                onTap: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign In',
                      style: whiteTextStyle.copyWith(
                          fontSize: 20, fontWeight: medium),
                    )
                  ],
                ),
              ),
            ),
          );
        }

        Widget body() {
          return Expanded(
            child: Container(
              width: double.infinity,
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
                  button(),
                  // check(),
                ],
              ),
            ),
          );
        }

        return SafeArea(
          child: SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(80.0),
                child: Column(
                  children: [
                    AppBar(
                      toolbarHeight: 80,
                      leading: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              color: whiteColor,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      iconTheme: IconThemeData(color: Colors.black),
                      centerTitle: false,
                      backgroundColor: blueBrightColor,
                      bottomOpacity: 0.0,
                      elevation: 0.0,
                      title: Text(
                        'Log In.',
                        style: whiteRobotoTextStyle.copyWith(
                          fontWeight: extraBold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              backgroundColor: blueBrightColor,
              body: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    body(),
                  ],
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
