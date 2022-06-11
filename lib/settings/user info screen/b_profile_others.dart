import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BasicInfoEditScreen extends StatelessWidget {
  BasicInfoEditScreen({Key? key}) : super(key: key);
  Rx<String> rxGender = "Male".obs; // Male or Female
  Rx<num> rxHeight = 165.obs; // in cm
  Rx<num> rxWeight = 60.0.obs; // in kg
  Rx<int> rxAge = 30.obs; // in yrs

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Basic Info'),
        ),
        body: ListView(
          children: [
            const SizedBox(height: 10),
            _gender(),
            divider(),
            _age(),
            divider(),
            _weight(),
            divider(),
            _height(),
            divider(),
          ],
        ),
      ),
    );
  }

  Widget divider() {
    return const Divider(
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
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Icon(MdiIcons.humanMaleFemale),
          ),
          _button("Male"),
          const SizedBox(width: 20),
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
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
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
        const Text("yrs"),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Obx(
            () => (vd.value >= 1 && vd.value < 120)
                ? const Text("")
                : const Text(
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
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 5, 10, 5),
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
        const Text("ft"),
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
        const Text("inch"),
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
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
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
        const Text("Kg"),
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

  // Widget activity() {}
}
