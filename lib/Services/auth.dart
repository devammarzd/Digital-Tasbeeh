
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'User.dart';
class AuthService {
//create an user object based on firebase user
  final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignin = new GoogleSignIn();

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid, email: user.email, name: user.displayName,photourl: user.photoUrl,phone:user.phoneNumber) : null;
  }

 Stream<User> get user {
    return _auth.onAuthStateChanged
        // .map((FirebaseUser user)=>_userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  //Google Sign in
  Future gsignIn() async {
    
    GoogleSignInAccount googleSignInAccount = await googleSignin.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: gSA.accessToken,
      idToken: gSA.idToken,
    );
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
//     final FirebaseUser currentUser = await _auth.currentUser();
// if(currentUser != null){
//   print('Current User: ${currentUser.displayName}');
// }
    print("User Name:${user.displayName}");
    return _userFromFirebaseUser(user);
  }

  //googleSignout
  Future gsignOut() async{

      googleSignin.signOut().whenComplete((){
        print('Signed out succesfully');
      });
      return await _auth.signOut();
}





}