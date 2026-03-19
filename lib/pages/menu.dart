import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({super.key});

  void _showSupportDialog(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    // Colores de identidad
    const Color moradoFondo = Color(0xFF7B2CBF);
    const Color moradoTexto = Color(0xFF6A1B9A);
    const Color naranjaBoton = Color(0xFFFF7043);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. MARCA DE AGUA DE FONDO (Imagen 3)
          Positioned.fill(
            child: Opacity(
              opacity: 0.05, // Muy sutil para que no estorbe la lectura
              child: Image.asset(
                'assets/main/fondo_marca.png',
                fit: BoxFit.contain,
              ),
            ),
          ),

          // 2. CONTENIDO PRINCIPAL
          Column(
            children: [
              // Encabezado Morado con Logo
              Container(
                width: double.infinity,
                height: 140,
                decoration: const BoxDecoration(color: moradoFondo),
                child: SafeArea(
                  child: Center(
                    child: Image.asset('assets/main/titulo.png', height: 60),
                  ),
                ),
              ),

              // Cuerpo con Scroll
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),

                      // Bienvenida
                      Text(
                        "Bienvenido(a),",
                        style: TextStyle(color: moradoTexto, fontSize: 18),
                      ),
                      const Text(
                        "Jesus Alberto Valenzuela Alcudia",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: moradoTexto,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Nro. de contrato:\n22913-1",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: moradoTexto,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 40),
                      const Text(
                        "Estatus del servicio:",
                        style: TextStyle(color: moradoTexto, fontSize: 18),
                      ),
                      const SizedBox(height: 10),

                      // Botón/Indicador ACTIVO
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: naranjaBoton,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "ACTIVO",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 48,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),
                      const Text(
                        "Servicio contratado:\nNormal 200mbps",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: moradoTexto,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Botones de Acción
                      _buildActionButton(
                        label: "Datos de mi próximo pago",
                        onPressed: () {},
                        color: moradoTexto,
                      ),
                      const SizedBox(height: 15),
                      _buildActionButton(
                        label: "Cambio de plan",
                        onPressed: () {},
                        color: moradoTexto,
                      ),

                      const SizedBox(
                        height: 100,
                      ), // Espacio para no chocar con la mascota
                    ],
                  ),
                ),
              ),
            ],
          ),

          // 3. MASCOTA FLOTANTE (Esquina inferior derecha)
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                _showSupportDialog(context);
              },
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: naranjaBoton, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                    ),
                  ],
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
          ),
        ],
      ),
    );
  }

  // Widget auxiliar para los botones morados
  Widget _buildActionButton({
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
