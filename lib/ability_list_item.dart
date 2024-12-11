import 'package:flutter/material.dart';

class AbilityListItem extends StatefulWidget {
  AbilityListItem({
    super.key,
    required this.abilityName,
    required this.maxUses,
  });

  final String abilityName;
  final int maxUses;

  @override
  State<AbilityListItem> createState() => _AbilityListItemState();
}

class _AbilityListItemState extends State<AbilityListItem> {
  int uses = 0;
  List<bool> steps = List.empty();

  void updateProgress(int newUses) {
    if (newUses <= widget.maxUses) {
      setState(() {
        steps[uses] = true;
        uses = newUses;
      });
    }
  }

  @override
  void initState() {
    steps = List.generate(widget.maxUses, (index) => false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightGreenAccent,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    widget.abilityName,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.lightGreen,
                        backgroundColor: uses >= widget.maxUses
                            ? Colors.blueGrey
                            : Colors.white),
                    onPressed: () {
                      updateProgress(uses + 1);
                    },
                    child: const Text("USE"),
                  ),
                )
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
                        Icons.circle,
                        color: step ? Colors.lightGreen : Colors.white,
                        size: 24,
                      ),
                    ),
                ],
              ),
            ),
          ],
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
