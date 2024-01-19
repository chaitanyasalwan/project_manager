import 'package:cloud_firestore/cloud_firestore.dart';

class TicketResponseModel {
  AssignDetails? assignDetails;
  BasicDetails? basicDetails;

  TicketResponseModel({this.assignDetails, this.basicDetails});

  TicketResponseModel.fromJson(Map<String, dynamic> json) {
    assignDetails = json['assignDetails'] != null
        ? new AssignDetails.fromJson(json['assignDetails'])
        : null;
    basicDetails = json['basicDetails'] != null
        ? new BasicDetails.fromJson(json['basicDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.assignDetails != null) {
      data['assignDetails'] = this.assignDetails!.toJson();
    }
    if (this.basicDetails != null) {
      data['basicDetails'] = this.basicDetails!.toJson();
    }
    return data;
  }
}

class AssignDetails {
  AssignedBy? assignedBy;
  AssignedBy? assignedTo;

  AssignDetails({this.assignedBy, this.assignedTo});

  AssignDetails.fromJson(Map<String, dynamic> json) {
    assignedBy = json['assignedBy'] != null
        ? new AssignedBy.fromJson(json['assignedBy'])
        : null;
    assignedTo = json['assignedTo'] != null
        ? new AssignedBy.fromJson(json['assignedTo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.assignedBy != null) {
      data['assignedBy'] = this.assignedBy!.toJson();
    }
    if (this.assignedTo != null) {
      data['assignedTo'] = this.assignedTo!.toJson();
    }
    return data;
  }
}

class AssignedBy {
  String? name;
  Timestamp? time;
  String? uid;
  String? url;

  AssignedBy({this.name, this.time, this.uid, this.url});

  AssignedBy.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    time = json['time'];
    uid = json['uid'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['time'] = this.time;
    data['uid'] = this.uid;
    data['url'] = this.url;
    return data;
  }
}

class BasicDetails {
  String? description;
  int? estimatedDays;
  int? id;
  bool? isActive;
  String? iteration;
  int? priority;
  String? state;
  Timestamp? timeStamp;
  String? title;

  BasicDetails(
      {this.description,
      this.estimatedDays,
      this.isActive,
      this.iteration,
      this.priority,
      this.state,
      this.timeStamp,
      this.title,
      this.id});

  BasicDetails.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    estimatedDays = json['estimatedDays'];
    isActive = json['isActive'];
    iteration = json['iteration'];
    priority = json['priority'];
    state = json['state'];
    timeStamp = json['timeStamp'];
    title = json['title'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['estimatedDays'] = this.estimatedDays;
    data['isActive'] = this.isActive;
    data['iteration'] = this.iteration;
    data['priority'] = this.priority;
    data['state'] = this.state;
    data['timeStamp'] = this.timeStamp;
    data['title'] = this.title;
    data['id'] = this.id;
    return data;
  }
}
