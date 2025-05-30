# 📲 Gestor de Inventario Móvil

Aplicación móvil desarrollada en **Flutter** y **Dart** que permite registrar, consultar y administrar inventarios desde un dispositivo Android. Está diseñada para pequeños negocios o uso educativo como ejemplo de sistema de inventario portátil.

## 👤 Autor

- **Nombre:** Isaias Marrero Burgos  
- **E-mail:** isaiasmarrerob@outlook.com  

## 🧩 Tecnologías Utilizadas

- Flutter (SDK)
- Dart (Lenguaje)
- Android SDK (compilación nativa)
- SQLite o almacenamiento local en dispositivo
- Diseño Material (Interfaz de usuario)

## 🎯 Funcionalidades

- 🔐 Inicio de sesión de usuario (si aplica)
- 📋 Registro y edición de productos
- 🔍 Búsqueda rápida por nombre o código de producto
- 🔄 Control de entradas y salidas de inventario
- 📦 Visualización de stock actual
- 📤 Posible exportación o backup (opcional para futuras versiones)
- 📱 Aplicación compilada como APK lista para instalar (`Gestor de Inventario.apk`)

## ⚙️ Instalación y Ejecución

### ✅ Opción 1: Ejecutar con Flutter

1. Clona este repositorio o descomprime el ZIP:
   ```bash
   git clone https://github.com/tuusuario/gestor-inventario-movil.git

2. Entra en el directorio del proyecto:
    cd gestor-inventario-movil

3. Instala las dependencias:
    flutter pub get

4. Conecta un dispositivo Android o abre un emulador.

5. Ejecuta el proyecto:
    flutter run

6. Para compilar el APK en modo release:
    flutter build apk --release

    El APK se generará en:
    build/app/outputs/flutter-apk/app-release.apk

### 📥  Opción 2: Instalación Directa del APK


1. Transfiere el archivo Gestor de Inventario.apk a tu celular Android.

2. En tu celular, activa la opción "Permitir instalación de fuentes desconocidas" (Ajustes > Seguridad).

3. Abre el archivo desde el administrador de archivos o notificación.

4. Sigue el asistente de instalación.

### 📁 Estructura del Proyecto

Gestor de Inventario Movil/
├── lib/                         # Código principal en Dart
│   └── main.dart                # Punto de entrada de la aplicación
├── android/                     # Código nativo para Android
├── pubspec.yaml                 # Configuración de dependencias y metadatos
├── Gestor de Inventario.apk     # APK para instalación manual
└── README.md                    # Documentación del proyecto

