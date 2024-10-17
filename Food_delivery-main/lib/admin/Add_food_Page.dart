import 'dart:io';
import 'dart:typed_data'; // For Uint8List
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:firebase_auth/firebase_auth.dart'; // For getting current user
import 'firebase_storage_service.dart'; // Import your FirebaseStorageService

class AddFoodPage extends StatefulWidget {
  const AddFoodPage({super.key});

  @override
  _AddFoodPageState createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _restaurantController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  File? _selectedImage;
  File? _selectedPdf;
  Uint8List? _webImage;
  Uint8List? _webPdf;

  bool _isLoading = false;
  final FirebaseStorageService _storageService = FirebaseStorageService();

  Future<void> _pickImage() async {
    try {
      if (kIsWeb) {
        final result =
            await FilePicker.platform.pickFiles(type: FileType.image);
        if (result != null && result.files.single.bytes != null) {
          setState(() => _webImage = result.files.single.bytes);
        }
      } else {
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          setState(() => _selectedImage = File(pickedFile.path));
        }
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _pickPdf() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null) {
        if (kIsWeb) {
          setState(() => _webPdf = result.files.single.bytes);
        } else {
          setState(() => _selectedPdf = File(result.files.single.path!));
        }
      }
    } catch (e) {
      print('Error picking PDF: $e');
    }
  }

  Future<void> _addFoodToFirebase(BuildContext context) async {
    final name = _nameController.text;
    final restaurant = _restaurantController.text;
    final description = _descriptionController.text;

    if (name.isNotEmpty &&
        restaurant.isNotEmpty &&
        description.isNotEmpty &&
        (_selectedImage != null || _webImage != null) &&
        (_selectedPdf != null || _webPdf != null)) {
      setState(() => _isLoading = true);

      try {
        String? imageUrl, pdfUrl;

        if (kIsWeb) {
          // For web uploads
          if (_webImage != null) {
            imageUrl = await _storageService.uploadFile(
              _webImage!,
              'Food/food_images/${DateTime.now().millisecondsSinceEpoch}.jpg',
              isWeb: true,
            );
          }
          if (_webPdf != null) {
            pdfUrl = await _storageService.uploadFile(
              _webPdf!,
              'Food/food_pdfs/${DateTime.now().millisecondsSinceEpoch}.pdf',
              isWeb: true,
            );
          }
        } else {
          // For mobile uploads
          if (_selectedImage != null) {
            imageUrl = await _storageService.uploadFile(
              _selectedImage!,
              'Food/food_images/${DateTime.now().millisecondsSinceEpoch}.jpg',
            );
          }
          if (_selectedPdf != null) {
            pdfUrl = await _storageService.uploadFile(
              _selectedPdf!,
              'Food/food_pdfs/${DateTime.now().millisecondsSinceEpoch}.pdf',
            );
          }
        }

        final currentUser = FirebaseAuth.instance.currentUser;
        final userId = currentUser?.uid ?? '';

        // Add the food document to Firestore with an auto-generated ID
        final foodRef = FirebaseFirestore.instance.collection('foods').doc();
        final foodId = foodRef.id;

        await foodRef.set({
          'id': foodId, // Add the food ID field
          'name': name,
          'restaurant': restaurant,
          'description': description,
          'image_url': imageUrl,
          
          'uploader_id': userId, // Set the uploader_id field
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Food item added successfully!')),
        );

        Navigator.of(context).pop(); // Navigate back to the previous page
      } catch (e) {
        print('Error adding food: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to add food item.')),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill in all fields and select files.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Food')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Text('Add a New Food Item',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Food Name'),
            ),
            TextFormField(
              controller: _restaurantController,
              decoration: const InputDecoration(labelText: 'Restaurant Name'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Select Food Image'),
            ),
            ElevatedButton(
              onPressed: _pickPdf,
              child: const Text('Select Recipe PDF'),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: () => _addFoodToFirebase(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text('Add Food Item'),
                  ),
          ],
        ),
      ),
    );
  }
}
