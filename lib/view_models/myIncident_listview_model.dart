import 'package:city_care/models/incidents.dart';
import 'package:city_care/view_models/incident_list_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyIncidentListViewModel {
  Future<List<IncidentViewModel>> myIncidentsList() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('incidents')
        .where('userId', isEqualTo: userId)
        .orderBy('incidentDate', descending: true)
        .get();

    final incidents =
        snapshot.docs.map((e) => Incidents.fromDocument(e)).toList();
    return incidents.map((e) => IncidentViewModel(incidents: e)).toList();
  }
}
