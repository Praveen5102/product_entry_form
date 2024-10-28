import 'package:flutter/material.dart';

void main() => runApp(ProductEntryApp());

class ProductEntryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Entry Form',
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: ProductEntryForm(),
    );
  }
}

class ProductEntryForm extends StatefulWidget {
  @override
  _ProductEntryFormState createState() => _ProductEntryFormState();
}

class _ProductEntryFormState extends State<ProductEntryForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productIdController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _discountPriceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _storeController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  // Dropdown Values
  String? _selectedCategory;
  String? _selectedMeasurement;

  // Date Values
  DateTime? _validFrom;
  DateTime? _validTo;

  // Checkboxes
  bool _notifyUsers = false;
  bool _whatsappAlert = false;

  // Validation and submission function
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Product details saved successfully!")),
      );
      // Save form data logic here
    }
  }

  // UI for the product entry form
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.0), // You can adjust the height as needed
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent, // Set AppBar background to transparent
            title: const Text(
              "Product Entry Form",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                // Product Name
                TextFormField(
                  controller: _productNameController,
                  decoration: const InputDecoration(
                    labelText: "Product Name",
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    filled: true, // To apply fill color
                    fillColor: Colors.white,
                  ),
                  style: const TextStyle(color: Colors.black), // Set text color here
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product name';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16),

                // Product ID
                TextFormField(
                  controller: _productIdController,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    labelText: "Product ID",
                    labelStyle: TextStyle(color: Colors.black),
                    helperText: "Must be unique and 10 characters max",
                    helperStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    filled: true, // To apply fill color
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length > 10) {
                      return 'Please enter a valid Product ID (max 10 chars)';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Category Dropdown
                DropdownButtonFormField(
                  value: _selectedCategory,
                  items: ["Grocery", "Electronics"]
                      .map((category) => DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value as String?;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: "Category",
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    filled: true, // To apply fill color
                    fillColor: Colors.white,
                  ),
                  validator: (value) =>
                  value == null ? 'Please select a category' : null,
                ),
                SizedBox(height: 16),

                // Brand
                TextFormField(
                  controller: _brandController,
                  decoration: const InputDecoration(
                    labelText: "Brand (Optional)",
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    filled: true, // To apply fill color
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 16),

                // Price
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Price",
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    filled: true, // To apply fill color
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null ||
                        double.tryParse(value) == null ||
                        double.parse(value) <= 0) {
                      return 'Please enter a valid price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Discount Price
                TextFormField(
                  controller: _discountPriceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Discount Price (Optional)",
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    filled: true, // To apply fill color
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      double? discountPrice = double.tryParse(value);
                      double? price = double.tryParse(_priceController.text);
                      if (discountPrice != null &&
                          price != null &&
                          discountPrice > price) {
                        return 'Discount Price cannot exceed Price';
                      }
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Quantity
                TextFormField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Quantity",
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    filled: true, // To apply fill color
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null ||
                        int.tryParse(value) == null ||
                        int.parse(value) <= 0) {
                      return 'Please enter a valid quantity';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Measurement Type Dropdown
                DropdownButtonFormField(
                  value: _selectedMeasurement,
                  items: ["kg", "liters"]
                      .map((measurement) => DropdownMenuItem(
                    value: measurement,
                    child: Text(measurement),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedMeasurement = value as String?;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: "Measurement Type",
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    filled: true, // To apply fill color
                    fillColor: Colors.white,
                  ),
                  validator: (value) => value == null
                      ? 'Please select a measurement type'
                      : null,
                ),
                SizedBox(height: 16),

                // Store Name
                TextFormField(
                  controller: _storeController,
                  decoration: const InputDecoration(
                    labelText: "Store",
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    filled: true, // To apply fill color
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a store name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Valid From Date
                GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _validFrom ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _validFrom = pickedDate;
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Valid From",
                        labelStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        filled: true, // To apply fill color
                        fillColor: Colors.white,
                      ),
                      controller: TextEditingController(
                          text: _validFrom != null
                              ? "${_validFrom!.toLocal()}".split(' ')[0]
                              : ""),
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Valid To Date
                GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _validTo ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _validTo = pickedDate;
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Valid To",
                        labelStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        filled: true, // To apply fill color
                        fillColor: Colors.white,
                      ),
                      controller: TextEditingController(
                          text: _validTo != null
                              ? "${_validTo!.toLocal()}".split(' ')[0]
                              : ""),
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Notify Users Checkbox
                CheckboxListTile(
                  title: Text("Notify Users",style: TextStyle(color: Colors.white),),
                  value: _notifyUsers,
                  onChanged: (newValue) {
                    setState(() {
                      _notifyUsers = newValue!;
                    });
                  },
                ),
                SizedBox(height: 16),

                // Whatsapp Alert Checkbox
                CheckboxListTile(
                  title: Text("WhatsApp Alert",style: TextStyle(color: Colors.white),),
                  value: _whatsappAlert,
                  onChanged: (newValue) {
                    setState(() {
                      _whatsappAlert = newValue!;
                    });
                  },
                ),
                SizedBox(height: 16),

                // Image URL
                TextFormField(
                  controller: _imageUrlController,
                  decoration: const InputDecoration(
                    labelText: "Image URL",
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    filled: true, // To apply fill color
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 16),

                // Submit Button
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text("Submit"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, foregroundColor: Colors.white, // Text color
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _productIdController.dispose();
    _brandController.dispose();
    _priceController.dispose();
    _discountPriceController.dispose();
    _quantityController.dispose();
    _storeController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }
}
