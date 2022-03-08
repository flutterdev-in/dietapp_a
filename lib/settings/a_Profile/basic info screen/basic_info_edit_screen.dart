import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BasicInfoEditScreen extends StatelessWidget {
  BasicInfoEditScreen({Key? key}) : super(key: key);
  final Rx<String> rxGender = "Male".obs; // Male or Female
  final Rx<num> rxHeight = 165.obs; // in cm
  final Rx<num> rxWeight = 60.0.obs; // in kg
  final Rx<int> rxAge = 30.obs; // in yrs

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Basic Info'),
        ),
        body: ListView(
          children: [
            SizedBox(height: 10),
            _gender(),
            divider(),
            _age(),
            divider(),
            _weight(),
            divider(),
            _height(),
            divider(),
            activity(context),
            divider(),
            dietPreference(context),
            divider(),
          ],
        ),
      ),
    );
  }

  Widget divider() {
    return Divider(
      thickness: 1,
    );
  }

  Widget _gender() {
    Widget _button(String gender) {
      return GFButton(
        onPressed: () {
          rxGender.value = gender;
        },
        type: GFButtonType.solid,
        child: Text(
          gender,
          style: TextStyle(
              color: rxGender.value == gender ? Colors.white : Colors.black),
        ),
        color: rxGender.value == gender ? GFColors.DARK : GFColors.LIGHT,
      );
    }

    return Obx(
      () => Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Icon(MdiIcons.humanMaleFemale),
          ),
          _button("Male"),
          SizedBox(width: 20),
          _button("Female"),
        ],
      ),
    );
  }

  Widget _age() {
    Rx<int> vd = rxAge.value.obs;
    TextEditingController tc = TextEditingController();
    tc.text = rxAge.value.toString();
    tc.selection =
        TextSelection.fromPosition(TextPosition(offset: tc.text.length));
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: Icon(MdiIcons.cakeVariant),
        ),
        SizedBox(
          width: 50,
          child: TextFormField(
            keyboardType: TextInputType.phone,
            controller: tc,
            onChanged: (value) {
              rxWeight.value = double.tryParse(value == "" ? "0.5" : value) ??
                  rxWeight.value;
              vd.value = int.tryParse(value) ?? 0;
            },
          ),
        ),
        Text("yrs"),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Obx(
            () => (vd.value >= 1 && vd.value < 120)
                ? Text("")
                : Text(
                    "Enter valid age",
                    style: TextStyle(color: Colors.brown),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _height() {
    Rx<int> ft = 5.obs;
    Rx<int> inch = 5.obs;
    List<int> lft = [1, 2, 3, 4, 5, 6];
    List<int> linch = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

    num hcm() {
      return (30.48 * ft.value + 2.54 * inch.value).round();
    }

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
          child: Icon(MdiIcons.humanMaleHeightVariant),
        ),
        SizedBox(
          width: 70,
          height: 60,
          child: CupertinoPicker(
              itemExtent: 40,
              diameterRatio: 10,
              scrollController: FixedExtentScrollController(initialItem: 4),
              onSelectedItemChanged: (v) {
                ft.value = lft[v];
                rxHeight.value = hcm();
              },
              children: lft
                  .map((e) => Center(
                          child: Text(
                        e.toString(),
                        textScaleFactor: 1,
                      )))
                  .toList()),
        ),
        Text("ft"),
        SizedBox(
          width: 70,
          height: 60,
          child: CupertinoPicker(
              itemExtent: 40,
              diameterRatio: 10,
              scrollController: FixedExtentScrollController(initialItem: 5),
              onSelectedItemChanged: (v) {
                inch.value = linch[v];
                rxHeight.value = hcm();
              },
              children: linch
                  .map((e) => Center(
                          child: Text(
                        e.toString(),
                        textScaleFactor: 1,
                      )))
                  .toList()),
        ),
        Text("inch"),
      ],
    );
  }

  Widget _weight() {
    Rx<num> vd = rxWeight.value.obs;
    TextEditingController tc = TextEditingController();
    tc.text = rxWeight.value.toString();
    tc.selection =
        TextSelection.fromPosition(TextPosition(offset: tc.text.length));
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: Icon(FontAwesomeIcons.weight),
        ),
        SizedBox(
          width: 50,
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: tc,
            onChanged: (value) {
              rxWeight.value = double.tryParse(value == "" ? "0.5" : value) ??
                  rxWeight.value;
              vd.value = double.tryParse(value) ?? 0.5;
            },
          ),
        ),
        const Text("Kgs"),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Obx(
            () => (vd.value > 1 && vd.value < 180)
                ? const Text("")
                : const Text(
                    "Enter valid weight",
                    style: TextStyle(color: Colors.brown),
                  ),
          ),
        ),
      ],
    );
  }

  Widget activity(BuildContext context) {
    Rx<String> activityText = "Little or No Active".obs;

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
            child: Icon(MdiIcons.shoeSneaker),
          ),
          SizedBox(width: 20),
          Expanded(
            child: InkWell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Daily activity",
                    style: TextStyle(color: Colors.black54),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Text(activityText.value)),
                      Icon(MdiIcons.menuDown)
                    ],
                  ),
                ],
              ),
              onTap: () {
                Widget selct({
                  required String title,
                  required String subtitle,
                }) {
                  return InkWell(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title),
                        Text(subtitle, textScaleFactor: 0.9),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                    onTap: () async {
                      Navigator.of(context).pop();
                      await Future.delayed(Duration(milliseconds: 300));
                      activityText.value = title;
                    },
                  );
                }

                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => AlertDialog(
                      contentPadding: EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 24.0),
                      scrollable: true,
                      actionsAlignment: MainAxisAlignment.start,
                      content: Column(
                        children: [
                          selct(
                            title: "Little or No Active",
                            subtitle:
                                "Mostly sitting throught the day, neggligible physical movement",
                          ),
                          selct(
                            title: "Lightly Active",
                            subtitle:
                                "Moderate physical movement during working hours",
                          ),
                          selct(
                            title: "Moderately Active",
                            subtitle:
                                "High physical movement during working hours, (eg. delivery person, waiter",
                          ),
                          selct(
                            title: "Very Active",
                            subtitle:
                                "Mostly doing heavy physical activities through the day (eg. construction worker, gym instructor)",
                          ),
                        ],
                      )),
                );
              },
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }

  Widget dietPreference(BuildContext context) {
    Rx<String> iam = "Non Vegetarian".obs;

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Row(
        children: [
          const Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
            child: Icon(MdiIcons.food),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: InkWell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "I'm",
                    style: TextStyle(color: Colors.black54),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Text(iam.value)),
                      const Icon(MdiIcons.menuDown)
                    ],
                  ),
                ],
              ),
              onTap: () {
                Widget selct({
                  required String title,
                  required String subtitle,
                }) {
                  return InkWell(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title),
                        Text(subtitle, textScaleFactor: 0.9),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                    onTap: () async {
                      Navigator.of(context).pop();
                      await Future.delayed(const Duration(milliseconds: 300));
                      iam.value = title;
                    },
                  );
                }

                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => AlertDialog(
                      contentPadding:
                          const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 24.0),
                      scrollable: true,
                      actionsAlignment: MainAxisAlignment.start,
                      content: Column(
                        children: [
                          selct(
                            title: "Vegan",
                            subtitle:
                                "Only eat Vegetable foods and Not eat Dairy products, Egss and Meat",
                          ),
                          selct(
                            title: "Vegetarian",
                            subtitle:
                                "Can eat Veg and Dairy products but not eat Eggs and Meat",
                          ),
                          selct(
                            title: "Eggetarian",
                            subtitle:
                                "Can eat Veg, Dairy products and Eggs but not eat Meat",
                          ),
                          selct(
                            title: "Non Vegetarian",
                            subtitle: "Can eat both Veg and Non Veg Foods",
                          ),
                        ],
                      )),
                );
              },
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
