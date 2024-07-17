import 'package:accordion/accordion.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:tasklist_recipes_chat/core/constants/assets.dart';
import 'package:tasklist_recipes_chat/features/recipies/data/models/recipie.dart';
import 'package:tasklist_recipes_chat/features/recipies/presentation/widgets/details_tile.dart';
import 'package:tasklist_recipes_chat/features/recipies/presentation/widgets/recipie_accordion_section.dart';
import 'package:tasklist_recipes_chat/features/recipies/presentation/widgets/recipie_card_item.dart';

class RecipiesDetailsScreen extends StatelessWidget {
  const RecipiesDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final recipie = ModalRoute.of(context)!.settings.arguments as Recipie;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[400],
        title: const Text(
          'Recipie Details',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: recipie.id!,
              child: CachedNetworkImage(
                errorListener: (value) {},
                imageUrl: recipie.imageUrl ?? kFailedRecipieLink,
                errorWidget: (context, url, error) => Image.asset(
                  kFailedRecipieAsset,
                  fit: BoxFit.cover,
                ),
                fit: BoxFit.cover,
                height: 200.h,
                width: double.infinity,
                progressIndicatorBuilder: (context, url, progress) =>
                    SkeletonAnimation(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(color: Colors.grey[400]!),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(18.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipie.name!,
                    style: GoogleFonts.cookie(
                      color: Colors.black87,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(
                    color: Colors.deepOrange[200],
                    thickness: 1.sp,
                    height: 20.sp,
                  ),
                  recipie.course != null
                      ? DetailsTile(
                          title: 'Course: ',
                          value: recipie.course!,
                          padding: 0.sp,
                        )
                      : const SizedBox(),
                  Divider(
                    color: Colors.deepOrange[200],
                    thickness: 1.sp,
                    height: 20.sp,
                  ),
                  recipie.diet != null
                      ? DetailsTile(
                          title: 'Diet: ',
                          value: recipie.diet!,
                          padding: 0.sp,
                        )
                      : const SizedBox(),
                  Divider(
                    color: Colors.deepOrange[200],
                    thickness: 1.sp,
                    height: 20.sp,
                  ),
                  recipie.cuisine != null
                      ? DetailsTile(
                          title: 'Cuisine: ',
                          value: recipie.cuisine!,
                          padding: 0.sp,
                        )
                      : const SizedBox(),
                  Divider(
                    color: Colors.deepOrange[200],
                    thickness: 1.sp,
                    height: 20.sp,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      recipie.prepTimeInMins != null
                          ? RecipieItemCard(
                              padding: 8.sp,
                              iconSize: 40.sp,
                              fontSize: 12.sp,
                              time: recipie.prepTimeInMins!,
                              icon: kPrepAsset,
                            )
                          : const SizedBox(),
                      recipie.cookTimeInMins != null
                          ? RecipieItemCard(
                              padding: 8.sp,
                              iconSize: 40.sp,
                              fontSize: 12.sp,
                              time: recipie.cookTimeInMins ?? 0,
                              icon: kCookingAsset,
                            )
                          : const SizedBox(),
                    ],
                  ),
                  Accordion(
                      maxOpenSections: 3,
                      scaleWhenAnimating: false,
                      disableScrolling: true,
                      paddingListHorizontal: 0.sp,
                      children: [
                        recipieAccordionSection(
                          isOpen: true,
                          title: 'Description',
                          value: recipie.description ?? 'No description',
                          icon: Icons.description,
                          color: Colors.deepOrange[700]!,
                          borderColor: Colors.deepOrange[700]!,
                        ),
                        recipieAccordionSection(
                          isOpen: true,
                          title: 'Ingredients',
                          value: recipie.ingredientsQuantity ??
                              recipie.ingredientsName ??
                              'No ingredients found',
                          icon: Icons.shopping_cart,
                          color: Colors.orange[700]!,
                          borderColor: Colors.orange[700]!,
                        ),
                        recipieAccordionSection(
                          isOpen: true,
                          title: 'Instructions',
                          value:
                              recipie.instructions ?? 'No instructions found',
                          icon: Icons.cookie_outlined,
                          color: Colors.orangeAccent,
                          borderColor: Colors.orangeAccent[700]!,
                        ),
                      ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
