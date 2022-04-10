import 'package:shared_preferences/shared_preferences.dart';

import '../model/contact.dart';

class ContactService {
  Future<List<String>> _getBaseContacts() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    List<String> fromStorage = storage.getStringList('contacts') ?? [];
    return fromStorage;
  }

  Future<List<Contact>> getAll() async {
    final fromStorage = await _getBaseContacts();
    return fromStorage.map((e) => Contact.fromJSON(e)).toList();
  }

  Future<void> add(Contact contact) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final fromStorage = await _getBaseContacts();
    fromStorage.add(contact.toJSON());
    storage.setStringList('contacts', fromStorage);
  }
}
