import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/producto_modelo.dart';
import '../services/base_datos_inventario.dart';
import 'dart:io';

class AgregarEditarProducto extends StatefulWidget {
  final Producto? producto;

  const AgregarEditarProducto({super.key, this.producto});

  @override
  _AgregarEditarProductoState createState() => _AgregarEditarProductoState();
}

class _AgregarEditarProductoState extends State<AgregarEditarProducto> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  File? _imagenSeleccionada;

  @override
  void initState() {
    super.initState();
    if (widget.producto != null) {
      _nombreController.text = widget.producto!.nombre;
      _descripcionController.text = widget.producto!.descripcion;
      _cantidadController.text = widget.producto!.cantidad.toString();
      _precioController.text = widget.producto!.precio.toString();
      if (widget.producto!.imagen != null) {
        _imagenSeleccionada = File(widget.producto!.imagen!);
      }
    }
  }

  Future<void> _seleccionarImagen() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagen = await picker.pickImage(source: ImageSource.gallery);

    if (imagen != null) {
      setState(() {
        _imagenSeleccionada = File(imagen.path);
      });
    }
  }

  Future<void> _guardarProducto() async {
    if (!_formKey.currentState!.validate()) return;

    final producto = Producto(
      id: widget.producto?.id,
      nombre: _nombreController.text,
      descripcion: _descripcionController.text,
      cantidad: int.parse(_cantidadController.text),
      precio: double.parse(_precioController.text),
      imagen: _imagenSeleccionada?.path,
    );

    if (widget.producto == null) {
      await BaseDatosInventario().insertarProducto(producto.aMapa());
    } else {
      await BaseDatosInventario()
          .actualizarProducto(widget.producto!.id!, producto.aMapa());
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.producto == null ? 'Agregar Producto' : 'Editar Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre es obligatorio.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                maxLines: 3,
              ),
              TextFormField(
                controller: _cantidadController,
                decoration: const InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La cantidad es obligatoria.';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Debe ser un número entero.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _precioController,
                decoration: const InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El precio es obligatorio.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Debe ser un número válido.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: _seleccionarImagen,
                child: _imagenSeleccionada == null
                    ? Container(
                        height: 150,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Text('Seleccionar Imagen'),
                        ),
                      )
                    : Image.file(
                        _imagenSeleccionada!,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _guardarProducto,
                child: const Text('Guardar Producto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
