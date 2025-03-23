import '../../core/resources/const_values.dart';

class ItemStageModel {
  final int id;
  final int status;
  final String title;
  final String description;
  final String image;
  String? createdAt;


  @override
  String toString() {
    return 'ItemStageModel{id: $id, status: $status, title: $title, description: $description, image: $image, createdAt: $createdAt}';
  }

  Map<String, dynamic> toJson() {
    return {
      ConstValue.kEducationStagesColumnName: title,
      ConstValue.kEducationStagesColumnDescription: description,
      ConstValue.kEducationStagesColumnImage: image,
    };
  }

  ItemStageModel(
      {this.status=1,required this.id,
      required this.title,
      this.createdAt,
      required this.description,
      required this.image});

  factory ItemStageModel.fromJson(Map data) {
    return ItemStageModel(
      id: data['id'],
      title: data['name'],
      description: data['description'],
      image: data['image'],
      status: data[ConstValue.kEducationStagesColumnStatus],
      createdAt: data[ConstValue.kEducationStagesColumnCreatedAt], // Fix here
    );
  }
}
