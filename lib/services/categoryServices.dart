import 'package:shared_preferences/shared_preferences.dart';

class CategoryService {
  static const String _selectedCategoryKey = 'selectedCategory';

  static Future<void> saveSelectedCategory(String categoryName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedCategoryKey, categoryName);
  }

  static Future<String?> loadSelectedCategory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_selectedCategoryKey);
  }
}