// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../../core/resources/colors_manger.dart';
// import '../../../core/resources/const_values.dart';
// import '../../../core/resources/fonts_manger.dart';
//
// class CustomGroupRadioDN extends StatelessWidget {
//   const CustomGroupRadioDN({
//     super.key,
//     required this.groupValue,
//     required this.omChangeD_OR_N_value,
//   });
//
//   final String groupValue;
//   final ValueChanged<String?>? omChangeD_OR_N_value;
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Directionality(
//             textDirection: TextDirection.rtl,
//             child: RadioListTile(
//               title: Text(
//                 ConstValue.kD,
//                 style: TextStyle(
//                     color: ColorsManger.kPrimaryColor,
//                     fontSize: FontsSize.f14,
//                     fontFamily: FontsName.geDinerFont),
//               ),
//               value: ConstValue.kD,
//               groupValue: groupValue,
//               onChanged: omChangeD_OR_N_value,
//             ),
//           ),
//           Directionality(
//             textDirection: TextDirection.rtl,
//             child: RadioListTile(
//               title: Text(
//                 ConstValue.kN,
//                 style: TextStyle(
//                     color: ColorsManger.kPrimaryColor,
//                     fontSize: FontsSize.f14,
//                     fontFamily: FontsName.geDinerFont),
//               ),
//               value: ConstValue.kN,
//               groupValue: groupValue,
//               onChanged: omChangeD_OR_N_value,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
