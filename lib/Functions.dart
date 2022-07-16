

class Functions{
  String funcRegister(String name, String email, String pw, String pwchk, String birth, int height, int weight) {
    if (name == '' || email == '' || pw == '' || pwchk == '' || birth == '' || height.toString() == '' || weight.toString() == ''){
      return 'RESULT_EMPTY';
    } else if (pw != pwchk){
      return 'RESULT_NOT_MATCH_PW';
    }
    return 'DONE ';
  }
}