import 'package:flutter/material.dart';
import '../widget/form_create_contact.dart';
import '../model/contact.dart';
import '../services/contact.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final contactService = ContactService();
  late Future<List<Contact>> contacts;

  @override
  initState() {
    super.initState();
    contacts = contactService.getAll();
  }

  onAddContact(BuildContext context, Contact contact) async {
    await contactService.add(contact);
    setState(() {
      contacts = contactService.getAll();
    });
    Navigator.of(context, rootNavigator: true).pop();
  }

  showAddContactForm(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: const Text('Add Contact'),
            content: FormCreateContact(onAddContact: ((Contact contact) {
              onAddContact(context, contact);
            }))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('My Phonebook'), actions: [
          Builder(
              builder: (context) => IconButton(
                  onPressed: () {
                    showAddContactForm(context);
                  },
                  icon: const Icon(Icons.person_add_alt_1_sharp)))
        ]),
        body: FutureBuilder(
            future: contacts,
            builder: (context, AsyncSnapshot<List<Contact>> result) {
              List<Contact> contactsFromFuture = result.data ?? [];
              return ListView.builder(
                itemCount: contactsFromFuture.length,
                itemBuilder: (context, i) {
                  Contact contact = contactsFromFuture[i];
                  return ListTile(
                    title: Text(contact.name),
                    subtitle: Text(contact.phone),
                  );
                },
              );
            }));
  }
}
