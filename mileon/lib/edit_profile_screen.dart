import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mileon/user_model.dart';

class EditProfileScreen extends StatefulWidget {
  final Usermodel usermodel;
  EditProfileScreen({
    Key? key,
    required this.usermodel,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _isLoading = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _bmiController = TextEditingController();
  TextEditingController _avgBPController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _nameController.text = widget.usermodel.name;
      _dobController.text = widget.usermodel.birthday;
      _heightController.text = widget.usermodel.height;
      _weightController.text = widget.usermodel.weight;
      _bmiController.text = widget.usermodel.bmi;
      _avgBPController.text = widget.usermodel.averagebloodpressure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Edit Profile"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _isLoading
              ? LinearProgressIndicator()
              : const SizedBox(
                  height: 0,
                ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        onSaved: (value) {
                          _nameController.text = value!;
                        },
                        validator: (value) {
                          if (value == "") {
                            return "Please fill this out";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Name",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _dobController,
                        onSaved: (value) {
                          _dobController.text = value!;
                        },
                        validator: (value) {
                          if (value == "") {
                            return "Please fill this out";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Date of birth",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _heightController,
                        onSaved: (value) {
                          _heightController.text = value!;
                        },
                        validator: (value) {
                          if (value == "") {
                            return "Please fill this out";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Height",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _weightController,
                        onSaved: (value) {
                          _weightController.text = value!;
                        },
                        validator: (value) {
                          if (value == "") {
                            return "Please fill this out";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Weight",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _bmiController,
                        onSaved: (value) {
                          _bmiController.text = value!;
                        },
                        validator: (value) {
                          if (value == "") {
                            return "Please fill this out";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "BMI",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _avgBPController,
                        onSaved: (value) {
                          _avgBPController.text = value!;
                        },
                        validator: (value) {
                          if (value == "") {
                            return "Please fill this out";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Average Blood pressure",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            final _auth = FirebaseAuth.instance;
                            final _firestore = FirebaseFirestore.instance;
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });

                              await _firestore
                                  .collection("users")
                                  .doc(_auth.currentUser!.uid)
                                  .update({
                                'name': _nameController.text,
                                'birthday': _dobController.text,
                                'weight': _weightController.text,
                                'height': _heightController.text,
                                'bmi': _bmiController.text,
                                'averagebloodpressure': _avgBPController.text,
                              });

                              setState(() {
                                _isLoading = false;
                              });
                              Navigator.of(context).pop();
                            }
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.6,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.blueAccent,
                                  width: 2.0,
                                )),
                            child: Center(
                                child: Text(
                              "Save",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
