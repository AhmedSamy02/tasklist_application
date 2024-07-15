import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasklist_recipes_chat/features/recipies/data/models/recipie.dart';

class RecipiesDetailsScreen extends StatelessWidget {
  const RecipiesDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final recipie = ModalRoute.of(context)!.settings.arguments as Recipie;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipie Details'),
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          Hero(
            tag: recipie.id!,
            child: CachedNetworkImage(
              imageUrl: recipie.imageUrl!,
              height: 250.h,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(18.sp),
            child: Column(
              children: [
                Text(recipie.name!), Text(recipie.description!),
                Text('Prep Time: ${recipie.prepTimeInMins} mins'),
                Text('Cook Time: ${recipie.cookTimeInMins} mins'),
                Text('Cuisine: ${recipie.cuisine}'),
                Text('Course: ${recipie.course}'),
                Text('Diet: ${recipie.diet}'),
                // Text('Ingredients: ${recipie.ingredientsName}'),
                // Text('Ingredients Quantity: ${recipie.ingredientsQuantity}'),
                // Text('Instructions: ${recipie.instructions}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
