import 'package:city_care/models/incidents.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class IncidentListViewModel {
  Future<List<IncidentViewModel>> getAllIncidents() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('incidents')
        .orderBy('incidentDate', descending: true)
        .get();
    final incidents =
        snapshot.docs.map((e) => Incidents.fromDocument(e)).toList();
    return incidents.map((e) => IncidentViewModel(incidents: e)).toList();
  }
}

class IncidentViewModel {
  final Incidents incidents;
  IncidentViewModel({required this.incidents});

  String get title {
    return incidents.title;
  }

  String get description {
    return incidents.description;
  }

  String get photoUrl {
    return incidents.photoUrl;
  }

  String get incidentsDate {
    return DateFormat('MM-dd-yyyy HH:mm:ss').format(incidents.incidentDate);
  }
}
