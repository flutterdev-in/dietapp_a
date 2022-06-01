import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/app%20Constants/fire_ref.dart';
import 'package:dietapp_a/v_chat/constants/chat_const_variables.dart';
import 'package:dietapp_a/v_chat/diet%20Room%20Screen/b_timing_view_diet_room.dart';
import 'package:flutter/material.dart';

class DietViewMemberManager extends StatelessWidget {
  const DietViewMemberManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (thisChatPersonUID.value == userUID) {
      return const TimingsViewDietRoom(roleVCMO: "O");
    } else {
      return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: dietViewMembersDR.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData && snapshot.data!.data() != null) {
              var dietViewMembersMap = snapshot.data!.data()!;
              if (dietViewMembersMap.containsKey(thisChatPersonUID.value)) {
                return TimingsViewDietRoom(
                    roleVCMO: dietViewMembersMap[thisChatPersonUID.value]);
              } else {
                return dietRoleManager();
              }
            } else {
              return const Text("Error while fetching data, please try again");
            }
          });
    }
  }

  Widget dietRoleManager() {
    return Container();
  }
}