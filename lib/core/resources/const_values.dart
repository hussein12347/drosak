import 'assets_values_manger.dart';

class ConstValue {
  static const List<String> listOnBoardingImage = [
    AssetsValueManger.kOn_bording_image_1,
    AssetsValueManger.kOn_bording_image_2,
    AssetsValueManger.kOn_bording_image_3,
    AssetsValueManger.kOn_bording_image_4,
    AssetsValueManger.kOn_bording_image_5,
  ];

////////////////////////////////////////////////////////
  static const double kWidthDesignScreen = 375;
  static const double kHeightDesignScreen = 812;
  static const String kNext = "التالي";
  static const String kSkip = "تخطي";
  static const String kExplore = "إستكشف التطبيق";
  static const String kRoutesName = "routesName";

  ///////////////////////////////////////////////////////////
  static const List<String> listExploreImage = [
    AssetsValueManger.kexplore_1,
    AssetsValueManger.kexplore_2,
    AssetsValueManger.kexplore_3,
    AssetsValueManger.kexplore_4,
    AssetsValueManger.kexplore_5,
  ];

  ////////////////////////////////////////////
  static const List<String> listExploreName = [
    "المراحل التعليمية",
    "المجموعات",
    "الطلاب",
    "الحضور",
    "الدفع"
  ];

  ////////////////////////////////////////////////////
  static const String kEducationStages = "المراحل التعليمية";
  static const String kGroups = "المجموعات";
  static const String kStudents = "الطلاب";
  static const String kAudience = "الحضور";
  static const String kPaying = "الدفع";

  ///////////////////education_table/////////////////////
  static const String kEducationStagesTableName = "educationStagesTableName";
  static const String kEducationStagesColumnID = "id";
  static const String kEducationStagesColumnName = "name";
  static const String kEducationStagesColumnCreatedAt = "created_at";
  static const String kEducationStagesColumnDescription = "description";
  static const String kEducationStagesColumnImage = "image";
  static const String kEducationStagesColumnStatus = "status";

  //////////////////////group_table//////////////////
  static const String kGroupTableName = "groupTableName";
  static const String kGroupColumnID = "id";
  static const String kGroupColumnEducationID = "education_id";
  static const String kGroupStatus = "status";
  static const String kGroupColumnName = "name";
  static const String kGroupCreatedAt = "created_at";
  static const String kGroupColumnNote = "note";
  static const String kGroupColumnImage = "image";
  //////////////////////student_table//////////////////
  static const String kStudentTableName = "studentTableName";
  static const String kStudentColumnID = "id";
  static const String kStudentColumnGroupID = "group_id";
  static const String kStudentStatus = "status";
  static const String kStudentColumnName = "name";
  static const String kStudentCreatedAt = "created_at";
  static const String kStudentColumnNote = "note";
  static const String kStudentColumnImage = "image";
  static const String kStudentName = "اسم الطالب";
  static const String kStudentNote = "اضف ملاحظة";

  //////////////////////appointments_table//////////////////
  static const String kAppointmentsTableName = "AppointmentsTableName";
  static const String kAppointmentsColumnID = "id";
  static const String kAppointmentsColumGroupID = "group_id";
  static const String kAppointmentsColumDay = "appointment_day";
  static const String kAppointmentsColumTime = "appointment_time";
  //////////////////////paying_table//////////////////
  static const String kPayingTableName = "PayingTableName";
  static const String kPayingColumnID = "id";
  static const String kPayingColumStudentID = "student_id";
  static const String kPayingColumMonth = "paying_month";
  static const String kPayingColumIsPaid = "paying_is_paid";
  // static const String kAppointmentsColumD_OR_N = "d_or_n";

/////////////////////////////////////////////////



  static const String kEducationStagesName = "اسم المرحلة التعليمية";
  static const String kEducation= "المرحلة التعليمية";
  static const String kEducationStagesDescription = "وصف المرحلة التعليمية";
  static const String kAdd = "إضافة";
  static const String kContentSearch = "محتوى البحث";
/////////////////////////////////////////////////
  static const String kGroupName = "اسم المجموعة";
  static const String kGroupNote= "وصف المجموعة";
  static const String kChooseEducationStage= "اختر المرحلة التعليمية";
  static const String kChooseGroup= "اختر المجموعة";
  static const String kChooseDay= "اختر اليوم";
  static const String kChooseTime= "اختر الوقت";
  static const String kDay= "اليوم";
  static const String kTime= "الوقت";
  // static const String kD_OR_N = "ص/م";
  // static const String kD= "ص";
  // static const String kN= "م";
  static const String kSaveAll= "حفظ الكل";

  ////////////////////////////////////////////////////////
  static const String kCantEmpty = "لا يمكن أن يكون هذا الحقل فارغ";
  static const String kNoTimeAndDAyAddedYet = "لم يتم إضافة يوم و ميعاد بعد";
  static const String kSureChooseGroup= "لم يتم إضافة المرحلة التعليمية بعد";

/////////////////////////////////////////////////////////////
  static const String kEdit = "تعديل";
  static const String kDelete = "حذف";
  static const String kDeleteSure = "تأكيد الحذف";
  static const String kNo = "إلغاء";
  static const String kOk = "حسنا";
  static const String kAddToTable = "إضافة إلى جدول المواعيد";
  static const String kEducationDeleteSure =
      "هل أنت متأكد من حذف هذه المرحلة التعليمية؟";

  static const List<String> daysOfWeek = [
    "السبت",
    "الأحد",
    "الاثنين",
    "الثلاثاء",
    "الأربعاء",
    "الخميس",
    "الجمعة",
  ];
  static const List<String> listMonths = [
    "يناير",
    "فبراير",
    "مارس",
    "أبريل",
    "مايو",
    "يونيو",
    "يوليو",
    "أغسطس",
    "سبتمبر",
    "أكتوبر",
    "نوفمبر",
    "ديسمبر"
  ];

}
