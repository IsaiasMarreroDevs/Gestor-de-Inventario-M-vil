import 'package:flutter/material.dart';
import '../models/producto_modelo.dart';
import '../services/base_datos_inventario.dart';
import 'agregar_editar_producto.dart';
import '../widgets/estadisticas_widget.dart';
import '../widgets/producto_card.dart';

class InicioPantalla extends StatefulWidget {
  const InicioPantalla({super.key});

  @override
  _InicioPantallaState createState() => _InicioPantallaState();
}

class _InicioPantallaState extends State<InicioPantalla>
    with SingleTickerProviderStateMixin {
  List<Producto> _productos = [];
  double _valorTotal = 0.0;
  int _totalProductos = 0;
  int _productosBajos = 0;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _cargarProductos();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _cargarProductos() async {
    final productos = await BaseDatosInventario().obtenerProductos();
    setState(() {
      _productos = productos.map((e) => Producto.desdeMapa(e)).toList();
      _calcularEstadisticas();
    });
  }

  void _calcularEstadisticas() {
    _valorTotal = _productos.fold(
        0.0, (suma, item) => suma + (item.precio * item.cantidad));
    _totalProductos = _productos.length;
    _productosBajos =
        _productos.where((producto) => producto.cantidad < 5).length;
  }

  void _eliminarProducto(int id) async {
    await BaseDatosInventario().eliminarProducto(id);
    _cargarProductos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Gestor de Inventarios',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const AgregarEditarProducto()),
                );
                _cargarProductos();
              },
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surface.withOpacity(0.8),
            ],
          ),
        ),
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            children: [
              const SizedBox(height: 16),
              EstadisticasWidget(
                totalProductos: _totalProductos,
                valorTotal: _valorTotal,
                productosBajos: _productosBajos,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 16),
                  physics: const BouncingScrollPhysics(),
                  itemCount: _productos.length,
                  itemBuilder: (context, index) {
                    final producto = _productos[index];
                    return ProductoCard(
                      producto: producto,
                      onEditar: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                AgregarEditarProducto(producto: producto),
                          ),
                        );
                        _cargarProductos();
                      },
                      onEliminar: () => _eliminarProducto(producto.id!),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AgregarEditarProducto()),
          );
          _cargarProductos();
        },
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Producto'),
      ),
    );
  }
}
