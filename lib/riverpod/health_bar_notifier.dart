import 'dart:convert';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ability_list_notifier.dart';

class HealthbarDataNotifier extends Notifier<List<HealthbarData>> {
  @override
  List<HealthbarData> build() {
    return [];
  }

  void addHealthbar(HealthbarData healthBar) {
    state = [...state, healthBar];
    updateSaveFile();
  }

  void incrementHealth(int increment) {
    if (state[0].currentHealth + increment > 0 &&
        state[0].currentHealth + increment <= state[0].maxHealth) {
      state[0].currentHealth += increment;
      print(state[0].currentHealth);
    }
    state = [...state];
    updateSaveFile();
  }

  void resetHealth() {
    state[0].currentHealth = state[0].maxHealth;
    state = [...state];
    updateSaveFile();
  }

  void removeHealthbar() {
    state.removeAt(0);
    state = [...state];
    updateSaveFile();
  }

  Future<void> updateSaveFile() async {
    List<HealthbarData> data = state;
    List<String> dataJson = data.map((healthBar) => jsonEncode(healthBar.toJson())).toList();
    print(dataJson);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('HealthBarData', dataJson);
  }

  Future<void> getSaveData()async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? dataJson = await prefs.getStringList('HealthBarData');
    List<HealthbarData>? data = dataJson?.map((ability) => HealthbarData.fromJson(jsonDecode(ability))).toList();
    if(data == null){
      state = [];
    } else {
      state = data;
    }
    state = [...state];
  }
}

var healthbarNotifier =
    NotifierProvider<HealthbarDataNotifier, List<HealthbarData>>(
        HealthbarDataNotifier.new);

class HealthbarData {
  int maxHealth;
  int currentHealth;
  ResetType resetType = ResetType.LongRest;

  HealthbarData.fromJson(Map<String, dynamic> json)
      : maxHealth = json['maxHealth'],
        resetType = ResetType.values.firstWhere(
            (e) => e.toString().split('.').last == json['resetType']),
        currentHealth = json['currentHealth'];

  Map<String, dynamic> toJson() => {
    'maxHealth': maxHealth,
    'resetType': resetType.toString().split('.').last,
    'currentHealth': currentHealth,
  };

  HealthbarData({
    required this.maxHealth,
    required this.currentHealth,
  });
}
