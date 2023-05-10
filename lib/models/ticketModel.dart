class TicketModel {
  int ticketID;
  String summary;
  String description;
  String status;
  String milestone;
  int assignedID;
  int reportedID;
  int totalWorkingHours;
  String assignedName;
  String reportedName;
  String tags;
  int taskProjectID;

  int severityState;

  TicketModel({
    required this.ticketID,
    required this.summary,
    required this.description,
    required this.status,
    required this.milestone,
    required this.assignedID,
    required this.reportedID,
    required this.taskProjectID,
    required this.totalWorkingHours,
    required this.assignedName,
    required this.reportedName,
    required this.tags,
    required this.severityState,
  });

  factory TicketModel.fromJson(Map<String, dynamic> data) {
    final ticketID = data['ticketId'] as int;
    final summary = data['summary'] as String;
    final description = data['description'] as String;
    final status = data['status'] as String;
    final severityState = data['severity'] as int;
    final milestone = data['milestone'] as String;
    final assignedID = data['assignedToId'] as int;
    final reportedID = data['reportedId'] as int;
    final taskProjectID = data['taskProjectId'] as int;
    final totalWorkingHours = data['totalWorkingHours'] as int;
    final assignedName = data['assignedToName'] as String;
    final reportedName = data['reportedToName'] as String;
    final tags = data['tags'] as String;

    return TicketModel(
        ticketID: ticketID,
        summary: summary,
        description: description,
        status: status,
        severityState: severityState,
        milestone: milestone,
        assignedID: assignedID,
        reportedID: reportedID,
        taskProjectID: taskProjectID,
        totalWorkingHours: totalWorkingHours,
        assignedName: assignedName,
        reportedName: reportedName,
        tags: tags);
  }
}
