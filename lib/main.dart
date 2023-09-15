import 'package:flutter/material.dart';
import 'package:task2/dashboard.dart';
import 'package:task2/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth instance = FirebaseAuth.instance;
  DocumentReference documentReference = FirebaseFirestore.instance
      .collection("users")
      .doc("7wIeNKCQRypHbf2Shum0");

//   transaction() async {
//     FirebaseFirestore.instance.runTransaction((transaction) async {  //transaction to check if all any change was do this, don't do any error to check
//       // if the documents is exits or not
//       DocumentSnapshot docsnap = await transaction.get(documentReference);
//       if (docsnap.exists) {
// transaction.update(documentReference, {
//
//   "phone": "123123"
//
// });
//
//
//       } else {
//         print("user not exist");
//       }
//     });
//   }
  DocumentReference doc1 = FirebaseFirestore.instance
      .collection("users")
      .doc("pqVCZ0PRuN9jmNZWPfI6");
  DocumentReference doc2 = FirebaseFirestore.instance
      .collection("users")
      .doc("CV77Hhtfvxr6bQugZZMa");

  batch() async { //this do set update and delete in the same time
    WriteBatch batch = FirebaseFirestore.instance.batch();
    batch.delete(doc1);
    batch.update(doc2, {

      "age" :22

    });
    batch.commit();
  }

// batch() async{
//   CollectionReference users = FirebaseFirestore.instance.collection('users');
//
//   Future<void> batchDelete() {
//     WriteBatch batch = FirebaseFirestore.instance.batch();
//
//     return users.get().then((querySnapshot) {
//       querySnapshot.docs.forEach((document) {
//         batch.delete(document.reference);
//       });
//
//       return batch.commit();
//     });
//   }
//
//
//
// }
  @override
  void initState() {
    batch();
    // transaction();
/*    getData();*/
    // fetchSomethingData();
    conditionData();
    // TODO: implement initState
    super.initState();
    instance.authStateChanges().listen((user) {
      if (user == null) {
        print("No have a user");
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => login(),
        ));
      } else {
        print("have user" + user.email.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => profile(),
            ));
      }
    });
  }

  conditionData() async {
    // CollectionReference userref=FirebaseFirestore.instance.collection("users");
    // await userref.where("age", whereIn: ["30","21","80"]).get().then((value){
    //
    //   value.docs.forEach((element) {
    //     print("------------------------------------------");
    //
    //       print(element.data());
    //       print("------------------------------------------");
    //
    //
    //
    //
    //
    //   });
    //
    //
    // });
    // CollectionReference userref=FirebaseFirestore.instance.collection("users");
    // await userref.where("lang",arrayContains: "ar").get().then((value){
    //
    //   value.docs.forEach((element) {
    //     print("------------------------------------------");
    //
    //     print(element.data());
    //     print("------------------------------------------");
    //
    //
    //
    //
    //
    //   });
    //
    //
    // });
    // CollectionReference userref=FirebaseFirestore.instance.collection("users");
    // await userref.where("lang",arrayContainsAny: ["ar","en"]).get().then((value){   //or not and
    //
    //   value.docs.forEach((element) {
    //     print("------------------------------------------");
    //
    //     print(element.data());
    //     print("------------------------------------------");
    //
    //
    //
    //
    //
    //   });
    //
    //
    // });
    // CollectionReference userref=FirebaseFirestore.instance.collection("users");
    // await userref.where("age",isGreaterThanOrEqualTo: "21",isLessThan: "31").get().then((value){
    //
    //   value.docs.forEach((element) {
    //     print("------------------------------------------");
    //
    //     print(element.data());
    //     print("------------------------------------------");
    //
    //
    //
    //
    //
    //   });
    //
    //
    // });
    // CollectionReference userref=FirebaseFirestore.instance.collection("users");
    // await userref.where("username",isEqualTo: "salah").where("age",isGreaterThanOrEqualTo: 21).get().then((value){
    //
    //   value.docs.forEach((element) {
    //     print("------------------------------------------");
    //
    //     print(element.get("username")+" \n"+ element.get("age").toString());
    //     print("------------------------------------------");
    //
    //
    //
    //
    //
    //   });
    //
    //
    // });
    // CollectionReference userref=FirebaseFirestore.instance.collection("users");
    // await userref.orderBy("age").get().then((value){
    //
    //   value.docs.forEach((element) {
    //     print("------------------------------------------");
    //
    //     print(element.get("username")+" \n"+ element.get("age").toString());
    //     print("------------------------------------------");
    //
    //
    //
    //
    //
    //   });
    //
    //
    // });

    // CollectionReference userref=FirebaseFirestore.instance.collection("users");
    // await userref.orderBy("age").limit(1).get().then((value){
    //
    //   value.docs.forEach((element) {
    //     print("------------------------------------------");
    //
    //     print(element.get("username")+" \n"+ element.get("age").toString());
    //     print("------------------------------------------");
    //
    //
    //
    //
    //
    //   });
    //
    //
    // });
    // CollectionReference userref=FirebaseFirestore.instance.collection("users");
    // await userref.orderBy("age").limitToLast(1).get().then((value){
    //
    //   value.docs.forEach((element) {
    //     print("------------------------------------------");
    //
    //     print(element.get("username")+" \n"+ element.get("age").toString());
    //     print("------------------------------------------");
    //
    //
    //
    //
    //
    //   });
    //
    //
    // });
    // CollectionReference userref=FirebaseFirestore.instance.collection("users");
    // await userref.orderBy("age",descending: false).startAt([20]).get().then((value){   //greader than or equal
    //
    //   value.docs.forEach((element) {
    //     print("------------------------------------------");
    //
    //     print(element.get("username")+" \n"+ element.get("age").toString());
    //     print("------------------------------------------");
    //
    //
    //
    //
    //
    //   });
    //
    //
    // });
    // CollectionReference userref=FirebaseFirestore.instance.collection("users");
    // await userref.orderBy("age",descending: false).startAfter([20]).get().then((value){   //greader than
    //
    //   value.docs.forEach((element) {
    //     print("------------------------------------------");
    //
    //     print(element.get("username")+" \n"+ element.get("age").toString());
    //     print("------------------------------------------");
    //
    //
    //
    //
    //
    //   });
    //
    //
    // });

    // FirebaseFirestore.instance.collection("users").snapshots().listen((event) {
    //   event.docs.forEach((element) {
    //     print("========================================================");
    //     print(element.get("username"));
    //     print(element.get("age"));
    //     print("========================================================");
    //
    //   });
    // });
    // CollectionReference colRef = FirebaseFirestore.instance.collection("users");
    // colRef.doc("7wIeNKCQRypHbf2Shum0").update({"lang": ["dd"]});
    // colRef                                               //nested collection
    //     .doc("7wIeNKCQRypHbf2Shum0")
    //     .collection("address")
    //     .doc("61ES75lT8qxbG3hVBbq6").update(
    //
    //   {
    //
    //     "city" : "Ramallah"
    //   }

    // );//this do just update in field

    // colRef.doc("7wIeNKCQRypHbf2Shum0").update({"age": 67});  //this do just update
    // colRef.doc("7wIeNKCQRypHbf2Shum0").set({"age": 67});    //this do set the document from new
    // colRef.doc("7wIeNKCQRypHbf2Shum0").set({"age": 67},
    //     SetOptions(merge: true)); //this do set and donnot do the remove and add if not find the field

//this do just update
  }

  // fetchSomethingData() async {
  //   DocumentReference docs = FirebaseFirestore.instance
  //       .collection("users")
  //       .doc("CV77Hhtfvxr6bQugZZMa");
  //  await docs.get().then((value) {
  //    if(value.exists==false){
  //
  //      print("------------------------------------------");
  //     print("the id is not exists");
  //      print("------------------------------------------");
  //
  //
  //    }else{
  //      print("------------------------------------------");
  //      print(value.id);
  //      print(value.exists);   //check if the id is correct
  //      print(value.data());
  //      print("------------------------------------------");
  //      print(value.get("phome").toString());
  //      print("------------------------------------------");
  //
  //
  //    }
  //
  //
  //
  //   });
  // }

  // getData() async{
  //
  //  CollectionReference usersref= FirebaseFirestore.instance.collection("users");
  //  usersref.get().then((value) {   //this get the users and then save it in (value)
  //        value.docs.forEach((element) {
  //          print(element.data());
  //            print("==========================================================================");
  //
  //
  //        });
  //
  //  });
  //  // QuerySnapshot qaury=  await usersref.get();
  //  // List<QueryDocumentSnapshot> listdocument= await qaury.docs;
  //  // listdocument.forEach((element) {
  //  //   print(element.data());
  //  //   print("==========================================================================");
  //  //
  //  // });
  //
  CollectionReference col = FirebaseFirestore.instance.collection("users");

  //
  // }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/backgroound.jpg"),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 50),
                child: Text(
                  "welcome TO EU".toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      fontFamily: "fonts/TrajanPro.ttf"),
                ),
              ),
              Container(
                height: 200,
                margin: EdgeInsets.only(top: 50, left: 38),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("images/3818136.png"),
                )),
              ),
              Container(
                margin: EdgeInsets.only(top: 60),
                width: 200,
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => login(),
                        ));
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)))),
                  icon: Icon(Icons.login),
                  label: Text(
                    "Login".toUpperCase(),
                    style: TextStyle(
                        color: Colors.white, fontFamily: "fonts/TrajanPro.ttf"),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                width: 200,
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SecondRoute()));
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.black12,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)))),
                  icon: Icon(Icons.login),
                  label: Text(
                    "Sign up".toUpperCase(),
                    style: TextStyle(
                        color: Colors.black, fontFamily: "fonts/TrajanPro.ttf"),
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
