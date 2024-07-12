import 'package:google_sign_in/google_sign_in.dart';

const List<String> scopes = <String>[
  'profile',
  'email',
  // 'https://www.googleapis.com/auth/contacts.readonly',
];
// final authRepositoryProvider = Provider((ref) {
//   return AuthRepository(
//     googleSignIn: GoogleSignIn(scopes: scopes),
//   );
// });

// final testRepositaryProvider = Provider(
//   (ref) {
//     return "Testing riverpod";
//   },
// );

class AuthRepository {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: 'your-client_id.apps.googleusercontent.com',
    scopes: scopes,
  );
  // AuthRepository({required GoogleSignIn googleSignIn})
  //     : _googleSignIn = googleSignIn;
  AuthRepository();

  // void signInWithGoogle() async {
  //   try {
  //     print("sign in google");
  //     final user = await _googleSignIn.signIn();
  //     if (user != null) {
  //       print("user ${user}");
  //       print(user.email);
  //       print(user.displayName);
  //       // print(user.photoUrl);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<void> handleSGoogleignIn() async {
    try {
      // await _googleSignIn.signIn();
      print("sign in google");
      final user = await _googleSignIn.signIn();
      if (user != null) {
        print("user ${user}");
        print(user.email);
        print(user.displayName);
      }
    } catch (error) {
      print(error);
    }
  }
}
