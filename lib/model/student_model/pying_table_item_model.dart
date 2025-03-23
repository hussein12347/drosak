import '../../core/resources/const_values.dart';

class PayingTableItemModel {
  String month;
  int isPaid;
  int studentId;
  int id;

  PayingTableItemModel({
    required this.id ,
     this.studentId=0,
    required this.month,
    required this.isPaid,
  });


  @override
  String toString() {
    return 'PayingTableItemModel{month: $month, isPaid: $isPaid, studentId: $studentId, id: $id}';
  }

  Map<String, dynamic> toJson(int studentId) {
    return {
      ConstValue.kPayingColumMonth: month,
      ConstValue.kPayingColumStudentID: studentId,
      ConstValue.kPayingColumIsPaid: isPaid,
    };
  }

  factory PayingTableItemModel.fromJson(Map data) {
    return PayingTableItemModel(
        month: data[ConstValue.kPayingColumMonth],
        isPaid: data[ConstValue.kPayingColumIsPaid],
        studentId:data [ConstValue.kPayingColumStudentID], id: data[ConstValue.kStudentColumnID]);
  }
}
