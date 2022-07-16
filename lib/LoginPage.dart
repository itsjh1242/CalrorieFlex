import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

// dartFile
import 'Strings.dart';
import 'UserInfoPage.dart';
import 'RegisterPage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final idCtrl = TextEditingController();
  final pwCtrl = TextEditingController();

  var sv = Strings();

  bool _isObscure = true;

  Future<void> _alert(String msg, String extra, String extra2) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(msg),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(extra),
                Text(extra2)
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
                  child: Text('Calrorie-Flex',
                      style: TextStyle(color: Colors.grey[200], fontSize: 50)),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextField(
                            textAlign: TextAlign.left,
                            controller: idCtrl,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
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
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          child: TextField(
                            obscureText: _isObscure, // 비밀번호 입력시 * 표시
                            textAlign: TextAlign.left,
                            controller: pwCtrl,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscure ? Icons.visibility : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                              ),
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
                                fillColor: Colors.transparent)
                          ),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(sv.findAccount,
                                style: TextStyle(color: Colors.grey[400]))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      UserCredential userCredential =
                                          await FirebaseAuth.instance
                                              .signInWithEmailAndPassword(
                                                  email: idCtrl.text,
                                                  password: pwCtrl
                                                      .text) // 아이디와 비밀번호로 로그인 시도
                                              .then((value) {
                                        value.user!.emailVerified ==
                                                true //이메일 인증 여부
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (_) => (UserInfoPage())))
                                            : [_alert(
                                            '로그인',
                                            '이메일 승인이 완료되지 않았습니다.',
                                            '이메일이 도착하지 않았다면 스팸함을 확인해주세요!'),
                                            FirebaseAuth.instance.currentUser?.sendEmailVerification()];
                                        return value;
                                      });
                                    } on FirebaseAuthException catch (e) {
                                      //로그인 예외처리
                                      if (e.code == 'user-not-found') {
                                        print('등록되지 않은 이메일입니다');
                                      } else if (e.code == 'wrong-password') {
                                        print('비밀번호가 틀렸습니다');
                                      } else {
                                        print(e.code);
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green[400],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0))),
                                  child: Text(sv.login)),
                            ),
                            SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                        MaterialPageRoute(builder: (_) => (RegisterPage()))
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white60,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0))),
                                  child: Text(sv.register)),
                            )
                          ],
                        )
                      ],
                    ))
              ],
            )));
  }
}
