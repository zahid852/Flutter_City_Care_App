import 'package:city_care/view_models/incidentViewState.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Incidents {
  final String userId;
  final String title;
  final String description;
  final String photoUrl;
  final DateTime incidentDate;
  Incidents(
      {required this.userId,
      required this.title,
      required this.description,
      required this.photoUrl,
      required this.incidentDate});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'description': description,
      'photoUrl': photoUrl,
      'incidentDate': incidentDate
    };
  }

  factory Incidents.fromDocument(QueryDocumentSnapshot doc) {
    return Incidents(
        userId: doc['userId'],
        title: doc['title'],
        description: doc['description'],
        photoUrl: doc['photoUrl'],
        incidentDate: doc['incidentDate'].toDate());
  }

  factory Incidents.fromIncidentViewState(IncidentViewState incidentViewState) {
    return Incidents(
        userId: incidentViewState.userId,
        title: incidentViewState.title,
        description: incidentViewState.description,
        photoUrl: incidentViewState.photoUrl,
        incidentDate: incidentViewState.incidentDate);
  }
}
