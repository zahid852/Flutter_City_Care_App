import 'dart:io';
import 'package:city_care/view_models/add_incident_view_model.dart';
import 'package:city_care/view_models/incidentViewState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

enum PhotoOptions { camera, library }

class AddIncidentsPage extends StatefulWidget {
  @override
  _AddIncidentsPage createState() => _AddIncidentsPage();
}

class _AddIncidentsPage extends State<AddIncidentsPage> {
  late AddIncidentViewModel _addIncidentViewModel;
  File? _image;
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _selectPhotoFromPhotoLibrary() async {
    final imagePicker = ImagePicker();
    XFile? pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      // imageQuality: 70, maxWidth: 150
    );
    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  void _selectPhotoFromCamera() async {
    final imagePicker = ImagePicker();
    XFile? pickedFile = await imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 70, maxWidth: 150);

    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  void _optionSelected(PhotoOptions option) {
    switch (option) {
      case PhotoOptions.camera:
        _selectPhotoFromCamera();
        break;
      case PhotoOptions.library:
        _selectPhotoFromPhotoLibrary();
        break;
    }
  }

  void _saveIncident(BuildContext context) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    // validate the form
    if (_formKey.currentState!.validate()) {
      final fileImageUrl = await _addIncidentViewModel.uploadFile(_image!);
      if (fileImageUrl.isNotEmpty) {
        final title = _titleController.text;
        final description = _descriptionController.text;
        final incidentVS = IncidentViewState(
            userId: userId,
            title: title,
            description: description,
            photoUrl: fileImageUrl,
            incidentDate: DateTime.now());
        final isSaved = await _addIncidentViewModel.saveIncident(incidentVS);
        if (isSaved) {
          Navigator.of(context).pop(true);
        }
      }
    }
  }

  Widget _buildLoadingWidget() {
    return Text("Loading...");
  }

  @override
  Widget build(BuildContext context) {
    _addIncidentViewModel = Provider.of<AddIncidentViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Incident"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(children: [
                  Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.fill,
                        image: _image == null
                            ? Image.asset("assets/images/city_care.jpg").image
                            : FileImage(_image!),
                      )),
                      width: 300,
                      height: 300),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: TextButton(
                      style: TextButton.styleFrom(backgroundColor: Colors.blue),
                      onPressed: () {},
                      // textColor: Colors.white,
                      child: PopupMenuButton<PhotoOptions>(
                        child: Text(
                          "Add Photo",
                          style: TextStyle(color: Colors.white),
                        ),
                        onSelected: _optionSelected,
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Text("Take a picture"),
                            value: PhotoOptions.camera,
                          ),
                          PopupMenuItem(
                              child: Text("Select from photo library"),
                              value: PhotoOptions.library)
                        ],
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _titleController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Title is required!";
                      }
                      return null;
                    },
                    decoration:
                        InputDecoration(hintText: "Enter incident title"),
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Description is required!";
                      }
                      return null;
                    },
                    maxLines: null,
                    decoration:
                        InputDecoration(hintText: "Enter incident description"),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.blue),
                    child: Text("Submit"),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      _saveIncident(context);
                    },
                    // color: Colors.blue,
                    // textColor: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_addIncidentViewModel.message),
                  ),
                  _buildLoadingWidget()
                ]),
              ),
            ),
          ),
        ));
  }
}
