import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EstadisticasWidget extends StatelessWidget {
  final int totalProductos;
  final double valorTotal;
  final int productosBajos;

  const EstadisticasWidget({
    super.key,
    required this.totalProductos,
    required this.valorTotal,
    required this.productosBajos,
  });

  @override
  Widget build(BuildContext context) {
    final formatMoneda = NumberFormat.simpleCurrency(locale: 'es_419');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildEstadistica('Productos', '$totalProductos', Icons.inventory),
          _buildEstadistica('Valor Total', formatMoneda.format(valorTotal),
              Icons.attach_money),
          _buildEstadistica(
              'Bajos', '$productosBajos', Icons.warning, Colors.red),
        ],
      ),
    );
  }

  Widget _buildEstadistica(String titulo, String valor, IconData icono,
      [Color? color]) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: (color ?? Colors.teal).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icono,
              color: color ?? Colors.teal,
              size: 32,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            titulo,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            valor,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
