import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task2/animation.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task2/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:regexpattern/regexpattern.dart';
import 'dashboard.dart';
import 'main.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool passowrd = true;
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth instance = FirebaseAuth.instance;
  bool isloading = false;
  bool visible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // instance.authStateChanges().listen((user) {
    //   if(user==null){
    //     print("No have a user");
    //     setState(() {
    //     });
    //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SecondRoute(),));
    //   }
    //   else{
    //     print("have user");
    //   }
    //
    // });
  }
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  UserCredential? credential;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/backgroound.jpg"),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 50, left: 8, right: 180),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                          child: FloatingActionButton(
                            heroTag: "back",
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyApp(),));
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.deepPurple,
                            ),
                            backgroundColor: Colors.white,
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide:
                                    BorderSide(color: Colors.deepPurple)),
                          ),
                        ),
                        Text(
                          "Login".toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.black54,
                              fontFamily: "fonts/TrajanPro.ttf"),
                        ),
                      ],
                    )),
                Container(
                  height: 200,
                  width: 200,
                  margin: EdgeInsets.only(top: 50, left: 40),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("images/res2.png"),
                  )),
                ),
                Container(
                    margin: EdgeInsets.only(left: 40, right: 40, top: 20),
                    child: TextFormField(
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: email,
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'fill the email';
                        } else if ((value.toString().trim().isEmail()) ==
                            false) {
                          return ' The email is not correct';
                        }
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black12,
                          labelText: "Email",
                          hintStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: [AutofillHints.email],
                    )),
                Container(
                    margin: EdgeInsets.only(left: 40, right: 40, top: 20),
                    child: TextFormField(
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: pass,
                      obscureText: passowrd,

                      validator: (value) {
                        if (value.toString().isEmpty &&
                            value.toString().length < 6) {
                          return 'Fill the password and You should the password at least 6 characters';
                        } else if (value.toString().isEmpty) {
                          return 'Fill the password';
                        } else if (value.toString().length < 6) {
                          return 'You should the password at least 6 characters';
                        }
                      },
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                //
                                passowrd = !passowrd;
                                //
                              });
                            },
                            icon: Icon((passowrd == true
                                ? Icons.visibility_off
                                : Icons.visibility)),
                          ),
                          filled: true,
                          fillColor: Colors.black12,
                          labelText: "Password",
                          hintText:
                              "Enter the password should at least 6 character ",
                          hintStyle: TextStyle(color: Colors.black45),
                          prefixIcon: Icon(Icons.password),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                      keyboardType: TextInputType.visiblePassword,
                    )),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    width: 340,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)))),
                        onPressed: () async {
                          setState(() {
                            isloading = true;
                          });
                          setState(() async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                UserCredential credential = await instance
                                    .signInWithEmailAndPassword(
                                    email: email.text.toString(),
                                    password: pass.text.toString());

                                await Future.delayed(Duration(seconds: 1));
                                isloading = false;

                                Navigator.of(context)
                                    .push(animation(page: profile()));
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => profile(),
                                //     ));
                              } on FirebaseAuthException catch (e) {

                                if(e.code=='invalid-email'){

                                  Fluttertoast.showToast(  msg: "user-not-found",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.blue,
                                      textColor: Colors.black,
                                      fontSize: 16.0

                                  );
                                  setState(() {
                                    isloading = false;


                                  });

                                }
                                else if(e.code== 'user-not-found'){
                                  Fluttertoast.showToast(  msg: "user-not-found",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.blue,
                                      textColor: Colors.black,
                                      fontSize: 16.0

                                  );
                                  setState(() {
                                    isloading = false;


                                  });
                                }
                                else if(e.code=='wrong-password'){

                                  Fluttertoast.showToast(  msg: "wrong-password",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.blue,
                                      textColor: Colors.black,
                                      fontSize: 16.0

                                  );

                                  setState(() {
                                    isloading = false;


                                  });
                                }
                                else{

                                  setState(() {
                                    isloading = false;


                                  });

                                }

                              }
                            } else {
                              setState(() {
                                isloading = false;
                              });
                            }
                          });

                        },
                        child: isloading
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    CircularProgressIndicator(
                                        color: Colors.white, strokeWidth: 3),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Text("LOGIN".toUpperCase(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "fonts/TrajanPro.ttf"))
                                  ])
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.login),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    "LOGIN".toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "fonts/TrajanPro.ttf"),
                                  ),
                                ],
                              ))),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Already have an account?"),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              Navigator.of(context)
                                  .push(animation(page: SecondRoute()));
                            });
                          },
                          child: Text("Sign up"))
                    ],
                  ),
                ),
                Container(
                  width: 200,
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        color: Colors.black,
                      )),
                      Text(" OR "),
                      Expanded(child: Divider(color: Colors.black))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 100, right: 120),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FloatingActionButton(
                        onPressed: () {},
                        heroTag: "facebook",
                        child: Icon(
                          Icons.facebook,
                          color: Colors.deepPurple,
                        ),
                        backgroundColor: Colors.white,
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Colors.deepPurple)),
                      ),
                      FloatingActionButton(
                        onPressed: () async {

                          try {
                            UserCredential cred= await signInWithGoogle();
                            setState(() {
                              isloading = true;
                            });
                            await Future.delayed(Duration(seconds: 2));
                            setState(() {
                              isloading = false;
                            });

                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => profile(),
                            ));
                          } catch (e) {
                            print(e.toString()+"   hhhhh");
                          }
                          // print(cred.toString()+"                   kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
                        },
                        heroTag: "google",
                        child: Icon(
                          Icons.g_mobiledata,
                          color: Colors.deepPurple,
                        ),
                        backgroundColor: Colors.white,
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Colors.deepPurple)),
                      ),
                      FloatingActionButton(
                        onPressed: () {},
                        heroTag: "call",
                        child: Icon(
                          Icons.add_call,
                          color: Colors.deepPurple,
                        ),
                        backgroundColor: Colors.white,
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Colors.deepPurple)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
