// // create station form

// import 'package:flutter/material.dart';

// import '../core/widgets/appBar.dart';
// import '../core/widgets/formField.dart';
// import '../core/widgets/primaryButton.dart';
// import 'widgets/inputFieldHeader.dart';

// class CreateStation extends StatelessWidget {
//   const CreateStation({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CHSAppBar.build(context, "Create Station", (){}, true),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//             const InputFieldHeader(text: "Station Name",),
//             CSFFormField(hintText: "Station Name", onChanged: (){}, obscureText: false,),
//             const InputFieldHeader(text: "Station Address",),
//             CSFFormField(hintText: "Station Address", onChanged: (){}, obscureText: false,),
//             const InputFieldHeader(text: "Station Owner Name",),
//             CSFFormField(hintText: "Owner Name", onChanged: (){}, obscureText: false,),
//             const SizedBox(height: 80,),
//             PrimaryButton(text: "Create", onPressed: (){})
//           ]),
//         ),
//       ),
//     );
//   }
// }
