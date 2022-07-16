// date
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
// firebase
import 'package:cloud_firestore/cloud_firestore.dart';

class Strings{
  // loginPage
  String mainText = 'Calrorie-Flex';
  String idHint = 'E-MAIL';
  String pwHint = 'PW';
  String findAccount = 'forgot E-MAIL / PW?';
  String login = '로그인';
  String register = '회원가입';
  // RegisterPage
  String nameHint = 'NAME';
  String pwchkHint = 'PW CHK';
  String joinButton = '가입하기';
  String enterData = '생년월일';
  String heightHint = '키(cm)';
  String weightHint = '몸무게(kg)';
    // age
  static final DateTime now = DateTime. now();
  static final DateFormat formatter = DateFormat('yyyy');
  final String formatted = formatter. format(now);

  // UserInfoPage

}