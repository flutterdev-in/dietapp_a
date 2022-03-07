import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BasicInfo extends StatelessWidget {
  BasicInfo({Key? key}) : super(key: key);
  Rx<String> rxGender = "Male".obs; // Male or Female
  Rx<num> rxHeight = 165.obs; // in cm
  Rx<num> rxWeight = 60.0.obs; // in kg
  Rx<int> rxAge = 30.obs; // in yrs
  Rx<num> rxBMI = 21.0.obs;
  Rx<num> rxBfp = 17.0.obs;
  Rx<String> rxCat = "Fit".obs;
  Rx<String> rxAvtivity = "sedentry".obs;
  Rx<num> rxPal = 1.5.obs;

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
            Obx(
              () => _bfp(),
            ),
            divider(),
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
        Text("Kg"),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Obx(
            () => (vd.value > 1 && vd.value < 180)
                ? Text("")
                : Text(
                    "Enter valid weight",
                    style: TextStyle(color: Colors.brown),
                  ),
          ),
        ),
      ],
    );
  }

  void fat() {
    int s = rxGender.value == "Male" ? 1 : 0;
    num bmi = rxWeight.value * 10000 / (rxHeight.value * rxHeight.value);
    rxBMI.value = bmi;
    num bfp;
    String cat;

    if (rxAge.value < 18) {
      bfp = (1.51 * bmi) - (0.70 * rxAge.value) - (3.6 * s) + 1.4;
      bfp = num.parse(bfp.toStringAsFixed(1));
      rxBfp.value = bfp;
    } else {
      bfp = (1.39 * bmi) + (0.16 * rxAge.value) - (10.34 * s) - 9;
      bfp = num.parse(bfp.toStringAsFixed(1));
      rxBfp.value = bfp;
    }
    String catf() {
      if (rxGender.value == "Male") {
        if (bfp >= 2 && bfp <= 5) {
          cat = "lean";
        } else if (bfp >= 6 && bfp <= 13) {
          cat = "Under weight";
        } else if (bfp > 13 && bfp <= 17) {
          cat = "Fit";
        } else if (bfp > 17 && bfp <= 24) {
          cat = "Over weight";
        } else if (bfp > 24 && bfp <= 80) {
          cat = "Obese";
        } else {
          cat = ".......";
        }
      } else {
        if (bfp >= 10 && bfp <= 13) {
          cat = "lean";
        } else if (bfp >= 14 && bfp <= 20) {
          cat = "Under weight";
        } else if (bfp > 20 && bfp <= 24) {
          cat = "Fit";
        } else if (bfp > 24 && bfp <= 31) {
          cat = "Over weight";
        } else if (bfp > 31 && bfp <= 80) {
          cat = "Obese";
        } else {
          cat = "......";
        }
      }
      return cat;
    }

    rxCat.value = catf();
  }

  num tee() {
    bool isMale = rxGender.value == "Male" ? true : false;
    num a = rxAge.value;
    num w = rxWeight.value;
    num p = rxPal.value;
    num t = 2000;
    if (isMale) {
      if (a < 19) {
        t = 310.2 + 63.3 * w - 0.263 * w * w;
      }
      if (a >= 19 && a <= 30) {
        t = (15.1 * w + 692.2) * 0.9 * p;
      } else if (a > 30 && a <= 60) {
        t = (11.5 * w + 873) * 0.9 * p;
      } else {
        t = (11.7 * w + 587.7) * 0.9 * p;
      }
    } else {
      if (a < 19) {
        t = 263.4 + 65.3 * w - 0.454 * w * w;
      }
      if (a >= 19 && a <= 30) {
        t = (14.8 * w + 486.6) * 0.91 * p;
      } else if (a > 30 && a <= 60) {
        t = (8.1 * w + 845.6) * 0.91 * p;
      } else {
        t = (9.1 * w + 658.5) * 0.91 * p;
      }
    }
    return t;
  }

  // https://en.wikipedia.org/wiki/Body_fat_percentage#From_BMI
  // https://halls.md/body-fat-percentage-formula/
  Widget _bfp() {
    fat();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: Icon(MdiIcons.humanMaleHeight),
        ),
        Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Your BMI = ${rxBMI.value.toStringAsFixed(1)}"),
                Text("Your Body Fat = ${rxBfp.value.toString()} %"),
                Text("Category = ${rxCat.value}"),
              ],
            )),
      ],
    );
  }

  // Widget activity() {}
}
