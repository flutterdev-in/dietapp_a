import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/userData/models/user_welcome_model.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class ChatPersonProfileViewScreen extends StatelessWidget {
  final String chatPersonUID;
  const ChatPersonProfileViewScreen({Key? key, required this.chatPersonUID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: usersCollection.doc(chatPersonUID).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.data() != null) {
              var uwm = UserWelcomeModel.fromMap(snapshot.data!.data()!);
              return profile(uwm);
            }
            return Container();
          }),
    );
  }

  Widget profile(UserWelcomeModel uwm) {
    return Center(
      child: Column(
        children: [
          GFAvatar(
            backgroundColor: Colors.transparent,
            size: 100,
            child: uwm.photoURL != null
                ? CachedNetworkImage(imageUrl: uwm.photoURL!)
                : null,
          ),
          Text(uwm.displayName, textScaleFactor: 1.1),
          Text(uwm.userID),
          Text(uwm.bioData),
        ],
      ),
    );
  }
}
