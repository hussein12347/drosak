import '../../core/resources/const_values.dart';

class ItemStudentModel {
  final int id;
  final int groupId;
  final int status;
  final String title;
  // final String day;
  final String notes;
  // final String time;
  // final String d_or_n;
  final String image;
  String? createdAt;


  @override
  String toString() {
    return 'ItemGroupModel{id: $id, groupId: $groupId, status: $status, title: $title, notes: $notes, image: $image, createdAt: $createdAt}';
  }

  Map<String, dynamic> toJson() {
    return {
      ConstValue.kStudentColumnName: title,
      ConstValue.kStudentColumnGroupID: groupId,
      ConstValue.kStudentColumnNote: notes,
      ConstValue.kStudentColumnImage: image,
    };
  }

  ItemStudentModel(
      {required this.notes,
        required this.groupId,
        this.status = 1,
        required this.id,
        required this.title,
        this.createdAt,
        required this.image});

  factory ItemStudentModel.fromJson(Map data) {
    return ItemStudentModel(
      id: data[ConstValue.kStudentColumnID],
      title: data[ConstValue.kStudentColumnName],

      image: data[ConstValue.kStudentColumnImage],
      createdAt: data[ConstValue.kStudentCreatedAt],
      notes: data[ConstValue.kStudentColumnNote],
      groupId: data[ConstValue.kStudentColumnGroupID], // Fix here
    );
  }
}
