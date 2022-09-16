import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:dietapp_a/v_chat/controllers/chat_room_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ReplyMessageWidget extends StatelessWidget {
  const ReplyMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: csv.replyMessageModel.value != dummyMM ? 50 : 0,
          // width: mdWidth(context),
          child: Row(
            children: [
              Container(
                color: Colors.teal.shade50,
                width: 10,
              ),
              const SizedBox(width: 5),
              Container(
                color: primaryColor,
                width: 5,
                height: double.maxFinite,
              ),
              Expanded(
                  child: Obx(() =>
                      Text(csv.replyMessageModel.value.chatString ?? "Reply"))),
              IconButton(
                  onPressed: () {
                    csv.replyMessageModel.value = dummyMM;
                  },
                  icon: const Icon(MdiIcons.close)),
              Container(
                color: Colors.teal.shade50,
                width: 10,
              ),
            ],
          ),
        ));
  }
}
