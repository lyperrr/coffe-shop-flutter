import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import '../providers/history_provider.dart';
import '../constants/colors.dart';
import '../widgets/history_card.dart'; // pastikan path ini sesuai

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final historyProvider = Provider.of<HistoryProvider>(context);
    final historyList = historyProvider.historyList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pesanan'),
        backgroundColor: activeItems,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              historyProvider.clearHistory();
            },
          ),
        ],
      ),
      body:
          historyList.isEmpty
              ? const Center(child: Text('Belum ada riwayat pesanan.'))
              : ListView.builder(
                itemCount: historyList.length,
                itemBuilder: (context, index) {
                  final item = historyList[index];
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) {
                      historyProvider.removeFromHistory(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Riwayat dihapus')),
                      );
                    },
                    child: HistoryCard(history: item),
                  );
                },
              ),
    );
  }
}
