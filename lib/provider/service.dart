import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/http_exception.dart';

class Service with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore data = FirebaseFirestore.instance;
  late String otpId;

  //Auth Methods
  Future<void> verifyNumber(phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) async {
        //signInWithPhoneAuthCredential(phoneAuthCredential);
      },
      verificationFailed: (verificationFailed) async {},
      codeSent: (verificationId, resendingToken) async {
        otpId = verificationId;
        notifyListeners();
      },
      codeAutoRetrievalTimeout: (verificationId) async {},
    );
  }

  Future<void> signUp(smsText, email, phoneNumber, password, interest) async {
    try {
      UserCredential authResult;
      authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await data.collection('users').doc(authResult.user!.uid).set({
        'uid': authResult.user!.uid,
        'phoneNumber': phoneNumber,
        'email': email,
        'interest': interest,
      });

      notifyListeners();
    } on FirebaseAuthException catch (error) {
      throw HttpException(error.message!);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signIn(email, password) async {
    UserCredential authResult;
    print(password);
    try {
      authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
    } on FirebaseAuthException catch (error) {
      throw HttpException(error.message!);
    } catch (error) {
      rethrow;
    }
  }

  Future signOut() async {
    notifyListeners();
    await _auth.signOut();
  }
}
