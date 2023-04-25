import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal_model.dart';
import '../repository/meal_repository.dart';

final mealProvider = FutureProvider<MealModel>((ref) {
  return MealRepo().getMeal();
});
