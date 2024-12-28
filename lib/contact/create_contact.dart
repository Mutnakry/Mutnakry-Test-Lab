import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:testflutter/app_url.dart';
import 'package:testflutter/contact/app_showcontact.dart';

class CreateContact extends StatefulWidget {
  const CreateContact({Key? key}) : super(key: key);

  @override
  State<CreateContact> createState() => _CreateContactState();
}

class _CreateContactState extends State<CreateContact> {
  final TextEditingController contactName = TextEditingController();
  final TextEditingController contactNumber = TextEditingController();
  final TextEditingController contactEmail = TextEditingController();

  // Create a GlobalKey for form validation
  final _formKey = GlobalKey<FormState>();

  // Email validation function
  String? validateEmail(String email) {
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (email.isEmpty || !regex.hasMatch(email)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // Phone number validation function
  String? validatePhoneNumber(String phone) {
    final regex = RegExp(r'^\d{10,15}$');
    if (phone.isEmpty || !regex.hasMatch(phone)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  Future<void> createContact(String contactName, String contactNumber, String contactEmail) async {
    var uri = Uri.parse("${AppUrl.url}create_product.php");

    // Print data being sent to the server for debugging
    print('Sending data to the server:');
    print('Name: $contactName');
    print('Phone: $contactNumber');
    print('Email: $contactEmail');

    EasyLoading.show(status: 'Loading...');
    try {
      final response = await http.post(
        uri,
        body: {
          'contactName': contactName,
          'contactNumber': contactNumber,
          'contactEmail': contactEmail,
        },
      );

      EasyLoading.dismiss();
      print('Server Response: ${response.body}');  // Print server response for debugging

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (data['success'] == 1) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['msg_success'])),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AppShowcontact()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['msg_error'] ?? "Registration failed")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: ${response.statusCode} - ${response.reasonPhrase}"),
          ),
        );
      }
    } catch (e) {
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: Unable to connect to server. $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(height: screenHeight * 0.05),
              Center(
                child: CircleAvatar(
                  radius: screenWidth * 0.2,
                  backgroundColor: Colors.blueAccent,
                  child: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/2622/2622075.png',
                    width: screenWidth * 0.3,
                    height: screenWidth * 0.3,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              TextFormField(
                controller: contactName,
                decoration: InputDecoration(
                  hintText: 'Contact Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Contact name is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: screenHeight * 0.01),
              TextFormField(
                controller: contactNumber,
                decoration: InputDecoration(
                  hintText: 'Contact Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                validator: (value) {
                  return validatePhoneNumber(value ?? '');
                },
              ),
              SizedBox(height: screenHeight * 0.01),
              TextFormField(
                controller: contactEmail,
                decoration: InputDecoration(
                  hintText: 'Contact Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                validator: (value) {
                  return validateEmail(value ?? '');
                },
              ),
              SizedBox(height: screenHeight * 0.02),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Print form data before sending it
                    print("Form is valid. Proceeding to send data.");
                    createContact(
                      contactName.text,
                      contactNumber.text,
                      contactEmail.text,
                    );
                  } else {
                    print("Form validation failed.");
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  backgroundColor: Colors.blue,
                ),
                child: const Text('CREATE',
                    style: TextStyle(fontSize: 16.0, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
