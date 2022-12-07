class IncidentViewState {
  final String userId;
  final String title;
  final String description;
  final String photoUrl;
  final DateTime incidentDate;
  IncidentViewState(
      {required this.userId,
      required this.title,
      required this.description,
      required this.photoUrl,
      required this.incidentDate});
}
