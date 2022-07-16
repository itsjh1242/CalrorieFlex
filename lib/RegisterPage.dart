import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// date
import 'package:intl/intl.dart';
// dartFile
import 'Strings.dart';
import 'Functions.dart';
import 'UserInfoPage.dart';

// Toast
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var sv = Strings();
  var f = Functions();

  final nameCtrl = TextEditingController();
  final idCtrl = TextEditingController();
  final pwCtrl = TextEditingController();
  final pwchkCtrl = TextEditingController();
  final heightCtrl = TextEditingController();
  final weightCtrl = TextEditingController();

  TextEditingController dateinput = TextEditingController();

  Future<void> _alert(String msg, String extra) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(msg),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(extra)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState(){
    dateinput.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/login_background.jpg'))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Text('회원가입',
                      style: TextStyle(color: Colors.grey[200], fontSize: 50)),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextField(
                            textAlign: TextAlign.left,
                            controller: nameCtrl,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              icon: Icon(Icons.label),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.blueAccent)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.transparent)),
                                hintText: sv.nameHint,
                                hintStyle: TextStyle(fontSize: 16),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        width: 0, style: BorderStyle.solid)),
                                filled: true,
                                contentPadding: EdgeInsets.all(16),
                                fillColor: Colors.transparent),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextField(
                            textAlign: TextAlign.left,
                            controller: idCtrl,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              icon: Icon(Icons.mail),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.blueAccent)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.transparent)),
                                hintText: sv.idHint,
                                hintStyle: TextStyle(fontSize: 16),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        width: 0, style: BorderStyle.solid)),
                                filled: true,
                                contentPadding: EdgeInsets.all(16),
                                fillColor: Colors.transparent),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextField(
                            textAlign: TextAlign.left,
                            controller: pwCtrl,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              icon: Icon(Icons.lock),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.blueAccent)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.transparent)),
                                hintText: sv.pwHint,
                                hintStyle: TextStyle(fontSize: 16),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        width: 0, style: BorderStyle.solid)),
                                filled: true,
                                contentPadding: EdgeInsets.all(16),
                                fillColor: Colors.transparent),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextField(
                            textAlign: TextAlign.left,
                            controller: pwchkCtrl,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              icon: Icon(Icons.verified_user),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.blueAccent)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.transparent)),
                                hintText: sv.pwchkHint,
                                hintStyle: TextStyle(fontSize: 16),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        width: 0, style: BorderStyle.solid)),
                                filled: true,
                                contentPadding: EdgeInsets.all(16),
                                fillColor: Colors.transparent),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TextField(
                              controller: dateinput,
                              decoration: InputDecoration(
                                icon: Icon(Icons.calendar_today),
                                hintText: sv.enterData,
                              ),
                              readOnly: true,
                              onTap: () async{
                                DateTime? pickedDate = await showDatePicker(
                                    context: context, initialDate: DateTime.now(), firstDate: DateTime(1950), lastDate: DateTime(2023)
                                );
                                if (pickedDate != null){
                                  print(pickedDate);
                                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                  // String formattedYear = DateFormat('yyyy').format(pickedDate);
                                  setState(() {
                                    dateinput.text = formattedDate;
                                    // uage = '${int.parse(sv.formatted) - int.parse(formattedYear) + 1} 세';
                                  });
                                }
                              },
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextField(
                            textAlign: TextAlign.left,
                            controller: heightCtrl,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              icon: Icon(Icons.height),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.blueAccent)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.transparent)),
                                hintText: sv.heightHint,
                                hintStyle: TextStyle(fontSize: 16),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        width: 0, style: BorderStyle.solid)),
                                filled: true,
                                contentPadding: EdgeInsets.all(16),
                                fillColor: Colors.transparent),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextField(
                            textAlign: TextAlign.left,
                            controller: weightCtrl,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              icon: Icon(Icons.person_add),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.blueAccent)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.transparent)),
                                hintText: sv.weightHint,
                                hintStyle: TextStyle(fontSize: 16),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        width: 0, style: BorderStyle.solid)),
                                filled: true,
                                contentPadding: EdgeInsets.all(16),
                                fillColor: Colors.transparent),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: ElevatedButton(
                              onPressed: () async {
                                final rf = f.funcRegister(
                                    nameCtrl.text,
                                    idCtrl.text,
                                    pwCtrl.text,
                                    pwchkCtrl.text,
                                    dateinput.text,
                                    int.parse(heightCtrl.text),
                                    int.parse(weightCtrl.text)
                                );
                                if (rf == 'RESULT_EMPTY'){
                                  _alert('회원가입', '빈 입력란이 있는지 확인해주세요!');
                                } else if (rf == 'RESULT_NOT_MATCH_PW'){
                                  _alert('회원가입', '비밀번호가 일치하지 않습니다!');
                                } else{
                                  try {
                                    UserCredential userCredential = await FirebaseAuth
                                        .instance
                                        .createUserWithEmailAndPassword(
                                        email: idCtrl.text, password: pwCtrl.text)
                                        .then((value) {
                                      if (value.user!.email == null) {} else {
                                        Navigator.pop(context);
                                      }
                                      return value;
                                    });
                                    FirebaseAuth.instance.currentUser?.sendEmailVerification();
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'weak-password') {
                                      _alert('회원가입', '비밀번호가 약합니다!');
                                    } else if (e.code == 'email-already-in-use') {
                                      _alert('회원가입', '이미 존재하는 이메일입니다!');
                                    } else {
                                      _alert('회원가입', '이메일 형식을 확인해주세요!');
                                    }
                                  } catch (e) {
                                    print('DONE');
                                  }
                                  var ref = FirebaseFirestore.instance.collection('cf_data');
                                  FirebaseAuth auth = FirebaseAuth.instance;
                                  ref.doc(auth.currentUser?.uid)
                                      .set({
                                    'uid': auth.currentUser?.uid,
                                    'u_name': nameCtrl.text,
                                    'u_email': idCtrl.text,
                                    'u_pw': pwCtrl.text,
                                    'u_birth': dateinput.text,
                                    'u_height': int.parse(heightCtrl.text),
                                    'u_weight': int.parse(weightCtrl.text)
                                  })
                                      .catchError((error) => print('Add failed: $error'));
                                }
                                },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0))),
                              child: Text(sv.joinButton)),
                        )
                      ],
                    ))
              ],
            )));
  }
}