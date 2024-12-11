import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class AbilityListNotifier extends Notifier<List<Ability>> {
  @override
  List<Ability> build() {
    return [];
  }

  void addAbility(Ability ability){
    state = [...state,ability];
  }

  void removeAbility(int index){
    state.removeAt(index);
    state = [...state];
  }
}
var abilityNotifierProvider = NotifierProvider<AbilityListNotifier,List<Ability>>(AbilityListNotifier.new);

class Ability {
  String name = '';
  int maxUses = 0;
  int currentUses = 0; //Currently not used, usefull for when SaveData comes into play

  Ability({
    required this.name,
    required this.maxUses,
  });
}
