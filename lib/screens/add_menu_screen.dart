import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_uas/constants/colors.dart';
import 'package:project_uas/main.dart';
import '../models/menu_model.dart';
import '../services/api_service.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class AddMenuScreen extends StatefulWidget {
  const AddMenuScreen({super.key});

  @override
  State<AddMenuScreen> createState() => _AddMenuScreenState();
}

class _AddMenuScreenState extends State<AddMenuScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _kategoriController = TextEditingController();
  final _hargaController = TextEditingController();
  final _stokController = TextEditingController();
  final _deskripsiController = TextEditingController();

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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: Colors.white,
                title: Row(
                  children: const [
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 8),
                    Text("Berhasil"),
                  ],
                ),
                content: const Text(
                  "Menu berhasil ditambahkan.",
                  style: TextStyle(fontSize: 16),
                ),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: textWhite,
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("OK"),
                  ),
                ],
              ),
        );


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
              CustomTextField(
                hint: "Nama Menu",
                icon: Icons.fastfood,
                controller: _namaController,
                validator:
                    (value) =>
                        value!.isEmpty ? "Nama menu tidak boleh kosong" : null,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hint: "Kategori",
                icon: Icons.category,
                controller: _kategoriController,
                validator:
                    (value) =>
                        value!.isEmpty ? "Kategori tidak boleh kosong" : null,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hint: "Harga",
                icon: Icons.attach_money,
                keyboardType: TextInputType.number,
                controller: _hargaController,
                validator:
                    (value) =>
                        value!.isEmpty ? "Harga tidak boleh kosong" : null,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hint: "Stok",
                icon: Icons.inventory,
                keyboardType: TextInputType.number,
                controller: _stokController,
                validator:
                    (value) =>
                        value!.isEmpty ? "Stok tidak boleh kosong" : null,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hint: "Deskripsi",
                icon: Icons.description,
                maxLines: 3,
                controller: _deskripsiController,
                validator:
                    (value) =>
                        value!.isEmpty ? "Deskripsi tidak boleh kosong" : null,
              ),
              const SizedBox(height: 16),
              _image != null
                  ? Image.file(_image!, height: 150)
                  : const Text("Belum ada gambar dipilih"),
              TextButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image),
                label: const Text("Pilih Gambar"),
              ),
              const SizedBox(height: 20),
              CustomButton(text: "Simpan", onPressed: _submit),
            ],
          ),
        ),
      ),
    );
  }
}
