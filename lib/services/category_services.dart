import 'package:shared_preferences/shared_preferences.dart';

class CategoryService {
  static const String _selectedCategoryKey = 'selectedCategory';

  static Future<void> saveSelectedCategory(String categoryName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedCategoryKey, categoryName);
  }

  static Future<String?> loadSelectedCategory() async {
    final prefs = await SharedPreferences.getInstance();
    String? categoryName = prefs.getString(_selectedCategoryKey);

    // Check if categoryName is null and return a default value if necessary
    categoryName ??= 'animal';
    // categoryName ??= 'Animal';
    return categoryName;
  }
}