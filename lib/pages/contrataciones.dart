import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaginaContrataciones extends StatefulWidget {
  const PaginaContrataciones({super.key});

  @override
  State<PaginaContrataciones> createState() => _PaginaContratacionesState();
}

class _PaginaContratacionesState extends State<PaginaContrataciones> {
  late final WebViewController controller;
  bool isLoading = true; // Para mostrar un indicador mientras carga

  @override
  void initState() {
    super.initState();

    // Configuramos el controlador del WebView
    controller = WebViewController()
      ..setJavaScriptMode(
        JavaScriptMode.unrestricted,
      ) // Permite que la web funcione bien
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(
        Uri.parse('https://www.fast-net.com.mx/HTML/requisitos.html'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Requisitos de Contratación"),
        backgroundColor: const Color(
          0xFF7B2CBF,
        ), // Morado para mantener la línea
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          // El visor web
          WebViewWidget(controller: controller),

          // Indicador de carga sutil
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFFF7043), // Naranja FastNet
              ),
            ),
        ],
      ),
    );
  }
}

