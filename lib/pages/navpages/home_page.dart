import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/cubit/app_cubits.dart';
import 'package:my_first_app/misc/colors.dart';
import 'package:my_first_app/widgets/app_large_text.dart';
import 'package:my_first_app/widgets/app_text.dart';

import '../../cubit/app_cubit_states.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // list to store the card image names
  var image = {
    "balloning.png": "Balloning",
    "hiking.png": "Hiking",
    "kayaking.png": "Kayaking",
    "snorkling.png": "Snorkling"
  };
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(body: BlocBuilder<AppCubits, CubitStates>(
      builder: (context, state) {
        // if state is loaded successfully
        if (state is LoadedState) {
          // fetch the places list
          var info = state.places;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // heading and profile image
                Container(
                  padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
                  child: Row(children: [
                    const Icon(
                      Icons.menu,
                      size: 30,
                      color: Colors.black54,
                    ),
                    Expanded(child: Container()),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.5)),
                    ),
                  ]),
                ),

                // spacing
                const SizedBox(
                  height: 40,
                ),

                // heading (discover)
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: AppLargeText(text: "Discover"),
                ),

                // spacing
                const SizedBox(
                  height: 30,
                ),

                // tab bar headings
                Container(
                  child: Align(
                    // alignment: Alignment.centerLeft,
                    child: TabBar(
                        labelPadding:
                            const EdgeInsets.only(left: 20, right: 20),
                        controller: _tabController,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        // isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: const CircleTabIndicator(
                            color: AppColors.mainColor, radius: 4),
                        tabs: const [
                          Tab(text: "Places"),
                          Tab(text: "Inspiration"),
                          Tab(text: "Emotions"),
                        ]),
                  ),
                ),

                // card list for tab view
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  height: 300,
                  width: double.maxFinite,
                  // tab bar view
                  child: TabBarView(controller: _tabController, children: [
                    ListView.builder(
                      itemCount: info.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            BlocProvider.of<AppCubits>(context)
                                .detailPage(info[index]);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 15, top: 10),
                            width: 200,
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              image: DecorationImage(
                                image: NetworkImage(
                                    "http://mark.bslmeiyu.com/uploads/${info[index].img}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ]),
                ),

                // spacing
                const SizedBox(
                  height: 30,
                ),
                // explore more section and see all text
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(children: [
                    AppLargeText(
                      text: "Explore more",
                      size: 20,
                    ),
                    Expanded(child: Container()),
                    AppText(
                      text: "See all",
                      color: AppColors.textColor1,
                    )
                  ]),
                ),

                // spacing
                const SizedBox(
                  height: 10,
                ),

                // small card list showing explore more
                Container(
                  height: 100,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  width: double.maxFinite,
                  child: ListView.builder(
                    // for 4 cards
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      // each card as container
                      return Container(
                        // margin in right side
                        margin: const EdgeInsets.only(right: 20),
                        // height of card
                        height: 120,
                        // column to represent image and text
                        child: Column(
                          children: [
                            // container to contain image and apply decoration
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/${image.keys.elementAt(index)}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // distance between image and text
                            const SizedBox(
                              height: 10,
                            ),
                            // text below image
                            AppText(
                              text: image.values.elementAt(index),
                              color: AppColors.textColor2,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    ));
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  final double radius;

  const CircleTabIndicator({required this.color, required this.radius});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;

  _CirclePainter({required this.color, required this.radius});
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint paint = Paint();
    paint.color = color;
    paint.isAntiAlias = true;
    final Offset circleOffset = offset +
        Offset(configuration.size!.width / 2 - radius / 2,
            configuration.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, paint);
  }
}
