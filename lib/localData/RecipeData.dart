import 'package:cookie/services/Models.dart';
import 'package:flutter/material.dart';

import 'IngridientsData.dart';

List<Recipe> cookBook = [omelette, saltCrustedDorade, tomatoBasilPasta];

Recipe omelette = Recipe(
    cook: 'Ivan',
    cusine: 'european',
    title: 'Omelette with cheese',
    time: '25 min',
    favorite: true,
    ingridient: omeletteIng,
    image: AssetImage("assets/Omelette.jpg"));

Recipe saltCrustedDorade = Recipe(
    cook: 'Nati',
    cusine: 'european',
    title: 'Salt crusted Dorade',
    time: '45 Mins',
    ingridient: saltCrustedDoradeIng,
    favorite: true,
    image: AssetImage("assets/SaltCrustedDorade.jpeg"));

Recipe tomatoBasilPasta = Recipe(
    cook: 'Ivan',
    cusine: 'european',
    title: 'Pasta with fresh Tomatoes and Basil',
    time: '25 Mins',
    ingridient: saltCrustedDoradeIng,
    favorite: true,
    image: AssetImage("assets/TomatoBasilPasta.jpg"));
