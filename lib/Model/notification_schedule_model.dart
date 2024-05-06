class NotificationScheduleModel {
  String? sId;
  int? timePeriod;
  bool? status;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isSelected;

  NotificationScheduleModel(
      {this.sId,
        this.timePeriod,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.isSelected = false,
        this.iV});

  NotificationScheduleModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    timePeriod = json['time_period'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['time_period'] = timePeriod;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}