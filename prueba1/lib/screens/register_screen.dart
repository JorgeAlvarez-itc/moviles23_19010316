import 'dart:io';
import '../firebase/google_auth.dart';
import 'package:flutter/material.dart';
import '../firebase/facebook_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prueba1/firebase/email_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:prueba1/widgets/awesomeDialog_widget.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  EmailAuth emailAuth = EmailAuth();
  GoogleAuth googleAuth = GoogleAuth();
  FaceAuth faceAuth = FaceAuth();
  Awesome awesome = Awesome();
  final _formKey = GlobalKey<FormState>();
  final txtEmailController = TextEditingController();
  final txtPassController = TextEditingController();
  bool isLoading = false;
  File? _image;
  final horizontalSpace = SizedBox(
    height: 10,
  );
  final imgLogo = Image.asset(
    "assets/logo.png",
    height: 50,
  );
  final txtNombre = TextFormField(
    decoration: const InputDecoration(
        label: Text("Full name"), border: OutlineInputBorder()),
    validator: (value) {
      if (value!.isEmpty) {
        return 'Por favor ingresa tu nombre completo';
      }
      return null;
    },
  );

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      emailAuth!.registerWithEmailAndPassword(
          email: txtEmailController.text, password: txtPassController.text);
      // Aquí iría el código para registrar al usuario en tu base de datos
      // También podrías guardar la imagen en tu servidor o almacenarla localmente en el dispositivo
      // Puedes acceder a la imagen usando la variable _image
      // Puedes acceder a los otros campos usando las variables _name, _email y _password
    }
  }

  void _openGallery(BuildContext context) async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
    });
    Navigator.of(context).pop();
  }

  void _openCamera(BuildContext context) async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedImage!.path);
    });
    Navigator.of(context).pop();
  }

  void _showSelectionDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Selecciona una opción"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Galería"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    child: Text("Cámara"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final googlebtn = SocialLoginButton(
      buttonType: SocialLoginButtonType.google,
      text: 'Continue with Google',
      onPressed: () {
        googleAuth.registerWithGoogle().then((value) {
          if (value == 1) {
            awesome
                .buildDialog(
                    context,
                    DialogType.success,
                    'Registro exitoso',
                    'Su cuenta se ha registrado por favor inicia sesion',
                    '/login',
                    AnimType.scale,
                    false)
                .show();
          } else if (value == 2) {
            awesome
                .buildDialog(
                    context,
                    DialogType.warning,
                    'La cuenta ya está registrada',
                    'Ya existe una cuenta registrada con este correo electronico, por favor inicie sesion',
                    '/login',
                    AnimType.bottomSlide,
                    false)
                .show();
          } else {
            awesome
                .buildDialog(
                    context,
                    DialogType.error,
                    'Ocurrio un error',
                    'Ocurrió un error al intentar realizar el registro',
                    '/register',
                    AnimType.bottomSlide,
                    false)
                .show();
          }
        });
      },
    );
    final facebookbtn = SocialLoginButton(
      buttonType: SocialLoginButtonType.facebook,
      text: 'Continue with Facebook',
      onPressed: () {
        faceAuth.signUpWithFacebook().then((value) {
          if (value == 1) {
            awesome
                .buildDialog(
                    context,
                    DialogType.success,
                    'Registro exitoso',
                    'Su cuenta se ha registrado por favor inicia sesion',
                    '/login',
                    AnimType.scale,
                    false)
                .show();
          } else if (value == 2) {
            awesome
                .buildDialog(
                    context,
                    DialogType.warning,
                    'La cuenta ya está registrada',
                    'Ya existe una cuenta registrada con este correo electronico, por favor inicie sesion',
                    '/login',
                    AnimType.bottomSlide,
                    false)
                .show();
          } else {
            awesome
                .buildDialog(
                    context,
                    DialogType.error,
                    'Ocurrio un error',
                    'Ocurrió un error al intentar realizar el registro',
                    '/register',
                    AnimType.bottomSlide,
                    false)
                .show();
          }
        });
      },
    );

    final txtPass = TextFormField(
      controller: txtPassController,
      decoration: const InputDecoration(
          label: Text("Password"), border: OutlineInputBorder()),
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Por favor ingresa una contraseña';
        }
        if (value!.length < 6) {
          return 'La contraseña debe tener al menos 6 caracteres';
        }
        return null;
      },
    );
    final txtEmail = TextFormField(
      controller: txtEmailController,
      decoration: const InputDecoration(
          label: Text("Email user"), border: OutlineInputBorder()),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Por favor ingresa tu correo electrónico';
        }
        if (!value.contains('@')) {
          return 'Por favor ingresa un correo electrónico válido';
        }
        return null;
      },
    );

    final buttonRegister = SocialLoginButton(
      buttonType: SocialLoginButtonType.generalLogin,
      text: 'Register',
      onPressed: () {
        _submitForm();
      },
    );
    final imgAvatar = GestureDetector(
      onTap: () {
        _showSelectionDialog(context);
      },
      child: CircleAvatar(
        radius: 60,
        backgroundImage: _image != null ? FileImage(_image!) : null,
        child: _image == null ? Icon(Icons.person) : null,
      ),
    );
    final txtLogin = Padding(
        padding: const EdgeInsets.all(1),
        child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: const Text(
              'Iniciar sesion',
              style:
                  TextStyle(fontSize: 18, decoration: TextDecoration.underline),
            )));
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
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        horizontalSpace,
                        imgAvatar,
                        horizontalSpace,
                        txtNombre,
                        horizontalSpace,
                        txtEmail,
                        horizontalSpace,
                        txtPass,
                        horizontalSpace,
                        buttonRegister,
                        horizontalSpace,
                        googlebtn,
                        horizontalSpace,
                        facebookbtn,
                        horizontalSpace,
                        Divider(),
                        horizontalSpace,
                        horizontalSpace,
                        txtLogin,
                        horizontalSpace,
                      ],
                    ),
                  ),
                  Positioned(top: 100, child: imgLogo)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
