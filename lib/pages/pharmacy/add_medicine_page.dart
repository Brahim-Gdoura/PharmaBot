import 'package:flutter/material.dart';
import 'package:pharma_bot/models/medicine.dart';
import 'package:pharma_bot/services/medicine_service.dart';
import 'package:uuid/uuid.dart';

class AddMedicinePage extends StatefulWidget {
  @override
  _AddMedicinePageState createState() => _AddMedicinePageState();
}

class _AddMedicinePageState extends State<AddMedicinePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _compositionController = TextEditingController();
  final _usesController = TextEditingController();
  final _sideEffectsController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _manufacturerController = TextEditingController();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  final _service = MedicineService();

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final id = Uuid().v4();
      final medicine = Medicine(
        id: id,
        name: _nameController.text,
        composition: _compositionController.text,
        uses: _usesController.text,
        sideEffects: _sideEffectsController.text,
        imageUrl: _imageUrlController.text,
        manufacturer: _manufacturerController.text,
        category: 'General', // Default category, can be changed later
        price: 0.0, // Default price, can be set later
      );

      await _service.addMedicine(medicine);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Medicine added successfully')),
      );
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Medicine')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Medicine Name'),
                    validator: (val) => val!.isEmpty ? 'Required' : null),
                TextFormField(
                    controller: _compositionController,
                    decoration: InputDecoration(labelText: 'Composition'),
                    validator: (val) => val!.isEmpty ? 'Required' : null),
                TextFormField(
                    controller: _usesController,
                    decoration: InputDecoration(labelText: 'Uses'),
                    validator: (val) => val!.isEmpty ? 'Required' : null),
                TextFormField(
                    controller: _sideEffectsController,
                    decoration: InputDecoration(labelText: 'Side Effects'),
                    validator: (val) => val!.isEmpty ? 'Required' : null),
                TextFormField(
                    controller: _imageUrlController,
                    decoration: InputDecoration(labelText: 'Image URL'),
                    validator: (val) => val!.isEmpty ? 'Required' : null),
                TextFormField(
                    controller: _manufacturerController,
                    decoration: InputDecoration(labelText: 'Manufacturer'),
                    validator: (val) => val!.isEmpty ? 'Required' : null),
                TextFormField(
                  controller: _categoryController,
                  decoration: InputDecoration(labelText: 'Category'),
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                SizedBox(height: 20),
                ElevatedButton(onPressed: _submit, child: Text('Add Medicine')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
