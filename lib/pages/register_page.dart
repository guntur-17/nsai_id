import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:nsai_id/models/region_model.dart';
import 'package:nsai_id/pages/register_page.dart';
import 'package:nsai_id/pages/test_page.dart';
import 'package:nsai_id/providers/region_provider.dart';
import 'package:nsai_id/services/region_service.dart';
import 'package:nsai_id/theme.dart';
import 'package:nsai_id/widget/checkbox.dart';
import 'package:provider/provider.dart';
import 'package:relative_scale/relative_scale.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // List<RegionModel> regions = [];
  // List<RegionModel> _regions = [];
  TextEditingController nameController = TextEditingController(text: '');

  TextEditingController passwordController = TextEditingController(text: '');

  TextEditingController nomerController = TextEditingController(text: '');

  DropdownEditingController<String>? areaController =
      DropdownEditingController(value: null);

  TextEditingController emailController = TextEditingController(text: '');

  bool hiddenPassword = true;

  bool isLoading = false;

  bool isChecked = false;
  @override
  void iniState() {
    super.initState();
  }

  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNode2 = FocusNode();
  FocusNode myFocusNode3 = FocusNode();
  FocusNode myFocusNode4 = FocusNode();
  FocusNode myFocusNode5 = FocusNode();

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    RegionProvider regionProvider =
        Provider.of<RegionProvider>(context, listen: false);

    // List distributor = distributorProvider.distributors.toList();
    List<RegionModel> regions = regionProvider.regions;

    List<String> _area = [];

    for (var region in regions) {
      _area.add(region.name!);
      print(region.name);
    }

    print(_area);

    // final List<String> roles = _roles;

    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        Widget logo() {
          return Padding(
            padding: const EdgeInsets.only(top: 27, bottom: 20),
            child: Container(
              // width: MediaQuery.of(context).size.width * 0.9,
              // height: MediaQuery.of(context).size.height * 0.25,
              child: Image.asset(
                "assets/login_logo.png",
                width: sx(180),
                height: sx(140),
                // fit: BoxFit.fitWidth,
              ),
            ),
          );
        }

        Widget name() {
          return Focus(
            onFocusChange: (hasFocus) {
              // When you focus on input email, you need to notify the color change into the widget.
              setState(() => hasFocus ? primaryBlue : grey40);
            },
            child: TextFormField(
              // scrollPadding: EdgeInsets.only(
              //     bottom: MediaQuery.of(context).viewInsets.bottom + 16 * 4),
              focusNode: myFocusNode,
              controller: nameController,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                labelText: 'nama',
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

        Widget nomer() {
          return Focus(
            onFocusChange: (hasFocus2) {
              // When you focus on input email, you need to notify the color change into the widget.
              setState(() => hasFocus2 ? primaryBlue : grey40);
            },
            child: TextFormField(
              // scrollPadding: EdgeInsets.only(
              //     bottom: MediaQuery.of(context).viewInsets.bottom + 16 * 4),
              focusNode: myFocusNode2,
              controller: nomerController,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                labelText: 'Nomer',
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

                // errorText: 'Error message',
                border: const OutlineInputBorder(),
              ),
            ),
          );
        }

        Widget area2() {
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Focus(
                onFocusChange: (hasFocus3) {
                  // When you focus on input email, you need to notify the color change into the widget.
                  setState(() => hasFocus3 ? primaryBlue : grey40);
                },
                child: TextDropdownFormField(
                  controller: areaController,
                  options: _area,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                    labelText: 'Area',
                    labelStyle: TextStyle(
                        color: myFocusNode3.hasFocus ? primaryBlue : grey),
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
                  dropdownHeight: 120,
                ),
              ),
            ),
          );
        }

        Widget email() {
          return Focus(
            onFocusChange: (hasFocus4) {
              // When you focus on input email, you need to notify the color change into the widget.
              setState(() => hasFocus4 ? primaryBlue : grey40);
            },
            child: TextFormField(
              // scrollPadding: EdgeInsets.only(
              //     bottom: MediaQuery.of(context).viewInsets.bottom + 16 * 4),
              focusNode: myFocusNode4,
              controller: emailController,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                labelText: 'Email',
                labelStyle: TextStyle(
                    color: myFocusNode4.hasFocus ? primaryBlue : grey),
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
            onFocusChange: (hasFocus5) {
              // When you focus on input email, you need to notify the color change into the widget.
              setState(() => hasFocus5 ? primaryBlue : grey40);
            },
            child: TextFormField(
              // scrollPadding: EdgeInsets.only(
              //     bottom: MediaQuery.of(context).viewInsets.bottom + 16 * 4),
              // initialValue: 'Input text',
              focusNode: myFocusNode5,
              controller: passwordController,
              obscureText: hiddenPassword,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                labelText: 'password',
                labelStyle: TextStyle(
                    color: myFocusNode5.hasFocus ? primaryBlue : grey),
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

        Widget input() {
          return RelativeBuilder(builder: (context, height, width, sy, sx) {
            return Padding(
              padding: const EdgeInsets.only(top: 27, bottom: 20),
              child: Container(
                // padding: const EdgeInsets.all(30.0),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: [
                    name(),
                    const SizedBox(
                      height: 12,
                    ),
                    nomer(),
                    const SizedBox(
                      height: 12,
                    ),
                    // area(),
                    area2(),
                    const SizedBox(
                      height: 12,
                    ),
                    email(),
                    const SizedBox(
                      height: 12,
                    ),
                    password(),
                    // const SizedBox(
                    //   height: 12,
                    // ),
                    // username(),
                    // const SizedBox(
                    //   height: 12,
                    // ),
                    // username(),
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
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (BuildContext context) => StockListPage()));
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

        Widget signin() {
          return Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sudah memiliki akun ? ",
                    style: trueBlackTextStyle.copyWith(
                        fontSize: 16, fontWeight: light),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => RegisterPage()));
                    },
                    child: Text(
                      "Log In",
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
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    logo(),
                    input(),
                    if (nameController.text.isEmpty ||
                        passwordController.text.isEmpty ||
                        nomerController.text.isEmpty ||
                        emailController.text.isEmpty ||
                        areaController!.value!.isEmpty) ...[
                      disable()
                    ] else ...[
                      button()
                    ],

                    signin(),
                    // check(),
                  ],
                ),
              ),
            ),
          );
        }

        Widget header() {
          return Expanded(
            flex: 1,
            child: Container(
              color: orangeYellow,
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
                    'Register.',
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
            backgroundColor: orangeYellow,
            body: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                // constraints: BoxConstraints(
                //     maxHeight: MediaQuery.of(context).size.height),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
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
