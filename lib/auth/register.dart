import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_bbms/auth/login.dart';
import 'package:fyp_bbms/api.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import '../main.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  PickedFile? image;
  // PickedFile image1 = PickedFile('assets/images/register.png');
  final ImagePicker _picker = ImagePicker();
  // final XFile _imageFile = XFile();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();

  // final TextEditingController _confirmPass = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool verifyButton = false;
  String verifyLink = '';

  var _selectedGenderValue;
  var _selectedBloodGroupValue;

  List<String> gender = ['Male', 'Female'];
  List<String> bloodGroup = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  Future sendLink() async {
    var url = Uri.parse(registerUrl);
    var response = await http.post(url);
    var link = json.decode(response.body);
    print(link);

    setState(() {
      verifyLink = link;
    });
  }

  Future register() async {
    try {
      // var url = Uri.parse(registerUrl);
      // var response = await http.post(url, body: {
      //   "username": _email.text,
      //   "password": _pass.text,
      //   "name": _name.text,
      //   "age": _age.text,
      //   "address": _address.text,
      //   "phone_number": _phoneNumber.text,
      //   "gender": _selectedGenderValue,
      //   "blood_group": _selectedBloodGroupValue,
      // });
      // var link = json.decode(response.body);
      final uri = Uri.parse("$rootUrl/bbms_api/register.php");
      var request = http.MultipartRequest('POST', uri);
      request.fields['username'] = _email.text;
      request.fields['password'] = _pass.text;
      request.fields['name'] = _name.text;
      request.fields['age'] = _age.text;
      request.fields['address'] = _address.text;
      request.fields['phone_number'] = _phoneNumber.text;
      request.fields['gender'] = _selectedGenderValue;
      request.fields['blood_group'] = _selectedBloodGroupValue;
      var pic = await http.MultipartFile.fromPath("image", image!.path);
      request.files.add(pic);
      // var link = json.decode(request.method);
      var response1 = await request.send();
      final responseData = await response1.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);

      print(response1);
      print(responseString);

      if (responseString == '"Error"') {
        Fluttertoast.showToast(
            msg: "This user already exist",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Registration completed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => Login()));
      }

      // print('susan');

      // setState(() {
      //   verifyButton = true;
      //   Fluttertoast.showToast(
      //       msg: "Check your mail and verify",
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.CENTER,
      //       timeInSecForIosWeb: 1,
      //       backgroundColor: Colors.red,
      //       textColor: Colors.white,
      //       fontSize: 16.0);
      // });
      sendMail();

      // if (link == "Error") {
      //   Fluttertoast.showToast(
      //       msg: "This user already exist",
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.CENTER,
      //       timeInSecForIosWeb: 1,
      //       backgroundColor: Colors.red,
      //       textColor: Colors.white,
      //       fontSize: 16.0);
      //   // Navigator.push(
      //   //   context,
      //   //   MaterialPageRoute(
      //   //     builder: (context) => MyApp(),
      //   //   ),
      //   // );
      // } else {
      //   Fluttertoast.showToast(
      //       msg: "Registration completed",
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.CENTER,
      //       timeInSecForIosWeb: 1,
      //       backgroundColor: Colors.green,
      //       textColor: Colors.white,
      //       fontSize: 16.0);
      //   // Navigator.push(
      //   //   context,
      //   //   MaterialPageRoute(
      //   //     builder: (context) => Login(),
      //   //   ),
      //   // );
      // }
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  String? validatePassword(String? value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value!.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }

  Future verify() async {
    var response = await http.post(Uri.parse(verifyLink));

    var link = json.decode(response.body);
    setState(() {
      verifyButton = false;
    });
    print(link);
  }

  Future choiceImage() async {
    // var pickedImage = await picker.getImage
    var pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = PickedFile(pickedImage!.path);
    });
  }

  sendMail() async {
    String username = 'gautamsusan15@gmail.com';
    String password = '###asdf1234###';

    print(verifyLink);

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Susan Gautam')
      ..recipients.add(_email.text)
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..html =
          "<h1>Verify your mail</h1>\n<p>Verify your mail and access your app</p><p> <a href='$verifyLink'>Click here to verify</a></p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException {
      print('Message not sent.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: 300,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
              color: Colors.red,
              gradient: LinearGradient(
                colors: [
                  Colors.red,
                  Colors.redAccent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Image.asset(
                    "assets/images/launch_image.png",
                    height: 90,
                    width: 90,
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: const Text("BloodSource",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ))),
                Container(
                  margin: const EdgeInsets.only(right: 20, top: 20),
                  alignment: Alignment.bottomRight,
                  child: const Text(
                    "Register",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                )
              ],
            )),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context, builder: (builder) => bottomSheet());
            },
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.red[100],
                  radius: 60,
                  backgroundImage:
                      image == null ? null : FileImage(File(image!.path)),
                ),
                const Positioned(
                  bottom: 15,
                  right: 15,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          image == null
              ? const Text("Choose your profile picture")
              : const Text(''),
          emailTextField(),
          passwordTextFormField(),
          rePasswordTextField(),
          nameTextField(),
          ageTextField(),
          addressFormField(),
          phoneTextField(),
          genderTextField(),
          bloodGroupTextField(),
          registerButton(),
          alreadyHaveAccount(),
        ],
      )),
    ));
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          const Text(
            "Choose a profile photo",
            style: TextStyle(fontSize: 20.0),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  choiceImage();
                },
                icon: const Icon(Icons.camera_alt),
              ),
              IconButton(
                onPressed: () {
                  choiceImage();
                },
                icon: const Icon(Icons.image),
              ),
            ],
          )
        ],
      ),
    );
  }

  void chooseImageCamera() {
    setState(() async {
      XFile? image = await _picker.pickImage(source: ImageSource.camera);
    });
  }

  Widget emailTextField() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey[200],
        boxShadow: const [
          BoxShadow(
              offset: Offset(0, 10), blurRadius: 50, color: Color(0xffEEEEEE)),
        ],
      ),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter your email";
          }
          return null;
        },
        controller: _email,
        cursorColor: Colors.red,
        decoration: const InputDecoration(
          icon: Icon(
            Icons.email,
            color: Colors.red,
          ),
          hintText: "Enter Email",
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget passwordTextFormField() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: const Color(0xffEEEEEE),
        boxShadow: const [
          BoxShadow(
              offset: Offset(0, 20), blurRadius: 100, color: Color(0xffEEEEEE)),
        ],
      ),
      child: TextFormField(
        validator: validatePassword,
        controller: _pass,
        obscureText: true,
        cursorColor: const Color(0xffF5591F),
        decoration: const InputDecoration(
          focusColor: Color(0xffF5591F),
          icon: Icon(
            Icons.vpn_key,
            color: Colors.red,
          ),
          hintText: "Enter Password",
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget rePasswordTextField() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: const Color(0xffEEEEEE),
        boxShadow: const [
          BoxShadow(
              offset: Offset(0, 20), blurRadius: 100, color: Color(0xffEEEEEE)),
        ],
      ),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Please re-enter your password";
          }
          if (value != _pass.text) {
            return "Passwords didnt match";
          }
          return null;
        },
        obscureText: true,
        cursorColor: const Color(0xffF5591F),
        decoration: const InputDecoration(
          focusColor: Color(0xffF5591F),
          icon: Icon(
            Icons.vpn_key,
            color: Colors.red,
          ),
          hintText: "Re-Enter Password",
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget nameTextField() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey[200],
        boxShadow: const [
          BoxShadow(
              offset: Offset(0, 10), blurRadius: 50, color: Color(0xffEEEEEE)),
        ],
      ),
      child: TextFormField(
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter your name";
          }
          return null;
        },
        controller: _name,
        cursorColor: Colors.red,
        decoration: const InputDecoration(
          icon: Icon(
            Icons.person,
            color: Colors.red,
          ),
          hintText: "Enter Your Name",
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget ageTextField() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey[200],
        boxShadow: const [
          BoxShadow(
              offset: Offset(0, 10), blurRadius: 50, color: Color(0xffEEEEEE)),
        ],
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter your age";
          }
          return null;
        },
        controller: _age,
        cursorColor: Colors.red,
        decoration: const InputDecoration(
          icon: Icon(
            Icons.numbers,
            color: Colors.red,
          ),
          hintText: "Enter Your Age",
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget addressFormField() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey[200],
        boxShadow: const [
          BoxShadow(
              offset: Offset(0, 10), blurRadius: 50, color: Color(0xffEEEEEE)),
        ],
      ),
      child: TextFormField(
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please your address";
          }
          return null;
        },
        controller: _address,
        cursorColor: Colors.red,
        decoration: const InputDecoration(
          icon: Icon(
            Icons.location_on,
            color: Colors.red,
          ),
          hintText: "Enter your address ",
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget phoneTextField() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey[200],
        boxShadow: const [
          BoxShadow(
              offset: Offset(0, 10), blurRadius: 50, color: Color(0xffEEEEEE)),
        ],
      ),
      child: TextFormField(
        maxLength: 10,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please your phone number";
          }
          return null;
        },
        controller: _phoneNumber,
        cursorColor: Colors.red,
        decoration: const InputDecoration(
          icon: Icon(
            Icons.phone,
            color: Colors.red,
          ),
          hintText: "Enter your phone number",
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget genderTextField() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: const Color(0xffEEEEEE),
        boxShadow: const [
          BoxShadow(
              offset: Offset(0, 20), blurRadius: 100, color: Color(0xffEEEEEE)),
        ],
      ),
      child: DropdownButtonFormField(
        validator: (value) {
          if (value == null) {
            return "Please select one";
          }
          return null;
        },
        value: _selectedGenderValue,
        hint: const Text(
          'Choose your gender',
        ),
        isExpanded: true,
        onChanged: (value) {
          setState(() {
            _selectedGenderValue = value;
          });
        },
        onSaved: (value) {
          setState(() {
            _selectedGenderValue = value;
          });
        },
        items: gender.map((String val) {
          return DropdownMenuItem(
            value: val,
            child: Text(
              val,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget bloodGroupTextField() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: const Color(0xffEEEEEE),
        boxShadow: const [
          BoxShadow(
              offset: Offset(0, 20), blurRadius: 100, color: Color(0xffEEEEEE)),
        ],
      ),
      child: DropdownButtonFormField(
        validator: (value) {
          if (value == null) {
            return "Please select one";
          }
          return null;
        },
        value: _selectedBloodGroupValue,
        hint: const Text(
          'Choose your blood group',
        ),
        isExpanded: true,
        onChanged: (value) {
          setState(() {
            _selectedBloodGroupValue = value;
          });
        },
        onSaved: (value) {
          setState(() {
            _selectedBloodGroupValue = value;
          });
        },
        items: bloodGroup.map((String val) {
          return DropdownMenuItem(
            value: val,
            child: Text(
              val,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget registerButton() {
    return GestureDetector(
      onTap: () {
        if (image == null) {
          Fluttertoast.showToast(
              msg: "Please pick a image",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        if (_formKey.currentState!.validate()) {
          register();
          // uploadImage();
          if (kDebugMode) {
            print(_selectedGenderValue);
          }
        }
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
        padding: const EdgeInsets.only(left: 20, right: 20),
        height: 54,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Colors.red, Colors.redAccent],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
          borderRadius: BorderRadius.circular(50),
          color: Colors.grey[200],
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 50,
                color: Color(0xffEEEEEE)),
          ],
        ),
        child: const Text(
          "REGISTER",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget alreadyHaveAccount() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Already have an account?  "),
          GestureDetector(
            child: const Text(
              "Login Now",
              style: TextStyle(color: Color(0xffF5591F)),
            ),
            onTap: () {
              // Write Tap Code Here.
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ));
            },
          )
        ],
      ),
    );
  }
}
