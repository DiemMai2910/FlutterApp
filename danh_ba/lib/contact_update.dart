// Widget cho màn hình cập nhật điện thoại
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ContactUpdate extends StatefulWidget {
  final String? initialName;
  final int? initialPhoneNumber;
  final String? initialImage;

  const ContactUpdate({
    Key? key,
    this.initialName,
    this.initialPhoneNumber,
    this.initialImage,
  }) : super(key: key);

  @override
  State<ContactUpdate> createState() => _ContactUpdateState();
}

class _ContactUpdateState extends State<ContactUpdate> {
  late TextEditingController _nameController;
  late TextEditingController _phoneNumberController;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _phoneNumberController =
        TextEditingController(text: widget.initialPhoneNumber?.toString() ?? '');
    _imagePath = widget.initialImage;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  // Chọn và thiết lập hình ảnh cho điện thoại
  Future<String?> _pickImage() async {
    final picker = ImagePicker();
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return pickedFile.path;
    } else {
      return null;
    }
  }

  // Chọn và thiết lập hình ảnh cho điện thoại
  void _pickAndSetImage() async {
    final imagePath = await _pickImage();
    if (imagePath != null) {
      setState(() {
        _imagePath = imagePath;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initialName != null
            ? 'Chỉnh sửa'
            : 'Thêm danh bạ'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop({
                'name': _nameController.text,
                'phoneNumber': int.tryParse(_phoneNumberController.text) ?? 0,
                'image': _imagePath, // Chuyển đường dẫn hình ảnh cho người gọi
              });
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _pickAndSetImage,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _imagePath != null
                      ? kIsWeb
                          ? Image.network(
                              _imagePath!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(_imagePath!),
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            )
                      : const Icon(
                          Icons.add_photo_alternate,
                          size: 60,
                          color: Colors.grey,
                        ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
