
import 'package:flutter/material.dart';

class ButtonPickeRick extends StatefulWidget {
  final VoidCallback onPressed;
  final double width; // Ancho requerido
  final double height; // Altura requerida
  final AssetImage  imagen;
  final String texto;

  const ButtonPickeRick({
    super.key,
    required this.onPressed,
    required this.width,
    required this.height,
    required this.imagen,
    required this.texto
    });

  @override
  State<ButtonPickeRick> createState() => _ButtonPickeRickState();
}

//le agregue el single ticker para darle un ciclo de vida a la animacion
class _ButtonPickeRickState extends State<ButtonPickeRick> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this, //vertical sync
      duration: const Duration(seconds: 3),
      );

    // Inicializar la animación con el controlador
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);  

    // Iniciar la animación al cargar el widget
    _animationController.forward();  
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animation,
      child: InkWell(
        onTap: widget.onPressed,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              // Ruta de la imagen de Pickle Rick en tus assets
              image: widget.imagen, 
              fit: BoxFit.cover,
              
            ),
          ),
          child:  Center(
            child: Text(
              widget.texto, 
              style: const TextStyle(
                color: Color.fromARGB(255, 23, 39, 24),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  //libero el recurso de la animacion, lo detengo
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();

  }
}


