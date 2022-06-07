import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/x_customWidgets/alert_dialogue.dart';
import 'package:dietapp_a/y_Active%20diet/controllers/active_plan_controller.dart';
import 'package:dietapp_a/y_Active%20diet/functions/cam_pic_photo_upload.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_timing_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TimingsRowHomeScreen extends StatelessWidget {
  final ActiveTimingModel atm;
  final bool editingIconRequired;
  const TimingsRowHomeScreen(
      {Key? key, required this.atm, this.editingIconRequired = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(0),
      color: const Color.fromARGB(22, 139, 53, 201),
      title: Text(
        atm.timingName,
        maxLines: 1,
        style: const TextStyle(fontSize: 18, color: primaryColor),
      ),
      icon: (apc.currentActiveDayDR.value.id ==
              admos.dayFormat.format(DateTime.now()))
          ? Row(
              children: [
                IconButton(
                    onPressed: () async {
                      await camPicPhotoUploadFunction(context, atm.docRef!);
                    },
                    icon: const Icon(MdiIcons.cameraPlus)),
                IconButton(
                    onPressed: () {
                      if (atm.docRef != null) {
                        notes(context, atm);
                      }
                    },
                    icon: Icon(atm.notes == null
                        ? MdiIcons.textBoxPlusOutline
                        : MdiIcons.playlistEdit)),
              ],
            )
          : null,
    );
  }

  void notes(BuildContext context, ActiveTimingModel atm) {
    textFieldAlertW(
      context,
      text: atm.notes,
      lableText: atm.timingName + " notes",
      confirmText: atm.notes == null ? "Add" : "Update",
      onPressedConfirm: (text) async {
        Get.back();
        atm.docRef!.update({"$unIndexed.$notes0": text});
      },
    );
  }
}
