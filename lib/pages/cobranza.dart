import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PantallaCobranza extends StatelessWidget {
  const PantallaCobranza({super.key});

  // Función para lanzar las URLs (Llamada y WhatsApp)
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('No se pudo abrir $url');
    }
  }

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
                      color: const Color(0xFF9161B4),
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
                          onTap: () => _launchURL("tel:9933833889"),
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

  @override
  Widget build(BuildContext context) {
    const Color moradoFondo = Color(0xFF7B2CBF);
    const Color moradoTexto = Color(0xFF6A1B9A);
    const Color naranjaBoton = Color(0xFFFF7043);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. MARCA DE AGUA DE FONDO
          Positioned.fill(
            child: Image.asset(
              'assets/main/fondo_marca.png', // Tu Imagen3.png
              fit: BoxFit.contain,
            ),
          ),

          // 2. CONTENIDO PRINCIPAL
          Column(
            children: [
              // Encabezado
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

              // Cuerpo
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),

                      // Título
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          style: TextStyle(color: moradoTexto, fontSize: 28),
                          children: [
                            TextSpan(text: "¿Contactar al\nárea de "),
                            TextSpan(
                              text: "cobranza?",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Descripción
                      const Text(
                        "¿Porqué contactar al área de cobranza?\nSi tienes dudas sobre:\n- Cambio de plan.\n- Preguntas acerca de tu pago.\n- Solicitar tu estado de cuenta.\n- Reportes de pago.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: moradoTexto,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 50),

                      // Botón Llamada
                      _buildContactButton(
                        label: "Contactar\npor llamada",
                        icon: Icons.phone_in_talk,
                        color: naranjaBoton,
                        onTap: () => _launchURL("tel:9935240400"),
                      ),

                      const SizedBox(height: 25),

                      // Botón WhatsApp
                      _buildContactButton(
                        label: "Contactar\nvía WhatsApp",
                        icon: Icons.chat_bubble_outline,
                        color: naranjaBoton,
                        onTap: () => _launchURL("https://wa.me/9933833889"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // 3. MASCOTA FIJA (Opcional, si quieres que aparezca también aquí)
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

  // Widget personalizado para los botones grandes de contacto
  Widget _buildContactButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 50),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
