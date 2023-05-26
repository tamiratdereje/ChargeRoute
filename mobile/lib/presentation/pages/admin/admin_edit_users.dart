import 'package:charge_station_finder/domain/admin/admin_model.dart';
import 'package:charge_station_finder/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminUpdateUserPage extends StatefulWidget {

  final String previousName;
  final String previousEmail;
  final String previousRole;
  final String previousId;

  const AdminUpdateUserPage(
      {required this.previousEmail,
      required this.previousName,
      required this.previousRole,
      required this.previousId,
      super.key});


  @override
  State<AdminUpdateUserPage> createState() => _AdminUpdateUserPageState();
}

class _AdminUpdateUserPageState extends State<AdminUpdateUserPage> {
  @override
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController =
        TextEditingController(text: widget.previousEmail);
    TextEditingController nameController =
        TextEditingController(text: widget.previousName);
    TextEditingController roleController =
        TextEditingController(text: widget.previousRole);

    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: Radius.circular(20))),
        padding: EdgeInsets.all(40),
        child: Wrap(
          children: <Widget>[
            const SizedBox(height: 22),
            const Center(
                child: Icon(
              Icons.horizontal_rule,
              size: 30,
              color: Color.fromARGB(255, 232, 230, 226),
            )),
            Container(
                alignment: Alignment.bottomLeft,
                child: const  Center(
                  child: Text(
                    'Edit User',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 30, 30, 30)),
                  ),
                )),
            const SizedBox(height: 22),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Email',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 26, 25, 25))),
                  const SizedBox(
                    height: 10,
                  ),
    
                  TextFormField(
                    // initialValue: widget.previousEmail ?? 'nothing',
                    controller: emailController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        // fillColor: ,
                        filled: true,
                        border: InputBorder.none,
                        hintText: 'would you like to change your email?',
                        hintStyle: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 26, 25, 25))),
                    minLines: 1,
                    maxLines: 2,
                  ),
                  
                  const Text('Name',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 26, 25, 25))),
                  const SizedBox(height: 10),
    
                  TextFormField(
                    // initialValue: widget.previousName ?? 'nothing',
                    controller: nameController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        // fillColor: ,
                        filled: true,
                        border: InputBorder.none,
                        hintText: 'would you like to change your name?',
                        hintStyle: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 26, 25, 25))),
                    minLines: 1,
                    maxLines: 2,
                  ),
                  
                  const Text('Role',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 26, 25, 25))),
    
    
                  const SizedBox(height: 10),
                  TextFormField(
                    // initialValue: widget.previousRole ?? 'nothing',
                    controller: roleController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        // fillColor: ,
                        filled: true,
                        border: InputBorder.none,
                        hintText: 'would you like to change your role?',
                        hintStyle: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 26, 25, 25))),
                    minLines: 1,
                    maxLines: 2,
                  ),
                  SizedBox(height: 20),
                  Container(
                      child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: ElevatedButton(
                      style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.black), // Replace with your desired color
                          ),
                      
                        onPressed: () {
                                                                          
                          // if (_formKey.currentState!.validate()) {
                          //   validator:
                          //   (value) {
                          //     if (value != null && value.isEmpty) {
                          //       return 'Please write some reviews.';
                          //     }
                          //     return null;
                          //   };
                          // }
                          return Navigator.pop(
                              context,
                              AdminDomain(
                                email: emailController.text,
                                name: nameController.text,
                                role: roleController.text,
                                id: widget.previousId,
                              ));
                        },
                        child: Center(child: const Text("Update User", style: TextStyle(color: Color(0XFFFFFFFF)),))),
                  )),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
