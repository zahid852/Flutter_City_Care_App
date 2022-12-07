import 'dart:io';

import 'package:city_care/view_models/incidentViewState.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import '../models/incidents.dart';

class AddIncidentViewModel with ChangeNotifier {
  String message = "";
  Future<bool> saveIncident(IncidentViewState incidentViewState) async {
    bool isSaved = false;
    final incident = Incidents.fromIncidentViewState(incidentViewState);
    try {
      await FirebaseFirestore.instance
          .collection('incidents')
          .add(incident.toMap());
      isSaved = true;
    } catch (e) {
      message = "Unable to save data";
    }
    notifyListeners();
    return isSaved;
  }

  Future<String> uploadFile(File imageFile) async {
    late String downloadUrl;
    final uuid = Uuid();
    final imagePath = "/images/${uuid.v4()}.jpg";
    final storage = FirebaseStorage.instance.ref(imagePath);
    TaskSnapshot uploadTask = await storage.putFile(imageFile);
    if (uploadTask.state == TaskState.success) {
      downloadUrl = await storage.getDownloadURL();
    }
    return downloadUrl;
  }
}
