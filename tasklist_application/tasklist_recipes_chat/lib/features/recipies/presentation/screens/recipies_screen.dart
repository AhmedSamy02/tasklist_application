import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tasklist_recipes_chat/core/constants/values.dart';
import 'package:tasklist_recipes_chat/features/recipies/data/models/recipie.dart';
import 'package:tasklist_recipes_chat/features/recipies/presentation/controllers/recipies_controller.dart';
import 'package:tasklist_recipes_chat/features/recipies/presentation/widgets/loading_recipie_item.dart';
import 'package:tasklist_recipes_chat/features/recipies/presentation/widgets/recipie_list_item.dart';

class RecipiesScreen extends StatefulWidget {
  const RecipiesScreen({super.key});

  @override
  State<RecipiesScreen> createState() => _RecipiesScreenState();
}

class _RecipiesScreenState extends State<RecipiesScreen> {
  static const _pageSize = 20;
  final PagingController<int, Recipie> _pagingController =
      PagingController(firstPageKey: 0);
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      getit.get<RecipiesController>().getRecipies(
            page: pageKey,
            limit: _pageSize,
            controller: _pagingController,
            context: context,
          );
    });
    super.initState();
  }

  final testRecipie = Recipie(
    name: 'Recipe Bed Belts',
    description:
        "Chingiri Paturi or Prawn Paturi is a famous traditional dish from Bengal cuisine that also belongs to the coastal region of West Bengal. Prawns cooked with minimum ingredients are parceled in banana leaf and then steamed is a delicious recipe that comes from my mother's diary. The dish is typically enjoyed with plain hot rice with a tinge of lemon on it.",
    imageUrl:
        'https://www.archanaskitchen.com/images/archanaskitchen/1-Author/Shaheen_Ali/CHINGIRI_PATURI__PRAWN_PATURI.jpg',
    prepTimeInMins: 10,
    cookTimeInMins: 35,
    cuisine: 'Bengali Recipes',
    course: 'Lunch',
    diet: 'Non Vegeterian',
    ingredientsName:
        'Prawns, Poppy seeds, Mustard seeds (Rai/ Kadugu), Fresh coconut, Green Chillies, Salt, Mustard oil, Lemon juice, Banana leaf',
    ingredientsQuantity:
        '500 grams Prawns , medium size  1/2 cup Poppy seeds  1/3 cup Mustard seeds (Rai/ Kadugu)  1/2 cup Fresh coconut , grated  4 Green Chillies  1/2 teaspoon Salt , adjustable  3 tablespoon Mustard oil  1 teaspoon Lemon juice  1 Banana leaf , big (cut into 4 halves)',
    id: '6683fff2c40f44ab839abb89',
    instructions:
        'To begin with the Chingiri Paturi Recipe start by soaking khus khus for minimum 3 to 4 hours or overnight.Wash and clean prawns nicely in salt water to remove that fishy smell.In a grinder jar, take soaked khuskhus, mustard seeds, green chilies and grated coconut. Grind to make a thick & smooth paste.Add salt as per taste and mustard oil in the paste. Mix well and keep aside.Heat 2 cups of water in a pan and add few drops of lemon juice and 2 pinch of salt.As soon as the water starts boiling, add prawns and turn off the gas and remove pan from the stove and keep aside for few minutes.The prawns will blanch and also get properly cleaned. After a while, drain water and collect the prawns and keep aside.Heat mustard oil in a non stick pan and saute the prawns for 2-3 mins. Divide the prawns in four equal portions and keep aside.For making leaf parcels, first take a banana leaf and heat on stove top very carefully from both sides. Keep the leaf high from flames to avoid getting burnt. By doing this the leaf will soften and get easily folded like a fabric without tearing apart. Do this for all for pieces of leaf and keep aside.Now take a banana leaf piece and place around of khuskhus paste in the center.Now add one portion of sauteed prawns on the paste. Gently mix such that the paste coats all over the prawns.Add some more paste over the prawns and around mustard oil on top.Carefully fold the two opposite sides of the leaf inwards and then the next two sides inwards to make parcels.Tie the packet cris-cros with thread and put a knot. Make other parcels following the same method and keep aside.Heat a non stick pan that has a lid. Brush some mustard oil all over.Place the parcels on the pan and cover the lid.Steam the parcels in low flames for 10 mins or till you find the color of leaf changing.Carefully flip the parcel and steam from the other side as well. This might take 15-20 mins in total.Turn of the gas and carefully transfer the parcels on the serving plate and serve hot with plain steamed rice.Do not open the parcel before serving, they shall be opened by the one who is about to relish this delicacy.Enjoy the Chingiri Paturi Recipe with some hot rice and samar for amazing lunch.',
  );
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _pagingController.refresh();
        return;
      },
      child: PagedListView(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Recipie>(
            itemBuilder: (context, recipie, index) {
              return RecipieListItem(recipie: recipie);
            },
            firstPageProgressIndicatorBuilder: (context) {
              return const Column(
                children: [
                  LoadingRecipieItem(),
                  LoadingRecipieItem(),
                  LoadingRecipieItem(),
                  LoadingRecipieItem(),
                ],
              );
            },
          )),
    );
  }
}
