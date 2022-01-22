import 'package:dietapp_a/settings/a_Profile/childrens/a_profile_first.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Profile"),
          ),
          body: ListView(
            shrinkWrap: true,
            children: [
              ProfileFirst(),
            ],
          )),
    );
  }
}
