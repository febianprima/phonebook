import 'package:flutter/material.dart';
import '../model/contact.dart';

class FormCreateContact extends StatelessWidget {
  FormCreateContact(
      {Key? key, required this.onAddContact})
      : super(key: key);
  void Function(Contact) onAddContact;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  label: const Text('Name'), prefixIcon: Icon(Icons.person)),
              validator: (String? value) {
                if (value == '' || value!.isEmpty) {
                  return 'Name is a required!';
                }
              },
            ),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                  label: const Text('Phone Number'),
                  prefixIcon: Icon(Icons.phone)),
              keyboardType: TextInputType.phone,
              validator: (String? value) {
                if (value == '' || value!.isEmpty) {
                  return 'Phone number is a required!';
                }
              },
            ),
            Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Save'),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      onAddContact(Contact(
                          name: nameController.text,
                          phone: phoneController.text));
                      nameController.clear();
                      phoneController.clear();
                    }
                  },
                ))
          ],
        ));
  }
}
