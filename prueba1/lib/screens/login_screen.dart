import 'package:flutter/material.dart';
import 'package:prueba1/widgets/loading_modal_widget.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isLoading=false;
  
  final txtEmail = TextFormField(
    decoration: const InputDecoration(
      label: Text("EMAIL USER"),
      border: OutlineInputBorder()
    ),
  );


  final txtPass = TextFormField(
    decoration:const InputDecoration(
      label: Text("Password"),
      border: OutlineInputBorder()
    ),
  );
  
  final horizontalSpace = SizedBox(height: 10,);
  
  final googlebtn = SocialLoginButton(
    buttonType: SocialLoginButtonType.google, 
    onPressed: (){},
  );
  final facebookbtn = SocialLoginButton(
    buttonType: SocialLoginButtonType.facebook, 
    onPressed: (){},
  );
  final gitbtn = SocialLoginButton(
    buttonType: SocialLoginButtonType.github, 
    onPressed: (){},
  );
  final imgLogo = Image.asset("assets/logo.png", height: 200,);

  @override
  Widget build(BuildContext context) {
    final buttonlogging = SocialLoginButton(
    buttonType: SocialLoginButtonType.generalLogin, 
    onPressed: (){
      isLoading=true;
      setState(() {
        
      });
      Future.delayed(const Duration(milliseconds: 4000)).then((value){
        isLoading=false;
        Navigator.pushNamed(context, '/dash');
        setState(() {});
      });
    },
    );
    final txtRegister =Padding(
    padding: const EdgeInsets.all(1), 
    child: TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/register');
      },
      child:const Text('Crear cuenta',
      style:TextStyle(
        fontSize: 18,
        decoration: TextDecoration.underline
      ) ,)
  ));  
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                opacity: .3,
                fit: BoxFit.cover,
                image: AssetImage('assets/fondo.png')
              )
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      horizontalSpace,
                      txtEmail,
                      horizontalSpace,
                      txtPass,
                      horizontalSpace,
                      buttonlogging,
                      horizontalSpace,
                      googlebtn,
                      horizontalSpace,
                      facebookbtn,
                      horizontalSpace,
                      gitbtn,
                      horizontalSpace,
                      txtRegister
                    ],
                  ),
                  Positioned( 
                  top: 130,
                  child:imgLogo)
                ],
              ),
            ),
          ),
          isLoading?const LoadingModalWidget():Container()
        ],
      ),
    );
  }
}