import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert'; // For encoding image to base64
import 'api_service.dart';

class ClassificationPage extends StatefulWidget {
  @override
  _ClassificationPageState createState() => _ClassificationPageState();
}

class _ClassificationPageState extends State<ClassificationPage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  String? _result; // To store the classification result
  bool _isLoading = false; // To show loading state during classification

  static const IconData add_photo_alternate_outlined = IconData(0xee48, fontFamily: 'MaterialIcons');

  final ApiService apiService = ApiService('http://your-backend-url'); // Replace with your actual URL

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _result = null; // Reset result when new image is picked
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _takeImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _result = null; // Reset result when new image is taken
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _classifyImage() async {
    if (_image == null) return; // Check if an image is selected

    setState(() {
      _isLoading = true; // Show loading while sending the image
    });

    try {
      // Convert the image to base64
      List<int> imageBytes = await _image!.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      // Call the API service and get the classification result
      var result = await apiService.getPrediction(base64Image);

      setState(() {
        _result = result; // Update the result with the prediction
      });
    } catch (e) {
      print('Error during classification: $e');
    } finally {
      setState(() {
        _isLoading = false; // Hide loading state
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Classification'),
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _image == null
                    ? Text('No image selected.', style: TextStyle(fontSize: 18, color: Colors.white))
                    : Image.file(_image!),
                SizedBox(height: 20),
                _buildElevatedButton(
                  context,
                  'Pick Image from Gallery',
                  _pickImageFromGallery,
                ),
                SizedBox(height: 20),
                _buildElevatedButton(
                  context,
                  'Take Image from Camera',
                  _takeImageFromCamera,
                ),
                SizedBox(height: 20),
                _image != null
                    ? ElevatedButton(
                  onPressed: _classifyImage,
                  child: _isLoading ? CircularProgressIndicator() : Text('Classify Image'),
                )
                    : Container(),
                SizedBox(height: 20),
                _result != null
                    ? Text('Classification Result: $_result', style: TextStyle(fontSize: 18, color: Colors.white))
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildElevatedButton(BuildContext context, String text, VoidCallback onPressed) {
    return ElevatedButton.icon(
      icon: Icon(add_photo_alternate_outlined),
      onPressed: onPressed,
      label: Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        textStyle: TextStyle(fontSize: 18),
      ),
    );
  }
}
