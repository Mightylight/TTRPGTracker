import 'package:fluttah/riverpod/ability_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AbilityListItem extends ConsumerStatefulWidget {
  const AbilityListItem({
    super.key,
    required this.abilityName,
    required this.maxUses,
    required this.index,
  });

  final String abilityName;
  final int maxUses;
  final int index;

  @override
  ConsumerState<AbilityListItem> createState() => _AbilityListItemState();
}

class _AbilityListItemState extends ConsumerState<AbilityListItem> {
  int uses = 0;
  List<bool> steps = List.empty();

  void updateProgress(int newUses) {
    if (newUses <= widget.maxUses) {
      ref.read(abilityNotifierProvider.notifier).useAbility(widget.index, 1);
      // setState(() {
      //   steps[uses] = true;
      //   uses = newUses;
      // });
    }
  }

  @override
  void initState() {
    steps = List.generate(widget.maxUses, (index) => false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Ability> abilityList = ref.watch(abilityNotifierProvider);
    uses = abilityList[widget.index].currentUses;
    for (int i = 0; i < uses; i++) {
      if(i < steps.length){
        steps[i] = true;
      }
    }
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Slidable(
        endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [SlidableAction(
              backgroundColor: Colors.red,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              onPressed: (BuildContext context){
                ref.read(abilityNotifierProvider.notifier).removeAbility(widget.index);
              },
              icon: Icons.delete,
            ),SlidableAction(
              backgroundColor: Colors.blue,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              onPressed: (BuildContext context){
                //WIP, be able to edit the current widget
              },
              icon: Icons.edit,
            )],),
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
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      widget.abilityName,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.black, width: 2),
                        foregroundColor: Colors.lightGreen,
                        backgroundColor: uses >= widget.maxUses
                            ? Colors.blueGrey
                            : Colors.white,
                      ),
                      onPressed: () {
                        updateProgress(uses + 1);
                      },
                      child: const Text("USE"),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 10, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (var step in steps)
                      Expanded(
                        child: Icon(
                          step ? Icons.circle : Icons.circle_outlined,
                          color: step ? Colors.lightGreen : Colors.black,
                          size: 30,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Padding(
// padding: const EdgeInsets.only(top: 20),
// child: LinearProgressIndicator(
// minHeight: 25,
// borderRadius: BorderRadius.circular(15),
// semanticsValue: "uses left:$uses",
// color: Colors.lightGreen,
// backgroundColor: Colors.white,
// value: uses / widget.maxUses,
// ),
// ),
