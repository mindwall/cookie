import 'package:flutter/material.dart';

class Recipe {
  int id;
  String title;
  String cusine;

  String time;
  bool favorite;
  List<Ingredient> ingridient;
  AssetImage image;
  List<Step> steps;
  String notes;
  String cook;
  int cooked;

  Recipe(
      {this.id,
      this.title,
      this.cusine,
      this.time,
      this.favorite,
      this.cook,
      this.cooked,
      this.image,
      this.ingridient,
      this.notes,
      this.steps});
}

class Step {
  int orderId;
  String action;
  String time;
  Ingredient ingridient;

  Step({this.orderId, this.action, this.ingridient, this.time});
}

class Ingredient {
  String name;
  String category;
  bool isEmpty = false;
  String measurement;

  Ingredient(
      {this.category, this.isEmpty = false, this.name, this.measurement});
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
