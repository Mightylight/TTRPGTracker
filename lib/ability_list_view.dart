import 'package:fluttah/riverpod/ability_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ability_list_item.dart';

class AbilityListView extends ConsumerWidget {
  const AbilityListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Ability> abilityList = ref.watch(abilityNotifierProvider);
    return ListView.builder(
        key: UniqueKey(),
        itemCount: abilityList.length,
        itemBuilder: (BuildContext context, index) {
          return AbilityListItem(
            abilityName: abilityList[index].name,
            maxUses: abilityList[index].maxUses,
          );
        });
  }
}
