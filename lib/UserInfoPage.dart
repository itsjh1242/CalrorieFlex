

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ${ref.doc(auth.currentUser?.uid).get().then((value){value.get('u_name');})}

class UserInfoPage extends StatefulWidget{
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage>{
  String now = DateFormat('yyyy').format(DateTime.now());
  print(now) {
    // TODO: implement print
    throw UnimplementedError();
  }
  late double bmi;
  String uName = 'none';
  String uAge = 'none';
  String uBirth = 'none';
  String uHeight = 'none';
  String uWeight = 'none';
  String uResultBMI = 'none';
  String uValueBMI = 'none';
  FirebaseAuth auth = FirebaseAuth.instance;
  // var ref = FirebaseFirestore.instance.collection('cf_data').doc(auth.currentUser!.uid);
  CollectionReference ref = FirebaseFirestore.instance.collection('cf_data');
  @override
  Widget build(BuildContext context) {
    // FirebaseFirestore.instance
    // .collection('cf_data')
    // .doc(auth.currentUser?.uid)
    // .get()
    // .then((DocumentSnapshot documentSnapshot) {
    //   if(documentSnapshot.exists){
    //     uName = document.get('u_name');
    //     print('data: ${documentSnapshot.data()}');
    //   }
    // });
    double getBMI(int cm, int kg){
      double bmi = kg / pow(cm/100, 2);
      return bmi;
    }

    return FutureBuilder<DocumentSnapshot>(
      future: ref.doc(auth.currentUser?.uid).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        //Error Handling conditions
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }
        //Data is output to the user
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          // return Text("Full Name: ${data['u_name']} ${data['u_birth']}");
          uName = '${data['u_name']}';
          uAge = '${int.parse(now) - int.parse('${data['u_birth']}'.substring(0, 4)) + 1} 세';
          uBirth = '${data['u_birth']}';
          uHeight = '${data['u_height']} CM';
          uWeight = '${data['u_weight']} KG';
          bmi = getBMI(data['u_height'], data['u_weight']);
          if (bmi >= 30){
            uResultBMI = '비만';
          } else if (bmi >= 24){
            uResultBMI = '과체중';
          } else if (bmi >= 20){
            uResultBMI = '정상';
          } else {
            uResultBMI = '저체중';
          }
          uValueBMI = '${bmi.toStringAsFixed(1)}%';
        }
        return Material(
              child: Padding(
                padding: EdgeInsets.only(top: 30, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/userinfo_background.jpg'))),
                  child: Padding(
                    padding: EdgeInsets.only(top: 70, right: 20, bottom: 40, left: 20),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('이름: $uName', style: TextStyle(fontSize: 20)),
                          Text('나이: $uAge', style: TextStyle(fontSize: 20)),
                          Text('생년월일: $uBirth', style: TextStyle(fontSize: 20)),
                          Text('키: $uHeight', style: TextStyle(fontSize: 20)),
                          Text('몸무게: $uWeight', style: TextStyle(fontSize: 20)),
                          Text(''),
                          Text('비만도 결과: $uResultBMI', style: TextStyle(fontSize: 20)),
                          Text('BMI지수: $uValueBMI', style: TextStyle(fontSize: 20)),
                          Image.asset('assets/images/userinfo_bmi.jpg', height: 70, fit: BoxFit.fill)
                        ],
                      ),
                    )
                  ),
                )
              )
            );
      }
    );
      }
  }