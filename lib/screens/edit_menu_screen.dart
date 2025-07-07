import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/menu_model.dart';
import '../services/api_service.dart';

class EditMenuScreen extends StatefulWidget {
  final MenuModel menu;
  const EditMenuScreen({super.key, required this.menu});

  @override
  State<EditMenuScreen> createState() => _EditMenuScreenState();
}

class _EditMenuScreenState extends State<EditMenuScreen> {
  late TextEditingController _namaController;
  late TextEditingController _kategoriController;
  late TextEditingController _hargaController;
  late TextEditingController _stokController;
  late TextEditingController _deskripsiController;

  File? _image;
  String? _base64Image;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.menu.namaMenu);
    _kategoriController = TextEditingController(text: widget.menu.kategori);
    _hargaController = TextEditingController(text: widget.menu.harga);
    _stokController = TextEditingController(text: widget.menu.stok.toString());
    _deskripsiController = TextEditingController(text: widget.menu.deskripsi);
    _base64Image = widget.menu.imageBase64;
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() {
        _image = File(picked.path);
        _base64Image = base64Encode(bytes);
      });
    }
  }

  Future<void> _submit() async {
    final updatedMenu = MenuModel(
      id: widget.menu.id,
      namaMenu: _namaController.text,
      kategori: _kategoriController.text,
      harga: _hargaController.text,
      stok: int.parse(_stokController.text),
      deskripsi: _deskripsiController.text,
      imageBase64: _base64Image ?? '',
    );

    final success = await ApiService.updateMenu(updatedMenu);
    if (success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Menu berhasil diupdate")));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Gagal update menu")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Menu")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextFormField(
              controller: _namaController,
              decoration: const InputDecoration(labelText: "Nama Menu"),
            ),
            TextFormField(
              controller: _kategoriController,
              decoration: const InputDecoration(labelText: "Kategori"),
            ),
            TextFormField(
              controller: _hargaController,
              decoration: const InputDecoration(labelText: "Harga"),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _stokController,
              decoration: const InputDecoration(labelText: "Stok"),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _deskripsiController,
              decoration: const InputDecoration(labelText: "Deskripsi"),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            _image != null
                ? Image.file(_image!, height: 150)
                : widget.menu.imageBase64.isNotEmpty
                ? Image.memory(
                  base64Decode(widget.menu.imageBase64),
                  height: 150,
                )
                : const Text("Belum ada gambar"),
            TextButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.image),
              label: const Text("Ganti Gambar"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: const Text("Simpan Perubahan"),
            ),
          ],
        ),
      ),
    );
  }
}
