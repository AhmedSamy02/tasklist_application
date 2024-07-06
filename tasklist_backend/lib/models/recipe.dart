import 'package:mongo_dart/mongo_dart.dart';

class Recipe {
  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.cuisine,
    required this.course,
    required this.diet,
    required this.ingredientsName,
    required this.ingredientsQuantity,
    required this.prepTimeInMins,
    required this.cookTimeInMins,
    required this.instructions,
    required this.imageUrl,
  });
  ObjectId? id;
  String? name;
  String? description;
  String? cuisine;
  String? course;
  String? diet;
  String? ingredientsName;
  String? ingredientsQuantity;
  int? prepTimeInMins;
  int? cookTimeInMins;
  String? instructions;
  String? imageUrl;
  
}
