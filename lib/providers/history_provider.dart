import 'package:flutter/material.dart';
import '../models/history_model.dart';

class HistoryProvider extends ChangeNotifier {
  final List<HistoryModel> _historyList = [];

  List<HistoryModel> get historyList => _historyList;

  void addToHistory(HistoryModel item) {
    _historyList.add(item);
    notifyListeners();
  }

  void clearHistory() {
    _historyList.clear();
    notifyListeners();
  }

  void removeFromHistory(int index) {}
}