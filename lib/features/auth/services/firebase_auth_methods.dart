import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_app/core/utils/utils.dart';
import 'package:shop_app/features/auth/screens/otp_screen.dart';


class FirebaseAuthMethods {


final FirebaseAuth _auth;
FirebaseAuthMethods(this._auth);



  Future<void> phoneSignIn(BuildContext context, String phoneNumber,Function() callBack )async{

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential ) async{
        await _auth.signInWithCredential(credential);

      },
       verificationFailed: (e){
        showSnackBar(context, e.message!);

       },
        codeSent: ((String verificationId,int? resendToken)async{

          callBack();

           Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtpScreen(
                              verificationId: verificationId,
                            ),
                          ),
                        );
        }),
         codeAutoRetrievalTimeout: (String verificationId){

         }
         );
    
  }
  
}

