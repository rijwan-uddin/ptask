// To parse this JSON data, do
//
//     final taskResponse = taskResponseFromJson(jsonString);

import 'dart:convert';

TaskResponse taskResponseFromJson(String str) => TaskResponse.fromJson(json.decode(str));

String taskResponseToJson(TaskResponse data) => json.encode(data.toJson());

class TaskResponse {
  List<Task>? tasks;

  TaskResponse({
    this.tasks,
  });

  factory TaskResponse.fromJson(Map<String, dynamic> json) => TaskResponse(
    tasks: json["tasks"] == null
        ? null
        : List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tasks": tasks == null
        ? null
        : List<dynamic>.from(tasks!.map((x) => x.toJson())),
  };
}

class Task {
  int? id;
  String? title;
  String? slug;
  int? isDone;
  int? isArchive;
  String? description;
  dynamic cover;
  int? listId;
  int? order;
  int? userId;
  int? projectId;
  DateTime? dueDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? estimationTime;
  String? storyIds;
  int? isRecurring;
  ListClass? list;
  List<dynamic>? taskLabels;
  Project? project;
  List<Assignee>? assignees;
  dynamic timer;

  Task({
    this.id,
    this.title,
    this.slug,
    this.isDone,
    this.isArchive,
    this.description,
    this.cover,
    this.listId,
    this.order,
    this.userId,
    this.projectId,
    this.dueDate,
    this.createdAt,
    this.updatedAt,
    this.estimationTime,
    this.storyIds,
    this.isRecurring,
    this.list,
    this.taskLabels,
    this.project,
    this.assignees,
    this.timer,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    isDone: json["is_done"],
    isArchive: json["is_archive"],
    description: json["description"],
    cover: json["cover"],
    listId: json["list_id"],
    order: json["order"],
    userId: json["user_id"],
    projectId: json["project_id"],
    dueDate: json["due_date"] == null
        ? null
        : DateTime.parse(json["due_date"]),
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    estimationTime: json["estimation_time"],
    storyIds: json["story_ids"],
    isRecurring: json["is_recurring"],
    list: json["list"] == null
        ? null
        : ListClass.fromJson(json["list"]),
    taskLabels: json["task_labels"] == null
        ? null
        : List<dynamic>.from(json["task_labels"].map((x) => x)),
    project: json["project"] == null
        ? null
        : Project.fromJson(json["project"]),
    assignees: json["assignees"] == null
        ? null
        : List<Assignee>.from(json["assignees"].map((x) => Assignee.fromJson(x))),
    timer: json["timer"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "is_done": isDone,
    "is_archive": isArchive,
    "description": description,
    "cover": cover,
    "list_id": listId,
    "order": order,
    "user_id": userId,
    "project_id": projectId,
    "due_date": dueDate?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "estimation_time": estimationTime,
    "story_ids": storyIds,
    "is_recurring": isRecurring,
    "list": list?.toJson(),
    "task_labels": taskLabels == null
        ? null
        : List<dynamic>.from(taskLabels!.map((x) => x)),
    "project": project?.toJson(),
    "assignees": assignees == null
        ? null
        : List<dynamic>.from(assignees!.map((x) => x.toJson())),
    "timer": timer,
  };
}

class Assignee {
  int? id;
  int? taskId;
  int? userId;
  User? user;

  Assignee({
    this.id,
    this.taskId,
    this.userId,
    this.user,
  });

  factory Assignee.fromJson(Map<String, dynamic> json) => Assignee(
    id: json["id"],
    taskId: json["task_id"],
    userId: json["user_id"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "task_id": taskId,
    "user_id": userId,
    "user": user?.toJson(),
  };
}

class User {
  int? id;
  int? roleId;
  String? locale;
  dynamic address;
  String? firstName;
  String? lastName;
  String? email;
  dynamic phone;
  dynamic emailVerifiedAt;
  String? photoPath;
  String? createdAt;
  DateTime? updatedAt;
  dynamic teamleadId;
  String? teamlead;
  dynamic position;
  dynamic reportingId;
  String? name;

  User({
    this.id,
    this.roleId,
    this.locale,
    this.address,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.emailVerifiedAt,
    this.photoPath,
    this.createdAt,
    this.updatedAt,
    this.teamleadId,
    this.teamlead,
    this.position,
    this.reportingId,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    roleId: json["role_id"],
    locale: json["locale"],
    address: json["address"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    phone: json["phone"],
    emailVerifiedAt: json["email_verified_at"],
    photoPath: json["photo_path"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    teamleadId: json["teamlead_id"],
    teamlead: json["teamlead"],
    position: json["position"],
    reportingId: json["reporting_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "role_id": roleId,
    "locale": locale,
    "address": address,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone": phone,
    "email_verified_at": emailVerifiedAt,
    "photo_path": photoPath,
    "created_at": createdAt,
    "updated_at": updatedAt?.toIso8601String(),
    "teamlead_id": teamleadId,
    "teamlead": teamlead,
    "position": position,
    "reporting_id": reportingId,
    "name": name,
  };
}

class ListClass {
  int? id;
  int? projectId;
  String? title;
  int? order;
  int? isArchive;
  int? userId;
  dynamic createdAt;
  dynamic updatedAt;

  ListClass({
    this.id,
    this.projectId,
    this.title,
    this.order,
    this.isArchive,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
    id: json["id"],
    projectId: json["project_id"],
    title: json["title"],
    order: json["order"],
    isArchive: json["is_archive"],
    userId: json["user_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "project_id": projectId,
    "title": title,
    "order": order,
    "is_archive": isArchive,
    "user_id": userId,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Project {
  int? id;
  String? title;
  String? slug;
  int? backgroundId;
  int? userId;
  int? workspaceId;
  dynamic description;
  String? createdAt;
  DateTime? updatedAt;
  int? isPrivate;
  String? projectImage;
  dynamic linkUrl;
  dynamic filesUrl;
  String? projectType;
  DateTime? startDate;
  DateTime? endDate;
  String? projectStatus;
  int? projectManagerId;
  int? projectTeamleadId;
  int? projectCoordinatorId;
  Background? background;

  Project({
    this.id,
    this.title,
    this.slug,
    this.backgroundId,
    this.userId,
    this.workspaceId,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.isPrivate,
    this.projectImage,
    this.linkUrl,
    this.filesUrl,
    this.projectType,
    this.startDate,
    this.endDate,
    this.projectStatus,
    this.projectManagerId,
    this.projectTeamleadId,
    this.projectCoordinatorId,
    this.background,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    backgroundId: json["background_id"],
    userId: json["user_id"],
    workspaceId: json["workspace_id"],
    description: json["description"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    isPrivate: json["is_private"],
    projectImage: json["project_image"],
    linkUrl: json["link_url"],
    filesUrl: json["files_url"],
    projectType: json["project_type"],
    startDate: json["start_date"] == null
        ? null
        : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null
        ? null
        : DateTime.parse(json["end_date"]),
    projectStatus: json["project_status"],
    projectManagerId: json["project_manager_id"],
    projectTeamleadId: json["project_teamlead_id"],
    projectCoordinatorId: json["project_coordinator_id"],
    background: json["background"] == null
        ? null
        : Background.fromJson(json["background"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "background_id": backgroundId,
    "user_id": userId,
    "workspace_id": workspaceId,
    "description": description,
    "created_at": createdAt,
    "updated_at": updatedAt?.toIso8601String(),
    "is_private": isPrivate,
    "project_image": projectImage,
    "link_url": linkUrl,
    "files_url": filesUrl,
    "project_type": projectType,
    "start_date": startDate?.toIso8601String(),
    "end_date": endDate?.toIso8601String(),
    "project_status": projectStatus,
    "project_manager_id": projectManagerId,
    "project_teamlead_id": projectTeamleadId,
    "project_coordinator_id": projectCoordinatorId,
    "background": background?.toJson(),
  };
}

class Background {
  int? id;
  String? bg;
  String? image;
  String? top;
  String? color;
  String? type;
  String? side;

  Background({
    this.id,
    this.bg,
    this.image,
    this.top,
    this.color,
    this.type,
    this.side,
  });

  factory Background.fromJson(Map<String, dynamic> json) => Background(
    id: json["id"],
    bg: json["bg"],
    image: json["image"],
    top: json["top"],
    color: json["color"],
    type: json["type"],
    side: json["side"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bg": bg,
    "image": image,
    "top": top,
    "color": color,
    "type": type,
    "side": side,
  };
}
