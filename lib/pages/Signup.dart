import 'package:barber_app/pages/login.dart';
import 'package:barber_app/servies/database.dart';
import 'package:barber_app/servies/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String? name, mail, password;
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (password != null && name != null && mail != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: mail!, password: password!);
        String id = randomAlphaNumeric(10);
        await SharedPreferenceHelper().saveUSerName(nameController.text);
        await SharedPreferenceHelper().saveUSerEmail(emailController.text);
        await SharedPreferenceHelper().saveUSerImage(
            "https://thumbs.dreamstime.com/b/ai-generated-illustration-depicts-cartoon-boy-brown-hair-green-eyes-wearing-white-outfit-waving-cheerfully-347496657.jpg");
        await SharedPreferenceHelper().saveUSerId;
        Map<String, dynamic> userInfoMap = {
          "Name": nameController.text,
          "Email": emailController.text,
          "Id": id,
          "Image":
              "https://thumbs.dreamstime.com/b/ai-generated-illustration-depicts-cartoon-boy-brown-hair-green-eyes-wearing-white-outfit-waving-cheerfully-347496657.jpg"
        };
        await DatabaseMethods().addUserDetails(userInfoMap, id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Registration Successfully",
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Password provided is weak",
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Account already exist",
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(top: 50, left: 20),
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffb91635),
                      Color(0xff621d3c),
                      Color(0xff311937),
                    ],
                  ),
                ),
                child: Text(
                  "Create Your\nAccount",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 5),
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 4),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
                        style: TextStyle(
                            color: Color(0xffb91635),
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter name';
                          }
                          return null;
                        },
                        controller: nameController,
                        decoration: InputDecoration(
                            hintText: "Your name",
                            prefixIcon: Icon(Icons.person_outline)),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Gmail",
                        style: TextStyle(
                            color: Color(0xffb91635),
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter E-mail';
                          }
                          return null;
                        },
                        controller: emailController,
                        decoration: InputDecoration(
                            hintText: "Enter Gmail",
                            prefixIcon: Icon(Icons.mail_outline)),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Password",
                        style: TextStyle(
                            color: Color(0xffb91635),
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: "Enter password",
                          prefixIcon: Icon(Icons.password_outlined),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_formkey.currentState!.validate()) {
                            setState(
                              () {
                                mail = emailController.text;
                                name = nameController.text;
                                password = passwordController.text;
                              },
                            );
                          }
                          registration();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xffb91635),
                                  Color(0xff621d3c),
                                  Color(0xff311937),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: Text(
                              "SIGN UP",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      // Spacer(),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(
                                color: Color(0xff311937),
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Log in",
                              style: TextStyle(
                                  color: Color(0xff621d3c),
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
