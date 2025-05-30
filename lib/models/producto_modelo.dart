class Producto {
  final int? id;
  final String nombre;
  final String descripcion;
  final int cantidad;
  final double precio;
  final String? imagen;

  Producto({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.cantidad,
    required this.precio,
    this.imagen,
  });

  Map<String, dynamic> aMapa() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'cantidad': cantidad,
      'precio': precio,
      'imagen': imagen,
    };
  }

  factory Producto.desdeMapa(Map<String, dynamic> mapa) {
    return Producto(
      id: mapa['id'],
      nombre: mapa['nombre'],
      descripcion: mapa['descripcion'],
      cantidad: mapa['cantidad'],
      precio: mapa['precio'],
      imagen: mapa['imagen'],
    );
  }
}
