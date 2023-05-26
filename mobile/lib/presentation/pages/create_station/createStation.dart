// create station form

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/create_station/create_station_bloc.dart';
import '../core/widgets/appBar.dart';
import '../core/widgets/primaryButton.dart';
import 'widgets/inputFieldHeader.dart';

class CreateStation extends StatefulWidget {
  const CreateStation({super.key});

  @override
  State<CreateStation> createState() => _CreateStationState();
}

class _CreateStationState extends State<CreateStation> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _wattageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateStationBloc, CreateStationState>(
        listener: (context, state) {
      if (state is CreateStationSuccess) {
        // TODO: Navigate to station details page
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Station created successfully"),
          ),
        );
      } else if (state is CreateStationFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
          ),
        );
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: CHSAppBar.build(context, "Create Station", () {}, true),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const InputFieldHeader(
                  text: "Station Name",
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(color: Colors.black26),
                    hintText: "Station name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter station name";
                    }
                    return null;
                  },
                ),
                const InputFieldHeader(text: "Station Description"),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(color: Colors.black26),
                    hintText: "Station description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter station description";
                    }
                    return null;
                  },
                ),
                const InputFieldHeader(
                  text: "Station Address",
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(color: Colors.black26),
                    hintText: "Station address",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter station address";
                    }
                    return null;
                  },
                ),
                const InputFieldHeader(
                  text: "Station Phone",
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(color: Colors.black26),
                    hintText: "Station phone",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter station phone";
                    } else if (value.length < 10) {
                      return "Please enter a valid phone number";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                ),
                const InputFieldHeader(
                  text: "Station Wattage",
                ),
                TextFormField(
                  controller: _wattageController,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(color: Colors.black26),
                    hintText: "Station wattage",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter station wattage";
                    }
                    return null;
                  },
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: state is CreateStationLoading
                      ? const CircularProgressIndicator()
                      : PrimaryButton(
                          text: "Create",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<CreateStationBloc>().add(
                                    CreateStationSubmitEvent(
                                      name: _nameController.text,
                                      description: _descriptionController.text,
                                      address: _addressController.text,
                                      phone: _phoneController.text,
                                      wattage:
                                          double.parse(_wattageController.text),
                                    ),
                                  );
                            }
                          },
                        ),
                )
              ],
            ),
          ),
        )),
      );
    });
  }
}
