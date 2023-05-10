class ProjectModel {
  final int projectID;
  final String projectName;

  ProjectModel({required this.projectID, required this.projectName});

  factory ProjectModel.fromJson(Map<String, dynamic> data) {
    final projectID = data['projectId'] as int;
    final projectName = data['projectName'] as String;

    return ProjectModel(projectID: projectID, projectName: projectName);
  }
}
