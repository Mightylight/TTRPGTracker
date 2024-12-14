import 'package:fluttah/ability_list_item.dart';
import 'package:fluttah/ability_list_view.dart';
import 'package:fluttah/health_bar.dart';
import 'package:fluttah/pages/add_ability_page.dart';
import 'package:fluttah/riverpod/ability_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart';
import '../riverpod/health_bar_notifier.dart';

class HomePage extends ConsumerStatefulWidget {
  HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
@override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('TTRPG Tracker'),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu),
            );
          }),
        ),
        drawer: Drawer(
            child: ListView(
          children: [
            const SizedBox(
              height: 64,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Text(
                  'Reset your abilities',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            ListTile(
              title: const Text('Short Rest'),
              onTap: () {
                ref.read(abilityNotifierProvider.notifier).resetAbilities(ResetType.ShortRest);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Long Rest'),
              onTap: () {
                ref.read(abilityNotifierProvider.notifier).resetAbilities(ResetType.LongRest);
                ref.read(healthbarNotifier.notifier).resetHealth();
                Navigator.pop(context);
              },
            ),
          ],
        )),
        body: const AbilityListView(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddAbilityPage()));
          },
          child: const Icon(Icons.add),
        ));
  }
}
