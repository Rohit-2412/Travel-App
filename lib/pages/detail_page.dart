import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/cubit/app_cubit_states.dart';
import 'package:my_first_app/misc/colors.dart';
import 'package:my_first_app/widgets/app_large_text.dart';
import 'package:my_first_app/widgets/app_text.dart';
import 'package:my_first_app/widgets/responsive_button.dart';

import '../cubit/app_cubits.dart';
import '../widgets/app_button.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int starsReceived = 4;
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits, CubitStates>(
      builder: ((context, state) {
        DetailState detail = state as DetailState;
        return Scaffold(
          body: SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: Stack(children: [
              // image
              Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: double.maxFinite,
                  height: 350,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "http://mark.bslmeiyu.com/uploads/${detail.place.img}"),
                        fit: BoxFit.cover),
                  ),
                ),
              ),

              // icons
              Positioned(
                left: 20,
                right: 10,
                top: 50,
                child: SizedBox(
                  // make width equal to the width of the screen
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<AppCubits>(context).goHome();
                        },
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ),
                      const IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // bottom card container
              Positioned(
                top: 300,
                child: Container(
                  padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 500,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: Colors.white),

                  // content of card
                  child: Column(
                    // aligning the content to the start of the card
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // col1
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // heading and price
                          AppLargeText(
                            text: detail.place.name,
                            size: 30,
                            color: Colors.black.withOpacity(0.8),
                          ),
                          AppLargeText(
                            text: "\$${detail.place.price}",
                            size: 30,
                            color: AppColors.mainColor,
                          ),
                        ],
                      ),

                      // spacing
                      const SizedBox(height: 10),

                      // col2
                      Row(children: [
                        const Icon(
                          Icons.location_on,
                          color: AppColors.mainColor,
                        ),
                        // spacing
                        const SizedBox(width: 5),
                        // location
                        AppText(
                          text: detail.place.location,
                          color: AppColors.textColor1,
                        ),
                      ]),

                      // spacing
                      const SizedBox(height: 10),

                      // col3
                      Row(
                        children: [
                          // stars list
                          Wrap(
                            children: List.generate(5, (index) {
                              return Icon(
                                Icons.star,
                                color: index < detail.place.stars
                                    ? AppColors.starColor
                                    : Colors.grey,
                              );
                            }),
                          ),

                          // spacing
                          const SizedBox(width: 10),

                          // rating
                          AppText(
                            // convert int to double then to string
                            text:
                                "(${detail.place.stars.toDouble().toString()})",
                            color: AppColors.textColor2,
                          ),
                        ],
                      ),

                      // spacing
                      const SizedBox(height: 25),

                      // col4
                      AppLargeText(
                        text: "People",
                        size: 20,
                        color: Colors.black.withOpacity(0.8),
                      ),

                      // spacing
                      const SizedBox(height: 5),

                      // col5
                      AppText(
                        text: "Number of people in your group",
                        color: AppColors.mainTextColor,
                        size: 14,
                      ),

                      // spacing
                      const SizedBox(height: 10),

                      // boxes showing number of people
                      Wrap(
                        children: List.generate(5, (index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: AppButton(
                                color: selectedIndex == index
                                    ? Colors.white
                                    : Colors.black,
                                backgroundColor: selectedIndex == index
                                    ? Colors.black.withOpacity(0.8)
                                    : AppColors.buttonBackground,
                                size: 17.5,
                                borderColor: selectedIndex == index
                                    ? Colors.black
                                    : AppColors.buttonBackground,
                                text: (index + 1).toString(),
                                isBold: true,
                              ),
                            ),
                          );
                        }),
                      ),

                      // spacing
                      const SizedBox(height: 20),

                      // col6
                      AppLargeText(
                        text: "Description",
                        color: Colors.black.withOpacity(.85),
                        size: 25,
                      ),

                      // spacing
                      const SizedBox(height: 5),

                      // col7
                      AppText(
                        text: detail.place.description,
                        color: Colors.black.withOpacity(.6),
                        size: 16,
                      )
                    ],
                  ),
                ),
              ),

              // bottom like button and book trip button
              Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: Row(
                  children: [
                    // like button
                    AppButton(
                      color: AppColors.textColor1,
                      backgroundColor: Colors.white,
                      size: 30,
                      borderColor: AppColors.textColor1,
                      isIcon: true,
                      icon: Icons.favorite_border,
                    ),

                    // spacing b/w 2 buttons
                    const SizedBox(width: 10),

                    // proceed button
                    ResponsiveButton(
                      isResponsive: true,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        );
      }),
    );
  }
}
