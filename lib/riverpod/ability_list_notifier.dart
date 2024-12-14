import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AbilityListNotifier extends Notifier<List<Ability>> {
  @override
  List<Ability> build() {
    return [];
  }

  void addAbility(Ability ability) {
    state = [...state, ability];
    updateSaveFile();
  }

  void removeAbility(int index) {
    state.removeAt(index);
    state = [...state];
    updateSaveFile();
  }

  void useAbility(int index, int increment) {
    state[index].currentUses = state[index].currentUses + increment;
    state = [...state];
    updateSaveFile();
  }

  void resetAbility(int index) {
    state[index].currentUses = 0;
    state = [...state];
    updateSaveFile();
  }

  void resetAbilities(ResetType resetType) {
    state
        .where((element) => element.resetType == resetType)
        .forEach((item) => item.currentUses = 0);
    state = [...state];
    updateSaveFile();
  }

  Future<void> updateSaveFile() async {
    List<Ability> abilities = state;
    List<String> abilityJson = abilities.map((ability) => jsonEncode(ability.toJson())).toList();
    print(abilityJson);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('AbilityList', abilityJson);
  }

  Future<void> getSaveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? abilityJson = await prefs.getStringList('AbilityList');
    List<Ability>? abilities = abilityJson?.map((ability) => Ability.fromJson(jsonDecode(ability))).toList();
    state = abilities!;
    state = [...state];
  }
}

var abilityNotifierProvider =
    NotifierProvider<AbilityListNotifier, List<Ability>>(
        AbilityListNotifier.new);

class Ability {
  String name = '';
  ResetType resetType;
  int maxUses = 0;
  int currentUses = 0; //Currently not used, usefull for when SaveData comes into play

  Ability.fromJson(Map<String, dynamic> json) :
    name = json['name'],
        resetType = ResetType.values.firstWhere((e) => e.toString().split('.').last == json['resetType']),
    maxUses = json['maxUses'],
    currentUses = json['currentUses'];

  Map<String, dynamic> toJson() => {
    'name':name,
    'resetType': resetType.toString().split('.').last,
    'maxUses': maxUses,
    'currentUses': currentUses,
  };

  Ability({
    required this.name,
    required this.maxUses,
    required this.resetType,
  });
}

typedef ResetTypeEntry = DropdownMenuEntry<ResetType>;

enum ResetType {
  ShortRest('ShortRest'),
  LongRest('LongRest');

  const ResetType(this.label);

  final String label;

  static final List<ResetTypeEntry> entries =
      UnmodifiableListView<ResetTypeEntry>(
          values.map<ResetTypeEntry>((ResetType type) => ResetTypeEntry(
                value: type,
                label: type.label,
              )));
}
