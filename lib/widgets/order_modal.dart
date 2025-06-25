import 'package:flutter/material.dart';
import 'package:project_uas/constants/colors.dart';
import 'package:intl/intl.dart';

class OrderModal extends StatefulWidget {
  final VoidCallback onOrderPlaced;

  const OrderModal({super.key, required this.onOrderPlaced});

  @override
  State<OrderModal> createState() => _OrderModalState();
}

class _OrderModalState extends State<OrderModal> {
  final TextEditingController _nameController = TextEditingController();
  String _orderDateTime = DateFormat(
    'dd MMMM yyyy HH:mm a',
  ).format(DateTime.now());

  @override
  void initState() {
    super.initState();
    // Set initial date and time
    final now = DateTime.now();
    _orderDateTime = DateFormat('dd MMMM yyyy HH:mm a').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Order Details',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: anActiveItems), // "X" icon
            onPressed: () {
              Navigator.of(context).pop(); // Close the modal
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Name',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'Customer name..',
              filled: true,
              fillColor: textWhite,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Order Date',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: TextEditingController(text: _orderDateTime),
            readOnly: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: textWhite,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            // Handle order placement
            widget.onOrderPlaced();
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: activeItems,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Order', style: TextStyle(color: textWhite)),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
