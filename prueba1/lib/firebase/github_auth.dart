/*

class GitAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GitHubSignIn _githubSignIn = GitHubSignIn(
    clientId: 'YOUR_GITHUB_CLIENT_ID',
    clientSecret: 'YOUR_GITHUB_CLIENT_SECRET',
    redirectUrl: 'YOUR_GITHUB_REDIRECT_URL',
  );

  Future<bool> signInWithGitHub(BuildContext context) async {
    try {
      final result = await _githubSignIn.signIn(context);

      if (result != null) {
        final githubAuthCredential =
            GithubAuthProvider.credential(result.token);
        final authResult =
            await _firebaseAuth.signInWithCredential(githubAuthCredential);
        if (authResult.user != null) {
          return true;
        }
      }
      return false;
    } on PlatformException catch (e) {
      Fluttertoast.showToast(
        msg: 'Error signing in with GitHub: ${e.message}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return false;
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error signing in with GitHub: $e',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return false;
    }
  }

  Future<bool> signUpWithGitHub(BuildContext context) async {
    try {
      final result = await _githubSignIn.signIn(context);
      if (result != null) {
        final githubAuthCredential =
            GithubAuthProvider.credential(result.token);
        final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: '${result.token}@github.com',
          password: '${result.token}',
        );
        if (authResult.user != null) {
          await authResult.user!.updateDisplayName(result.token);
          await authResult.user!.sendEmailVerification();
          await authResult.user!.linkWithCredential(githubAuthCredential);
          return true;
        }
      }

      return false;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: 'Error signing up with GitHub: ${e.message}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return false;
    } on PlatformException catch (e) {
      Fluttertoast.showToast(
        msg: 'Error signing up with GitHub: ${e.message}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return false;
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error signing in with GitHub: $e',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return false;
    }
  }
}
*/