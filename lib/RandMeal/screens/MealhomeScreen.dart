// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onestop_api/RandMeal/screens/recipeScreen.dart';

import '../providers/meal_provider.dart';

class MealhomeScreen extends ConsumerWidget {
  const MealhomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.jpg'), fit: BoxFit.cover)),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            height: MediaQuery.of(context).size.height * 0.45,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Feeling hungry?',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent),
                    onPressed: () {
                      ref.refresh(mealProvider);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => recipeScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Show a recipe !!',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    )),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                  'How to use:\n\n1. Click on "Show a recipe" button to generate a delicious recipe.\n\n2. You can see the Ingredients and follow the instructions to make the food.\n\n3. You can also watch the Youtube tutorials provided inside the application. \n\n4. Everytime this application generates a random food.\n\n*NOTE*\n\nThis application uses the MealDB API to fetch all the recipes.'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'))
                              ],
                            );
                          });
                    },
                    icon: const Icon(Icons.info_outline, color: Colors.black))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
