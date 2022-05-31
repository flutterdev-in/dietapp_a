import 'package:dietapp_a/v_chat/chat%20Room%20Screen/a_chat_room_top.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_chat_room_middle.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/c_chat_room_bottom.dart';
import 'package:dietapp_a/v_chat/controllers/chat_room_controller.dart';
import 'package:dietapp_a/v_chat/diet%20Room%20Screen/_diet_view_chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatRoomScreen extends StatefulWidget {
  
  const ChatRoomScreen({Key? key, })
      : super(key: key);

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabC;

  @override
  void initState() {
    super.initState();
    tabC = TabController(initialIndex: 1, length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ChatScreenController());
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: const ChatRoomAppBar(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(32.0),
          child: TabBar(
            controller: tabC,
            indicatorColor: Colors.white70,
            tabs: const [
              SizedBox(height: 30, child: Center(child: Text("Diet"))),
              SizedBox(height: 30, child: Center(child: Text("Chat"))),
            ],
            indicatorWeight: 2.5,
            onTap: (index) {
              FocusScope.of(context).unfocus();
            },
          ),
        ),
      ),
      body: TabBarView(
        controller: tabC,
        children: [
          DietViewChat(),
          Column(
            children: [
              const ChatRoomMiddle(),
              ChatRoomBottom(),
            ],
          ),
        ],
      ),
    ));
  }
}
