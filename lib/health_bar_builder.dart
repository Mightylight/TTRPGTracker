import 'package:fluttah/health_bar_placeholder.dart';
import 'package:fluttah/riverpod/health_bar_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'health_bar.dart';

class HealthBarBuilder extends ConsumerStatefulWidget {
  const HealthBarBuilder({super.key});

  @override
  ConsumerState createState() => _HealthBarBuilderState();
}

class _HealthBarBuilderState extends ConsumerState<HealthBarBuilder> {


  @override
  Widget build(BuildContext context) {
    List<HealthbarData> data = ref.watch(healthbarNotifier);
    List<bool> healthBarPlaceholder = [true];
    if (data.isEmpty) {
      return ListView.builder(
          key: UniqueKey(),
          itemCount: healthBarPlaceholder.length,
          itemBuilder: (BuildContext context, index) {
            return const HealthBarPlaceholder();
          });

    } else {
     return ListView.builder(
         key: UniqueKey(),
         itemCount: data.length,
         itemBuilder: (BuildContext context, index) {
           return HealthBar(
             data[index].maxHealth,
           );
         });
    }
  }
}
