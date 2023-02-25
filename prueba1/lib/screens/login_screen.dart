import '../responsive.dart';
import 'package:flutter/material.dart';
import 'package:prueba1/widgets/loading_modal_widget.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  final txtEmail = TextFormField(
    decoration: const InputDecoration(
        labelText: "EMAIL USER", border: OutlineInputBorder()),
  );

  final txtPass = TextFormField(
    decoration: const InputDecoration(
        labelText: "Password", border: OutlineInputBorder()),
  );

  final horizontalSpace = SizedBox(
    height: 10,
  );
  final verticalSpace = SizedBox(
    width: 10,
  );
  final googlebtn = SocialLoginButton(
    buttonType: SocialLoginButtonType.google,
    onPressed: () {},
  );
  final facebookbtn = SocialLoginButton(
    buttonType: SocialLoginButtonType.facebook,
    onPressed: () {},
  );
  final gitbtn = SocialLoginButton(
    buttonType: SocialLoginButtonType.github,
    onPressed: () {},
  );
  final imgLogo = Image.asset(
    "assets/logo.png",
    height: 120,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
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
                mobile: _buildMobileContent(),
                tablet: _buildTabletContent(),
                desktop: _buildDesktopContent(),
              ),
            ),
          ),
          isLoading ? const LoadingModalWidget() : Container()
        ],
      ),
    );
  }

  Widget _buildMobileContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
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
        facebookbtn,
        horizontalSpace,
        gitbtn,
        horizontalSpace,
        _buildRegisterTextButton(),
      ],
    );
  }

  Widget _buildTabletContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FractionallySizedBox(
                widthFactor: 0.8, // ajusta el ancho de la imagen al 80% del ancho de la pantalla
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
              facebookbtn,
              horizontalSpace,
              gitbtn,
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              facebookbtn,
              horizontalSpace,
              gitbtn,
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SocialLoginButton(
      buttonType: SocialLoginButtonType.generalLogin,
      onPressed: () {
        isLoading = true;
        setState(() {});
        Future.delayed(const Duration(milliseconds: 4000)).then((value) {
          isLoading = false;
          Navigator.pushNamed(context, '/dash');
          setState(() {});
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
