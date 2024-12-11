import 'package:fluttah/main.dart';
import 'package:fluttah/riverpod/ability_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_page.dart';

class AddAbilityPage extends ConsumerWidget {
  AddAbilityPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController maxUsesController = TextEditingController();

  void onSubmit(BuildContext context,WidgetRef ref) {
    //Process data
    String name = nameController.text;
    int number = int.parse(
        maxUsesController.text); //already validated, will always be a number.
    ref
        .read(abilityNotifierProvider.notifier)
        .addAbility(Ability(name: name, maxUses: number));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Ability"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20,left: 50,right: 50),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                textAlign: TextAlign.center,
                controller: nameController,
                decoration: const InputDecoration(hintText: "Enter a name"),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "This field is required";
                  }
                },
              ),
              TextFormField(
                textAlign: TextAlign.center,
                controller: maxUsesController,
                decoration: const InputDecoration(hintText: "Enter the max uses"),
                validator: (String? value) {
                  int? integer = int.tryParse(value!);
                  if (integer == null) {
                    return "Please enter a number";
                  } else {
                    return null;
                  }
                },
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        onSubmit(context,ref);
                      }
                    },
                    child: const Text("Submit"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
