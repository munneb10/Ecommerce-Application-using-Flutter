import 'package:shared_preferences/shared_preferences.dart';

class UserStorage {
  // static AllProductState products = AllProductState();
  static SharedPreferneces userstorage = SharedPreferneces(null);

  static void write(String key, String value) async {
    await userstorage.write(key, value);
  }

  static void deletekey(var key) async {
    await userstorage.deletekey(key);
  }

  static Future<String?> read(var key) async {
    return await userstorage.read(key);
  }
}

class SharedPreferneces {
  var userstorage;
  bool isInitialized = false;
  SharedPreferneces(this.userstorage);
  Future<void> confirmInitialized() async {
    if (!isInitialized) {
      userstorage = await SharedPreferences.getInstance();
      isInitialized = true;
    }
  }

  Future<void> write(String key, String value) async {
    await confirmInitialized();
    await userstorage.setString(key, value);
  }

  Future<void> deletekey(var key) async {
    await confirmInitialized();
    await userstorage.remove(key);
  }

  Future<String?> read(var key) async {
    // return "";
    await confirmInitialized();
    return userstorage.getString(key);
  }
}
