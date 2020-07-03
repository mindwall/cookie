import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookie/services/Models.dart';
import 'package:flutter/material.dart';
import 'package:cookie/services/services.dart';

import 'IngridientsData.dart';

List<Recipe> cookBook = [omelette, saltCrustedDorade, tomatoBasilPasta];

Recipe omelette = Recipe(
    cook: 'Ivan',
    cusine: 'european',
    title: 'Omelette with cheese',
    time: '25 min',
    favorite: true,
    ingredient: omeletteIng,
    image: AssetImage("assets/Omelette.jpg"));

/* Recipe omeletteDB = Recipe(
    cook: 'Ivan',
    cusine: 'european',
    title: 'Omelette with cheese',
    time: '25 min',
    favorite: true,
    ingredient: omeletteIngredients,
    image: AssetImage("assets/Omelette.jpg")); */

Recipe saltCrustedDorade = Recipe(
    cook: 'Nati',
    cusine: 'european',
    title: 'Salt crusted Dorade',
    time: '45 Mins',
    ingredient: saltCrustedDoradeIng,
    favorite: true,
    image: AssetImage("assets/SaltCrustedDorade.jpeg"));

Recipe tomatoBasilPasta = Recipe(
    cook: 'Ivan',
    cusine: 'european',
    title: 'Pasta with fresh Tomatoes and Basil',
    time: '25 Mins',
    ingredient: saltCrustedDoradeIng,
    favorite: true,
    image: AssetImage("assets/TomatoBasilPasta.jpg"));

void write() async {
  final Firestore _dB = Firestore.instance;
  _dB.collection('Recipes').add(tomatoBasilPasta.toJson());
}

// doc = _dB.collection('Ingredients').where('name' isEqual to tappedOn)
