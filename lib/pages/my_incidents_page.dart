import 'package:city_care/widgets/incident_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../view_models/incident_list_view_model.dart';

class MyIncidentsPage extends StatefulWidget {
  @override
  _MyIncidentsPage createState() => _MyIncidentsPage();
}

class _MyIncidentsPage extends State<MyIncidentsPage> {
  IncidentListViewModel _incidentListViewModel = IncidentListViewModel();
  List<IncidentViewModel> _incidents = [];

  @override
  void initState() {
    super.initState();
    _populateMyIncidents();
  }

  void _populateMyIncidents() async {
    final incidents = await _incidentListViewModel.getAllIncidents();
    setState(() {
      _incidents = incidents;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Incidents"),
        ),
        body: Column(
            children: [Expanded(child: IncidentList(incidents: _incidents))]));
  }
}
