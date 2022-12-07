import 'package:city_care/view_models/incident_list_view_model.dart';
import 'package:flutter/material.dart';

class IncidentList extends StatelessWidget {
  final List<IncidentViewModel> incidents;
  IncidentList({required this.incidents});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: incidents.length,
      itemBuilder: (context, index) {
        final incident = incidents[index];
        return ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                incident.photoUrl,
                fit: BoxFit.contain,
                height: 200,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(incident.title,
                    style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(incident.description,
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                        fontWeight: FontWeight.w400)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(incident.incidentsDate),
              )
            ],
          ),
        );
      },
    );
  }
}
