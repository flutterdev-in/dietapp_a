import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class IntroView extends StatelessWidget {
  const IntroView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      showDoneButton: false,
      showNextButton: true,
      showBackButton: true,
      next: const Icon(MdiIcons.arrowRight, color: Colors.white),
      back: const Icon(MdiIcons.arrowLeft, color: Colors.white),
      dotsDecorator: const DotsDecorator(
        color: Colors.white,
        activeColor: Colors.yellow,
      ),
      rawPages: [
        intro(),
        upcoming(),
      ],
    );
  }

  Widget intro() {
    return Container(
      color: primaryColor,
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 40, 0, 20),
            child: Text(
              "Welcome to the DietApp",
              textScaleFactor: 1.6,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                table("Diet chat with anyone like WhatsApp"),
                const Spacer(),
                table("View and Manage others diet in realtime"),
                const Spacer(),
                table("Detect cheat diet with proof pictures"),
                const Spacer(),
                table("Manage foods collection like FileManager"),
                const Spacer(),
                table(
                    "Import your favorite foods from Websites or Youtube with inbuilt Web browser"),
                const Spacer(),
                table(
                  "Unbelievable upcoming features\n(see in next page)",
                  emoji: "\u{231B}",
                ),
                const Spacer(),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget upcoming() {
    return Container(
      color: primaryColor,
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 40, 0, 20),
            child: Text(
              "Upcoming features",
              textScaleFactor: 1.6,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                table(
                    "100+ Macro & Micro Nutrition values for every food wrt IFCT 2017, NIN India.  The first Diet App to achive this",
                    emoji: "\u{1F552}"),
                const Spacer(),
                table("Connects Diet expert to the user without mediation cost",
                    emoji: "\u{1F550}"),
                const Spacer(),
                table(
                    "View and import any diet or Foods collection, prepared by the experts which are matched with your health condition",
                    emoji: "\u{1F551}"),
                const Spacer(),
                table(
                    " ",
                    emoji: "\u{1F554}"),
                const Spacer(),
                table("World first App having these innovative features",
                    iconW: const Icon(MdiIcons.seal, color: Colors.yellow)),
                const Spacer(),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget table(String text, {String emoji = "\u{1F449}", Widget? iconW}) {
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.topCenter,
            child: iconW ?? Text(emoji),
          ),
        ),
        Expanded(
          flex: 8,
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              text,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10)
      ],
    );
  }
}

