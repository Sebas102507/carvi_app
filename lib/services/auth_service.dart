import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import '../model/Exception/credentials_exception.dart';
import 'data_validator.dart';

class AuthService{

  static final _auth = FirebaseAuth.instance;
  Stream<User?> get authStatus=>_auth.authStateChanges();


  login(String email, String password) async{
    DataValidator.validateEmailPassword(email, password);
    try{
      Logger().i("Trying to  login!!!");
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).timeout(const Duration(seconds: 30));
    }catch(e){
      if(e is TimeoutException){
        Logger().e("Error: $e");
        throw Exception( "Error de conexión, inténtalo de nuevo.");
      }
      throw CredentialsException(message: "Correo o contraseña inválida.");
    }
    Logger().i("Login successfully!!!");
  }


  Future<String>signUp(String email, String password) async{
    Logger().i("THE SINGUP EMAIL: ${email}");
    DataValidator.validateEmailPassword(email,password);
    await _auth.createUserWithEmailAndPassword(email: email, password: password!);
    return  _auth.currentUser!.uid;
  }


  Future<void> signOut() async {
    await _auth.signOut();
  }


}