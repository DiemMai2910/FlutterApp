import 'package:danh_ba/contact_view_model.dart';
import 'package:flutter/material.dart';

import 'contact_details_view.dart';
import 'contact_update.dart';
import 'contact_widget.dart';

// Widget cho danh sách điện thoại
class ContactListView extends StatefulWidget {
  const ContactListView({Key? key}) : super(key: key);

  @override
  State<ContactListView> createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView> {
  final viewModel = ContactViewModel();
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh Bạ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet<Map<String, dynamic>>(
                context: context,
                builder: (context) => const ContactUpdate(),
              ).then((value) {
                if (value != null) {
                  viewModel.addContact(
                    value['name'] ?? '',
                    value['phoneNumber'] ?? 0,
                    value['image'] ?? '', // Chuyển đường dẫn hình ảnh
                  );
                }
              });
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {}); // Cập nhật UI khi truy vấn tìm kiếm thay đổi
              },
              decoration: InputDecoration(
                labelText: 'Tìm kiếm',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListenableBuilder(
              listenable: viewModel,
              builder: (context, _) {
                // Lọc danh sách điện thoại dựa trên truy vấn tìm kiếm
                final filteredContacts = viewModel.contacts.where((contact) {
                  final searchTerm = _searchController.text.toLowerCase();
                  final name = contact.name.value.toLowerCase();
                  final phoneNumber = contact.phoneNumber.value.toString();
                  return name.contains(searchTerm) ||
                      phoneNumber.contains(searchTerm);
                }).toList();
                return ListView.builder(
                  itemCount: filteredContacts.length,
                  itemBuilder: (context, index) {
                    final contact = filteredContacts[index];
                    return ContactWidget(
                      key: ValueKey(contact.id),
                      contact: contact,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ContactDetailsView(
                              contact: contact,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
