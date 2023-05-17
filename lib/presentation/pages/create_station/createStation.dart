// create station form
import 'package:charge_station_finder/presentation/pages/core/widgets/appBar.dart';
import 'package:charge_station_finder/presentation/pages/core/widgets/primaryButton.dart';
import 'package:charge_station_finder/presentation/pages/create_station/widgets/inputFieldHeader.dart';
import 'package:flutter/material.dart';

import '../core/widgets/formField.dart';

class CreateStation extends StatelessWidget {
  const CreateStation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CHSAppBar.build(context, "Create Station", (){}, true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const InputFieldHeader(text: "Station Name",),
            CSFFormField(hintText: "Station Name", onChanged: (){}),
            const InputFieldHeader(text: "Station Address",),
            CSFFormField(hintText: "Station Address", onChanged: (){}),
            const InputFieldHeader(text: "Station Owner Name",),
            CSFFormField(hintText: "Owner Name", onChanged: (){}),
            const SizedBox(height: 40,),
            PrimaryButton(text: "Create", onPressed: (){})
          ]),
        ),
      ),
    );
  }
}
