import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/menu_model.dart';
import '../services/api_service.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../constants/colors.dart'; // jika butuh warna konsisten

class EditMenuScreen extends StatefulWidget {
  final MenuModel menu;

  const EditMenuScreen({super.key, required this.menu});

  @override
  State<EditMenuScreen> createState() => _EditMenuScreenState();
}

class _EditMenuScreenState extends State<EditMenuScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _namaController;
  late final TextEditingController _kategoriController;
  late final TextEditingController _hargaController;
  late final TextEditingController _stokController;
  late final TextEditingController _deskripsiController;

  File? _image;
  String? _base64Image; // null artinya gambar belum diganti

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.menu.namaMenu);
    _kategoriController = TextEditingController(text: widget.menu.kategori);
    _hargaController = TextEditingController(text: widget.menu.harga);
    _stokController = TextEditingController(text: widget.menu.stok.toString());
    _deskripsiController = TextEditingController(text: widget.menu.deskripsi);
    _base64Image = widget.menu.imageBase64; // nilai awal
  }

  /* ───────────────────────── PICK IMAGE ───────────────────────── */
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

  /* ───────────────────────── SUBMIT ───────────────────────── */
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final updatedMenu = MenuModel(
      id: widget.menu.id, // Wajib ada untuk update
      namaMenu: _namaController.text,
      kategori: _kategoriController.text,
      harga: _hargaController.text,
      stok: int.parse(_stokController.text),
      deskripsi: _deskripsiController.text,
      imageBase64: _base64Image ?? '',
    );

    final success = await ApiService.updateMenu(updatedMenu);

    if (success) {
      // Dialog sukses dengan style modern
      await showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Row(
                children: const [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 8),
                  Text("Berhasil"),
                ],
              ),
              content: const Text("Perubahan menu telah disimpan."),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(), // tutup dialog
                  child: const Text("OK"),
                ),
              ],
            ),
      );

      Navigator.pop(
        context,
        true,
      ); // Kembali ke screen sebelumnya & kirim flag refresh
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Gagal update menu")));
    }
  }

  /* ───────────────────────── UI ───────────────────────── */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Menu")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextField(
                hint: "Nama Menu",
                icon: Icons.fastfood,
                controller: _namaController,
                validator:
                    (v) => v!.isEmpty ? "Nama menu tidak boleh kosong" : null,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hint: "Kategori",
                icon: Icons.category,
                controller: _kategoriController,
                validator:
                    (v) => v!.isEmpty ? "Kategori tidak boleh kosong" : null,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hint: "Harga",
                icon: Icons.attach_money,
                keyboardType: TextInputType.number,
                controller: _hargaController,
                validator:
                    (v) => v!.isEmpty ? "Harga tidak boleh kosong" : null,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hint: "Stok",
                icon: Icons.inventory,
                keyboardType: TextInputType.number,
                controller: _stokController,
                validator: (v) => v!.isEmpty ? "Stok tidak boleh kosong" : null,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hint: "Deskripsi",
                icon: Icons.description,
                maxLines: 3,
                controller: _deskripsiController,
                validator:
                    (v) => v!.isEmpty ? "Deskripsi tidak boleh kosong" : null,
              ),
              const SizedBox(height: 16),

              // Preview gambar
              _image != null
                  ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(_image!, height: 150, fit: BoxFit.cover),
                  )
                  : widget.menu.imageBase64.isNotEmpty
                  ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.memory(
                      base64Decode(widget.menu.imageBase64),
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  )
                  : const Text("Belum ada gambar"),

              TextButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image),
                label: const Text("Ganti Gambar"),
              ),
              const SizedBox(height: 20),

              CustomButton(text: "Simpan Perubahan", onPressed: _submit),
            ],
          ),
        ),
      ),
    );
  }
}
