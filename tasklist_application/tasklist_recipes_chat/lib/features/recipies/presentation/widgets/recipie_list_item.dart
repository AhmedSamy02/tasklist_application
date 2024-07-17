import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:tasklist_recipes_chat/core/constants/assets.dart';
import 'package:tasklist_recipes_chat/core/constants/screens.dart';
import 'package:tasklist_recipes_chat/features/recipies/data/models/recipie.dart';
import 'package:tasklist_recipes_chat/features/recipies/presentation/widgets/recipie_card_item.dart';

class RecipieListItem extends StatelessWidget {
  const RecipieListItem({super.key, required this.recipie});
  final Recipie recipie;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          kRecipieDetailsScreen,
          arguments: recipie,
        );
      },
      child: Container(
        margin: EdgeInsets.all(18.sp),
        height: 130.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.dg),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Hero(
                tag: recipie.id!,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.dg),
                    bottomLeft: Radius.circular(10.dg),
                  ),
                  child: CachedNetworkImage(
                    errorListener: (value) {},
                    imageUrl: recipie.imageUrl ?? kFailedRecipieLink,
                    errorWidget: (context, url, error) => Image.asset(
                      kFailedRecipieAsset,
                      fit: BoxFit.cover,
                    ),
                    fit: BoxFit.cover,
                    height: 150.h,
                    progressIndicatorBuilder: (context, url, progress) =>
                        SkeletonAnimation(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(color: Colors.grey[400]!),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 18.sp, vertical: 10.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(recipie.name!,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w600)),
                    Padding(
                      padding: EdgeInsets.only(top: 3.sp),
                      child: Text(recipie.course!,
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.deepOrange[300],
                              fontWeight: FontWeight.w600)),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        recipie.prepTimeInMins!=null? RecipieItemCard(
                          time: recipie.prepTimeInMins ?? 0,
                          icon: kPrepAsset,
                        ):const SizedBox(),
                        recipie.prepTimeInMins!=null? RecipieItemCard(
                          time: recipie.cookTimeInMins ?? 0,
                          icon: kCookingAsset,
                        ):const SizedBox(),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
