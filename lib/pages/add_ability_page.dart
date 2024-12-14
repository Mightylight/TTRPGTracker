import 'package:fluttah/main.dart';
import 'package:fluttah/riverpod/ability_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_page.dart';

class AddAbilityPage extends ConsumerStatefulWidget {
  AddAbilityPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController maxUsesController = TextEditingController();
  TextEditingController resetTypeController = TextEditingController();

  ResetType? currentSelectedResetType;

  void onSubmit(BuildContext context,WidgetRef ref) {
    //Process data
    String name = nameController.text;
    ResetType resetType = currentSelectedResetType == null ? ResetType.LongRest : ResetType.ShortRest;
    int number = int.parse(
        maxUsesController.text); //already validated, will always be a number.
    ref
        .read(abilityNotifierProvider.notifier)
        .addAbility(Ability(name: name, maxUses: number, resetType: resetType));
    Navigator.pop(context);
  }

  @override
  ConsumerState<AddAbilityPage> createState() => _AddAbilityPageState();
}

class _AddAbilityPageState extends ConsumerState<AddAbilityPage> {
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Text("Add Ability"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100, bottom: 20,left: 50,right: 50),
        child: Form(
          key: widget._formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                textAlign: TextAlign.center,
                controller: widget.nameController,
                decoration: const InputDecoration(hintText: "Enter a name"),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "This field is required";
                  }
                },
              ),
              TextFormField(
                textAlign: TextAlign.center,
                controller: widget.maxUsesController,
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
                  child: DropdownMenu<ResetType>(
                    initialSelection: ResetType.LongRest,
                    controller: widget.resetTypeController,
                    label: Text('This ability resets on:'),
                    onSelected: (ResetType? type){
                      setState(() {
                        widget.currentSelectedResetType = type!;
                      });
                    },
                    requestFocusOnTap: true,
                    dropdownMenuEntries: ResetType.entries,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      if (widget._formKey.currentState!.validate()) {
                        widget.onSubmit(context,ref);
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
