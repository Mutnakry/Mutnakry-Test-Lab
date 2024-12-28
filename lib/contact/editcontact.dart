import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:testflutter/app_url.dart';

class EditContact extends StatefulWidget {
  final String contactID;
  final String contactName;
  final String contactNumber;
  final String contactEmail;

  const EditContact({
    Key? key,
    required this.contactID,
    required this.contactName,
    required this.contactNumber,
    required this.contactEmail,
  }) : super(key: key);

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  final TextEditingController contactNameController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController contactEmailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current contact data
    contactNameController.text = widget.contactName;
    contactNumberController.text = widget.contactNumber;
    contactEmailController.text = widget.contactEmail;
  }

  Future<void> updateContact() async {
    final url = Uri.parse("${AppUrl.url}update_contact.php");

    try {
      final response = await http.post(
        url,
        body: {
          'contactId': widget.contactID,  // Use widget.contactId here
          'contactName': contactNameController.text,
          'contactNumber': contactNumberController.text,
          'contactEmail': contactEmailController.text,
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == 1) {
        // Handle success
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Contact updated successfully!')),
        );
        Navigator.pop(context); // Go back after update
      } else {
        // Handle failure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['msg_error'] ?? 'Failed to update contact')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: Unable to update contact. $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            TextFormField(
              controller: contactNameController,
              decoration: InputDecoration(
                labelText: 'Contact Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: contactNumberController,
              decoration: InputDecoration(
                labelText: 'Contact Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: contactEmailController,
              decoration: InputDecoration(
                labelText: 'Contact Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: updateContact,
              child: const Text('Update Contact'),
            ),
          ],
        ),
      ),
    );
  }
}
