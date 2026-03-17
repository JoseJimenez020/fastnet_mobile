import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Quitamos la banda de debug
      title: 'FastNet App',
      theme: ThemeData(
        // Corregido: Agregamos ColorScheme antes del punto
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6A1B9A)),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7B2CBF), // El morado de fondo
      body: Stack(
        children: [
          // Contenido principal con Scroll para que no truene al abrir el teclado
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  // Logo y Texto (Aquí puedes usar Image.asset si tienes el logo)
                  Image.asset(
                    'assets/main/titulo.jpg',
                    height:
                        180, // Ajusta esta altura según cómo se vea en tu pantalla
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    "Por favor, ingresa tu cuenta\ny contraseña para acceder",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 40),

                  // Campo: Número de contrato
                  _buildLabel("Número de contrato o correo electrónico"),
                  _buildTextField(hint: ""),

                  const SizedBox(height: 20),

                  // Campo: Contraseña
                  _buildLabel("Contraseña"),
                  _buildTextField(hint: "", isPassword: true),

                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "¿Olvidaste alguno de tus datos?",
                      style: TextStyle(color: Colors.orangeAccent),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Botón Iniciar Sesión
                  // Botón Iniciar Sesión corregido
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        print("Login presionado");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF7043), // Naranja
                        foregroundColor: Colors.white, // Color del texto
                        shape: RoundedRectangleBorder(
                          // <--- EL CAMBIO ESTÁ AQUÍ
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Iniciar Sesión",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 100), // Espacio para el footer
                ],
              ),
            ),
          ),

          // Mascota en la esquina superior derecha
          Positioned(
            top: 40,
            right: 20,
            child: CircleAvatar(
              radius: 35,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Icon(
                  Icons.pets,
                  size: 40,
                  color: Colors.orange,
                ), // Reemplazar por Image.asset
              ),
            ),
          ),

          // Footer Blanco (Contrataciones)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 70,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Center(
                child: Text(
                  "Contrataciones",
                  style: TextStyle(
                    color: Colors.purple[800],
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget auxiliar para las etiquetas
  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 5),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 13),
        ),
      ),
    );
  }

  // Widget auxiliar para los inputs
  Widget _buildTextField({required String hint, bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          border: InputBorder.none,
          suffixIcon: isPassword
              ? const Icon(Icons.visibility_off_outlined, color: Colors.grey)
              : null,
        ),
      ),
    );
  }
}
