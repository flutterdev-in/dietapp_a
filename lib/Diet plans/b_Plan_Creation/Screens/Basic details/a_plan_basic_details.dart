import 'package:dietapp_a/Diet%20plans/b_Plan_Creation/controllers/plan_creation_controller.dart';
import 'package:dietapp_a/x_customWidgets/url_preview_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'package:metadata_fetch/metadata_fetch.dart';

class PlanBasicDetails extends StatelessWidget {
  PlanBasicDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Plan basic details"),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          planName(),
          planNotes(),
          refWebURL(),
          GFButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Back")),
        ],
      ),
    );
  }

  Widget planName() {
    TextEditingController tcName = TextEditingController();
    tcName.text = pcc.planName.value;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: tcName,
        maxLines: null,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: "Plan Name*",
        ),
        onChanged: (value) {
          pcc.planName.value = value;
        },
      ),
    );
  }

  Widget planNotes() {
    TextEditingController tcNotes = TextEditingController();
    tcNotes.text = pcc.planNotes.value;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: tcNotes,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          labelText: "Notes",
        ),
        onChanged: (value) {
          pcc.planNotes.value = value;
        },
      ),
    );
  }

  Widget refWebURL() {
    TextEditingController tcURL = TextEditingController();
    tcURL.text = pcc.planURL.value;
    Rx<String> url = "".obs;
    Rx<String> title = "".obs;
    Rx<String> imgURL = "".obs;

    return Column(
      children: [

        
        Obx(() => title.value.isNotEmpty
            ? GFListTile(
                avatar: urlPreviewAvatar(
                  url: url.value,
                  imgURL: imgURL.value,
                ),
                title: Text(
                  title.value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            : SizedBox()),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: tcURL,
            maxLines: null,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.url,
            decoration: InputDecoration(
              labelText: "Ref URL",
            ),
            onChanged: (value) async {
              try {
                Metadata? data = await MetadataFetch.extract(value)
                    .onError((error, stackTrace) => null);
                url.value = data?.url ?? "";
                title.value = data?.title ?? "";
                imgURL.value = data?.image ?? "";
              } catch (e) {}
            },
          ),
        ),
      ],
    );
  }
}
