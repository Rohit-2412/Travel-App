import 'package:flutter/material.dart';
import 'package:my_first_app/widgets/app_large_text.dart';
import 'package:my_first_app/widgets/responsive_button.dart';

import '../misc/colors.dart';
import '../widgets/app_text.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    // list of caption and headings and headers

    List headers = [
      "Trips",
      "Trekking",
      "Camping",
    ];

    List headings = [
      "Mountain",
      "Forest",
      "Beach",
    ];

    List captions = [
      "Mountain hikes give you an incredible sense of freedom along with endurance tests",
      "Forest hikes give you an incredible sense of freedom along with endurance tests",
      "Beach hikes give you an incredible sense of freedom along with endurance tests",
    ];
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 3,
        itemBuilder: (_, index) {
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            // background image
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/welcome_${index + 1}.png'),
                  fit: BoxFit.cover),
            ),
            child: Container(
              margin: EdgeInsets.only(top: 150, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppLargeText(
                        text: headers[index],
                      ),
                      AppText(
                        text: headings[index],
                        size: 30,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 250,
                        child: AppText(
                          text: captions[index],
                          color: AppColors.textColor2,
                          size: 14,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ResponsiveButton(
                        width: 120,
                      )
                    ],
                  ),
                  Column(
                    children: List.generate(3, (idxDots) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 5),
                        width: 8,
                        height: idxDots == index ? 25 : 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: idxDots == index
                              ? AppColors.mainColor
                              : AppColors.mainColor.withOpacity(0.5),
                        ),
                      );
                    }),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
