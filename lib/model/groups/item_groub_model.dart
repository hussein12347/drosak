import '../../core/resources/const_values.dart';

class ItemGroupModel {
  final int id;
  final int education_id;
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
    return 'ItemGroupModel{id: $id, education_id: $education_id, status: $status, title: $title, notes: $notes, image: $image, createdAt: $createdAt}';
  }

  Map<String, dynamic> toJson() {
    return {
      ConstValue.kGroupColumnName: title,
      ConstValue.kGroupColumnEducationID: education_id,
      ConstValue.kGroupColumnNote: notes,
      ConstValue.kGroupColumnImage: image,
    };
  }

  ItemGroupModel(
      {required this.notes,
        required this.education_id,
      this.status = 1,
      required this.id,
      required this.title,
      this.createdAt,
      required this.image});

  factory ItemGroupModel.fromJson(Map data) {
    return ItemGroupModel(
      id: data[ConstValue.kGroupColumnID],
      title: data[ConstValue.kGroupColumnName],

      image: data[ConstValue.kGroupColumnImage],
      createdAt: data[ConstValue.kGroupCreatedAt],
      notes: data[ConstValue.kGroupColumnNote],
       education_id: data[ConstValue.kGroupColumnEducationID], // Fix here
    );
  }
}
