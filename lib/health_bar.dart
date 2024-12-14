import 'package:fluttah/riverpod/ability_list_notifier.dart';
import 'package:fluttah/riverpod/health_bar_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HealthBar extends ConsumerStatefulWidget {
  const HealthBar(this.maxUses, {super.key});

  final String abilityName = "HP";
  final int maxUses;

  @override
  ConsumerState createState() => _State();
}

class _State extends ConsumerState<HealthBar> {
  void updateProgress(int currentHealth, int increment) {
      ref.read(healthbarNotifier.notifier).incrementHealth(increment);
  }

  @override
  Widget build(BuildContext context) {
    List<HealthbarData> data = ref.watch(healthbarNotifier);
    String hpString = "HP: " + data[0].currentHealth.toString() + "/" + data[0].maxHealth.toString();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              backgroundColor: Colors.red,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              onPressed: (BuildContext context) {
                ref.read(healthbarNotifier.notifier).removeHealthbar();
              },
              icon: Icons.delete,
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: Colors.black, style: BorderStyle.solid, width: 2),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                textAlign: TextAlign.center,
                hpString,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.black, width: 2),
                        foregroundColor: Colors.lightGreen,
                        backgroundColor: data[0].currentHealth <= 0
                            ? Colors.grey
                            : Colors.white,
                      ),
                      onPressed: () {
                        updateProgress(data[0].currentHealth, -1);
                      },
                      onLongPress: () {
                        updateProgress(data[0].currentHealth, -10);
                      },
                      child: const Icon(Icons.arrow_left),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 20, right: 20),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.grey,
                        color: Colors.green,
                        value: data[0].currentHealth / widget.maxUses,
                        minHeight: 25,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.black, width: 2),
                        foregroundColor: Colors.lightGreen,
                        backgroundColor: data[0].currentHealth >= widget.maxUses
                            ? Colors.blueGrey
                            : Colors.white,
                      ),
                      onPressed: () {
                        updateProgress(data[0].currentHealth, 1);
                      },
                      onLongPress: () {
                        updateProgress(data[0].currentHealth, 10);
                      },
                      child: const Icon(Icons.arrow_right),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
