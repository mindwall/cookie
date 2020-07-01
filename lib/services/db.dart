import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookie/localData/IngridientsData.dart';
import 'package:cookie/localData/RecipeData.dart';
import 'package:cookie/services/services.dart';

class DatabaseService {
  final Firestore _dB = Firestore.instance;

  Future<Recipe> getRecipe(recipeId) {
    return _dB
        .collection('Recipes')
        .document(recipeId)
        .get()
        .then((value) => Recipe.fromMap(value.data));
  }

  static loadData() async {
    var data = await DatabaseService().getRecipe('2y5K9oD5uSNbbhif2Hhy');
    return data;
  }
/* 
  void write() async {
    _dB.collection('Recipes').add(omeletteDB.toJson());
  } */

  getAllIngredients() async {
    List<Ingredient> ingredientsList = [];
    final allIngredients = await _dB.collection('Ingredients').getDocuments();
    allIngredients.documents.forEach((element) {
      Ingredient a = Ingredient.fromMap(element.data);
      ingredientsList.add(a);
    });

    return ingredientsList;
  }

  void addIngredients(
    List array,
    String cat,
    String mes,
  ) {
    array.forEach((element) {
      _dB.collection('Ingredients').add({
        'name': element,
        'category': cat,
        'isEmpty': false,
        'measurement': mes,
      });
    });
  }

  void delete(String searchBy, String query) {
    /*  WriteBatch batch = _dB.batch();
    DocumentReference allIngredients; */
    _dB
        .collection('Ingredients')
        .where(searchBy, isEqualTo: query)
        .getDocuments()
        .then((value) {
      for (DocumentSnapshot ds in value.documents) {
        ds.reference.delete();
      }
    });

    /* batch.delete(allIngredients); */
  }
}