class Recipie {
  String? id;
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

  Recipie({
    this.name,
    this.description,
    this.cuisine,
    this.course,
    this.diet,
    this.ingredientsName,
    this.ingredientsQuantity,
    this.prepTimeInMins,
    this.cookTimeInMins,
    this.instructions,
    this.imageUrl,
    this.id,
  });

  factory Recipie.fromJson(Map<String, dynamic> json) => Recipie(
        id: json['id'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        cuisine: json['cuisine'] as String?,
        course: json['course'] as String?,
        diet: json['diet'] as String?,
        ingredientsName: json['ingredients_name'] as String?,
        ingredientsQuantity: json['ingredients_quantity'] as String?,
        prepTimeInMins: (json['prep_time (in mins)'] as double?)?.toInt(),
        cookTimeInMins: (json['cook_time (in mins)'] as double?)?.toInt(),
        instructions: json['instructions'] as String?,
        imageUrl: json['image_url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
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
