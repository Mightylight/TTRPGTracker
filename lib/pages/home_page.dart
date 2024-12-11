import 'package:fluttah/ability_list_item.dart';
import 'package:fluttah/ability_list_view.dart';
import 'package:fluttah/pages/add_ability_page.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightGreen,
        appBar: AppBar(
          title: const Text('TTRPG Tracker'),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
        ),
        body: AbilityListView(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddAbilityPage()));
          },
          child: const Icon(Icons.add),
        ));
  }
}
