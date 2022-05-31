import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/y_Active%20diet/controllers/active_plan_controller.dart';
import 'package:dietapp_a/y_Active%20diet/functions/cam_pic_photo_upload.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_day_model.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_timing_model.dart';
import 'package:dietapp_a/z_homeScreen/c_Timings%20view/ab_timing_row_popup_menu.dart';
import 'package:flutter/material.dart';
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
      padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
      margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 0),
      color: const Color.fromARGB(22, 139, 53, 201),
      title: Text(
        atm.timingName,
        maxLines: 1,
        style: const TextStyle(fontSize: 18, color: primaryColor),
      ),
      icon: Row(
        children: [
          if (apc.cuurentActiveDayDR.value.id ==
              admos.dayFormat.format(dateNow))
            IconButton(
                onPressed: () async {
                  if (atm.docRef != null) {
                    await camPicPhotoUploadFunction(context, atm.docRef!);
                  }
                },
                icon: const Icon(MdiIcons.cameraPlus)),
          MenuItemsTimingViewHS(thisTimingDR: atm.docRef!),
        ],
      ),
    );
  }
}
