import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:world_famous_landmarks/data/models/landmark_model.dart';
import 'package:world_famous_landmarks/res/colors/app_colors.dart';
import 'package:world_famous_landmarks/res/dimensions/app_dimensions.dart';
import 'package:world_famous_landmarks/res/styles/text_styles.dart';

class LandmarkInfoScreen extends StatefulWidget {
  const LandmarkInfoScreen({super.key, required this.landmark});

  final Landmark landmark;

  @override
  State<LandmarkInfoScreen> createState() => _LandmarkInfoScreenState();
}

class _LandmarkInfoScreenState extends State<LandmarkInfoScreen> {
  ScrollController parentScrollController = ScrollController();
  ScrollController childScrollController = ScrollController();

  ScrollPhysics parentScrollPhysics = const BouncingScrollPhysics();
  ScrollPhysics childScrollPhysics = const NeverScrollableScrollPhysics();

  @override
  void initState() {
    parentScrollController.addListener(parentScrollControllerListener);
    childScrollController.addListener(childScrollControllerListener);
    super.initState();
  }

  void parentScrollControllerListener() {
    if (parentScrollController.position.pixels ==
            parentScrollController.position.maxScrollExtent &&
        childScrollController.position.pixels ==
            childScrollController.position.minScrollExtent) {
      setState(() {
        parentScrollPhysics = const NeverScrollableScrollPhysics();
        childScrollPhysics = const ClampingScrollPhysics();
      });
    }
  }

  void childScrollControllerListener() {
    if (childScrollController.position.pixels ==
        childScrollController.position.minScrollExtent) {
      setState(() {
        parentScrollPhysics = const BouncingScrollPhysics();
        childScrollPhysics = const NeverScrollableScrollPhysics();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhiteColor,
        body: Stack(
          children: [
            SizedBox(
              height: 60.h,
              child: Image.network(
                widget.landmark.photoUrl!,
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              controller: parentScrollController,
              physics: parentScrollPhysics,
              child: Column(
                children: [
                  SizedBox(
                    height: 57.h,
                  ),
                  Container(
                    constraints:
                        BoxConstraints(minHeight: 60.h, maxHeight: 85.h),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: kPageHorizontalPadding,
                        vertical: kPageVerticalPadding / 2),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: kWhiteColor),
                    child: SingleChildScrollView(
                      controller: childScrollController,
                      physics: childScrollPhysics,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.landmark.name!,
                              style: TextStyles.headingLarge(),
                            ),
                            Text(widget.landmark.description!,
                                style: TextStyles.bodyMedium())
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 30,
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: kWhiteColor,
                  icon: const Icon(
                    Icons.arrow_back,
                  )),
            ),
          ],
        ));
  }
}
