import '../../core/resources/const_values.dart';

class TimeDayGroupModel {
  String day;
  String time;
  int groupId;
  int id;

  TimeDayGroupModel({
    required this.id ,
     this.groupId=0,
    required this.day,
    required this.time,
  });

  @override
  String toString() {
    return 'TimeDayGroupModel{id:$id,day: $day, time: $time,groupId:$groupId}';
  }

  Map<String, dynamic> toJson(int groupId) {
    return {
      ConstValue.kAppointmentsColumDay: day,
      ConstValue.kAppointmentsColumGroupID: groupId,
      ConstValue.kAppointmentsColumTime: time,
    };
  }

  factory TimeDayGroupModel.fromJson(Map data) {
    return TimeDayGroupModel(
        day: data[ConstValue.kAppointmentsColumDay],
        time: data[ConstValue.kAppointmentsColumTime],
        groupId:data [ConstValue.kAppointmentsColumGroupID], id: data[ConstValue.kAppointmentsColumnID]);
  }
}
