// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:testflutter/app_color.dart';
// import 'package:http/http.dart' as http;
// import 'package:testflutter/app_url.dart';
// import 'package:testflutter/component/view_product.dart';
//
// class CreateProduct extends StatefulWidget {
//   const CreateProduct({Key? key}) : super(key: key);
//
//   @override
//   State<CreateProduct> createState() => _CreateProductState();
// }
//
// class _CreateProductState extends State<CreateProduct> {
//   final TextEditingController _ProductNameController = TextEditingController();
//   final TextEditingController _DescriptionController = TextEditingController();
//   final TextEditingController _CategoryController = TextEditingController();
//   final TextEditingController _BarcodeController = TextEditingController();
//   final TextEditingController _ExpiredDateController = TextEditingController();
//   final TextEditingController _QtyController = TextEditingController();
//   final TextEditingController _UnitPriceInController = TextEditingController();
//   final TextEditingController _UnitPriceOutController = TextEditingController();
//
//   Future<void> registerUser(
//       String ProductName,
//       String Description,
//       Number CategoryID,
//       String Barcode,
//       DateTime ExpiredDate,
//       Number Qty,
//       Number 	UnitPriceOut,
//       Number UnitPriceIn,
//
//       BuildContext context
//       ) async {
//     var uri = Uri.parse("${AppUrl.url}register_user.php");
//     EasyLoading.show(status: 'Loading...');
//     try {
//       final response = await http.post(
//         uri,
//         body: {
//           'ProductName': ProductName,
//           'Description': Description,
//           'CategoryID': CategoryID,
//           'Barcode': Barcode,
//           'ExpiredDate': ExpiredDate,
//           'CategoryID': CategoryID,
//           'Qty': Qty,
//           'UnitPriceIn': UnitPriceIn,
//           'UnitPriceOut': UnitPriceOut,
//         },
//       );
//
//       print("Server response: ${response.body}");
//       if (response.statusCode == 200) {
//         EasyLoading.dismiss();
//         final data = jsonDecode(response.body);
//         if (data['success'] == 1) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(data['msg_success'])),
//           );
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => ViewProduct()),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(data['msg_error'] ?? "Registration failed")),
//           );
//         }
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Error: ${response.statusCode} - ${response.reasonPhrase}")),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: Unable to connect to server. $e")),
//       );
//     }
//   }
//
//
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form Key for validation
//
//   bool get isWideScreen => MediaQuery.of(context).size.width > 600; // Check if screen is wide
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Student'),
//       ),
//       body: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: LayoutBuilder(
//             builder: (context, constraints) {
//               return Form(
//                 key: _formKey,
//                 child: ListView(
//                   children: [
//                     SizedBox(height: 8),
//                     TextFormField(
//                       controller: _ProductNameController,
//                       decoration: InputDecoration(
//                         labelText: 'ProductName',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your name';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 8),
//                     TextFormField(
//                       controller: _CategoryController,
//                       decoration: InputDecoration(
//                         labelText: 'Category',
//                         border: OutlineInputBorder(),
//                       ),
//                       keyboardType: TextInputType.number,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your age';
//                         }
//                         return null;
//                       },
//                     ),
//
//                     SizedBox(height: 8),
//                     TextFormField(
//                       controller: _BarcodeController,
//                       decoration: InputDecoration(
//                         labelText: 'Barcode',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter the subject';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 8),
//                     TextFormField(
//                       controller: _QtyController,
//                       decoration: InputDecoration(
//                         labelText: 'Qty',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter gender';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 8),
//                     TextFormField(
//                       controller: _UnitPriceInController,
//                       decoration: InputDecoration(
//                         labelText: 'UnitPriceIn',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter UnitPriceIn';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 8),
//                     TextFormField(
//                       controller: _UnitPriceOutController,
//                       decoration: InputDecoration(
//                         labelText: 'UnitPriceOut',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter UnitPriceOut';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 8),
//                     TextFormField(
//                       controller: _DescriptionController,
//                       decoration: InputDecoration(
//                         labelText: '	Description',
//                         border: OutlineInputBorder(),
//                       ),
//
//                     ),
//                     SizedBox(height: 8),
//                     TextFormField(
//                       controller: _ExpiredDateController,
//                       decoration: InputDecoration(
//                         labelText: 'ExpiredDate',
//                         border: OutlineInputBorder(),
//                         suffixIcon: IconButton(
//                           icon: Icon(Icons.calendar_today),
//                           onPressed: () async {
//                             DateTime? selectedDate = await showDatePicker(
//                               context: context,
//                               initialDate: DateTime.now(),
//                               firstDate: DateTime(1900),
//                               lastDate: DateTime.now(),
//                             );
//
//                             if (selectedDate != null) {
//                               _ExpiredDateController.text = selectedDate.toLocal().toString().split(' ')[0]; // Format as YYYY-MM-DD
//                             }
//                           },
//                         ),
//                       ),
//                       readOnly: true,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please select your date of birth';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 16),
//                     ElevatedButton(
//                       onPressed: () {
//                         if (_formKey.currentState?.validate() ?? false) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text('Processing Data')),
//                           );
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         padding: isWideScreen
//                             ? EdgeInsets.symmetric(vertical: 12, horizontal: 32)
//                             : EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                       ),
//                       child: Text(
//                         'Save',
//                         style: TextStyle(
//                           color: AppColor.pur500,
//                           fontSize: 24,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:testflutter/app_url.dart';
import 'package:testflutter/component/view_product.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({Key? key}) : super(key: key);

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  final TextEditingController _ProductNameController = TextEditingController();
  final TextEditingController _DescriptionController = TextEditingController();
  final TextEditingController _CategoryController = TextEditingController();
  final TextEditingController _BarcodeController = TextEditingController();
  final TextEditingController _ExpiredDateController = TextEditingController();
  final TextEditingController _QtyController = TextEditingController();
  final TextEditingController _UnitPriceInController = TextEditingController();
  final TextEditingController _UnitPriceOutController = TextEditingController();

  // Insert product into database

  Future<void> insertProduct(
      String ProductName,
      String Description,
      int CategoryID,
      String Barcode,
      String ExpiredDate,
      int Qty,
      double UnitPriceIn,
      double UnitPriceOut,
      BuildContext context,
      TextEditingController _ProductNameController,
      TextEditingController _DescriptionController,
      TextEditingController _CategoryController,
      TextEditingController _BarcodeController,
      TextEditingController _ExpiredDateController,
      TextEditingController _QtyController,
      TextEditingController _UnitPriceInController,
      TextEditingController _UnitPriceOutController,
      ) async {
    var uri = Uri.parse("${AppUrl.url}create_product.php");  // Replace with correct URL
    EasyLoading.show(status: 'Loading...');

    try {
      final response = await http.post(
        uri,
        body: {
          'ProductName': ProductName,
          'Description': Description,
          'CategoryID': CategoryID.toString(),
          'Barcode': Barcode,
          'ExpiredDate': ExpiredDate,
          'Qty': Qty.toString(),
          'UnitPriceIn': UnitPriceIn.toString(),
          'UnitPriceOut': UnitPriceOut.toString(),
        },
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        final data = jsonDecode(response.body);
        if (data['success'] == 1) {
          // Show success dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Success'),
                content: Text(data['msg_success']),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                      // Clear the form fields
                      _ProductNameController.clear();
                      _DescriptionController.clear();
                      _CategoryController.clear();
                      _BarcodeController.clear();
                      _ExpiredDateController.clear();
                      _QtyController.clear();
                      _UnitPriceInController.clear();
                      _UnitPriceOutController.clear();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['msg_error'] ?? "Failed to register product")),
          );
        }
      } else {
        EasyLoading.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${response.statusCode} - ${response.reasonPhrase}")),
        );
      }
    } catch (e) {
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: Unable to connect to the server. $e")),
      );
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _ProductNameController,
                  decoration: InputDecoration(labelText: 'Product Name', border: OutlineInputBorder(),),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the product name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _CategoryController,
                  decoration: InputDecoration(labelText: 'Category ID', border: OutlineInputBorder(),),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the category ID';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _BarcodeController,
                  decoration: InputDecoration(labelText: 'Barcode',
                      border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _QtyController,
                  decoration: InputDecoration(labelText: 'Quantity', border: OutlineInputBorder(),),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _UnitPriceInController,
                  decoration: InputDecoration(labelText: 'Unit Price In', border: OutlineInputBorder(),),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _UnitPriceOutController,
                  decoration: InputDecoration(labelText: 'Unit Price Out', border: OutlineInputBorder(),),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _DescriptionController,
                  decoration: InputDecoration(labelText: 'Description', border: OutlineInputBorder(),),
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _ExpiredDateController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Expired Date',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () async {
                        DateTime? selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (selectedDate != null) {
                          _ExpiredDateController.text = selectedDate.toLocal().toString().split(' ')[0];
                        }
                      },
                    ),
                  ),
                  readOnly: true,
                ),
                SizedBox(height: 16),
                // ElevatedButton(
                //   onPressed: () {
                //     if (_formKey.currentState?.validate() ?? false) {
                //       insertProduct(
                //         _ProductNameController.text,
                //         _DescriptionController.text,
                //         int.parse(_CategoryController.text),
                //         _BarcodeController.text,
                //         _ExpiredDateController.text,
                //         int.parse(_QtyController.text),
                //         double.parse(_UnitPriceInController.text),
                //         double.parse(_UnitPriceOutController.text),
                //         context,
                //       );
                //     }
                //   },
                //   child: Text('រក្សាទុក្ខ'),
                // ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      insertProduct(
                        _ProductNameController.text,
                        _DescriptionController.text,
                        int.parse(_CategoryController.text),
                        _BarcodeController.text,
                        _ExpiredDateController.text,
                        int.parse(_QtyController.text),
                        double.parse(_UnitPriceInController.text),
                        double.parse(_UnitPriceOutController.text),
                        context,
                        _ProductNameController,
                        _DescriptionController,
                        _CategoryController,
                        _BarcodeController,
                        _ExpiredDateController,
                        _QtyController,
                        _UnitPriceInController,
                        _UnitPriceOutController,
                      );
                    }
                  },
                  child: Text('Save'),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
