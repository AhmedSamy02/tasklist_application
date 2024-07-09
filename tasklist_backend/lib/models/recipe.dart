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

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['_id'] as ObjectId,
      name: json['name'] as String,
      description: json['description'] as String,
      cuisine: json['cuisine'] as String,
      course: json['course'] as String,
      diet: json['diet'] as String,
      ingredientsName: json['ingredients_name'] as String,
      ingredientsQuantity: json['ingredients_quantity'] as String,
      prepTimeInMins: json['prep_time (in mins)'] as int,
      cookTimeInMins: json['cook_time (in mins)'] as int,
      instructions: json['instructions'] as String,
      imageUrl: json['image_url'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id.oid,
      'name': name,
      'description': description,
      'cuisine': cuisine,
      'course': course,
      'diet': diet,
      'ingredients_name': ingredientsName,
      'ingredients_quantity': ingredientsQuantity,
      'prep_time (in mins)': prepTimeInMins,
      'cook_time (in mins)': cookTimeInMins,
      'instructions': instructions,
      'image_url': imageUrl,
    };
  }

  final ObjectId id;
  final String name;
  final String description;
  final String cuisine;
  final String course;
  final String diet;
  final String ingredientsName;
  final String ingredientsQuantity;
  final int prepTimeInMins;
  final int cookTimeInMins;
  final String instructions;
  final String imageUrl;
}
