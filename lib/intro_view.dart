import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroView extends StatelessWidget {
  const IntroView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: IntroductionScreen(
        showDoneButton: false,
        showNextButton: false,

        // freeze: true,
        rawPages: [
          page1(),
          page2(),
        ],
      ),
    );
  }

  Widget page1() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 40, 0, 20),
          child: Text(
            "Welcome to the DietApp",
            textScaleFactor: 1.5,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Table(
          columnWidths: const {
            0: FractionColumnWidth(0.2),
            1: FractionColumnWidth(0.8),
          },
          children: [
            tableRow("Diet chat with anyone like WhatsApp"),
            tableRow("View and Manage others diet in realtime"),
            tableRow("Detect cheat diet with proof pictures"),
            tableRow("Manage foods collections like FileManager"),
            tableRow(
                "Import your favorite foods from Websites or Youtube with inbuilt Web browser"),
            tableRow("Unbelieveble upcoming feaatures"),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            "Innovation is our Motivation",
            textScaleFactor: 1.3,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(170, 0, 0, 0),
            ),
          ),
        )
      ],
    );
  }

  Widget page2() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 40, 0, 20),
          child: Text(
            "Upcoming features",
            textScaleFactor: 1.5,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Table(
          columnWidths: const {
            0: FractionColumnWidth(0.2),
            1: FractionColumnWidth(0.8),
          },
          children: [
            tableRow("Connect Diet experts to the users without mediation cost",
                "\u{1F550}"),
            tableRow(
              "View and import any diet or Foods collection, prepared by the experts which are matched with your health condition",
              "\u{1F551}",
            ),
            tableRow(
              "Macro & Micro Nutrition values for every food wrt IFCT 2017, NIN India.  The first Diet App to achive this",
              "\u{1F552}",
            ),
            tableRow(
              "Manage foods collections like FileManager",
              "\u{1F553}",
            ),
            tableRow(
              "Approve only healthy Diets, which are sceintifically logical",
              "\u{1F554}",
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            "Innovation is our Motivation",
            textScaleFactor: 1.3,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(170, 0, 0, 0),
            ),
          ),
        )
      ],
    );
  }

  TableRow tableRow(String text, [String icon = "\u{1F449}"]) {
    return TableRow(children: [
      Center(child: Text(icon)),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 3, 3, 3),
        child: Text(text, textScaleFactor: 1.2, textAlign: TextAlign.left),
      ),
    ]);
  }
}
