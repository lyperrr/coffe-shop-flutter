import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_uas/main.dart';
import '../models/menu_model.dart';
import '../services/api_service.dart'; // pastikan path ini sesuai

class AddMenuScreen extends StatefulWidget {
  const AddMenuScreen({super.key});

  @override
  State<AddMenuScreen> createState() => _AddMenuScreenState();
}

class _AddMenuScreenState extends State<AddMenuScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _kategoriController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _stokController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  File? _image;
  String? _base64Image;

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
    if (_formKey.currentState!.validate()) {
      if (_base64Image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Pilih gambar terlebih dahulu")),
        );
        return;
      }

      final newMenu = MenuModel(
        namaMenu: _namaController.text,
        kategori: _kategoriController.text,
        harga: _hargaController.text,
        stok: int.parse(_stokController.text),
        deskripsi: _deskripsiController.text,
        imageBase64: _base64Image!,
      );

      final success = await ApiService.addMenu(newMenu);

      if (success) {
        await showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: const Text("Berhasil"),
                content: const Text("Menu berhasil ditambahkan."),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("OK"),
                  ),
                ],
              ),
        );

        // Kembali dan arahkan ulang ke AddMenuScreen untuk reset form
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const HomeScreen(initialIndex: 2)),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Gagal menambahkan menu")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Menu")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: "Nama Menu"),
                validator:
                    (value) =>
                        value!.isEmpty ? "Nama menu tidak boleh kosong" : null,
              ),
              TextFormField(
                controller: _kategoriController,
                decoration: const InputDecoration(labelText: "Kategori"),
                validator:
                    (value) =>
                        value!.isEmpty ? "Kategori tidak boleh kosong" : null,
              ),
              TextFormField(
                controller: _hargaController,
                decoration: const InputDecoration(labelText: "Harga"),
                keyboardType: TextInputType.number,
                validator:
                    (value) =>
                        value!.isEmpty ? "Harga tidak boleh kosong" : null,
              ),
              TextFormField(
                controller: _stokController,
                decoration: const InputDecoration(labelText: "Stok"),
                keyboardType: TextInputType.number,
                validator:
                    (value) =>
                        value!.isEmpty ? "Stok tidak boleh kosong" : null,
              ),
              TextFormField(
                controller: _deskripsiController,
                decoration: const InputDecoration(labelText: "Deskripsi"),
                maxLines: 3,
                validator:
                    (value) =>
                        value!.isEmpty ? "Deskripsi tidak boleh kosong" : null,
              ),
              const SizedBox(height: 10),
              _image != null
                  ? Image.file(_image!, height: 150)
                  : const Text("Belum ada gambar dipilih"),
              TextButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image),
                label: const Text("Pilih Gambar"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _submit, child: const Text("Simpan")),
            ],
          ),
        ),
      ),
    );
  }
}
