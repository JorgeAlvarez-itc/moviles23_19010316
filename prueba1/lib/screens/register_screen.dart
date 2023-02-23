import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLoading=false;
  File ?_image;
  final horizontalSpace = SizedBox(height: 10,);
  final imgLogo = Image.asset("assets/logo.png", height: 200,);
  final txtNombre=TextFormField(
    decoration: InputDecoration(labelText: 'Nombre completo'),
    validator: (value) {
      if (value!.isEmpty) {
        return 'Por favor ingresa tu nombre completo';
      }
      return null;
    },     
  );

  final txtEmail = TextFormField(
    decoration: const InputDecoration(
      label: Text("Email user"),
      border: OutlineInputBorder()
    ),
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

  final txtPass = TextFormField(
    decoration:const InputDecoration(
      label: Text("Password"),
      border: OutlineInputBorder()
    ),
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
  
  void _pickImage() async {
    // Aquí utilizamos la librería de ImagePicker para seleccionar una imagen de la galería
    // Puedes agregar más opciones para tomar la imagen desde la cámara, etc.
    final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final imgAvatar= GestureDetector(
      onTap: _pickImage,
      child: CircleAvatar(
            radius: 60,
            backgroundImage: _image != null ? FileImage(_image!) : null,
            child: _image == null ? Icon(Icons.person) : null,
          ),
    );
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
                      imgAvatar,
                      horizontalSpace,
                      txtNombre,
                      horizontalSpace,
                      txtEmail,
                      horizontalSpace,
                      txtPass,
                      horizontalSpace,
                    ],
                  ),
                  Positioned( 
                  top: 130,
                  child:imgLogo)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}