import 'package:fastnet_app/pages/menu.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'pages/contrataciones.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FastNet App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6A1B9A)),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void _showSupportDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Cerrar",
      barrierColor: Colors.black54, // Fondo oscurecido
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, anim1, anim2) => const SizedBox(),
      transitionBuilder: (context, anim1, anim2, child) {
        // Animación de escala y opacidad
        return Transform.scale(
          scale: anim1.value,
          child: Opacity(
            opacity: anim1.value,
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              content: Stack(
                clipBehavior: Clip.none,
                children: [
                  // El recuadro morado de soporte
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: const Color(0xFF9161B4), // Color morado del popup
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.orange, width: 2),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Soporte\nTécnico",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(
                          color: Colors.orange,
                          thickness: 2,
                          height: 30,
                        ),

                        // Opción: Llamada
                        _buildSupportOption(
                          icon: Icons.phone_in_talk,
                          label: "Contactar a soporte técnico por llamada",
                          onTap: () => _launchURL(
                            "tel:9933833889",
                          ), // Reemplaza con tu número
                        ),
                        const SizedBox(height: 20),

                        // Opción: WhatsApp
                        _buildSupportOption(
                          icon: Icons.chat_bubble_outline,
                          label: "Contactar a soporte técnico vía WhatsApp",
                          onTap: () => _launchURL(
                            "https://wa.me/9934377745",
                          ), // Reemplaza con tu número
                        ),
                        const SizedBox(height: 30),

                        // Preguntas Frecuentes
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // Aquí mandas a tu pantalla de preguntas
                          },
                          child: const Text(
                            "Preguntas frecuentes",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Mascota en la esquina inferior derecha
                  Positioned(
                    bottom: -20,
                    right: -10,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/main/mascota.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSupportOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 25),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  // Función para lanzar las URLs externas
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('No se pudo abrir $url');
    }
  }

  // Estado para ocultar/mostrar contraseña
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    const Color backgroundPurple = Color(0xFF7B2CBF);
    const Color subtlePurple = Color(0xFFA55DD9);

    return Scaffold(
      backgroundColor: backgroundPurple,
      // CLAVE: Evita que el teclado mueva los elementos del fondo (como el footer)
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // 1. FONDO (Debajo de todo)
          Positioned.fill(
            child: Opacity(
              opacity: 0.15,
              child: Image.asset(
                'assets/main/fondo.png',
                color: subtlePurple,
                colorBlendMode: BlendMode.srcIn,
                fit: BoxFit.cover, // Cubre toda la pantalla
              ),
            ),
          ),

          // 2. CONTENIDO SCROLLABLE
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  // Logo de Título
                  Image.asset(
                    'assets/main/titulo.png',
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Por favor, ingresa tu cuenta\ny contraseña para acceder",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 40),

                  // Campos
                  _buildLabel("Número de contrato o correo electrónico"),
                  _buildTextField(hint: ""),
                  const SizedBox(height: 20),
                  _buildLabel("Contraseña"),
                  _buildTextField(
                    hint: "",
                    isPassword: true,
                    obscureText: _obscurePassword,
                    onToggle: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "¿Olvidaste alguno de tus datos?",
                      style: TextStyle(color: Colors.orangeAccent),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Botón Login
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navegación a la Pantalla Principal
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PantallaPrincipal(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF7043),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
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
                  // Espacio extra para que el teclado no tape el botón al bajar
                  const SizedBox(height: 300),
                ],
              ),
            ),
          ),

          // 3. MASCOTA COMO BOTÓN FLOTANTE (Ayuda)
          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              onTap: () {
                _showSupportDialog();
              },
              child: Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0), // Margen blanco
                  child: ClipOval(
                    child: Image.asset(
                      'assets/main/mascota.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 4. FOOTER FIJO (Contrataciones)
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                // Navegación a otra pantalla
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaginaContrataciones(),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: 75,
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
          ),
        ],
      ),
    );
  }

  // --- WIDGETS AUXILIARES ---

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

  Widget _buildTextField({
    required String hint,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        obscureText: isPassword ? obscureText : false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          border: InputBorder.none,
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: const Color(0xFFFF7043), // Naranja para que resalte
                  ),
                  onPressed: onToggle,
                )
              : null,
        ),
      ),
    );
  }
}
