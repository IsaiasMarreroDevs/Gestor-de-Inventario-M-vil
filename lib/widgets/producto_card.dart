import 'package:flutter/material.dart';
import '../models/producto_modelo.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class ProductoCard extends StatelessWidget {
  final Producto producto;
  final VoidCallback onEditar;
  final VoidCallback onEliminar;

  const ProductoCard({
    super.key,
    required this.producto,
    required this.onEditar,
    required this.onEliminar,
  });

  @override
  Widget build(BuildContext context) {
    final formatMoneda = NumberFormat.simpleCurrency(locale: 'es_419');
    final bool esBajoStock = producto.cantidad < 5;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onEditar,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Contenedor para imagen o icono
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: producto.imagen?.isNotEmpty == true
                          ? null
                          : Colors.teal.withOpacity(0.1),
                      shape: producto.imagen?.isNotEmpty == true
                          ? BoxShape.rectangle
                          : BoxShape.circle,
                      borderRadius: producto.imagen?.isNotEmpty == true
                          ? BorderRadius.circular(12)
                          : null,
                    ),
                    child: producto.imagen?.isNotEmpty == true
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              File(producto.imagen!),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return _buildIconoProducto();
                              },
                            ),
                          )
                        : _buildIconoProducto(),
                  ),
                  const SizedBox(width: 16),
                  // Información principal del producto
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          producto.nombre,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          producto.descripcion,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton(
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: onEditar,
                        child: const ListTile(
                          leading: Icon(Icons.edit, color: Colors.blue),
                          title: Text('Editar'),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      PopupMenuItem(
                        child: const ListTile(
                          leading: Icon(Icons.delete, color: Colors.red),
                          title: Text('Eliminar'),
                          contentPadding: EdgeInsets.zero,
                        ),
                        onTap: () {
                          // Agregamos un pequeño delay para evitar errores de contexto
                          Future.delayed(
                            const Duration(seconds: 0),
                            () => _mostrarDialogoConfirmacion(context),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Información detallada en chips
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildInfoChip(
                    Icons.attach_money,
                    formatMoneda.format(producto.precio),
                    Colors.green,
                  ),
                  _buildInfoChip(
                    Icons.inventory,
                    '${producto.cantidad} unidades',
                    esBajoStock ? Colors.red : Colors.blue,
                  ),
                  if (esBajoStock)
                    _buildInfoChip(
                      Icons.warning,
                      'Stock Bajo',
                      Colors.orange,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconoProducto() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: const Icon(
        Icons.inventory_2_outlined,
        color: Colors.teal,
        size: 24,
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _mostrarDialogoConfirmacion(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content:
              const Text('¿Estás seguro de que deseas eliminar este producto?'),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text(
                'Eliminar',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                onEliminar();
              },
            ),
          ],
        );
      },
    );
  }
}
