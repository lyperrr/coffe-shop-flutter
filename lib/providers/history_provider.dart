import 'package:flutter/material.dart';
import '../models/history_model.dart';

class HistoryProvider with ChangeNotifier {
  final List<HistoryModel> _historyList = [];

  List<HistoryModel> get historyList => _historyList;

  void addToHistory(HistoryModel history) {
    _historyList.add(history);
    notifyListeners();
  }

  void removeFromHistory(String name) {
    _historyList.removeWhere((item) => item.name == name);
    notifyListeners();
  }

  void clearHistory() {
    _historyList.clear();
    notifyListeners();
  }
}
