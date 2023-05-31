import 'package:carvi/util/text_utils.dart';
import '../model/Exception/wrong_input_exception.dart';

class DataValidator{


  static validateEmail(String email){
    if(email.isEmpty || email.isEmail()==false){
      throw WrongInputException(message: "Ingresa un email válido.");
    }
  }

  static validatePassword(String password, String repeatedPassword){
     if(password.isEmpty || password.length<8){
      throw WrongInputException(message: "Ingresa una contraseña válida. (Min:8 caracteres).");
    }else if(password!=repeatedPassword){
       throw WrongInputException(message: "Las contraseñas no coinciden.");
     }
  }

  static validateEmailPassword(String email, String password){
    if(email.isEmpty || email.isEmail()==false){
      throw WrongInputException(message: "Ingresa un email válido.");
    }else if(password.isEmpty || password.length<8){
      throw WrongInputException(message: "Ingresa una contraseña válida. (Min:8 caracteres).");
    }
  }

}