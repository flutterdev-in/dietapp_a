import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/userData/models/user_welcome_model.dart';
import 'package:flutter/material.dart';

class ChatPersonProfileViewScreen extends StatelessWidget {
  final String chatPersonUID;
  const ChatPersonProfileViewScreen({Key? key, required this.chatPersonUID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            if (uwm.photoURL != null)
              Center(
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    child: CachedNetworkImage(imageUrl: uwm.photoURL!)),
              ),
            const SizedBox(height: 25),
            Text("Profile Name  :  " + uwm.displayName, textScaleFactor: 1.1),
            Text("User ID  :  @" + uwm.userID),
            const SizedBox(height: 20),
            if (uwm.bioData.isNotEmpty) Text("Bio  :  " + uwm.bioData),
          ],
        ),
      ),
    );
  }
}
