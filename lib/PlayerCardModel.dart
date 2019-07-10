import 'package:flutter/material.dart';

class PlayerCardModel {

  bool _isMale;
  int _level;
  int _combat;

  PlayerCardModel(this._isMale, this._level, this._combat);

  void incrementCombatCounter() {
    _combat++;
  }

  void decrementCombatCounter() {
    _combat--;
  }

  void incrementLevelCounter() {
    _level++;
  }

  void decrementLevelCounter() {
    _level--;
  }

  void invertGender() {
    _isMale = !_isMale;
  }

  bool isMale() {
    return _isMale;
  }

  int getLevel() {
    return _level;
  }

  int getCombat() {
    return _combat;
  }

}