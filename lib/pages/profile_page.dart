import 'package:flutter/material.dart';
import 'package:nsai_id/widget/profile_card.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../providers/auth_provider.dart';
import '../theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    UserModel user = authProvider.user;
    Widget header() {
      return Expanded(
        flex: 3,
        child: Container(
          // color: orangeYellow,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
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
                    width: 4,
                  ),
                  Text(
                    'Profil',
                    softWrap: true,
                    style: whiteRobotoTextStyle.copyWith(
                      fontWeight: extraBold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: whiteColor, width: 4),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage('assets/ava.png')),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget body() {
      return Expanded(
        flex: 7,
        child: Container(
          // height: MediaQuery.of(context).size.height,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
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
                ProfileCard(
                    icon: Icons.person,
                    title: 'Nama Lengkap',
                    content: user.full_name),
                ProfileCard(
                    icon: Icons.credit_card_outlined,
                    title: 'NIK',
                    content: user.id_card_number),
                ProfileCard(
                    icon: Icons.location_city,
                    title: 'Region',
                    content: user.region),
                ProfileCard(
                    icon: Icons.email_outlined,
                    title: 'NIK',
                    content: user.email),
              ]),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        // backgroundColor: orangeYellow,
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/bggray.png'),
                        fit: BoxFit.cover)),
                // height: MediaQuery.of(context).size.height,
                // constraints: BoxConstraints(
                //     maxHeight: MediaQuery.of(context).size.height),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  // mainAxisSize: MainAxisSize.min,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    header(),
                    body()
                    // body(),
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
