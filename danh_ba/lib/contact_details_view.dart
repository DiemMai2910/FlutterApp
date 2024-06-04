import 'dart:io';

import 'package:danh_ba/contact.dart';
import 'package:danh_ba/contact_view_model.dart';
import 'package:danh_ba/contact_update.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Widget cho màn hình chi tiết điện thoại
class ContactDetailsView extends StatefulWidget {
  final Contact contact;

  const ContactDetailsView({Key? key, required this.contact}) : super(key: key);

  @override
  State<ContactDetailsView> createState() => _ContactDetailsViewState();
}

class _ContactDetailsViewState extends State<ContactDetailsView> {
  final viewModel = ContactViewModel();

  // Xác nhận xóa điện thoại
  void _deleteContact(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Xác nhận Xóa"),
          content:
              const Text("Bạn có chắc chắn muốn xóa điện thoại này không?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Hủy"),
            ),
            TextButton(
              onPressed: () {
                viewModel.removeContact(widget.contact.id);
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text("Xóa"),
            ),
          ],
        );
      },
    );
  }

  // Chỉnh sửa thông tin điện thoại
  void _editContact(BuildContext context) {
    showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      builder: (context) => ContactUpdate(
        initialName: widget.contact.name.value,
        initialPhoneNumber: widget.contact.phoneNumber.value,
        initialImage: widget.contact.image.value,
      ),
    ).then((value) {
      if (value != null) {
        viewModel.updateContact(
          widget.contact.id,
          value['name'] ?? '',
          value['phoneNumber'] ?? 0,
          value['image'], // Chuyển đường dẫn hình ảnh
        );
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi Tiết'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _editContact(context),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteContact(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.contact.image.value
                      .isNotEmpty) // Kiểm tra nếu đường dẫn hình ảnh không rỗng
                    ClipOval(
                      child: kIsWeb
                          ? Image.network(
                              widget.contact.image.value,
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(widget.contact.image.value),
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                    )
                  else
                    ClipOval(
                      child: Container(
                        width: 200,
                        height: 200,
                        color: Colors.grey[200],
                        child: Center(
                          child: Image.asset(
                            'assets/images/flutter_logo.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  Text(
                    widget.contact.name.value,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${widget.contact.phoneNumber.value}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
