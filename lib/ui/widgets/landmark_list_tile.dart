import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:world_famous_landmarks/bloc/landmarks/landmarks_bloc.dart';
import 'package:world_famous_landmarks/data/models/landmark_model.dart';
import 'package:world_famous_landmarks/res/colors/app_colors.dart';
import 'package:world_famous_landmarks/res/dimensions/app_dimensions.dart';
import 'package:world_famous_landmarks/res/styles/text_styles.dart';

class LandmarkListTile extends StatelessWidget {
  const LandmarkListTile({
    super.key,
    required this.landmark,
  });

  final Landmark landmark;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(kCardPadding),
      height: 100.h,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(kCardBorderRadius)),
        color: kCardColor,
      ),
      child: InkWell(
        onTap: () {
          context
              .read<LandmarksBloc>()
              .add(LandmarksClickLandmarkTileEvent(landmark: landmark));
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                  Radius.circular(kCardBorderRadius - 5)),
              child: Image.network(
                landmark.photoUrl!,
                fit: BoxFit.cover,
                width: 100.w,
                height: 100.h,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  landmark.name!,
                  style: TextStyles.bodySmallBold(),
                ),
                Text(
                  landmark.description!,
                  style: TextStyles.bodyVerySmall(),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
