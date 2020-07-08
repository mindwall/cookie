import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Recipe {
  String uid;
  String title;
  String cusine;

  String time;
  bool favorite;
  List<Ingredient> ingredient;
  AssetImage image;
  NetworkImage imageDB;
  List<Steps> steps;
  String notes;
  String cook;
  int cooked;

  Recipe(
      {this.uid,
      this.title,
      this.cusine,
      this.time,
      this.favorite,
      this.cook,
      this.cooked,
      this.image,
      this.imageDB,
      this.ingredient,
      this.notes,
      this.steps});

  factory Recipe.fromMap(Map data) {
    return Recipe(
        title: data['name'] ?? '',
        time: data['time'] ?? '',
        cusine: data['cusine'] ?? '',
        favorite: data['favorite'] ?? false,
        cook: data['cook'] ?? '',
        cooked: data['cooked'] ?? 0,
        imageDB: NetworkImage(data['image']),
        steps: (data['steps'] ?? []).map((v) => Steps.fromMap(v)).toList(),
        ingredient: (data['Ingredients'] ?? [])
            .map((v) => Ingredient.fromMap(v))
            .toList());
  }
  Map<String, dynamic> toJson() => {
        'title': title,
        'time': time,
        'cusine': cusine,
        'uid': uid,
        'favorite': favorite,
        'cook': cook,
        'cooked': cooked,
        'steps': steps.map((e) => e.action).toList(),
        'ingredients': ingredient
            .map((e) =>
                Firestore.instance.collection('Ingredients').document(e.name))
            .toList(),
        'image': imageDB.url,
      };
}

class Steps {
  int orderId;
  String action;
  String time;
  Ingredient ingridient;

  Steps({this.orderId, this.action, this.ingridient, this.time});
  factory Steps.fromMap(Map data) {
    return Steps(
      orderId: data['orderId'] ?? '',
      action: data['action'] ?? '',
      ingridient: data['Ingredient'] ?? '',
      time: data['time'] ?? '',
    );
  }
}

class Ingredient {
  String name;
  String category;
  bool isEmpty = false;
  String measurement;
  String quantity;
  bool isSelected = false;

  Ingredient(
      {this.category,
      this.isEmpty = false,
      this.name,
      this.measurement,
      this.quantity,
      this.isSelected});

  factory Ingredient.fromMap(Map data) {
    return Ingredient(
      name: data['name'] ?? '',
      quantity: data['quantity'] ?? '',
      category: data['category'] ?? '',
      isEmpty: data['isEmpty'] ?? false,
      isSelected: data['isSelected'] ?? false,
      measurement: data['measurement'] ?? '',
    );
  }
  Map<String, dynamic> toJson() => {
        'name': name,
        'category': category,
        'isEmpty': isEmpty,
        'measurement': measurement,
        'isSelected': isSelected
      };
}

// Essentials, Vegetables, Fruits, Spcices & Herbs, Diary, Meat, Seafood, Nuts, Oils & Vinegars, Grains, Sweatners,
//Cans, Beans & Legumes, Basics(produce), greens, bakery, pasta, snacks, drinks  Others

class Vegetable extends Ingredient {
  Vegetable(String name)
      : super(name: name, category: 'vegetable', measurement: 'Gramms');
}

class Fruit extends Ingredient {
  Fruit(String name)
      : super(name: name, category: 'fruit', measurement: 'Gramms');
}

class Spice extends Ingredient {
  Spice(String name)
      : super(name: name, category: 'Spices', measurement: 'tbsp');
}

class Dairy extends Ingredient {
  Dairy(String name) : super(name: name, category: 'Dairy', measurement: 'ml');
}

class Meat extends Ingredient {
  Meat(String name)
      : super(name: name, category: 'Meats', measurement: 'Gramms');
}

class Seafood extends Ingredient {
  Seafood(String name)
      : super(name: name, category: 'Seafood', measurement: 'Gramms');
}

class Nut extends Ingredient {
  Nut(String name) : super(name: name, category: 'Nuts', measurement: 'Gramms');
}

class Oil extends Ingredient {
  Oil(String name) : super(name: name, category: 'Oils', measurement: 'ml');
}

class Grain extends Ingredient {
  Grain(String name)
      : super(name: name, category: 'Grains', measurement: 'Gramms');
}

class Sweetner extends Ingredient {
  Sweetner(String name)
      : super(name: name, category: 'Sweetnes', measurement: 'ml');
}

class Canned extends Ingredient {
  Canned(String name)
      : super(name: name, category: 'Canned', measurement: 'Gramms');
}

class Legume extends Ingredient {
  Legume(String name)
      : super(name: name, category: 'Legumes', measurement: 'Gramms');
}

class Basic extends Ingredient {
  Basic(String name)
      : super(name: name, category: 'Basic', measurement: 'piece');
}

class Pasta extends Ingredient {
  Pasta(String name)
      : super(name: name, category: 'Pasta', measurement: 'Serving');
}

class Snack extends Ingredient {
  Snack(String name)
      : super(name: name, category: 'Snacks', measurement: 'piece');
}

class Drink extends Ingredient {
  Drink(String name) : super(name: name, category: 'Drinks', measurement: 'ml');
}
