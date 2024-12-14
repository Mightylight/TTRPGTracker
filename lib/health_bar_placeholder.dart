import 'package:fluttah/riverpod/health_bar_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HealthBarPlaceholder extends ConsumerStatefulWidget {
  const HealthBarPlaceholder({super.key});

  @override
  ConsumerState createState() => _HealthBarPlaceholderState();
}

class _HealthBarPlaceholderState extends ConsumerState<HealthBarPlaceholder> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text('Enter your characters hit points'),
          Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 20,left: 200,right: 200),
            child: TextField(
              controller: controller,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: Colors.black, style: BorderStyle.solid, width: 2),
            ),
            child: OutlinedButton(onPressed: () {
              ref.read(healthbarNotifier.notifier).addHealthbar(HealthbarData(maxHealth: int.parse(controller.text), currentHealth: int.parse(controller.text)));
            }, child: Icon(Icons.add)),
          ),
        ],
      ),
    );
  }
}
