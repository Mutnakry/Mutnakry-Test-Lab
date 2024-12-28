// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:testflutter/app_url.dart';
// import 'package:testflutter/contact/editcontact.dart';
//
// class AppShowcontact extends StatefulWidget {
//   const AppShowcontact({Key? key}) : super(key: key);
//
//   @override
//   State<AppShowcontact> createState() => _AppShowcontactState();
// }
//
// class _AppShowcontactState extends State<AppShowcontact> {
//   List<dynamic> contacts = [];
//   bool isLoading = true;
//   String errorMessage = '';
//
//   @override
//   void initState() {
//     super.initState();
//     fetchContacts();
//   }
//
//   Future<void> fetchContacts() async {
//     final url = Uri.parse("${AppUrl.url}get_contacts.php");
//
//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['success'] == 1) {
//           setState(() {
//             contacts = data['data'];
//             isLoading = false;
//           });
//         } else {
//           setState(() {
//             errorMessage = data['message'] ?? 'No contacts found.';
//             isLoading = false;
//           });
//         }
//       } else {
//         setState(() {
//           errorMessage = "Error: ${response.statusCode} - ${response.reasonPhrase}";
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = "Error: Unable to fetch contacts. $e";
//         isLoading = false;
//       });
//     }
//   }
//
//
//   // Future<void> fetchContacts() async {
//   //   final url = Uri.parse("${AppUrl.url}get_contacts.php"); // Replace with your backend URL
//   //   try {
//   //     final response = await http.get(url);
//   //     if (response.statusCode == 200) {
//   //       final data = jsonDecode(response.body);
//   //       if (data['success'] == 1) {
//   //         setState(() {
//   //           contacts = data['data'];
//   //           isLoading = false;
//   //         });
//   //       } else {
//   //         setState(() {
//   //           errorMessage = data['message'] ?? 'No contacts found.';
//   //           isLoading = false;
//   //         });
//   //       }
//   //     } else {
//   //       setState(() {
//   //         errorMessage = "Error: ${response.statusCode} - ${response.reasonPhrase}";
//   //         isLoading = false;
//   //       });
//   //     }
//   //   } catch (e) {
//   //     setState(() {
//   //       errorMessage = "Error: Unable to fetch contacts. $e";
//   //       isLoading = false;
//   //     });
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Contacts'),
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : errorMessage.isNotEmpty
//           ? Center(child: Text(errorMessage))
//           : ListView.builder(
//         itemCount: contacts.length,
//         itemBuilder: (context, index) {
//           final contact = contacts[index];
//           return Card(
//             margin: const EdgeInsets.all(8.0),
//             child: ListTile(
//               leading: CircleAvatar(
//                 backgroundColor: Colors.blueAccent,
//                 child: Text(
//                   contact['contactName'][0].toUpperCase(),
//                   style: const TextStyle(color: Colors.white),
//                 ),
//               ),
//               title: Text(contact['contactName']),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Email: ${contact['contactEmail']}"),
//                   Text("Number: ${contact['contactNumber']}"),
//                 ],
//               ),
//               trailing: IconButton(
//                 icon: const Icon(Icons.edit),
//                 onPressed: () {
//                   // Navigate to the EditContact screen, passing the contact details
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => EditContact(
//                         contactID: contact['contactID'].toString(),
//                         contactName: contact['contactName'],
//                         contactNumber: contact['contactNumber'],
//                         contactEmail: contact['contactEmail'],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:testflutter/app_url.dart';
import 'package:testflutter/contact/create_contact.dart';
import 'package:testflutter/contact/editcontact.dart';  // Import the AddContact screen

class AppShowcontact extends StatefulWidget {
  const AppShowcontact({Key? key}) : super(key: key);

  @override
  State<AppShowcontact> createState() => _AppShowcontactState();
}

class _AppShowcontactState extends State<AppShowcontact> {
  List<dynamic> contacts = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchContacts();
  }

  Future<void> fetchContacts() async {
    final url = Uri.parse("${AppUrl.url}get_contacts.php");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == 1) {
          setState(() {
            contacts = data['data'];
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = data['message'] ?? 'No contacts found.';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = "Error: ${response.statusCode} - ${response.reasonPhrase}";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error: Unable to fetch contacts. $e";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage))
          : ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Text(
                  contact['contactName'][0].toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(contact['contactName']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email: ${contact['contactEmail']}"),
                  Text("Number: ${contact['contactNumber']}"),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Navigate to the EditContact screen, passing the contact details
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditContact(
                        contactID: contact['contactID'].toString(),
                        contactName: contact['contactName'],
                        contactNumber: contact['contactNumber'],
                        contactEmail: contact['contactEmail'],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the AddContact screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateContact()),
          ).then((result) {
            // If result is true, refresh the contact list
            if (result == true) {
              fetchContacts();
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
