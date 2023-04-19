import '../responsive.dart';
import 'package:flutter/material.dart';
import 'package:prueba1/firebase/email_auth.dart';
import 'package:prueba1/firebase/github_auth.dart';
import 'package:prueba1/firebase/google_auth.dart';
import 'package:prueba1/firebase/facebook_auth.dart';
import 'package:prueba1/widgets/loading_modal_widget.dart';
import 'package:social_login_buttons/social_login_buttons.dart';





class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  EmailAuth emailAuth=EmailAuth();
  GoogleAuth googleAuth= GoogleAuth();
  FaceAuth faceAuth= FaceAuth();
  //GitAuth githubAuth= GitAuth();
  TextEditingController? txtemailCont = TextEditingController();
  TextEditingController? txtPassController = TextEditingController();
  
  final horizontalSpace = SizedBox(
    height: 10,
  );
  final verticalSpace = SizedBox(
    width: 10,
  );
  
  final gitbtn = SocialLoginButton(
    buttonType: SocialLoginButtonType.github,
    onPressed: () {},
  );
  final imgLogo = Image.asset(
    "assets/logo.png",
    height: 100,
  );

  @override
  Widget build(BuildContext context) {

    final googlebtn = SocialLoginButton(
    buttonType: SocialLoginButtonType.google,
    onPressed: () async{
      isLoading = true;
      setState(() {});
      await googleAuth.signInWithGoogle().then((value){
        if(value.name!=null){
         isLoading=false;
         Navigator.pushNamed(context, '/dash',arguments:value); 
        }else{
          isLoading=false;
          setState(() {});
          SnackBar(content: Text('Verifica tus credenciales'),);
        }
      });
     },
    );

    final txtEmail = TextFormField(
      controller: txtemailCont,
      decoration: const InputDecoration(
          labelText: "Email", border: OutlineInputBorder()),
    );

    final txtPass = TextFormField(
      controller: txtPassController,
      decoration: const InputDecoration(
          labelText: "Password", border: OutlineInputBorder()),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(0, 0, 0, 1),
        foregroundColor: Color.fromRGBO(255, 255, 255, 1),
        child: Icon(Icons.settings),
        onPressed: () {
          Navigator.pushNamed(context, '/theme');
        },
      ),
      body: Center(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      opacity: .3,
                      fit: BoxFit.cover,
                      image: AssetImage('assets/fondo.png'))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Responsive(
                  mobile: _buildMobileContent(txtEmail,txtPass,googlebtn),
                  tablet: _buildTabletContent(txtEmail,txtPass,googlebtn),
                  desktop: _buildDesktopContent(txtEmail,txtPass,googlebtn),
                ),
              ),
            ),
            isLoading ? const LoadingModalWidget() : Container()
          ],
        ),
      ),
    );
  }

  Widget _buildMobileContent(TextFormField txtEmail,TextFormField txtPass, SocialLoginButton googlebtn) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        horizontalSpace,
        FractionallySizedBox(
          widthFactor:
              0.8, // ajusta el ancho de la imagen al 80% del ancho de la pantalla
          child: imgLogo,
        ),
        horizontalSpace,
        txtEmail,
        horizontalSpace,
        txtPass,
        horizontalSpace,
        _buildLoginButton(),
        horizontalSpace,
        googlebtn,
        horizontalSpace,
        _buildFacebookButton(),
        horizontalSpace,
        _buildGitHubButton(),
        horizontalSpace,
        _buildRegisterTextButton(),
      ],
    );
  }

  Widget _buildTabletContent(TextFormField txtEmail,TextFormField txtPass, SocialLoginButton googlebtn) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FractionallySizedBox(
                widthFactor:
                    0.8, // ajusta el ancho de la imagen al 80% del ancho de la pantalla
                child: imgLogo,
              ),
              txtEmail,
              horizontalSpace,
              txtPass,
              horizontalSpace,
              _buildLoginButton(),
              horizontalSpace,
              _buildRegisterTextButton(),
            ],
          ),
        ),
        verticalSpace,
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              googlebtn,
              horizontalSpace,
              _buildFacebookButton(),
              horizontalSpace,
              _buildGitHubButton(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopContent(TextFormField txtEmail,TextFormField txtPass, SocialLoginButton googlebtn) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              imgLogo,
              horizontalSpace,
              txtEmail,
              horizontalSpace,
              txtPass,
              horizontalSpace,
              _buildLoginButton(),
              horizontalSpace,
              _buildRegisterTextButton(),
            ],
          ),
        ),
        verticalSpace,
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              googlebtn,
              horizontalSpace,
              _buildFacebookButton(),
              horizontalSpace,
              _buildGitHubButton(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFacebookButton(){
    return SocialLoginButton(
      buttonType: SocialLoginButtonType.facebook,
      onPressed: () async{
        isLoading=true;
        setState(() {});
        faceAuth.signInWithFacebook().then((value) {
         if(value.name!=null){
             Navigator.pushNamed(context, '/dash',arguments:value);
             isLoading=false;
          }else{
            isLoading=false;
            SnackBar(content: Text('Verifica tus credenciales'),);
          }
          setState(() {});
        });
      },
    );
  }

  Widget _buildGitHubButton(){
    return SocialLoginButton(
      buttonType: SocialLoginButtonType.github, 
      onPressed: () async{
          /*
          isLoading=true;
          githubAuth.signInWithGitHub(context).then((value){
            if(value){
              Navigator.pushNamed(context, '/dash');
              isLoading=false;
            }else{
              isLoading=false;
              SnackBar(content: Text('Verifica tus credenciales'),);
            }
            setState(() {});
          });
          */
        }
      );
  }

  Widget _buildLoginButton() {
    return SocialLoginButton(
      buttonType: SocialLoginButtonType.generalLogin,
      onPressed: () {
        isLoading = true;
        setState(() {});
        print(txtemailCont!.text);
        print(txtPassController!.text);
        emailAuth!.signInWithEmailAndPassword(email: txtemailCont!.text, password: txtPassController!.text).then((value){
          if(value){
             Navigator.pushNamed(context, '/dash');
             isLoading=false;
          }else{
            isLoading=false;
            SnackBar(content: Text('Verifica tus credenciales'),);
          }
        });
      },
    );
  }

  Widget _buildRegisterTextButton() {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/register');
      },
      child: const Text('Don\'t have an account? Sign up'),
    );
  }
}
