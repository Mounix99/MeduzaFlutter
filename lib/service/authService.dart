  import 'package:firebase_auth/firebase_auth.dart';

  class AuthService {

    final FirebaseAuth _auth = FirebaseAuth.instance;

    // auth change user stream
    Stream<User?> get user {
      return _auth.authStateChanges();
    }

    Future getUserData() async {
      try {
        User? user = _auth.currentUser;
        return user;
      } catch (e) {
        print(e.toString());
        return null;
      }
    }

    // Anon
    Future signAnon() async {
      try{
        UserCredential user =  await _auth.signInAnonymously();
        return user;
      } catch (e) {
        print(e.toString());
        return null;
      }
    }

    //email
    Future signInWithEmailAndPassword(String email, String password) async {
      try{
        UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
        return result.user;
      } catch (e){
        print(e.toString());
        return null;
      }
    }

    //regist
    Future registerWithEmailAndPassword(String email,String password) async{
      try{
        UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        return result.user;
      } catch (e) {
        print(e.toString());
        return null;
      }
    }

    //sign out
    Future signOut() async {
      try{
        return await _auth.signOut();
      } catch (e) {
        print(e.toString());
        return null;
      }
    }

  }