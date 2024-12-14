import 'package:fluttah/health_bar.dart';
import 'package:fluttah/health_bar_builder.dart';
import 'package:fluttah/health_bar_placeholder.dart';
import 'package:fluttah/riverpod/ability_list_notifier.dart';
import 'package:fluttah/riverpod/health_bar_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ability_list_item.dart';

class AbilityListView extends ConsumerWidget {
  const AbilityListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Ability> abilityList = ref.watch(abilityNotifierProvider);
    return Column(
      children: [
        Expanded(
            child: HealthBarBuilder()
        ),
        Expanded(
          flex: 4,
          child: ListView.builder(
              key: UniqueKey(),
              itemCount: abilityList.length,
              itemBuilder: (BuildContext context, index) {
                return AbilityListItem(
                  abilityName: abilityList[index].name,
                  maxUses: abilityList[index].maxUses,
                  index: index,
                );
              }),
        ),
      ],
    );
  }
}
